<?php
include_once(DIR_APPLICATION . '/controller/module/nicomodule.inc');
global $_nico_module_counter;
class ControllerModuleNicobanner extends NicoModule
{
	public function index($setting) 
	{
		if (!$this->is_filter_ok($setting)) return false;
		
		$this->language->load('module/nicobanner'); 
		$this->load->model('tool/image');
		$lang_code = $this->language->get('code');
		$data = $setting;

		$opencart_version = (int)str_replace('.','',VERSION);
		$default_lang = 'en';
		if ($opencart_version >= 2200)
		{
			$default_lang = 'en-gb';
		}

		global $_nico_module_counter;
		if (isset($_nico_module_counter['nicobanner'])) $_nico_module_counter['nicobanner']++; else $_nico_module_counter['nicobanner'] = 0;
		$data['module_id'] = $_nico_module_counter['nicobanner'];

		if (isset($setting['section'])) foreach ($setting['section'] as $nr => $section)
		{
			$data['section'][$nr] = $section;
			if (isset($section['title'])) $data['section'][$nr]['title'] = isset($section['title'][$lang_code])?$section['title'][$lang_code]:$section['title'][$default_lang];
			if (isset($section['subtitle'])) $data['section'][$nr]['subtitle'] = isset($section['subtitle'][$lang_code])?$section['subtitle'][$lang_code]:$section['subtitle'][$default_lang];
			if (isset($section['text'])) $data['section'][$nr]['text'] = isset($section['text'][$lang_code])?$section['text'][$lang_code]:$section['text'][$default_lang];
			if (isset($section['image_image'])) $data['section'][$nr]['image'] = $this->model_tool_image->cropsize($section['image_image'], $setting['image_width'], $setting['image_height']);
//			$data['section'][$nr]['image'] = $this->model_tool_image->resize($section['image_image'], 500, 400);
		}

		$data['type'] = $setting['module_type'];
		$data['cols'] = $setting['module_cols'];
		
		return $this->_render('nicobanner', $data);
	}
}
