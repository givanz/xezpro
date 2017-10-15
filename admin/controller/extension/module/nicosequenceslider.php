<?php
include('nicomodule.inc');
global $_nico_module;
$_nico_module = 'nicosequenceslider';

class ControllerModuleNicosequenceslider extends NicoModule 
{
	private $error = array(); 
	
	public function index() {   
		$data = array();
		$this->init($data);

		$this->categories($data);
		$this->manufacturers($data);

		$opencart_version = (int)str_replace('.','',VERSION);
		if ($opencart_version >= 2200)
		{
			return $this->response->setOutput($this->load->view('module/nicosequenceslider', $data));
		} if ($opencart_version >= 2000)
		{
			$this->response->setOutput($this->load->view('module/nicosequenceslider.tpl', $data));
		} else
		{
			$this->template = 'module/nicosequenceslider.tpl';
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
		
		if (isset($this->request->post['nicosequenceslider_module'])) {
			foreach ($this->request->post['nicosequenceslider_module'] as $key => $value) {
				if (!$value['image_width'] || !$value['image_height']) {
					$this->error['image'][$key] = $this->language->get('error_image');
				}
			}
		}
				
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}

class ControllerExtensionModuleNicosequenceslider extends ControllerModuleNicosequenceslider {}; 
