<?php
include_once(DIR_APPLICATION . '/controller/module/nicomodule.inc');
global $_nico_module_counter;
class ControllerModuleNicosequenceslider  extends NicoModule
{
	public function index($setting) 
	{
		if (!$this->is_filter_ok($setting)) return false;
		$opencart_version = (int)str_replace('.','',VERSION);

		$this->load->model('tool/image');

		$lang_code = isset($this->session->data['language'])?$this->session->data['language']:$this->language->get('code');
		
		if (!$lang_code || is_object($lang_code)) $lang_code = $lang_code->get('code');
		
		$lang_code = strtolower($lang_code);

		$default_lang = 'en';

		if ($opencart_version >= 2200)
		{
			$default_lang = 'en-gb';
		}
		
		$data = $setting;

		global $_nico_module_counter;
		if (isset($_nico_module_counter['nicosequenceslider'])) $_nico_module_counter['nicosequenceslider']++; else $_nico_module_counter['nicosequenceslider'] = 0;
		$data['module_id'] = $_nico_module_counter['nicosequenceslider'];

		$resize_method = 0;
		if (isset($setting['resize_method']) && $setting['resize_method'] == 'cropresize')
		{
			$resize_method = 1;
		}


		if (isset($setting['section'])) foreach ($setting['section'] as $nr => $section)
		{
			$data['section'][$nr] = $section;
			if (isset($section['title'][$lang_code])) $title = $section['title'][$lang_code];else if (isset($section['title'][$default_lang])) $title = $section['title'][$default_lang];else $title = '';
			$data['section'][$nr]['title'] = $title;

			if (isset($section['subtitle'][$lang_code])) $subtitle = $section['subtitle'][$lang_code];else if (isset($section['subtitle'][$default_lang])) $subtitle =  $section['subtitle'][$default_lang];else $subtitle = '';
			$data['section'][$nr]['subtitle'] = $subtitle;

			if (isset($section['text'][$lang_code])) $text = $section['text'][$lang_code];else if (isset($section['text'][$default_lang])) $text =  $section['text'][$default_lang];else $text = '';
			$data['section'][$nr]['text'] = $text;

			if (isset($section['button'][$lang_code])) $button = $section['button'][$lang_code];else if (isset($section['button'][$default_lang]))$button =  $section['button'][$default_lang];else $button = '';
			$data['section'][$nr]['button'] = $button;

			if (isset($section['image_image']) && $section['image_image']) 
			{
				if ($resize_method == 1)
				$data['section'][$nr]['image'] = $this->model_tool_image->cropsize($section['image_image'], $setting['image_width'], $setting['image_height']); else
				$data['section'][$nr]['image'] = $this->model_tool_image->resize/*keep*/($section['image_image'], $setting['image_width'], $setting['image_height']);
			}
			
			//$this->config->get('config_url') . 'image/' . $section['image_image'];//$this->model_tool_image->resize($section['image_image'], 500, 500);
			if (isset($section['background_image']) && $section['background_image'])
			{
				if ($resize_method == 1)
				$data['section'][$nr]['background'] = $this->model_tool_image->cropsize($section['background_image'], $setting['background_image_width'], $setting['background_image_height']);else
				$data['section'][$nr]['background'] = $this->model_tool_image->resize/*keep*/($section['background_image'], $setting['background_image_width'], $setting['background_image_height']);
			}			
		}

		return $this->_render('nicosequenceslider', $data);
	}
}
