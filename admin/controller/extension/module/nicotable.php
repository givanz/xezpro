<?php
include('nicomodule.inc');
global $_nico_module;
$_nico_module = 'nicotable';

class ControllerModuleNicotable extends NicoModule {
	private $error = array(); 
	
	public function index() 
	{   
		//echo $this->config->get('config_template'); 
		$this->init($data);
		$this->categories($data);
		$this->manufacturers($data);

		foreach($data['modules'] as $nr => $module)
		{
			$json = json_decode(html_entity_decode($data['modules'][$nr]['table']));
		}

				
		$opencart_version = (int)str_replace('.','',VERSION);
		if ($opencart_version >= 2200)
		{
			return $this->response->setOutput($this->load->view('module/nicotable', $data));
		} if ($opencart_version >= 2000)
		{
			$this->response->setOutput($this->load->view('module/nicotable.tpl', $data));
		} else
		{
			$this->template = 'module/nicotable.tpl';
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

        // Check Permissions
        if (!$this->user->hasPermission('modify', $extension_path . 'nicotable')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
				
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}

class ControllerExtensionModuleNicotable extends ControllerModuleNicotable {}; 
