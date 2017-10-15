<?php
include_once(DIR_APPLICATION . '/controller/module/nicomodule.inc');
class ControllerModuleNicocontrolpanel extends NicoModule
{
	public function index($setting) {
		/*
		$this->load->model('tool/image');

		if (isset($setting['section'])) foreach ($setting['section'] as $nr => $section)
		{
			$data['section'][$nr]['image'] = $this->model_tool_image->resize($section['image_image'], $setting['image_width'], $setting['image_height']);
		}
		*/
		$opencart2 = ((int)substr(VERSION,0,1) == 2);
		$data = $setting;

		if ($opencart2)
		{
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/nicocontrolpanel.tpl')) 
			{
				return $this->load->view($this->config->get('config_template') . '/template/module/nicocontrolpanel.tpl', $data);
			} else {
				return $this->load->view('default/template/module/nicocontrolpanel.tpl', $data);
			}
		} else
		{
			$this->data = $data;
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/nicocontrolpanel.tpl')) 
			{
				$this->template = $this->config->get('config_template') . '/template/module/nicocontrolpanel.tpl';
			} else {
				$this->template = 'default/template/module/nicocontrolpanel.tpl';
			}

			$this->render();
		}
	}
}
