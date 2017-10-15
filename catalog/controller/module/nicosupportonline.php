<?php
include_once(DIR_APPLICATION . '/controller/module/nicomodule.inc');
global $_nico_module_counter;
class ControllerModuleNicosupportonline  extends NicoModule
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
		if (isset($_nico_module_counter['nicosupportonline'])) $_nico_module_counter['nicosupportonline']++; else $_nico_module_counter['nicosupportonline'] = 0;
		$data['module_id'] = $_nico_module_counter['nicosupportonline'];

		$resize_method = 0;
		if (isset($setting['resize_method']) && $setting['resize_method'] == 'cropresize')
		{
			$resize_method = 1;
		}
		
		
		if (isset($data['title'][$lang_code])) $data['title'] = $data['title'][$lang_code];else if (isset($data['title'][$default_lang])) $data['title'] = $data['title'][$default_lang];else $data['title'] = '';
		if (isset($data['text'][$lang_code])) $data['text'] = $data['text'][$lang_code];else if (isset($data['text'][$default_lang])) $data['text'] = $data['text'][$default_lang];else $data['text'] = '';


		if (isset($setting['section'])) foreach ($setting['section'] as $nr => $section)
		{
			$data['section'][$nr] = $section;
			if (isset($section['position'][$lang_code])) $position = $section['position'][$lang_code];else if (isset($section['position'][$default_lang])) $position = $section['position'][$default_lang];else $position = '';
			$data['section'][$nr]['position'] = $position;

			if (isset($section['image_image']) && $section['image_image']) 
			{
				if ($resize_method == 1)
				$data['section'][$nr]['image'] = $this->model_tool_image->cropsize($section['image_image'], $setting['image_width'], $setting['image_height']); else
				$data['section'][$nr]['image'] = $this->model_tool_image->resize/*keep*/($section['image_image'], $setting['image_width'], $setting['image_height']);
			}
		}

		return $this->_render('nicosupportonline', $data);
	}
}
