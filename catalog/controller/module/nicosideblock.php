<?php
if (!defined('NICO_STANDALONE')) define('NICO_STANDALONE', false);
include_once(DIR_APPLICATION . '/controller/module/nicomodule.inc');
class ControllerModuleNicosideblock  extends NicoModule
{
	public function index($setting) 
	{
		if (!$this->is_filter_ok($setting)) return false;
		$data = $setting;

		
		$opencart_version = (int)str_replace('.','',VERSION);

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
			$data['section'][$nr] = $section;
			$data['section'][$nr]['icon_text'] = isset($section['icon_text'][$lang_code])?$section['icon_text'][$lang_code]:$section['icon_text'][$default_lang];
			$data['section'][$nr]['text'] = isset($section['text'][$lang_code])?$section['text'][$lang_code]:$section['text'][$default_lang];
		}

		$data['screen_position'] = $setting['screen_position'];

		if (NICO_STANDALONE) 
		{
			$this->document->addStyle('catalog/view/css/nicosideblock.css');
			if ($opencart_version < 2000)
			{
				$this->document->addStyle('catalog/view/javascript/font-awesome/css/font-awesome.min.css');
			}
		}
		//$this->document->addScript('catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js');

		return $this->_render('nicosideblock', $data);
	}
}
