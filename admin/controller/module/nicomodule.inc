<?php
global $opencart_version;
$opencart_version = (int)str_replace('.','',VERSION);

class NicoModule extends Controller 
{
	function init(&$data)
	{
		$opencart_version = (int)str_replace('.','',VERSION);
		
		global $_nico_module;

		$data['opencart_version'] = (int)str_replace('.','',VERSION);
		
		if (($data['theme_name'] = $this->config->get('config_theme')) == 'theme_default') {
			$data['theme_name'] = $this->config->get('theme_default_directory');
		} else if ($data['theme_name'] = $this->config->get('config_theme')) {
			$data['theme_name'] = $this->config->get('config_theme');
		} else {
			$data['theme_name'] = $this->config->get('config_template');
		}
		
  		$data['breadcrumbs'] = array();

		$data['modules'] = array();
		
		if ($data['opencart_version'] > 1564)
		{
			$data['home'] = 'common/dashboard';
		} else
		{
			$data['home'] = 'common/home';
		}

		$data['layouts'] = $this->layout();
		//$data['position'] = $this->position();
		
		if ($data['opencart_version'] > 2300)
		{
			$this->load->language('module/'. $_nico_module);
		} else
		if ($data['opencart_version'] > 1564)
		{
			$this->language->load('module/' . $_nico_module);
		} else
		{
			$this->load->language('module/'. $_nico_module);
		}
		$module_path = 'module';
		$extensions_path = 'extension/module';
		if ($opencart_version >= 3000) 
		{
			$module_path = 'extension/module';
			$extensions_path = 'marketplace/extension'	;
			
		} else
		if ($opencart_version >= 2300) 
		{
			$module_path = 'extension/module';
			$extensions_path = 'extension/extension';
		}

		if ($opencart_version > 2000 && !isset($data['no_instances']))
		{
			if ($opencart_version >= 3000)
			{
				$this->load->model('setting/module');
				$module = $this->model_setting_module;
			} else
			{
				$this->load->model('extension/module');
				$module = $this->model_extension_module;
			}

			if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

				//reorder sections		
				if (isset($this->request->post['section']) && isset($this->request->post['section']['1']['order']))		
				{
					usort($this->request->post['section'], function($a, $b) 
					{
						if ((int)$a['order'] == (int)$b['order']) 
						{
							return 0;
						}
						return ((int)$a['order'] < (int)$b['order']) ? -1 : 1;
					});
					
					$i = 0;
					foreach ($this->request->post['section'] as $key => $value)
					{
						$i++;
						$new_sections[$i] = $value;
					}
					
					$this->request->post['section'] = $new_sections;
				}
				
				if (!isset($this->request->get['module_id'])) {
					$module->addModule($_nico_module, $this->request->post);
				} else {
					$module->editModule($this->request->get['module_id'], $this->request->post);
				}
							
				$this->session->data['success'] = $this->language->get('text_success');

				$this->response->redirect($this->url->link($extensions_path, 'token=' . (isset($this->session->data['token'])?$this->session->data['token']:'') . '&user_token=' . (isset($this->session->data['user_token'])?$this->session->data['user_token']:'') . '&type=module', 'SSL'));
			}
		} else
		{
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			//reorder sections		
			if (isset($this->request->post['section']) && isset($this->request->post['section']['1']['order']))		
			{
				usort($this->request->post['section'], function($a, $b) 
				{
					if ((int)$a['order'] == (int)$b['order']) 
					{
						return 0;
					}
					return ((int)$a['order'] < (int)$b['order']) ? -1 : 1;
				});

					$i = 0;
					foreach ($this->request->post['section'] as $key => $value)
					{
						$i++;
						$this->request->post['section'][$i] = $value;
						unset($this->request->post['section'][$key]);
					}
			}

						
			if (($data['opencart_version'] > 2000) && isset($data['no_instances']) && $_nico_module != 'nicocontrolpanel') 
			{
				//if (isset($this->request->post['section'])
				$_post = $this->request->post;
				$this->request->post = array();
				$this->request->post[$_nico_module] = $_post;
			}
			
			$this->model_setting_setting->editSetting($_nico_module, $this->request->post);		
			$this->session->data['success'] = $this->language->get('text_success');
			if ($data['opencart_version'] > 1564)
			{
				$this->response->redirect($this->url->link($extensions_path, 'token=' . (isset($this->session->data['token'])?$this->session->data['token']:'') . '&user_token=' . (isset($this->session->data['user_token'])?$this->session->data['user_token']:'') . '&type=module', 'SSL'));
			} else
			{
				$this->redirect($this->url->link($extensions_path, 'token=' . (isset($this->session->data['token'])?$this->session->data['token']:'') . '&user_token=' . (isset($this->session->data['user_token'])?$this->session->data['user_token']:'') . '&type=module', 'SSL'));
			}

		}
				
