<?php
include('nicomodule.inc');
global $_nico_module;
$_nico_module = 'nicomegamenu';

class ControllerModuleNicomegamenu extends NicoModule {
	private $error = array(); 
	
	public function index() 
	{   
		//echo $this->config->get('config_template'); 
		$data = array();
		$this->init($data);
		$this->categories($data);
		$this->manufacturers($data);
		
		//var_dump($data);
		//var_dump($_POST);
		//var_dump($data['modules'][1]['menu']);
		if (isset($data['modules']))
		foreach($data['modules'] as $nr => $module)
		{
			$data['modules'][$nr]['menu'] = json_decode(html_entity_decode($data['modules'][$nr]['menu']), true);
		}


		if (isset($data['menu']))
		{
			if (function_exists('get_magic_quotes_gpc') && get_magic_quotes_gpc()) $data['menu'] = stripslashes($data['menu']);
			$data['menu']= json_decode(html_entity_decode($data['menu']), true);
		}
		
		
		/*
		
		$data['modules'][1] = array('menu' =>
		  array (
			0 => 
			array (
			  'url' => 'index.php?route=pavblog/blogs',
			  'text' => 
			  array (
				'ro' => 'Blog',
				'en' => 'Blog',
			  ),
			),
			1 => 
			array (
			  'url' => '/index.php?route=product/category&amp;path=20_27',
			  'text' => 
			  array (
				'en' => 'Custom menu',
			  ),
			  'children' => 
			  array (
				0 => 
				array (
				  'url' => '/index.php?route=product/category&amp;path=20_27',
				  'text' => 
				  array (
					'en' => 'Subcat 1',
				  ),
				),
				1 => 
				array (
				  'url' => '/index.php?route=product/category&amp;path=20_27',
				  'text' => 
				  array (
					'en' => 'Subcat 2',
				  ),
				),
				2 => 
				array (
				  'url' => '/index.php?route=product/category&amp;path=20_27',
				  'text' => 
				  array (
					'en' => 'Subcat 3',
				  ),
				  
				    'children' => 
			  array (
				0 => 
				array (
				  'url' => '/index.php?route=product/category&amp;path=20_27',
				  'text' => 
				  array (
					'en' => 'Subcat 1',
				  ),
				),
				1 => 
				array (
				  'url' => '/index.php?route=product/category&amp;path=20_27',
				  'text' => 
				  array (
					'en' => 'Subcat 2',
				  ),
				),
				2 => 
				array (
				  'url' => '/index.php?route=product/category&amp;path=20_27',
				  'text' => 
				  array (
					'en' => 'Subcat 3 3',
				  ),
				)),
			  
				  
				),
			  ),
			),
			2 => 
			array (
			  'url' => '/index.php?route=product/category&amp;path=20_27',
			  'text' => 
			  array (
				'en' => 'Custom link',
			  ),
			),
			3 => 
			array (
			  'text' => 
			  array (
				'en' => 'Categories',
			  ),
			  'children' => 
			  array (
				0 => 
				array (
				  'categories' => 'true',
				),
			  ),
			),
		  ));
		  */
//		  var_dump($data);
				
		$opencart_version = (int)str_replace('.','',VERSION);
		if ($opencart_version >= 2200)
		{
			return $this->response->setOutput($this->load->view('module/nicomegamenu', $data));
		} if ($opencart_version >= 2000)
		{
			$this->response->setOutput($this->load->view('module/nicomegamenu.tpl', $data));
		} else
		{
			$this->template = 'module/nicomegamenu.tpl';
			$this->data = &$data;
			$this->response->setOutput($this->render());
		}
	}
	
	protected function validate() {
		$opencart_version = (int)str_replace('.','',VERSION);

		$extension_path = 'module/';
		
		if ($opencart_version >= 2300)
		{
			$extension_path = 'extension/module/';
		}

		global $_nico_module;
		$permission = $this->user->hasPermission('modify', "module/$_nico_module") || 
					  $this->user->hasPermission('modify', "extension/module/$_nico_module");
	
        // Check Permissions
        if (!$permission ) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
				
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}

class ControllerExtensionModuleNicomegamenu extends ControllerModuleNicomegamenu {}; 
