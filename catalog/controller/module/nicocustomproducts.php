<?php
include_once(DIR_APPLICATION . '/controller/module/nicomodule.inc');
global $_nico_module_counter;
class ControllerModuleNicocustomproducts extends NicoModule
{
	private function getProductRelated($product_id, $limit, $same_category_complete = true) 
	{
		$products = array();
		$key = 'productrelated.' . (int)$product_id . '-' . $limit . '-'. $same_category_complete . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $this->currency_code . '.' . $this->config->get('config_customer_group_id');
		$products = $this->cache->get($key);
		
		if (!$products)
		{
			if ($same_category_complete == true)
			{
				$sql = "
					SELECT * FROM
					(SELECT related_id FROM " . DB_PREFIX . "product_related pr 
						LEFT JOIN " . DB_PREFIX . "product p ON (pr.related_id = p.product_id) 
						LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) 
						WHERE pr.product_id = '" . (int)$product_id . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
					UNION ALL
					SELECT product_id as related_id FROM " . DB_PREFIX . "product_to_category pc WHERE pc.category_id IN (SELECT category_id FROM " . DB_PREFIX . "product_to_category pc2 WHERE product_id = $product_id) LIMIT $limit
					) r LIMIT $limit";
			} else
			{
				$sql = "SELECT * FROM " . DB_PREFIX . "product_related pr LEFT JOIN " . DB_PREFIX . "product p ON (pr.related_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE pr.product_id = '" . (int)$product_id . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";
			}

			$query = $this->db->query($sql);

			foreach ($query->rows as $result) {
				$products[$result['related_id']] = $this->model_catalog_product->getProduct($result['related_id']);
			}
			
			$this->cache->set($key, $products);
		}
		
