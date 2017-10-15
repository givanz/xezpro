<?php
include_once(DIR_APPLICATION . '/controller/module/nicomodule.inc');
global $_nico_module_counter;
class ControllerModuleNicocameraslider  extends NicoModule
{
	public function index($setting) 
	{
		if (!$this->is_filter_ok($setting)) return false;
		$opencart_version = (int)str_replace('.','',VERSION);

		$this->load->model('tool/image');
		$lang_code = isset($this->session->data['language'])?$this->session->data['language']:$this->language->get('code');
		
		if (is_object($lang_code)) $lang_code = $lang_code->get('code');
		
		$lang_code = strtolower($lang_code);
		
		$data = $setting;

		global $_nico_module_counter;
		if (isset($_nico_module_counter['nicocameraslider'])) $_nico_module_counter['nicocameraslider']++; else $_nico_module_counter['nicocameraslider'] = 0;
		$data['module_id'] = $_nico_module_counter['nicocameraslider'];

		$resize_method = 0;
		if (isset($setting['resize_method']) && $setting['resize_method'] == 'cropresize')
		{
			$resize_method = 1;
		}


		if (isset($setting['section'])) foreach ($setting['section'] as $nr => $section)
		{
			if ($section['image_image']) $data['section'][$nr]['image'] = $this->model_tool_image->cropsize($section['image_image'], $setting['image_width'], $setting['image_height']);//$this->config->get('config_url') . 'image/' . $section['image_image'];//$this->model_tool_image->resize($section['image_image'], 500, 500);
		}

		return $this->_render('nicocameraslider', $data);
	}
}