			if (isset($this->request->post[$_nico_module  . '_status'])) {
				$data[$_nico_module  . '_status'] = $this->request->post[$_nico_module  . '_status'];
			} else {
				$data[$_nico_module  . '_status'] = $this->config->get($_nico_module  . '_status');
			}
		}

		$this->document->setTitle(strip_tags($this->language->get('heading_title')));

		$data['heading_title'] = strip_tags($this->language->get('heading_title'));		
		
		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
		}

 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		if (isset($this->error['image'])) {
			$data['error_image'] = $this->error['image'];
		} else {
			$data['error_image'] = array();
		}
				

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link($data['home'], 'token=' . (isset($this->session->data['token'])?$this->session->data['token']:'') . '&user_token=' . (isset($this->session->data['user_token'])?$this->session->data['user_token']:'') . '&type=module', 'SSL'),
      		'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link($extensions_path , 'token=' . (isset($this->session->data['token'])?$this->session->data['token']:'') . '&user_token=' . (isset($this->session->data['user_token'])?$this->session->data['user_token']:'') . '&type=module', 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link($module_path . '/' . $_nico_module, 'token=' . (isset($this->session->data['token'])?$this->session->data['token']:'') . '&user_token=' . (isset($this->session->data['user_token'])?$this->session->data['user_token']:'') . '&type=module', 'SSL'),
      		'separator' => ' :: '
   		);
		

		if (!isset($this->request->get['module_id'])) {
		$data['action'] = $this->url->link($module_path . '/' . $_nico_module, 'token=' . (isset($this->session->data['token'])?$this->session->data['token']:'') . '&user_token=' . (isset($this->session->data['user_token'])?$this->session->data['user_token']:''), 'SSL');
		} else {
			$data['action'] = $this->url->link($module_path . '/' . $_nico_module, 'token=' . (isset($this->session->data['token'])?$this->session->data['token']:'') . '&user_token=' . (isset($this->session->data['user_token'])?$this->session->data['user_token']:'') . '&module_id=' . $this->request->get['module_id'], 'SSL');
		}
		
		$data['cancel'] = $this->url->link($extensions_path, 'token=' . (isset($this->session->data['token'])?$this->session->data['token']:'') . '&user_token=' . (isset($this->session->data['user_token'])?$this->session->data['user_token']:'') . '&type=module' , 'SSL');

		if (isset($this->session->data['token'])) $data['token'] = $this->session->data['token'];
		if (isset($this->session->data['user_token'])) 
		{
			$data['user_token'] = $this->session->data['user_token'];
			$data['token'] = $this->session->data['user_token'];
		}

		if ($data['opencart_version'] > 2000 && !isset($data['no_instances']))
		{
			if ($opencart_version >= 3000)
			{
				$this->load->model('setting/module');
				$module = $this->model_setting_module;
			} else
			{
				$this->load->model('extension/module');
				$module = $this->model_extension_module;
			}

			
			if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) 
			{
				$module_info = $module->getModule($this->request->get['module_id']);
				if ($module_info)
				{
					$data = array_merge($data, $module_info);
				}
			}
		} else
		{
			if (isset($this->request->post[$_nico_module . '_module'])) 
			{
				$module_info = $this->request->post[$_nico_module . '_module'];
			} elseif ($this->config->get($_nico_module . '_module')) 
			{ 
				$module_info = $this->config->get($_nico_module . '_module');
			} elseif ($this->config->get($_nico_module)) 
			{ 
				$module_info = $this->config->get($_nico_module);
			}		
			
			if (isset($module_info))
			{
				if (!is_array($module_info)) $module_info = json_decode($module_info, true);
				$data = array_merge($data, $module_info);
				$data['modules'] = $module_info;
			}
			
			/*
			if (isset($data['modules']['section']))
			{
				$data['section'] =	$data['modules']['section'];
				unset($data['modules']['section']);
			}
			*/
		}

		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($module_info) && isset($module_info['name'])) {
			$data['name'] = $module_info['name'];
		} else {
			$data['name'] = '';
		}

		$this->load->model('localisation/language');
		
		if ($data['opencart_version'] >= 2200)
		{
			$data['languages'] = $this->model_localisation_language->getLanguages();
		} else
		{
			$data['languages'] = $this->model_localisation_language->getLanguages();
		}

		$data['module'] = &$data;
				
		if ($data['opencart_version'] > 1564)
		{
			$data['header'] = $this->load->controller('common/header');
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['footer'] = $this->load->controller('common/footer');

			$data['text_edit'] = $this->language->get('text_edit');
			$data['text_enabled'] = $this->language->get('text_enabled');
			$data['text_disabled'] = $this->language->get('text_disabled');
			
			$data['entry_heading'] = $this->language->get('entry_heading');
			$data['entry_name'] = $this->language->get('entry_name');
			$data['entry_description'] = $this->language->get('entry_description');
			$data['entry_status'] = $this->language->get('entry_status');
			
			$data['button_save'] = $this->language->get('button_save');
			$data['button_cancel'] = $this->language->get('button_cancel');
			$data['button_module_add'] = $this->language->get('button_module_add');
			$data['button_remove'] = $this->language->get('button_remove');

			$data['tab_module'] = $this->language->get('tab_module');
		} else
		{
			$this->children = array(
				'common/header',
				'common/footer'
			);
		}
	}
	
   function layout()
   {
	    
	   $_layouts = array(99999 => 'All pages');
	   
		$this->load->model('design/layout');

		$layouts = $this->model_design_layout->getLayouts();	   
		if (is_array($layouts))
		foreach ($layouts as $layout) 
		{
			$_layouts[$layout['layout_id']] = $layout['name'];
		}	

		return $_layouts;
	}
	
	/*
   function position()
   {
	  return array(
			'menu' => 'Menu',
			'slideshow' => 'Slideshow',
			'footer_top' => 'Footer top',
			'content_top' => 'Content top',
			'content_bottom' => 'Content bottom',
			'column_left' => 'Column left',
			'column_right' => 'Column right',

			'menu' => 'Menu',
			'slideshow' => 'Slideshow',
			'footer_top' => 'Footer top',
			);
	}*/
	
	function products(&$data)
	{
		$data['products'] = $products = array();
							
		$this->load->model('catalog/product');

		if (isset($data['modules']) && !empty($data['modules']))
		foreach ($data['modules'] as $module_row => $module)
		{
			if (isset($module['section']) && isset($section['product_list']))
			foreach ($module['section'] as $section_nr => $section)
			{
				$products[$module_row][$section_nr] = explode(',', $section['product_list']);
			}
		
		if (isset($products))
		foreach ($products as $module_row => $sections) 
		{
			foreach ($sections as $section_nr => $section)
			{
				foreach ($section as $product_id) 
				{
					$product_info = $this->model_catalog_product->getProduct($product_id);
					
					if ($product_info) {
						$data['products'][$module_row][$section_nr][] = array(
							'product_id' => $product_info['product_id'],
							'name'       => $product_info['name']
						);
					}
				}	
			}
		}

		} else
		{
			if (isset($data['section']) && !empty($data['section']))
			foreach ($data['section'] as $section_nr => $section)
			{
				if (isset($section['product_list']))
				$products[$section_nr] = explode(',', $section['product_list']);
			}


			if (isset($products))
			foreach ($products as $section_nr => $section)
			{
				foreach ($section as $product_id) 
				{
					$product_info = $this->model_catalog_product->getProduct($product_id);
					
					if ($product_info) {
						$data['products'][$section_nr][] = array(
							'product_id' => $product_info['product_id'],
							'name'       => $product_info['name']
						);
					}
				}	
			}
		}

		
	}

	function categories(&$data)
	{
		//categories

		$data['categories'] = array();

		$this->load->model('catalog/category');

		//if (isset($this->model_catalog_category) && $this->model_catalog_category)
		$categories = $this->model_catalog_category->getCategories(0);
		
		if (isset($categories) && $categories)
		foreach ($categories as $category) {
			//$total = $this->model_catalog_product->getTotalProducts(array('filter_category_id' => $category['category_id']));

			$children_data = array();

			$children = $this->model_catalog_category->getCategories($category['category_id']);

			
			foreach ($children as $child) {
				//$product_total = $this->model_catalog_product->getTotalProducts($data);

				//$total += $product_total;
				/*
				$children_data[] = array(
					'category_id' => $child['category_id'],
					'name'        => $child['name'],
					'href'        => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])	
				);		
				*/ 
			}

			$data['categories'][$category['category_id']] = $category['name'];
		}
		
	}
	
	function manufacturers(&$data)
	{
		//manufacturers
		
		$this->load->model('catalog/manufacturer');
		
		$data['manufacturers'] = array();

		//$manufacturer_total = $this->model_catalog_manufacturer->getTotalManufacturers();
	
		$results = $this->model_catalog_manufacturer->getManufacturers();
 
    	foreach ($results as $result) {
			$action = array();
			$data['manufacturers'][$result['manufacturer_id']] = $result['name'];
		}
	}	
	function extensions(&$data)
	{
		
		if ($data['opencart_version'] >= 2300)
		{
			$extension_path = 'extension/module/';
		} else
		{
			$extension_path = 'module/';
		}		
		//extensions
		if ($data['opencart_version'] >= 3000)
		{

			$this->load->model('setting/extension');

			$this->load->model('setting/module');

			$data['text_layout'] = sprintf($this->language->get('text_layout'), $this->url->link('design/layout', 'user_token=' . $this->session->data['user_token'], true));

			if (isset($this->error['warning'])) {
				$data['error_warning'] = $this->error['warning'];
			} else {
				$data['error_warning'] = '';
			}

			if (isset($this->session->data['success'])) {
				$data['success'] = $this->session->data['success'];

				unset($this->session->data['success']);
			} else {
				$data['success'] = '';
			}

			$extensions = $this->model_setting_extension->getInstalled('module');

			foreach ($extensions as $key => $value) {
				if (!is_file(DIR_APPLICATION . 'controller/extension/module/' . $value . '.php') && !is_file(DIR_APPLICATION . 'controller/module/' . $value . '.php')) {
					$this->model_setting_extension->uninstall('module', $value);

					unset($extensions[$key]);
					
					$this->model_setting_module->deleteModulesByCode($value);
				}
			}

			$data['extensions'] = array();

			// Create a new language container so we don't pollute the current one
			$language = new Language($this->config->get('config_language'));
			
			// Compatibility code for old extension folders
			$files = glob(DIR_APPLICATION . 'controller/extension/module/*.php');

			if ($files) {
				foreach ($files as $file) {
					$extension = basename($file, '.php');

					$this->load->language('extension/module/' . $extension, 'extension');

					$module_data = array();

					$modules = $this->model_setting_module->getModulesByCode($extension);

					foreach ($modules as $module) {
						if ($module['setting']) {
							$setting_info = json_decode($module['setting'], true);
						} else {
							$setting_info = array();
						}
						
						$module_data[] = array(
							'module_id' => $module['module_id'],
							'code' 		=> $extension . '.' . $module['module_id'],
							'name'      => $module['name'],
							'status'    => (isset($setting_info['status']) && $setting_info['status']) ? $this->language->get('text_enabled') : $this->language->get('text_disabled'),
							'edit'      => $this->url->link('extension/module/' . $extension, 'user_token=' . $this->session->data['user_token'] . '&module_id=' . $module['module_id'], true),
							'delete'    => $this->url->link('extension/extension/module/delete', 'user_token=' . $this->session->data['user_token'] . '&module_id=' . $module['module_id'], true)
						);
					}

					$data['extensions'][] = array(
						'name'      => $this->language->get('extension')->get('heading_title'),
						'code' 		=> $extension,
						'status'    => $this->config->get('module_' . $extension . '_status') ? $this->language->get('text_enabled') : $this->language->get('text_disabled'),
						'module'    => $module_data,
						'install'   => $this->url->link('extension/extension/module/install', 'user_token=' . $this->session->data['user_token'] . '&extension=' . $extension, true),
						'uninstall' => $this->url->link('extension/extension/module/uninstall', 'user_token=' . $this->session->data['user_token'] . '&extension=' . $extension, true),
						'installed' => in_array($extension, $extensions),
						'edit'      => $this->url->link('extension/module/' . $extension, 'user_token=' . $this->session->data['user_token'], true)
					);
				}
			}

			$sort_order = array();

			foreach ($data['extensions'] as $key => $value) {
				$sort_order[$key] = $value['name'];
			}

			array_multisort($sort_order, SORT_ASC, $data['extensions']);

		}
		else
		if ($data['opencart_version'] > 1564)
		{		
			$this->load->model('extension/extension');
			
			$this->load->model('extension/module');
			
			$data['extensions'] = array();
			
			// Get a list of installed modules
			$extensions = $this->model_extension_extension->getInstalled('module');
					
			// Add all the modules which have multiple settings for each module
			foreach ($extensions as $code) {
				$this->load->language($extension_path . $code);
			
				$module_data = array();
				
				$modules = $this->model_extension_module->getModulesByCode($code);
				
				foreach ($modules as $module) {
					$module_data[] = array(
						'name' => strip_tags($this->language->get('heading_title') . ' &gt; ' . $module['name']),
						'code' => $code . '.' .  $module['module_id']
					);
				}
				
				if ($this->config->has($code . '_status') || $module_data) {
					$data['extensions'][] = array(
						'name'   => strip_tags($this->language->get('heading_title')),
						'code'   => $code,
						'module' => $module_data
					);
				}
			}
		} else
		{
			$module_data = array();

			$this->load->model('setting/extension');

			$extensions = $this->model_setting_extension->getInstalled('module');		

			foreach ($extensions as $extension) 
			{
				if ($extension == 'nicocontrolpanel') continue;
				
				if ($this->config->get($extension. '_module')) 
				{ 
					$modules = $this->config->get($extension . '_module');
				} elseif ($this->config->get($extension)) 
				{ 
					$modules = $this->config->get($extension);
				}		
				
				if (isset($modules) && $modules) 
				{
					foreach ($modules as $module) 
					{
							if (isset($counter[$extension])) $counter[$extension]++; else $counter[$extension] = 1;
							
							$data['extensions'][] = array(
								'name'       => $extension,
								'code'       => $counter[$extension],
							);				
					}
				}
			}
		}
	}	
}
