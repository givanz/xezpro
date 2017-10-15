<?php
include_once(DIR_APPLICATION . '/controller/module/nicomodule.inc');
class ControllerModuleNicofilter extends NicoModule
{
	public function index($setting) 
	{
		$opencart_version = (int)str_replace('.','',VERSION);

		if (isset($setting['nicofilter_module'][1])) $setting = $setting['nicofilter_module'][1];
		$data = $setting;

		if (isset($this->request->get['path'])) {
			if (is_numeric($this->request->get['path']))
			{
				$category_id  = (int)$this->request->get['path'];
			} else
			{
				$parts = explode('_', (string)$this->request->get['path']);
				$category_id = (int)end($parts);
			}
		}
		
		$this->request->get['category'] = $category_id;

		if ($category_id && !(isset($this->request->get['filter_category']))) $this->request->get['filter_category'] = $category_id;

		$this->load->model('module/nicofilter');
		
		$filter_sql = $this->model_module_nicofilter->build_filters($this->request->get);
		$filter_sql_options = $this->model_module_nicofilter->build_filters($this->request->get, true);
		$filter_sql_joins = $this->model_module_nicofilter->get_joins();

		$lang_code = isset($this->session->data['language'])?$this->session->data['language']:$this->language->get('code');
		
		if (!$lang_code || is_object($lang_code)) $lang_code = $lang_code->get('code');
		
		$lang_code = strtolower($lang_code);

		$default_lang = 'en';

		if ($opencart_version >= 2200)
		{
			$default_lang = 'en-gb';
		}

		if (isset($setting['price_text'][$lang_code])) $data['price_text'] = $setting['price_text'][$lang_code];else if (isset($setting['price_text'][$default_lang])) $data['price_text'] = $setting['price_text'][$default_lang];else $data['price_text'] = '';
		if (isset($setting['manufacturers_text'][$lang_code])) $data['manufacturers_text'] = $setting['manufacturers_text'][$lang_code];else if (isset($setting['manufacturers_text'][$default_lang])) $data['manufacturers_text'] = $setting['manufacturers_text'][$default_lang];else $data['manufacturers_text'] = '';
		if (isset($setting['availability_text'][$lang_code])) $data['availability_text'] = $setting['availability_text'][$lang_code];else if (isset($setting['availability_text'][$default_lang])) $data['availability_text'] = $setting['availability_text'][$default_lang];else $data['availability_text'] = '';
		if (isset($setting['categories_text'][$lang_code])) $data['categories_text'] = $setting['categories_text'][$lang_code];else if (isset($setting['categories_text'][$default_lang])) $data['categories_text'] = $setting['categories_text'][$default_lang];else $data['categories_text'] = '';
		if (isset($setting['tag_text'][$lang_code])) $data['tag_text'] = $setting['tag_text'][$lang_code];else if (isset($setting['tag_text'][$default_lang])) $data['tag_text'] = $setting['tag_text'][$default_lang];else $data['tag_text'] = '';
		if (isset($setting['name_text'][$lang_code])) $data['name_text'] = $setting['name_text'][$lang_code];else if (isset($setting['name_text'][$default_lang])) $data['name_text'] = $setting['name_text'][$default_lang];else $data['name_text'] = '';


		if ((int)$setting['price'] == 1) $data = array_merge($data, $this->model_module_nicofilter->price($this->model_module_nicofilter->build_filters($this->request->get, array('price'))));
		if (isset($setting['manufacturers']) && (int)$setting['manufacturers'] == 1) $data['manufacturers'] = $this->model_module_nicofilter->manufacturers($filter_sql, isset($setting['manufacturers_image_width'])?$setting['manufacturers_image_width']:100, isset($setting['manufacturers_image_height'])?$setting['manufacturers_image_height']:30);
		if ((int)$setting['categories'] == 1) $data['categories'] = $this->model_module_nicofilter->categories($category_id);
		if ((int)$setting['filters'] == 1) $data['filters'] = $this->model_module_nicofilter->filters($category_id);
		if ((int)$setting['availability'] == 1) $data['availability'] = array(1 => 'In stock');
		if ((int)$setting['options'] == 1) $data['options'] = $this->model_module_nicofilter->get_options($category_id, $filter_sql_options);
		if ((int)$setting['attributes'] == 1) $data['attributes'] = $this->model_module_nicofilter->get_attributes($category_id, $filter_sql_options, $filter_sql_joins);

		if (isset($this->request->get['filter_manufacturer'])) {
			$data['manufacturer_category'] = explode(',', $this->request->get['filter_manufacturer']);
		} else {
			$data['manufacturer_category'] = array();
		}
		
		if (isset($this->request->get['filter_category'])) {
			$data['category_category'] = explode(',', $this->request->get['filter_category']);
		} else {
			$data['category_category'] = array();
		}
	

		if (isset($this->request->get['filter'])) {
			$data['filter_category'] = explode(',', $this->request->get['filter']);
		} else {
			$data['filter_category'] = array();
		}			

		if (isset($this->request->get['filter_availability'])) {
			$data['availability_category'] = explode(',', $this->request->get['filter_availability']);
		} else {
			$data['availability_category'] = array();
		}						
		
		if (isset($this->request->get['filter_option'])) {
			$data['option_category'] = explode(',', $this->request->get['filter_option']);
			//$data['option_category'] = $this->request->get['filter_option'];
			/*foreach($data['option_category'] as $key => &$filter_value) 
			{
				if (strpos($filter_value, ',') !== false) $filter_value = explode(',', $filter_value);
			}*/
			//explode(',', $this->request->get['filter_option']);
		} else {
			$data['option_category'] = array();
		}			
		if (isset($this->request->get['filter_attribute'])) {
			$data['attribute_category'] = $this->request->get['filter_attribute'];
			foreach($data['attribute_category'] as $key => &$filter_value) 
			{
				if (strpos($filter_value, ',') !== false) $filter_value = explode(',', $filter_value);
			}

		} else {
			$data['attribute_category'] = array();
		}			

		if (isset($this->request->get['filter_price_min'])) {
			$data['price_min'] = $this->request->get['filter_price_min'];
			$data['price_max'] = $this->request->get['filter_price_max'];
		} else {
			$data['price_max'] = isset($data['price_max_limit'])?$data['price_max_limit']:-1;
			$data['price_min'] = isset($data['price_min_limit'])?$data['price_min_limit']:-1;
		}		
		
		$data['sort_order'] = array('price' => $data['price_sort_order'], 'filters' => $data['filters_sort_order'], 'manufacturers' => ($data['manufacturers_sort_order'])?$data['manufacturers_sort_order']:0, 'availability' => $data['availability_sort_order'], 'options' => $data['options_sort_order'], 'categories' => $data['categories_sort_order'], 'attributes' => $data['attributes_sort_order'], 'tag' => $data['tag_sort_order'], 'name' => $data['name_sort_order']);

		asort($data['sort_order']);
		
		$data['sort_order'] = array_flip(array_keys($data['sort_order']));
		
		$this->load->language('module/filter');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['button_filter'] = $this->language->get('button_filter');

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['limit'])) {
			$url .= '&limit=' . $this->request->get['limit'];
		}

		if (!isset($this->request->get['route'])) $this->request->get['route'] = 'common/home';
		$data['action'] = str_replace('&amp;', '&', $this->url->link($this->request->get['route'], 'path=' . (isset($this->request->get['path'])?$this->request->get['path']:'') . $url));

		return $this->_render('nicofilter', $data);
	}
}
