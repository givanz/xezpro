<?php
include_once(DIR_APPLICATION . '/controller/module/nicomodule.inc');
global $_nico_module_counter;
class ControllerModuleNicogooglemaps  extends NicoModule
{
	public function index($setting) 
	{
		if (!$this->is_filter_ok($setting)) return false;
		$opencart_version = (int)str_replace('.','',VERSION);
		$data = $setting;

		global $_nico_module_counter;
		if (isset($_nico_module_counter['nicogooglemaps'])) $_nico_module_counter['nicogooglemaps']++; else $_nico_module_counter['nicogooglemaps'] = 0;
		$data['module_id'] = $_nico_module_counter['nicogooglemaps'];
		
		$data['markers'] = $setting['section'];


		$lang_code = isset($this->session->data['language'])?$this->session->data['language']:$this->language->get('code');
		
		if (!$lang_code || is_object($lang_code)) $lang_code = $lang_code->get('code');
		
		$lang_code = strtolower($lang_code);

		$default_lang = 'en';

		if ($opencart_version >= 2200)
		{
			$default_lang = 'en-gb';
		}

		if (isset($setting['section'])) foreach ($setting['section'] as $nr => $section)
		{
			$data['markers'][$nr]['description'] = $section['description'][$lang_code];
		}
		
		$data['width'] = $setting['width'];
		$data['height'] = $setting['height'];

		$data['lat'] = $setting['lat'];
		$data['long'] = $setting['long'];
		$data['zoom'] = $setting['zoom'];

		$opencart_version = (int)str_replace('.','',VERSION);

		return $this->_render('nicogooglemaps', $data);
	}
}