		return $products;
	}
	
	private function getViewedProducts($limit = 0)
	{
		$viewed_products = array();
        
        if (isset($this->request->cookie['viewed'])) 
        {
			$viewed_products = '';
			if (preg_match('@[0-9]*,?@', $this->request->cookie['viewed']))
			{
				$viewed_products = explode(',', $this->request->cookie['viewed']);
			}
        } else if (isset($this->session->data['viewed'])) 
        {
      		$viewed_products = $this->session->data['viewed'];
    	}
        
        if (isset($this->request->get['route']) && $this->request->get['route'] == 'product/product') 
        {
            
            $product_id = (int)$this->request->get['product_id'];   
               
            $viewed_products = array_diff($viewed_products, array($product_id));
            if ($limit) $viewed_products = array_slice($viewed_products,0, $limit);
            
            array_unshift($viewed_products, $product_id);
            
            setcookie('viewed', implode(',',$viewed_products), time() + 60 * 60 * 24 * 30, '/', $this->request->server['HTTP_HOST']);
        
            if (!isset($this->session->data['viewed']) || $this->session->data['viewed'] != $viewed_products) 
            {
          		$this->session->data['viewed'] = $viewed_products;
        	}
        } 
        
        return $viewed_products;
	}
	
	private function getRandomProducts($limit, $cache = true)
	{
		$key = $limit . md5($_SERVER['REQUEST_URI']) . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $this->currency_code . '.' . $this->config->get('config_customer_group_id');
		if (!$limit) $limit = 5;
		if ($cache)
		{
			$products = $this->cache->get('productsRandom' . $key);
			if ($products && is_array($products)) return $products = shuffle($products);
		}
		
		$sql = 'SELECT * FROM '. DB_PREFIX . 'product p
					LEFT JOIN `' . DB_PREFIX . 'product_description` pd
					ON p.product_id = pd.product_id GROUP BY p.product_id ORDER BY rand() LIMIT ' . $limit ;
		
		$query = $this->db->query($sql);
		$products = array();
			
		foreach ($query->rows as $result) {
			$products[$result['product_id']] = $this->model_catalog_product->getProduct($result['product_id']);
		}

		if ($cache)
		{
			$this->cache->set('productsRandom' . $key, $products);
		}
		
		return $products;
	}
		
	
	private function getProductAlsoBought($product_id, $max_row)
	{
		$products = $this->cache->get('productAlsoBought.' . (int)$product_id . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $this->currency_code . '.' . $this->config->get('config_customer_group_id'));
		
		if (!$products) {
			$products = array();
	
			$sql = "
				SELECT
					DISTINCT 
					  p.product_id
					, p.tax_class_id
					, pd.name AS name
					, p.image
					, p.price
					, p.model
					, m.name AS manufacturer
					, ss.name AS stock
					, (SELECT 
							AVG(r.rating) 
						FROM `" . DB_PREFIX . "review` r 
						WHERE p.product_id = r.product_id 
						GROUP BY r.product_id) AS rating 
					, COUNT(*) AS cnt
				FROM `" . DB_PREFIX . "order_product` op
				INNER JOIN `" . DB_PREFIX . "order` o
					ON o.order_id = op.order_id
				INNER JOIN `" . DB_PREFIX . "product` p
					ON op.product_id = p.product_id
				LEFT OUTER JOIN `" . DB_PREFIX . "product_description` pd
					ON p.product_id = pd.product_id
				LEFT OUTER JOIN `" . DB_PREFIX . "product_to_store` p2s
					ON p.product_id = p2s.product_id
				LEFT OUTER JOIN `" . DB_PREFIX . "manufacturer` m
					ON p.manufacturer_id = m.manufacturer_id
				LEFT OUTER JOIN `" . DB_PREFIX . "stock_status` ss
					ON p.stock_status_id = ss.stock_status_id
				WHERE o.customer_id IN (
						SELECT
							o.customer_id
						FROM `" . DB_PREFIX . "order_product` op
						INNER JOIN `" . DB_PREFIX . "order` o
							ON o.order_id = op.order_id
						WHERE op.product_id = '" . (int)$product_id . "'
						GROUP BY o.customer_id)
					AND p.product_id != '" . (int)$product_id . "'
					AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "'
					AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
					AND ss.language_id = '" . (int)$this->config->get('config_language_id') . "'
					AND p.date_available <= NOW()
					AND p.status = '1'
				GROUP BY op.product_id
				ORDER BY COUNT(*) DESC
				LIMIT 0, ".$max_row.";
			";

			$product_also_bought_query = $this->db->query($sql);
			
			$products = $product_also_bought_query->rows;
			
			$this->cache->set('productAlsoBought.' . (int)$product_id, $products);
		}
		
		return $products;
	}
		
	public function index($setting) 
	{
		if (!$this->is_filter_ok($setting)) return false;

		global $_nico_module_counter;
		if (isset($_nico_module_counter['nicocustomproducts'])) $_nico_module_counter['nicocustomproducts']++; else $_nico_module_counter['nicocustomproducts'] = 0;

		$opencart_version = (int)str_replace('.','',VERSION);

		$lang_code = isset($this->session->data['language'])?$this->session->data['language']:$this->language->get('code');
		
		if (!$lang_code || is_object($lang_code)) $lang_code = $lang_code->get('code');
		
		$lang_code = strtolower($lang_code);

		$default_lang = 'en';

		if ($opencart_version >= 2200)
		{
			$default_lang = 'en-gb';
		}
	
		
		$currency_code = isset($this->session->data['currency'])?$this->session->data['currency']:$this->currency->get('code');
		
		if (is_object($currency_code)) $currency_code = $currency_code->get('code');
		
		$this->currency_code = $currency_code = strtolower($currency_code);


		$key = 'nicocustomproducts.'. (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $currency_code . '.' . $this->config->get('config_customer_group_id') . md5($_SERVER['REQUEST_URI']) . $_nico_module_counter['nicocustomproducts'];
		$data = $this->cache->get($key);

		if (!$data)
		{
			
			$data = $setting;
			
			$data['module_id'] = $_nico_module_counter['nicocustomproducts'];
			
			if ($opencart_version >= 2000)
			{
				$this->load->language('module/nicocustomproducts');
			} else
			{
				$this->language->load('module/nicocustomproducts'); 
			}
			
			$resize_method = 0;
			if (isset($setting['resize_method']))
			{
				$resize_method = (int)$setting['resize_method'];
			}


			if (isset($data['show_cover']) && $data['show_cover'] == '1')
			{
				if (isset($data['cover_title'][$lang_code])) $data['cover_title']= $data['cover_title'][$lang_code];else if (isset($data['cover_title'][$default_lang])) $data['cover_title'] = $data['cover_title'][$default_lang];else $data['cover_title'] = '';
				if (isset($data['cover_text'][$lang_code])) $data['cover_text']= $data['cover_text'][$lang_code];else if (isset($data['cover_text'][$default_lang])) $data['cover_text'] = $data['cover_text'][$default_lang];else $data['cover_text'] = '';
				if (isset($data['cover_button'][$lang_code])) $data['cover_button']= $data['cover_button'][$lang_code];else if (isset($data['cover_button'][$default_lang])) $data['cover_button'] = $data['cover_button'][$default_lang];else $data['cover_button'] = '';
				
				if (isset($data['cover_background_image']) && $setting['cover_background_image'])
				{
					$cover_resize_method = 0;
					if (isset($setting['cover_resize_method']))
					{
						$cover_resize_method = (int)$data['cover_resize_method'];
					}
					
					if (isset($data['cover_background_image']) && $data['cover_background_image'])
					switch($cover_resize_method)
					{
						case 1:
						$data['cover_background_image'] = $this->model_tool_image->cropsize($data['cover_background_image'], $data['cover_image_width'], $data['cover_image_height']);
						break;
						case 2:
						$data['cover_background_image'] = $this->model_tool_image->resizewidth($data['cover_background_image'], $data['cover_image_width'], $data['cover_image_height']);
						break;
						case 3:
						$data['cover_background_image'] = $this->model_tool_image->resizeheight($data['cover_background_image'], $data['cover_image_width'], $data['cover_image_height']);
						break;
						default:
						$data['cover_background_image'] = $this->model_tool_image->resize/*keep*/($data['cover_background_image'], $data['cover_image_width'], $data['cover_image_height']);
					}
				}
			}
			//$lang_code = $this->language->get('code');		
			
			
			$data['heading_title'] = $this->language->get('heading_title');
			
			$data['button_cart'] = $this->language->get('button_cart');
			$data['button_compare'] = $this->language->get('button_compare');
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			
			$this->load->model('design/banner');

			$this->load->model('catalog/product'); 
			
			$this->load->model('tool/image');
			
			$data['products'] = array();

			
			if (isset($setting['title'][$lang_code])) $title = $setting['title'][$lang_code];else if (isset($setting['title'][$default_lang])) $title = $setting['title'][$default_lang];else $title = '';
			$data['title'] = $title;
			
			
			$data['cols_xs'] = isset($setting['module_cols_xs'])?$setting['module_cols_xs']:1;
			$data['cols_sm'] = isset($setting['module_cols_sm'])?$setting['module_cols_sm']:2;
			$data['cols_md'] = isset($setting['module_cols_md'])?$setting['module_cols_md']:4;
			$data['cols_lg'] = isset($setting['module_cols_lg'])?$setting['module_cols_lg']:4;
			
			$data['type'] = isset($setting['type'])?$setting['type']:'list';
			
			//var_dump($setting);
			
			if (isset($setting['section'])) foreach ($setting['section'] as $nr => $section)
			{
				$data['section'][$nr]['title'] = isset($section['title'][$lang_code])?$section['title'][$lang_code]:$section['title'][$default_lang];
				$products = array();
				switch($section['section_type'])
				{
					case 'autocomplete':
						$products_list = explode(',', $section['product_list']);

						foreach ($products_list as $product_id) 
						{
							$products[] = $this->model_catalog_product->getProduct((int)$product_id);
						}
						break;
					case 'latest':
						$opt = array(
						'sort'  => 'p.date_added',
						'order' => 'DESC',
						'start' => 0,
						'limit' => $section['latest_limit']
						);

						$products = $this->model_catalog_product->getProducts($opt);
						//$products = $this->model_catalog_product->getLatestProducts($section['latest_limit']);
						break;
					case 'bestsellers':
						$products = $this->model_catalog_product->getBestSellerProducts($section['bestsellers_limit']);
						break;
					case 'specials':
						$opt = array(
							'sort'  => 'pd.name',
							'order' => 'ASC',
							'start' => 0,
							'limit' => $section['specials_limit']
						);

						$products = $this->model_catalog_product->getProductSpecials($opt);
						break;
					case 'category':
						$opt = array(
							'filter_category_id' => isset($section['category'])?$section['category']:0,
							'sort'               => 'p.date_added',
							'order'              => $section['category_sort'],
							'start'              => 0,
							'limit'              => $section['category_limit']
						);
								
						$products = $this->model_catalog_product->getProducts($opt);
						break;
					case 'manufacturer':
						$opt = array(
							'filter_manufacturer_id' => $section['manufacturer'], 
							'sort'               => 'p.date_added',
							'order'              => $section['manufacturer_sort'],
							'start'              => 0,
							'limit'              => $section['manufacturer_limit']
						);
								
						$products = $this->model_catalog_product->getProducts($opt);
						break;
						
					case 'popular':

						$products = $this->model_catalog_product->getPopularProducts($section['popular_limit']);
						break;
					case 'recentlyviewed':

						$products_list = $this->getViewedProducts($section['recentlyviewed_limit']);
						
						foreach ($products_list as $product_id) 
						{
							$products[] = $this->model_catalog_product->getProduct((int)$product_id);
						}
						break;
					case 'random':

						$products = $this->getRandomProducts($section['random_limit'], $section['random_cache'] === 'true'? true: false);
						break;
					case 'related':

						if (isset($this->request->get['product_id']))
						$products = $this->getProductRelated($this->request->get['product_id'], $section['related_limit'], $section['related_same_category']);
						//$products = $this->getProductAlsoBought($this->request->get['product_id'], $section['related_limit']);
						break;
					case 'alsobought':

						if (isset($this->request->get['product_id']))
						$products = $this->getProductAlsoBought($this->request->get['product_id'], $section['alsobought_limit']);
						break;
				}
				
				$HTTP_SERVER = substr(HTTP_SERVER, 0, strpos(HTTP_SERVER, '/', 8));
				$HTTPS_SERVER = substr(HTTP_SERVER, 0, strpos(HTTP_SERVER, '/', 8));
				
				if (isset($products) && is_array($products)) foreach ($products as $product_info) 
				{
					if ($product_info && isset($product_info['product_id'])) 
					{
						if ($product_info['image']) 
						{
							switch($resize_method)
							{
								case 1:
								$image = $this->model_tool_image->cropsize($product_info['image'], $setting['image_width'], $setting['image_height']);
								break;
								case 2:
								$image = $this->model_tool_image->resizewidth($product_info['image'], $setting['image_width'], $setting['image_height']);
								break;
								case 3:
								$image = $this->model_tool_image->resizeheight($product_info['image'], $setting['image_width'], $setting['image_height']);
								break;
								default:
								$image = $this->model_tool_image->resize/*keep*/($product_info['image'], $setting['image_width'], $setting['image_height']);
								break;
							}
						} else {
							$image = false;
						}
						
						$additional_image = '';
						
						if ($setting['additional_image'] == '1')
						{
							$product_images = $this->model_catalog_product->getProductImages($product_info['product_id']);
							if (isset($product_images[1]))
							{
								if ($resize_method)
								$additional_image = $this->model_tool_image->cropsize($product_images[1]['image'], $setting['image_width'], $setting['image_height']);
								else 
								$additional_image = $this->model_tool_image->resize/*keep*/($product_images[1]['image'], $setting['image_width'], $setting['image_height']);
							}
						}

						if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) 
						{
							$_price = $this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax'));
							$price = $this->currency->format($_price, $this->session->data['currency']);
						} else {
							$_price = false;
							$price = false;
						}
								
						if (isset($product_info['special']) && (float)$product_info['special']) 
						{
							
							$_special = $this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax'));
							$special = $this->currency->format($_special, $this->session->data['currency']);
						} else {
							$_special = false;
							$special = false;
						}
						
						if ($this->config->get('config_review_status') && isset($product_info['rating'])) 
						{
							$rating = $product_info['rating'];
						} else {
							$rating = false;
						}
						$product = 
						array(
							'product_id' => $product_info['product_id'],
							'thumb'   	 => $image,
							'name'    	 => $product_info['name'],
							'quantity'    	 => ($product_info['quantity'])?$product_info['quantity']:0,
							'stock_status'    	 => (isset($product_info['stock_status']))?$product_info['stock_status']:'',
							
							'price'   	 => $price,
							'_price'   	 => $_price,
							'special' 	 => $special,
							'_special' 	 => $_special,
							'rating'     => $rating,
							'href'    	 => str_replace(array($HTTP_SERVER, $HTTPS_SERVER), '', $this->url->link('product/product', 'product_id=' . $product_info['product_id'])),
							'additional_image' 	 => $additional_image,
							'viewed' => $product_info['viewed'],
							'date_added' => $product_info['date_added'],
							'days_added' => round((time() - strtotime($product_info['date_added'])) / (60 * 60 * 24)),
						);
						
						if (isset($product_info['description']))  $product['description'] = utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, 100);
						if (isset($product_info['reviews']))  $product['reviews'] = sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']);
						$data['products'][$nr][] = $product;
					}
				}
			}

			$this->cache->set($key, $data);
		}
		
		return $this->_render('nicocustomproducts', $data);
	}
}
