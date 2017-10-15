<?php
include('nicomodule.inc');
global $_nico_module;
$_nico_module = 'nicocontrolpanel';

class ControllerModuleNicocontrolpanel extends NicoModule 
{
	private $error = array(); 
	
	public function index($data = array()) 
	{
		$data['no_instances'] = true;
		
		$this->categories($data);
		$this->manufacturers($data);
		
		$this->init($data);
				
		if (function_exists('get_magic_quotes_gpc') && get_magic_quotes_gpc()) 
		{
			foreach ($data['modules'][1]['about_text'] as $lang => &$text)
			{
				$text = stripslashes($text);				
			}
			foreach ($data['modules'][1]['footer_about_text'] as $lang => &$text)
			{
				$text = stripslashes($text);				
			}
		}

		$opencart_version = (int)str_replace('.','',VERSION);
		if ($opencart_version >= 2200)
		{
			return $this->response->setOutput($this->load->view('module/nicocontrolpanel', $data));
		} if ($opencart_version >= 2000)
		{
			$this->response->setOutput($this->load->view('module/nicocontrolpanel.tpl', $data));
		} else
		{
			$this->template = 'module/nicocontrolpanel.tpl';
			$this->data = $data;
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

class ControllerExtensionModuleNicocontrolpanel extends ControllerModuleNicocontrolpanel {}; 
