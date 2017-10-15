<?php
include_once(DIR_APPLICATION . '/controller/module/nicomodule.inc');
global $_nico_module_counter;
class ControllerModuleNicodisqus  extends NicoModule
{
	public function index($setting) 
	{
		if (!$this->is_filter_ok($setting)) return false;
		$opencart_version = (int)str_replace('.','',VERSION);

		$lang_code = isset($this->session->data['language'])?$this->session->data['language']:$this->language->get('code');
		
		if (!$lang_code || is_object($lang_code)) $lang_code = $lang_code->get('code');
		
		$lang_code = strtolower($lang_code);

		$default_lang = 'en';

		if ($opencart_version >= 2200)
		{
			$default_lang = 'en-gb';
		}
		
		$data = $setting;



		if (isset($this->request->get['product_id'])){
			$identifier = 'pid' . $this->request->get['product_id'];
			$url = $this->url->link('product/product', 'product_id=' . $this->request->get['product_id'], 'SSL');
		} elseif ( $route == 'product/category' && isset($this->request->get['path'])) {
			$parts =  explode('_', $this->request->get['path']);
			$category_id = $parts[ count($parts) - 1];
			
			$identifier = 'cid' . $category_id;
			$url = $this->url->link('product/category', 'path=' . $category_id, 'SSL');
		} elseif ( $route == 'product/manufacturer'){
			if (isset($this->request->get['manufacturer_id'])){
				$url = $this->url->link('product/manufacturer', 'manufacturer_id=' . $this->request->get['manufacturer_id'], 'SSL');
				$identifier = 'mid' . $this->request->get['manufacturer_id'];
			} else {
				$url = $this->url->link('product/manufacturer', '', 'SSL'); 	
			}				
		} elseif ( $route == 'information/information' && isset($this->request->get['information_id'])){
			$url = $this->url->link('information/information', 'information_id=' . $this->request->get['information_id'], 'SSL'); 
			$identifier = 'iid' . $this->request->get['information_id'];
		} else {
	   
				
				$url =  '//' . $this->request->server["SERVER_NAME"] . $this->request->server["REQUEST_URI"];
				/*
				if ($this->request->server["SERVER_PORT"] != "80") {
					$url .= $this->request->server["SERVER_NAME"] . ":" . $this->request->server["SERVER_PORT"] . $this->request->server["REQUEST_URI"];
				} else {
					$url .= $this->request->server["SERVER_NAME"] . $this->request->server["REQUEST_URI"];
				}*/
		}


		if (empty($data['identifier'])) $data['identifier'] = $identifier; 
		if (empty($data['url'])) $data['url'] = $url; 


		global $_nico_module_counter;
		if (isset($_nico_module_counter['nicodisqus'])) $_nico_module_counter['nicodisqus']++; else $_nico_module_counter['nicodisqus'] = 0;
		$data['module_id'] = $_nico_module_counter['nicodisqus'];
		
		return $this->_render('nicodisqus', $data);
	}
}
