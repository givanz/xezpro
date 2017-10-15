<?php
include_once(DIR_APPLICATION . '/controller/module/nicomodule.inc');
global $_nico_module_counter;
class ControllerModuleNicotable  extends NicoModule
{
	public function index($setting) 
	{
		if (!$this->is_filter_ok($setting)) return false;

		$data = $setting;
		$opencart_version = (int)str_replace('.','',VERSION);

		global $_nico_module_counter;
		if (isset($_nico_module_counter['nicotable'])) $_nico_module_counter['nicotable']++; else $_nico_module_counter['nicotable'] = 0;
		$data['module_id'] = $_nico_module_counter['nicotable'];

		$data['table'] = json_decode(html_entity_decode($setting['table']), true);

		$lang_code = isset($this->session->data['language'])?$this->session->data['language']:$this->language->get('code');
		
		if (!$lang_code || is_object($lang_code)) $lang_code = $lang_code->get('code');
		
		$lang_code = strtolower($lang_code);

		$default_lang = 'en';

		if ($opencart_version >= 2200)
		{
			$default_lang = 'en-gb';
		}
		
		return $this->_render('nicotable', $data);
	}
}
