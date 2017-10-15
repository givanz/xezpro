<?php
if (!defined('NICO_STANDALONE')) define('NICO_STANDALONE', false);
include_once(DIR_APPLICATION . '/controller/module/nicomodule.inc');
class ControllerModuleNicomegamenu  extends NicoModule
{
	function get_products($product_list)
	{
		$key = 'megamenu_products.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $this->currency_code . '.' . $this->config->get('config_customer_group_id') . md5(json_encode($product_list));
		$products = $this->cache->get($key);

		if (!$products)
		{		
			$this->load->model('tool/image');

			$products_list = explode(',', $product_list);

			$this->load->model('catalog/product');

			foreach ($products_list as $product_id) 
			{
				$_product = $this->model_catalog_product->getProduct((int)$product_id);

				if ($_product['image']) 
				{
					$image = $this->model_tool_image->resize/*keep*/($_product['image'], 200, 160);
				} else {
					$image = false;
				}


				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) 
				{
					$price = $this->currency->format($this->tax->calculate($_product['price'], $_product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$price = false;
				}
						
				if (isset($_product['special']) && (float)$_product['special']) 
				{
					$special = $this->currency->format($this->tax->calculate($_product['special'], $_product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$special = false;
				}
				
				if ($this->config->get('config_review_status') && isset($_product['rating'])) 
				{
					$rating = $_product['rating'];
				} else {
					$rating = false;
				}

				
				$product = 
				array(
					'product_id' => $_product['product_id'],
					'thumb'   	 => $image,
					'name'    	 => $_product['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($_product['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
					
					'price'   	 => $price,
					'special' 	 => $special,
					'rating'     => $rating,
					'href'    	 => $this->url->link('product/product', 'product_id=' . $_product['product_id']),
					'viewed' => $_product['viewed'],
					'date_added' => $_product['date_added'],
					'days_added' => round((time() - strtotime($_product['date_added'])) / (60 * 60 * 24)),
					);
				
				$products[] = $product;					
			}
			
			$this->cache->set($key, $products);
		}

		return $products;
	}

	function get_categories($category)
	{
		$key = 'megamenu_categories.' . $category . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $this->currency_code . '.' . $this->config->get('config_customer_group_id');
		$categories = $this->cache->get($key);

		if (!$categories)
		{			
			$this->load->model('catalog/category');
			$this->load->model('tool/image');
			
			$categories = $this->model_catalog_category->getCategories($category);

			$width = $this->config->get('config_image_category_width');
			$height = $this->config->get('config_image_category_height');
			
			if (!$width)
			{
				$width = $this->config->get($this->config->get('config_theme') . '_image_category_width');
				$height = $this->config->get($this->config->get('config_theme') . '_image_category_height');
			}

			
			if ($categories)
			foreach ($categories as &$category)
			{
				$_category = array();
				$_category['name'] = $category['name'];
				$_category['category_id'] = $category['category_id'];
				$_category['url'] = $this->url->link('product/category', 'path=' . $category['category_id']);
				$_category['thumb'] = '';
				if (!empty($category['image'])) $_category['thumb'] = $this->model_tool_image->resize/*keep*/($category['image'], $width, $height);			
				$_category['children'] = $this->model_catalog_category->getCategories($category['category_id']);
				
				foreach($_category['children'] as &$child)
				{
					$child['url'] = $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id']);	
					$child['children'] = $this->model_catalog_category->getCategories($child['category_id']);

					foreach($child['children'] as &$grandchild)
					{
						$grandchild['url'] = $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id']. '_' . $grandchild['category_id']);	
					}
				}
				
				$category = $_category;
			}
			$this->cache->set($key, $categories);
		}
		
		return $categories;
	}
	
	function get_products_category($category_id, $limit = 4)
	{
		$key = 'products_category.' . $category_id . '-' . $limit . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $this->currency_code . '.' . $this->config->get('config_customer_group_id');
		$products = $this->cache->get($key);

		if (!$products)
		{		
			$this->load->model('tool/image');
			
			switch($category_id)
			{
				case -3:
					$this->load->model('catalog/product');
					$products = $this->model_catalog_product->getBestSellerProducts($limit);
				break;
				case -2:
					$this->load->model('catalog/product');
					$products = $this->model_catalog_product->getPopularProducts($limit);
				break;
				case -1:
					$this->load->model('catalog/product');
					$products = $this->model_catalog_product->getLatestProducts($limit);
				break;
				default:
					$this->load->model('catalog/product');
					$products = $this->model_catalog_product->getProducts(array('filter_category_id' => $category_id, 'start' => 0,'limit' => $limit));
			}

			foreach ($products as &$product) 
			{
			
				if ($product['image']) 
				{
					$product['thumb'] = $this->model_tool_image->resize/*keep*/($product['image'], 200, 160);
				}

				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) 
				{
					$product['price'] = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} 
						
				if (isset($product['special']) && (float)$product['special']) 
				{
					$product['special'] = $this->currency->format($this->tax->calculate($product['special'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$special = false;
				}
				
				if ($this->config->get('config_review_status') && isset($product['rating'])) 
				{
					//$rating = $product['rating'];
				}

				$product['href'] = $this->url->link('product/product', 'product_id=' . $product['product_id']);
			}
			
			$this->cache->set($key, $products);
		}
		
		return $products;
	}
	
	function get_manufacturers($data)
	{
		$key = 'megamenu_manufacturers.' . md5(json_encode($data));
		$manufacturers = $this->cache->get($key);

		$width = $this->config->get('config_image_category_width');
		$height = $this->config->get('config_image_category_height');
		
		if (!$width)
		{
			$width = $this->config->get($this->config->get('config_theme') . '_image_category_width');
			$height = $this->config->get($this->config->get('config_theme') . '_image_category_height');
		}

		if (!$manufacturers)
		{			
			$this->load->model('catalog/manufacturer');
			$this->load->model('tool/image');
			
			$manufacturers = $this->model_catalog_manufacturer->getManufacturers($data);

			foreach ($manufacturers as &$manufacturer)
			{
				if (!empty($manufacturer['image'])) $manufacturer['thumb'] = $this->model_tool_image->resize/*keep*/($manufacturer['image'], $width, $height);			
				$manufacturer['url'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $manufacturer['manufacturer_id']);
			}

			$this->cache->set($key, $manufacturers);
		}
		
		return $manufacturers;
	}	
	
	public function index($setting) 
	{
		if (!$this->is_filter_ok($setting)) return false;

		$opencart_version = (int)str_replace('.','',VERSION);
		$data = array();
		$data = $setting;

		$currency_code = isset($this->session->data['currency'])?$this->session->data['currency']:$this->currency->get('code');
		
		if (is_object($currency_code)) $currency_code = $currency_code->get('code');
		
		$this->currency_code = $currency_code = strtolower($currency_code);

		$lang_code = isset($this->session->data['language'])?$this->session->data['language']:$this->language->get('code');
		
		if (!$lang_code || is_object($lang_code)) $lang_code = $lang_code->get('code');
		
		$lang_code = strtolower($lang_code);

		$default_lang = 'en';

		if ($opencart_version >= 2200)
		{
			$default_lang = 'en-gb';
		}


		if (isset($setting['mobile_text'][$lang_code])) $mobile_text = $setting['mobile_text'][$lang_code];else if (isset($setting['mobile_text'][$default_lang])) $mobile_text = $setting['mobile_text'][$default_lang];else $mobile_text = '';
		$data['mobile_text'] = $mobile_text;
	
		
		if (function_exists('get_magic_quotes_gpc') && get_magic_quotes_gpc()) $setting['menu'] = stripslashes($setting['menu']);
		$data['menu'] = json_decode(html_entity_decode($setting['menu']), true);
		$data['_this'] = $this;
		$data['type'] = $setting['type'];
		$data['button_cart'] = $this->language->get('button_cart');
		

		
		if (NICO_STANDALONE) 
		{
			$this->document->addStyle('catalog/view/css/nicomegamenu.css');
			if ($opencart_version < 2000)
			{
				$this->document->addStyle('catalog/view/javascript/font-awesome/css/font-awesome.min.css');
			}
		}
		
		return $this->_render('nicomegamenu', $data);
	}
}
