<?php
include_once(DIR_APPLICATION . '/controller/module/nicomodule.inc');
global $_nico_module_counter;
class ControllerModuleNicocustomhtml  extends NicoModule
{
	public function index($setting) 
	{
		if (!$this->is_filter_ok($setting)) return false;
		$this->load->model('tool/image');
		$opencart_version = (int)str_replace('.','',VERSION);
		$data = $setting;		

		$lang_code = isset($this->session->data['language'])?$this->session->data['language']:$this->language->get('code');
		
		if (!$lang_code || is_object($lang_code)) $lang_code = $lang_code->get('code');
		
		$lang_code = strtolower($lang_code);

		$default_lang = 'en';

		if ($opencart_version >= 2200)
		{
			$default_lang = 'en-gb';
		}

		global $_nico_module_counter;
		if (isset($_nico_module_counter['nicocustomhtml'])) $_nico_module_counter['nicocustomhtml']++; else $_nico_module_counter['nicocustomhtml'] = 0;
		$data['module_id'] = $_nico_module_counter['nicocustomhtml'];
		
		$data['content'] = isset($setting['content'][$lang_code])?html_entity_decode($setting['content'][$lang_code]):'';

		return $this->_render('nicocustomhtml', $data);
	}
}
