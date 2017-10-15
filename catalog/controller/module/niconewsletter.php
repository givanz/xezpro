<?php
include_once(DIR_APPLICATION . '/controller/module/nicomodule.inc');
global $_nico_module_counter;
class ControllerModuleNiconewsletter extends NicoModule
{
	public function index($setting) 
	{
		if (!$this->is_filter_ok($setting)) return false;

		$opencart_version = (int)str_replace('.','',VERSION);
		$this->load->model('tool/image');
		
		$data = $setting;

		global $_nico_module_counter;
		if (isset($_nico_module_counter['niconewsletter'])) $_nico_module_counter['niconewsletter']++; else $_nico_module_counter['niconewsletter'] = 0;
		$data['module_id'] = $_nico_module_counter['niconewsletter'];

		$lang_code = isset($this->session->data['language'])?$this->session->data['language']:$this->language->get('code');
		
		if (!$lang_code || is_object($lang_code)) $lang_code = $lang_code->get('code');
		
		$lang_code = strtolower($lang_code);

		$default_lang = 'en';

		if ($opencart_version >= 2200)
		{
			$default_lang = 'en-gb';
		}

		if (isset($data['newsletter_text'][$lang_code])) $data['newsletter_text'] = $data['newsletter_text'][$lang_code];else if (isset($data['newsletter_text'][$default_lang])) $data['newsletter_text'] = $data['newsletter_text'][$default_lang];else $data['newsletter_text'] = '';
		if (isset($data['subscribe_text'][$lang_code])) $data['subscribe_text'] = $data['subscribe_text'][$lang_code];else if (isset($data['subscribe_text'][$default_lang])) $data['subscribe_text'] = $data['subscribe_text'][$default_lang];else $data['subscribe_text'] = '';
		if (isset($data['email_text'][$lang_code])) $data['email_text'] = $data['email_text'][$lang_code];else if (isset($data['email_text'][$default_lang])) $data['email_text'] = $data['email_text'][$default_lang];else $data['email_text'] = '';
		if (isset($data['additional_text'][$lang_code])) $data['additional_text'] = html_entity_decode($data['additional_text'][$lang_code]);else if (isset($data['additional_text'][$default_lang])) $data['additional_text'] = html_entity_decode($data['additional_text'][$default_lang]);else $data['additional_text'] = '';


		return $this->_render('niconewsletter', $data);
	}
}
