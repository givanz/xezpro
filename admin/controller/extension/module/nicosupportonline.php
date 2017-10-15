<?php
include('nicomodule.inc');
global $_nico_module;
$_nico_module = 'nicosupportonline';

class ControllerModuleNicosupportonline extends NicoModule 
{
	private $error = array(); 
	
	public function index() {   
		$data = array();
		
		$this->init($data);
		$this->categories($data);
		$this->manufacturers($data);
				
		if ($data['opencart_version'] > 1564)
		{
			$this->response->setOutput($this->load->view('module/nicosupportonline.tpl', $data));
		} else
		{
			$this->template = 'module/nicosupportonline.tpl';
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

class ControllerExtensionModuleNicosupportonline extends ControllerModuleNicosupportonline {}; 
