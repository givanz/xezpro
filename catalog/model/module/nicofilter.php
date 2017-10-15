<?php
class ModelModuleNicoFilter extends Model 
{
	static $joins = array();
	
	protected $lang_code;
	protected $currency;
	
	
	public function substract_taxes($value, $calculate = true, $category, $tax_class_id = false) {
		if (!$tax_class_id)
		{
			//get class id from first active product
			$sql = 'SELECT tax_class_id FROM ' . DB_PREFIX . "product p 
					LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) 
					LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)
					WHERE 
					p2s.store_id = " . (int)$this->config->get('config_store_id') . ' LIMIT 1';
			
			$query = $this->db->query($sql);
			$tax_class_id = $query->rows[0]['tax_class_id'];
		}
		
			if ($calculate != 'P') {
				$amount_fixed = 0;
				$tax_rates_amount = $this->tax->getRates($value, $tax_class_id);

				foreach ($tax_rates_amount as $tax_rate) {
					if ($calculate == 'F') {
						$amount_fixed += $tax_rate['amount'];
					}
				}
				
				$value -= $amount_fixed;
			}
			
			if ($calculate != 'F') {
				$amount_percent = 0;
				$tax_rates_percent = $this->tax->getRates(100, $tax_class_id);
				foreach ($tax_rates_percent as $tax_rate) {
					if ($calculate == 'P') {
						$amount_percent += ($value / 100 * $tax_rate['rate']);
					}
				}
				
				$value -= ceil($amount_percent);
			}

			return (int)$value;
	}
	
	public function build_filters($filters, $ignore = array())
	{
		
		$this->lang_code = isset($this->session->data['language'])?$this->session->data['language']:$this->language->get('code');
		
		if (!$this->lang_code || is_object($this->lang_code)) $this->lang_code = $this->lang_code->get('code');
		
		$this->lang_code = strtolower($this->lang_code);

		$this->currency = isset($this->session->data['currency'])?$this->session->data['currency']:$this->currency->getCode();
		
		if (!isset($filters['category']) && isset($this->request->get['path'])) {
			if (is_numeric($this->request->get['path']))
			{
				$filters['category']  = (int)$this->request->get['path'];
			} else
			{
				$parts = explode('_', (string)$this->request->get['path']);
				$filters['category'] = (int)end($parts);
			}
		}
		
		$first = true;
		$filter_sql = '';
		self :: $joins = array();
		
		foreach ($filters as $filter_name => $filter_value)
		{
			if (strpos($filter_name, 'filter_') !== false)
			{
				//filter value
				//filter name
				if (!$filter_value) continue;
				
				$filter_name = str_replace('filter_','',$filter_name);
				if (!is_array($filter_value) && strpos($filter_value, ',') !== false) $filter_value = explode(',', $filter_value);
				//if (!$first) 
				//$filter_sql .= ' AND ';

				if (is_array($filter_value))  
				{
					array_filter($filter_value, array($this->db, 'escape'));
					$value = 'IN (\'' . implode('\',\'', $filter_value) .'\')'; 
				}
				else if (is_numeric($filter_value))  $value = ' = '. $this->db->escape($filter_value);
				else $value = " = '" . $this->db->escape($filter_value). "'";

				switch ($filter_name)
				{
					case 'price_min':
					if (is_array($ignore) && in_array('price', $ignore)) continue;
					$price = $this->substract_taxes($filter_value, true, $filters['category']);
					$filter_sql .= ' AND (p.price >= ' . (int)$price. ' OR ps.price >= ' . (int)$price. ')';
					self :: $joins['price'] = ' LEFT JOIN ' . DB_PREFIX . 'product_special ps ON (p.product_id = ps.product_id) ';
					break;
					case 'price_max':
					if (is_array($ignore) && in_array('price', $ignore)) continue;
					$price = $this->substract_taxes($filter_value, true, $filters['category']);
					$filter_sql .= ' AND (p.price <= ' . (int)$price. ' OR ps.price <= ' . (int)$price. ')';
					self :: $joins['price'] = ' LEFT JOIN ' . DB_PREFIX . 'product_special ps ON (p.product_id = ps.product_id) ';
					break;
					case 'manufacturer':
					$filter_sql .= ' AND p.manufacturer_id ' . $value;
					break;
					case 'category':
					
					$sql = "
					(SELECT category_id FROM " . DB_PREFIX . "category WHERE category_id  $value)
					UNION 
					(SELECT category_id FROM " . DB_PREFIX . "category WHERE parent_id $value)
					UNION 
					(SELECT category_id FROM " . DB_PREFIX . "category WHERE parent_id in (SELECT category_id FROM " . DB_PREFIX . "category WHERE parent_id  $value))";
	
					//$query->rows;
					
					
				    $query = $this->db->query($sql);


					if ($query->num_rows > 1) 
					{
						$filter_sql .= ' AND p2c.category_id IN (';
						$i = 0;
						foreach ($query->rows as $row) 
						{
							$filter_sql .= $row['category_id'];
							$i++;
							if ($i<$query->num_rows) $filter_sql .= ',';
						}
						$filter_sql .= ')';
					}
					else $filter_sql .= ' AND p2c.category_id ' . $value;
					
					break;
					case 'option':
					self :: $joins['option'] = ' INNER JOIN ' . DB_PREFIX . 'product_option_value pov ON (p.product_id = pov.product_id) ';
						
					/*if (is_array($filter_value))  
					{
						$value = '';
						$_first = true;
						foreach ($filter_value as $fil => $val)
						{
							if (!$_first) $value .= ' AND pov2.option_value_id';
							$value .= " = $val ";
							$_first = false;
						}
					}
					else $value = " = '" . $this->db->escape($filter_value). "'";					
					*/
					$_count = count($filter_value);
					$filter_sql .= ' AND pov.product_id IN (SELECT product_id FROM ' . DB_PREFIX . 'product_option_value pov2 WHERE pov2.option_value_id ' . $value . " GROUP by product_id HAVING count(product_id) >= $_count)";
					/*
					if ($options)
					$filter_sql .= ' AND pov.product_id IN (SELECT product_id FROM product_option_value pov2 WHERE pov2.option_value_id ' . $value . ')';
					else
					$filter_sql .= ' AND pov.option_value_id ' . $value;*/
					break;
					case 'attribute':
					self :: $joins['attribute'] = ' INNER JOIN ' . DB_PREFIX . 'product_attribute pa  ON (p.product_id = pa.product_id) ';
				
					$filter_sql .= ' AND pa.text ' . $value;
					break;
					case 'category':
					$filter_sql .= ' AND p2c.category_id ' . $value;
					break;
					case 'availability':
					if ($value)	$filter_sql .= ' AND p.quantity > 0 '; else $filter_sql .= ' 1 ';
					break;
				}
				if ($first) $first = false;
				//$filters[$filter_name] = $filter_value;
			}
		}
		return $filter_sql;
	}
	
	public function get_joins()
	{
		return implode(' ',self :: $joins);
	}

	public function price($filter_sql = '')
	{
		$cache_key = 'nico_filter.price.' . (int)$this->config->get('config_store_id') . '.' . $this->lang_code . '.' . $this->currency . '.' . md5($filter_sql);
		$data = $this->cache->get($cache_key);
		
		if (!$data) 
		{
			
			$sql = "SELECT MAX(p.price) as price_max_limit, MIN(p.price) as price_min_limit, tax_class_id FROM " . DB_PREFIX . "product p 
					LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) 
					LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)
					LEFT JOIN " . DB_PREFIX . "product_option_value pov  ON (p.product_id = pov.product_id)
					LEFT JOIN " . DB_PREFIX . "product_attribute pa  ON (p.product_id = pa.product_id)
					WHERE 
					p2s.store_id = " . (int)$this->config->get('config_store_id') .
					' ' . $filter_sql;
					
			//if ($filter_sql) $sql .= " AND " . $filter_sql;
			$sql .= ' LIMIT 1';

			$query = $this->db->query($sql);
			
			
			$special_sql = "SELECT MAX(ps.price) as price_max_limit, MIN(ps.price) as price_min_limit, tax_class_id FROM " . DB_PREFIX . "product p 
					INNER JOIN " . DB_PREFIX . "product_special ps ON (p.product_id = ps.product_id) 
					LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) 
					LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)
					LEFT JOIN " . DB_PREFIX . "product_option_value pov  ON (p.product_id = pov.product_id)
					LEFT JOIN " . DB_PREFIX . "product_attribute pa  ON (p.product_id = pa.product_id)
					WHERE 
					p2s.store_id = " . (int)$this->config->get('config_store_id') .
					' ' . $filter_sql;
					
			//if ($filter_sql) $sql .= " AND " . $filter_sql;
			$special_sql .= ' LIMIT 1';

			$special_query = $this->db->query($special_sql);
			
			$price_min_limit = round($this->tax->calculate($query->rows[0]['price_min_limit'], $query->rows[0]['tax_class_id'], $this->config->get('config_tax')));
			$special_price_min_limit = round($this->tax->calculate($special_query->rows[0]['price_min_limit'], $special_query->rows[0]['tax_class_id'], $this->config->get('config_tax')));

			$price_min_limit_no_tax = round($this->tax->calculate($query->rows[0]['price_min_limit'], $query->rows[0]['tax_class_id'], $this->config->get('config_tax')));
			$special_price_min_limit_no_tax = round($this->tax->calculate($special_query->rows[0]['price_min_limit'], $special_query->rows[0]['tax_class_id'], $this->config->get('config_tax')));
			
			return 
				array(
				'price_max_limit' => round($this->tax->calculate($query->rows[0]['price_max_limit'], $query->rows[0]['tax_class_id'], $this->config->get('config_tax'))),
				//'price_min_limit' => $query->rows[0]['price_min_limit']//round($this->tax->calculate($query->rows[0]['price_min_limit'], $query->rows[0]['tax_class_id'], $this->config->get('config_tax')))
				'price_min_limit' => min($special_price_min_limit, $price_min_limit),
				'price_min_limit_no_tax' => min($query->rows[0]['price_min_limit'], $special_query->rows[0]['price_min_limit'])
				);
			
			$data = $query->rows[0];
			$this->cache->set($cache_key, $data);
		}

		return $data;			
	}
	
	public function manufacturers($filter_sql = '', $width = 100, $height = 30)
	{
		$cache_key = 'nico_filter.manufacturers.' . (int)$this->config->get('config_store_id') . '.' . $this->lang_code . '.' . $this->currency . '.' . md5($filter_sql);
		
		
		$data = $this->cache->get($cache_key);
		
		if (!$data) 
		{

			//, count(p.product_id) as prod_count 
			$sql = "SELECT *,m.image as image FROM " . DB_PREFIX . "manufacturer m 
					LEFT JOIN " . DB_PREFIX . "manufacturer_to_store m2s ON (m.manufacturer_id = m2s.manufacturer_id) 
					INNER JOIN  " . DB_PREFIX . "product p  ON (m.manufacturer_id = p.manufacturer_id)
					LEFT JOIN " . DB_PREFIX . "product_special ps ON (p.product_id = ps.product_id)  
					LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)
					LEFT JOIN " . DB_PREFIX . "product_option_value pov  ON (p.product_id = pov.product_id)
					LEFT JOIN " . DB_PREFIX . "product_attribute pa  ON (p.product_id = pa.product_id)
					WHERE 
					m2s.store_id = ". (int)$this->config->get('config_store_id');
			
			if ($filter_sql) $sql .= $filter_sql;
			
			$sql .= ' GROUP BY(m.manufacturer_id)';
			

			$query = $this->db->query($sql);
			
			$manufacturers = $query->rows;

			$this->load->model('tool/image');
			$width = ($width)?$width:100;
			$height = ($height)?$height:30;
			foreach ($manufacturers as &$manufacturer)
			{
				if (!empty($manufacturer['image'])) $manufacturer['thumb'] = $this->model_tool_image->resizeheight($manufacturer['image'], $width, $height);			
				$manufacturer['url'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $manufacturer['manufacturer_id']);
			}
			
			$data =  $manufacturers;
			$this->cache->set($cache_key, $data);
		}

		return $data;			
	}

	public function get_attributes($category_id = 0, $filter_sql, $sql_joins)
	{
		$cache_key = 'nico_filter.attributes.' . (int)$this->config->get('config_store_id') . '.' . $this->lang_code . '.' . $this->currency . '.' . md5($filter_sql);
		$data = $this->cache->get($cache_key);
		
		if (!$data) 
		{
			$product_attribute_data = array();
	//LEFT JOIN " . DB_PREFIX . "attribute a ON (pa1.attribute_id = a.attribute_id)
			 $sql = "SELECT pa1.attribute_id, ad.name, pa1.text,count(pa1.product_id) as prod_count FROM " . DB_PREFIX . "product_attribute pa1 
			 
			 LEFT JOIN " . DB_PREFIX . "attribute_description ad ON (pa1.attribute_id = ad.attribute_id)
			 WHERE ad.language_id = '" . (int)$this->config->get('config_language_id') . "' AND pa1.language_id = '" . (int)$this->config->get('config_language_id') . "' 
			 AND product_id IN (
			 SELECT p.product_id FROM 
			 " . DB_PREFIX . "product p
			 INNER JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id) " . $sql_joins . "
			 ". $filter_sql .
			 ") GROUP BY pa1.attribute_id,text ORDER BY ad.name";

			$product_attribute_query = $this->db->query($sql);
		
			if ($product_attribute_query)
			foreach ($product_attribute_query->rows as $product_attribute) {
				
				//if (isset($count[$product_attribute['name']][$product_attribute['attribute_id']])) $count[$product_attribute['name']][$product_attribute['attribute_id']]++; else $count[$product_attribute['name']][$product_attribute['attribute_id']] = 1;
				
				$product_attribute_data[$product_attribute['name']][] = array(
					'attribute_id' => $product_attribute['attribute_id'],
					'name'         => $product_attribute['name'],
					'text'         => $product_attribute['text'],
					'prod_count'   => $product_attribute['prod_count']
				);
			}
			//set count
			/*
			foreach ($product_attribute_data as $name => &$attributes) 
			foreach ($attributes as &$product_attribute);
			{
				$product_attribute['prod_count'] =  $count[$product_attribute['name']][$product_attribute['attribute_id']];
			}*/

			$data =  $product_attribute_data;
			$this->cache->set($cache_key, $data);
		}

		return $data;			
	}

	
	public function categories($parent_id = 0)
	{
		$cache_key = 'nico_filter.categories.' . (int)$this->config->get('config_store_id') . '.' . $this->lang_code . '.' . $this->currency . '.' . $parent_id;
		$data = $this->cache->get($cache_key);
		
		if (!$data) 
		{
		
			$query = $this->db->query(
			"SELECT *,c.category_id as category_id,count(p2c.product_id) as prod_count FROM " . DB_PREFIX . "category c 
			LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) 
			LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) 
			LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (c.category_id = p2c.category_id) 
			WHERE c.parent_id = '" . (int)$parent_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . ' ' .  "'  AND c.status = '1' GROUP BY c.category_id ORDER BY c.sort_order, LCASE(cd.name)");

			$data =  $query->rows;
			$this->cache->set($cache_key, $data);
		}

		return $data;			
	}
	
	public function filters($category_id = 0)
	{
		$cache_key = 'nico_filter.filters.' . (int)$this->config->get('config_store_id') . '.' . $this->lang_code . '.' . $this->currency . '.'  . $category_id;
		$data = $this->cache->get($cache_key);
		
		if (!$data) 
		{
		
			$this->load->model('catalog/category');

			$filters = array();

			$nicofilter_groups = $this->model_catalog_category->getCategoryFilters($category_id);

			foreach ($nicofilter_groups as $nicofilter_group) {
				$childen_data = array();

				foreach ($nicofilter_group['filter'] as $nicofilter) {
					$nicofilter_data = array(
						'filter_category_id' => $category_id,
						'filter_filter'      => $nicofilter['filter_id']
					);

					$childen_data[] = array(
						'filter_id' => $nicofilter['filter_id'],
						'name'      => $nicofilter['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($nicofilter_data) . ')' : '')
					);
				}

				$filters[] = array(
					'filter_group_id' => $nicofilter_group['filter_group_id'],
					'name'            => $nicofilter_group['name'],
					'filter'          => $childen_data
				);
			}

			$data =  $filters;
			$this->cache->set($cache_key, $data);
		}

		return $data;			
	}

	public function get_options($category_id = 0, $filter_sql)
	{
		$cache_key = 'nico_filter.options.' . (int)$this->config->get('config_store_id') . '.' . $this->lang_code . '.' . $this->currency . '.' . md5($filter_sql);
		$data = $this->cache->get($cache_key);
		
		if (!$data) 
		{
		
		$product_option_data = array();
		/*$sql = "SELECT * FROM " . DB_PREFIX . "product_option po LEFT JOIN `" . DB_PREFIX . "option` o ON (po.option_id = o.option_id) 
			LEFT JOIN " . DB_PREFIX . "option_description od ON (o.option_id = od.option_id) 
			INNER JOIN " . DB_PREFIX . "product_to_category ptc ON (po.product_id = ptc.product_id AND ptc.category_id = $category_id) 
			WHERE od.language_id = '" . (int)$this->config->get('config_language_id') . "'
				ORDER BY o.sort_order";

		$product_option_query = $this->db->query($sql);

		foreach ($product_option_query->rows as $product_option) {
			$product_option_value_data = array();*/
			$category_join = '';
			if ($category_id) $category_join =  "AND p2c.category_id = $category_id";
		
			$sql = 
			"SELECT *,od.name as option_name, ovd.name as value_name, ov.image as value_image, count(p.product_id) as prod_count 
				FROM " . DB_PREFIX . "product_option_value pov 
			LEFT JOIN " . DB_PREFIX . "option_value ov ON (pov.option_value_id = ov.option_value_id) 
			LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) 
			LEFT JOIN `" . DB_PREFIX . "option` po  ON (pov.option_id = po.option_id) 
			LEFT JOIN " . DB_PREFIX . "option_description od ON (po.option_id = od.option_id) 
			INNER JOIN " . DB_PREFIX . "product_to_category p2c ON (pov.product_id = p2c.product_id $category_join)
			LEFT JOIN " . DB_PREFIX . "product_attribute pa  ON (pov.product_id = pa.product_id)
			INNER JOIN  " . DB_PREFIX . "product p  ON (p.product_id = p2c.product_id) 
			LEFT JOIN " . DB_PREFIX . "product_special ps ON (p.product_id = ps.product_id) 
			WHERE ovd.language_id = '" . (int)$this->config->get('config_language_id') ."' ". $filter_sql . " GROUP BY ov.option_value_id";

			$product_option_value_query = $this->db->query($sql);
			$this->load->model('tool/image');
			
			foreach ($product_option_value_query->rows as $product_option_value) {
				$product_option_data[$product_option_value['option_name']][] = array(
					'product_option_id'    => $product_option_value['product_option_id'],
					'product_option_value' => $product_option_value,
					'option_id'            => $product_option_value['option_id'],
					'type'                 => $product_option_value['type'],
					'product_option_value_id' => $product_option_value['product_option_value_id'],
					'option_value_id'         => $product_option_value['option_value_id'],
					'name'                    => $product_option_value['value_name'],
					'image'                   => $this->model_tool_image->resize($product_option_value['value_image'], 20, 20),
					'quantity'                => $product_option_value['quantity'],
					'prod_count'                => $product_option_value['prod_count'],
					'subtract'                => $product_option_value['subtract'],
					'price'                   => $product_option_value['price'],
					'price_prefix'            => $product_option_value['price_prefix'],
					'weight'                  => $product_option_value['weight'],
					'weight_prefix'           => $product_option_value['weight_prefix']			);
			}
		//}

			$data = $product_option_data;
			$this->cache->set($cache_key, $data);
		}

		return $data;			
		
		return $product_option_data;
		
		
		$sql = "SELECT *,option_description.name as option_name, option_value_description.name as value_name FROM  `" . DB_PREFIX . "product_option_value` LEFT JOIN `". DB_PREFIX . "option_value` ON product_option_value.option_value_id = option_value.option_value_id LEFT JOIN `". DB_PREFIX . "option_value_description` ON product_option_value.option_value_id = option_value_description.option_value_id LEFT JOIN `". DB_PREFIX . "option_description` ON product_option_value.option_id = option_value.option_id ";
		  
		$query = $this->db->query($sql);

		foreach ($query->rows as $option)
		{
			$options[$option['option_name']][$option['value_name']] = $option;
		}
		
		return $options;
	}
}
