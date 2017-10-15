<?php
global $_config, $nico_config, $load, $opencart_version, $_nico_head_script, $_nico_head_style, $_nico_head_js, $_nico_head_css, $_loaded;
if (!class_exists('NicoModule'))
{
	class NicoModule extends Controller 
	{
		function is_filter_ok(&$data)
		{
			global $_config, $nico_config, $load, $registry, $opencart_version, $_nico_head_script, $_nico_head_style, $_nico_head_js, $_nico_head_css, $_loaded;

			$opencart_version = (int)str_replace('.','',VERSION);
			$registry = $this->registry;

			$_config =  $this->config;
			$session =  $this->registry->get('session');
			$request =  $this->registry->get('request');
			$load = $this->registry->get('load');


			if ($_loaded != true && !$_config->has('nico_module_positions') && !isset($request->get['ajax']))
			{
						$_loaded = true;
						$opencart_positions = array( 
							'content_top',
							'column_left',
							'column_right',
							'content_bottom',
						);	

						$positions = array( 
							'menu',
							'header',
							'top_links',
							'promotion',
							'showcase',
							'content_top',
							'column_left',
							'column_right',
							'content_bottom',
							'footer_top',
							'product_tabs',

							'footer_center',
							'footer_bottom'
						);	

						$load->model('design/layout');
						$model_design_layout = $this->registry->get('model_design_layout');

						if( (!property_exists($this, 'layout_id') || !$layout_id) ) 
						{
							if (isset($request->get['route'])) {
								$route = (string)$request->get['route'];
								$pageClass = 'page-'.str_replace( "/", "-", $route );
							} else {
								$route = 'common/home';
								$pageClass = 'page-home';
							}
					
					
							$layout_id = 0;
						
							if ($route == 'product/category' && isset($request->get['path'])) {
								$path = explode('_', (string)$request->get['path']);
									
								$load->model('catalog/category');
								$model_category = $this->registry->get('model_catalog_category');
									
								$layout_id = $model_category->getCategoryLayoutId(end($path));		
								$pageClass = 'page-category';		
							}
							
							if ($route == 'product/product' && isset($request->get['product_id'])) {
								$load->model('catalog/product');
								$model_product = $this->registry->get('model_catalog_product');

								$layout_id = $model_product->getProductLayoutId($request->get['product_id']);
								$pageClass = 'page-product';		
							}
							
							if ($route == 'information/information' && isset($request->get['information_id'])) {
								$load->model('catalog/information');
								$model_information = $this->registry->get('model_catalog_information');

								$layout_id = $model_information->getInformationLayoutId($request->get['information_id']);
								$pageClass = 'page-information';		
							}
							
							if (!$layout_id) {
								$layout_id = $model_design_layout->getLayout($route);
							}
									
							if (!$layout_id) {
								$layout_id = $_config->get('config_layout_id');
							}
						 
						}
						
						if ($opencart_version >= 3000)
						{
							$load->model('setting/module');
							$model_setting_module = $this->registry->get('model_setting_module');

							$db = $registry->get('db');;
							$query = $db->query("SELECT * FROM " . DB_PREFIX . "layout_module WHERE (layout_id = '" . (int)$layout_id . "' OR layout_id = 99999) ORDER BY sort_order");
							
							if (defined('NICO_DEMO_DISABLED_MODULES'))
							{
								foreach ($query->rows as $key => $module)
								{
										if (in_array($module['code'], NICO_DEMO_DISABLED_MODULES)) unset($query->rows[$key]);
									}
								}

							
							$extensions = $query->rows;

							foreach ($extensions as $module) {
								$part = explode('.', $module['code']);
								
								if ($opencart_version > 2000)
								{
										if (isset($part[1])) {
											$setting_info = $model_setting_module->getModule($part[1]);
											
											if ($setting_info && isset($setting_info['status']) && $setting_info['status']) {
												if (!in_array(trim($module['position']), $opencart_positions))
												$output[$module['position']][] = $load->controller('module/' . $part[0], $setting_info);
											}
										} else 
										if (isset($part[0]) && $_config->get($part[0] . '_status')) {
											if (!in_array(trim($module['position']), $opencart_positions))
											$output[$module['position']][] = $load->controller('module/' . $part[0]);
										}
								} else
								{
								if (isset($part[0])) {
									$code = $part[0];
								}
								
								if ($code && $code == 'nicocontrolpanel')
								{
									$nico_config = $_config->get('nicocontrolpanel_module');
									$nico_config = $nico_config[1];
								} else
								if ($code && $_config->get($code . '_status')) { 
									$setting = $_config->get($code . '_module');
									
									if (isset($part[1]) && isset($setting[$part[1]])) {
										if (!in_array(trim($module['position']), $opencart_positions))
										$output[$module['position']][] = $load->controller('module/' . $code, $setting[$part[1]]);
									} else {
										if (!in_array(trim($module['position']), $opencart_positions))
										$output[$module['position']][] = $load->controller('module/' . $code);
										}			
									}			
								}
							}			
						} else
						if ($opencart_version > 1564)
						{
							$load->model('extension/extension');
							$model_setting_extension = $this->registry->get('model_extension_extension');
							if ($opencart_version > 2000) 
							{
								$load->model('extension/module');
								$model_extension_module = $this->registry->get('model_extension_module');
							}
							$model_design_layout = $this->registry->get('model_design_layout');
							//$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
							$db = $registry->get('db');;
							//$extensions = $model_design_layout->getLayoutModules($layout_id, 'column_left');
							$query = $db->query("SELECT * FROM " . DB_PREFIX . "layout_module WHERE (layout_id = '" . (int)$layout_id . "' OR layout_id = 99999) ORDER BY sort_order");
							
							if (defined('NICO_DEMO_DISABLED_MODULES'))
							{
								foreach ($query->rows as $key => $module)
								{
										if (in_array($module['code'], NICO_DEMO_DISABLED_MODULES)) unset($query->rows[$key]);
									}
								}

							
							$extensions = $query->rows;

							foreach ($extensions as $module) {
								$part = explode('.', $module['code']);
								
								if ($opencart_version > 2000)
								{
										if (isset($part[1])) {
											$setting_info = $model_extension_module->getModule($part[1]);
											
											if ($setting_info && isset($setting_info['status']) && $setting_info['status']) {
												if (!in_array(trim($module['position']), $opencart_positions))
												$output[$module['position']][] = $load->controller('module/' . $part[0], $setting_info);
											}
										} else 
										if (isset($part[0]) && $_config->get($part[0] . '_status')) {
											if (!in_array(trim($module['position']), $opencart_positions))
											$output[$module['position']][] = $load->controller('module/' . $part[0]);
										}
								} else
								{
								if (isset($part[0])) {
									$code = $part[0];
								}
								
								if ($code && $code == 'nicocontrolpanel')
								{
									$nico_config = $_config->get('nicocontrolpanel_module');
									$nico_config = $nico_config[1];
								} else
								if ($code && $_config->get($code . '_status')) { 
									$setting = $_config->get($code . '_module');
									
									if (isset($part[1]) && isset($setting[$part[1]])) {
										if (!in_array(trim($module['position']), $opencart_positions))
										$output[$module['position']][] = $load->controller('module/' . $code, $setting[$part[1]]);
									} else {
										if (!in_array(trim($module['position']), $opencart_positions))
										$output[$module['position']][] = $load->controller('module/' . $code);
										}			
									}			
								}
							}
						}  else
						{
							$load->model('setting/extension');
							$model_setting_extension = $this->registry->get('model_setting_extension');
							$extensions = $model_setting_extension->getExtensions('module');		


							$module_data = array();
							foreach ($extensions as $extension) {
								$modules = $_config->get($extension['code'] . '_module');

								if ($extension['code'] == 'nicocontrolpanel')
								{
									$nico_config = $modules[1];
								}

								
								if ($modules) {
									foreach ($modules as $module) {  
										if ( (isset($module['layout_id']) && ($module['layout_id'] == $layout_id || $module['layout_id'] == '99999' ) && in_array(trim($module['position']), $positions) && $module['status'])) {
											$module_data[$module['position']][] = array(
												'code'       => $extension['code'],
												'setting'    => $module,
												'sort_order' => $module['sort_order']
											);				
										}
									}
								}
							}
				
						foreach( $module_data as $_position => $modules ){
							$_sort_order = array(); 
							foreach ($modules as $key => $value) {
								$_sort_order[$key] = $value['sort_order'];
							}
							array_multisort($_sort_order, SORT_ASC, $module_data[$_position]);
						}

						$data['modules'] = array();
						$output = array();
						$opencart1 = method_exists($this, 'getChild');

						foreach( $module_data as $_position => $modules )
						{
							foreach ($modules as $module) 
							if (!in_array(trim($_position), $opencart_positions))
							{
								if ($opencart1)
								{
									$html = $this->getChild('module/' . $module['code'], $module['setting']);
								}
								else
								{
									$html = $load->controller('module/' . $module['code'], $module['setting']);
								}
								
								if ($html) {
									$output[$_position][] = $html;
								}// else $output[$_position][] = 'broken module';
							} 
						} 
					}
						
					$_config->set('nico_module_positions', isset($output)?$output:'');			
					
					if (!isset($nico_config) || empty($nico_config))
					{
						$modules = $_config->get('nicocontrolpanel_module');
						$nico_config = $modules[1];
					}
			}

			
			if (isset($data['filter_type']) && !empty($data['filter_type']) && (isset($this->request->get['route']) || isset($this->request->get['_route_']) || isset($this->request->get['_route'])))
			{
				$filter_type = $data['filter_type'];
				$route = (string)$this->request->get['route'];
				if (isset($this->request->get['_route'])) $route = (string)$this->request->get['_route'];
				if (isset($this->request->get['_route_'])) $route = (string)$this->request->get['_route_'];
				switch($filter_type)
				{
						case 'category':
						if (isset($this->request->get['path']))
						{
						$path = $this->request->get['path'];
						$underscore = strrpos($path, '_');
						$category_id = substr($path, $underscore?$underscore+1:0);
						if ($route == 'product/category' && 
							isset($path) && 
							$data['filter_category'] == $category_id) 
						{
							return true;
							}
						}
						//if category filter is set on product page check if product has category
						if ($route == 'product/product') 
						{
							$product_id = $this->request->get['product_id'];
							$this->load->model('catalog/product');
							
							$categories = $this->model_catalog_product->getCategories($product_id);
							foreach ($categories as $category)
							{
								if ($category['category_id'] == $data['filter_category']) return true;
							}
						}
						break;

						case 'product':
						if ($route == 'product/product' && 
							$data['filter_products'] == $this->request->get['product_id']) 
						{
							return true;
						}
						break;

						case 'manufacturer':
						if ($route == 'product/manufacturer/info' && 
							$data['filter_manufacturer'] == $this->request->get['manufacturer_id']) 
						{
							return true;
						}
						break;

						case 'information':
						if ($route == 'information/information' && 
							$data['filter_information'] == $this->request->get['information_id']) 
						{
							return true;
						}
						break;
				}
				return false;
			}
			return true;
		}
	
		function _render($module, &$data)
		{
			$opencart_version = (int)str_replace('.','',VERSION);
			
			if ($opencart_version >= 2200)
			{
				return $this->load->view('module/' . $module, $data);
			} else if ($opencart_version >= 2000)
			{
				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/' . $module . '.tpl')) 
				{
					return $this->load->view($this->config->get('config_template') . '/template/module/' . $module . '.tpl', $data);
				} else {
					return $this->load->view('default/template/module/' . $module . '.tpl', $data);
				}
			} else
			{
				$this->data = $data;
				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/' . $module . '.tpl')) 
				{
					$this->template = $this->config->get('config_template') . '/template/module/' . $module . '.tpl';
				} else {
					$this->template = 'default/template/module/' . $module . '.tpl';
				}

				return $this->render();
			}		
		}


		function render_module($module)
		{
			$opencart_version = (int)str_replace('.','',VERSION);
			$content = '';
			
			if ($opencart_version >= 2300)
			{
				$extension_path = 'extension/module/';
			} else
			{
				$extension_path = 'module/';
			}

			if ($opencart_version >= 3000)
			{
				$this->load->model('setting/module');
				
				$part = explode('.', $module);

				if (isset($part[0]) && $this->config->get($part[0] . '_status')) {
					$content = $this->load->controller($extension_path . $part[0]);
				}
				
				if (isset($part[1])) {
					$setting_info = $this->model_setting_module->getModule($part[1]);
					if ($setting_info && $setting_info['status']) {
						$content = $this->load->controller($extension_path . $part[0], $setting_info);
					}
				}			
			} else 
			if ($opencart_version > 2000)
			{
					
				$part = explode('.', $module);

				if (isset($part[0]) && $this->config->get($part[0] . '_status')) {
					$content = $this->load->controller($extension_path . $part[0]);
				}
				
				if (isset($part[1])) {
					$setting_info = $this->model_extension_module->getModule($part[1]);
					if ($setting_info && $setting_info['status']) {
						$content = $this->load->controller($extension_path . $part[0], $setting_info);
					}
				}
			} else 
			{
				$part = explode('.', $module);
				
				$modules = $this->config->get($part[0] . '_module');

				if ($modules) {
					$i = 0;
					$found = false;
					
					foreach ($modules as $module) 
					{
						$i++;
						if ($i == $part[1] || $part[1] == $module['module_id'])
						{
							$content = $this->getChild('module/' . $part[0], $module);
							$found = true;
							break;
						}
					}
					
					if (!$found) $content = $this->getChild('module/' . $part[0], $modules[0]);
				}				
			}		
			return $content;
		}
	}

	/*
	 * Nico OpenCart framework
	 * Copyright nicole_89
	 * All rights reserved
	 */
	//include('settings.inc');
	//include('nico_config.inc');
	if (!isset($_GET['route'])) $_GET['route'] = 'common/home';

	function sanitize_route($route)
	{
		$route = substr($_GET['route'],strpos($_GET['route'], '/') + 1);
		return preg_replace( '/[^a-zA-Z]/', '', $route);
		
	}

	function nico_add_script($script, $group = 'module')
	{
		if ($group == 'module') $group =  isset($_GET['route'])?sanitize_route($_GET['route']):'common';
		global $_nico_head_script;
		$_nico_head_script[$group][] = $script;
	}

	function nico_add_style($style, $group = 'module')
	{
		if ($group == 'module') $group =  isset($_GET['route'])?sanitize_route($_GET['route']):'common';
		global $_nico_head_style;
		$_nico_head_style[$group][] = $style;
	}

	if (!function_exists('nico_add_js'))
	{
		function nico_add_js($js, $group = 'module')
		{
			if ($group == 'module') $group =  isset($_GET['route'])?sanitize_route($_GET['route']):'common';
			global $_nico_head_js;
			if (isset($_nico_head_js[$group])) $_nico_head_js[$group] .= "\n" . $js . ";\n"; else $_nico_head_js[$group] = "\n" . $js . ";\n";
		}
	}

	function nico_add_css($css, $group = 'module')
	{
		if ($group == 'module') $group =  isset($_GET['route'])?sanitize_route($_GET['route']):'common';
		global $_nico_head_css;
		if (isset($_nico_head_css[$group])) $_nico_head_css[$group] .= "\n" . $css; else $_nico_head_css[$group] = "\n" . $css;
	}
	

function nico_get_modules($position)
{
	global $_config;

	if ($_config->has('nico_module_positions'))
	{
		$positions = $_config->get('nico_module_positions');
		return isset($positions[$position])?$positions[$position]:'';
	}	
}

function nico_get_config($name)
{
	global $nico_config, $_config;


	if (defined('NICO_CONFIG') && ($config_demo = nico_config_demo($name))) return $config_demo;

	if (!isset($nico_config) || empty($nico_config))
	{
		$modules = $_config->get('nicocontrolpanel_module');
		if (!is_array($modules))	
		{
			$modules = @json_decode($modules,true);
			if ($modules == null) $modules = @unserialize($modules);
		}
		
		$nico_config = $modules[1];
	}
	return (isset($nico_config[$name]))?$nico_config[$name]:false;
}

function nico_get_categories($category = null)
{
	global $load, $registry;
	$load->model('catalog/category');
	$model_catalog_category = $registry->get('model_catalog_category');	
	
	
	
	$categories_1 = $model_catalog_category->getCategories(0);

	foreach ($categories_1 as $category_1) {
		$level_2_data = array();

		$categories_2 = $model_catalog_category->getCategories($category_1['category_id']);

		foreach ($categories_2 as $category_2) {
			$level_3_data = array();

			$categories_3 = $model_catalog_category->getCategories($category_2['category_id']);

			foreach ($categories_3 as $category_3) {
				$level_3_data[] = array(
					'category_id' => $category_3['category_id'],
					'name'        => $category_3['name'],
				);
			}

			$level_2_data[] = array(
				'category_id' => $category_2['category_id'],	
				'name'        => $category_2['name'],
				'children'    => $level_3_data
			);					
		}

		$categories[] = array(
			'category_id' => $category_1['category_id'],
			'name'        => $category_1['name'],
			'children'    => $level_2_data
		);
	}
	
	
	return $categories;
	}
}
