<?php
include_once(DIR_APPLICATION . '/controller/module/nicomodule.inc');
class ControllerModuleNicoproducttabs  extends NicoModule
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
		
		if ($opencart_version > 2000)
		{
			$this->load->language('module/nicoproducttabs');
		} else
		{
			$this->language->load('module/nicoproducttabs'); 
		}

		if (isset($setting['section'])) foreach ($setting['section'] as $nr => $section)
		{
			$data['section'][$nr] = $section;
			if (isset($section['title'])) $data['section'][$nr]['title'] = isset($section['title'][$lang_code])?$section['title'][$lang_code]:$section['title'][$default_lang];
			if (isset($section['subtitle'])) $data['section'][$nr]['subtitle'] = isset($section['subtitle'][$lang_code])?$section['subtitle'][$lang_code]:$section['subtitle'][$default_lang];
			if (isset($section['youtube'])) $data['section'][$nr]['youtube'] = isset($section['youtube'][$lang_code])?$section['youtube'][$lang_code]:(isset($section['youtube'][$default_lang])?$section['youtube'][$default_lang]:'');
			if (isset($section['vimeo'])) $data['section'][$nr]['vimeo'] = isset($section['vimeo'][$lang_code])?$section['vimeo'][$lang_code]:(isset($section['vimeo'][$default_lang])?$section['vimeo'][$default_lang]:'');
			if (isset($section['text'])) $data['section'][$nr]['text'] =isset($section['text'][$lang_code])?$section['text'][$lang_code]:$section['text'][$default_lang];


			if (isset($section['content_type']))
			switch($section['content_type'])
			{
				case 'module':
					$data['section'][$nr]['text'] = $this->render_module($data['section'][$nr]['_module']);
				break;
				case 'text':
					$data['section'][$nr]['text'] =isset($section['text'][$lang_code])?$section['text'][$lang_code]:$section['text'][$default_lang];
				break;
			}

		}

		return $this->_render('nicoproducttabs', $data);
	}
}
