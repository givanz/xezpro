<?php
include_once(DIR_APPLICATION . '/controller/module/nicomodule.inc');
global $_nico_module_counter;
class ControllerModuleNicoparallax  extends NicoModule
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
		if (isset($_nico_module_counter['nicoparallax'])) $_nico_module_counter['nicoparallax']++; else $_nico_module_counter['nicoparallax'] = 0;
		$data['module_id'] = $_nico_module_counter['nicoparallax'];
		
		$data['content'] = isset($setting['content'][$lang_code])?html_entity_decode($setting['content'][$lang_code]):'';
		
		if (isset($data['title'][$lang_code])) $data['title']= $data['title'][$lang_code];else if (isset($data['title'][$default_lang])) $data['title'] = $data['title'][$default_lang];else $data['title'] = '';
		if (isset($data['button_text'][$lang_code])) $data['button_text']= $data['button_text'][$lang_code];else if (isset($data['button_text'][$default_lang])) $data['button_text'] = $data['button_text'][$default_lang];else $data['button_text'] = '';

		if (isset($data['background_image']) && $setting['background_image'])
		{
			$resize_method = 0;
			if (isset($setting['resize_method']))
			{
				$resize_method = (int)$data['resize_method'];
			}
			
			if (isset($data['background_image']) && $data['background_image'])
			switch($resize_method)
			{
				case 1:
				$data['background_image'] = $this->model_tool_image->cropsize($data['background_image'], $data['image_width'], $data['image_height']);
				break;
				case 2:
				$data['background_image'] = $this->model_tool_image->resizewidth($data['background_image'], $data['image_width'], $data['image_height']);
				break;
				case 3:
				$data['background_image'] = $this->model_tool_image->resizeheight($data['background_image'], $data['image_width'], $data['image_height']);
				break;
				default:
				$data['background_image'] = $this->model_tool_image->resize/*keep*/($data['background_image'], $data['image_width'], $data['image_height']);
			}
		}
		
		switch($data['type'])
		{
			case 'module':
				$data['content'] = $this->render_module($data['_module']);
			break;
			case 'html':
				$data['content'] = isset($setting['content'][$lang_code])?html_entity_decode($setting['content'][$lang_code]):'';
			break;
		}


		return $this->_render('nicoparallax', $data);
	}
}
