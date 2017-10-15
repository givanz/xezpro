<?php
include_once(DIR_APPLICATION . '/controller/module/nicomodule.inc');
global $_nico_module_counter;
class ControllerModuleNicoimagegallery  extends NicoModule
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
		if (isset($_nico_module_counter['nicoimagegallery'])) $_nico_module_counter['nicoimagegallery']++; else $_nico_module_counter['nicoimagegallery'] = 0;
		$data['module_id'] = $_nico_module_counter['nicoimagegallery'];
		
		$resize_method = 0;
		if (isset($setting['resize_method']) && $setting['resize_method'] == 'cropresize')
		{
			$resize_method = 1;
		}


		$data['cols_xs'] = isset($setting['module_cols_xs'])?$setting['module_cols_xs']:1;
		$data['cols_sm'] = isset($setting['module_cols_sm'])?$setting['module_cols_sm']:2;
		$data['cols_md'] = isset($setting['module_cols_md'])?$setting['module_cols_md']:4;
		$data['cols_lg'] = isset($setting['module_cols_lg'])?$setting['module_cols_lg']:4;
		
		if (isset($setting['section'])) foreach ($setting['section'] as $nr => $section)
		{
			$data['section'][$nr] = $section;
			
			if (isset($section['image_image']) && $section['image_image'])  
			{
				$data['section'][$nr]['image'] = $this->model_tool_image->cropsize($section['image_image'], $setting['image_width'], $setting['image_height']);
				//$this->config->get('config_url') . 'image/' . $section['image_image'];//$this->model_tool_image->resize($section['image_image'], 500, 500);
				$data['section'][$nr]['thumb'] = $this->model_tool_image->cropsize($section['image_image'], $setting['thumb_image_width'], $setting['thumb_image_height']);
				//$this->config->get('config_url') . 'image/' . $section['image_image'];//$this->model_tool_image->resize($section['image_image'], 500, 500);
			}


			if (isset($section['title'][$lang_code])) $title = $section['title'][$lang_code];else if (isset($section['title'][$default_lang])) $title = $section['title'][$default_lang];else $title = '';
			$data['section'][$nr]['title'] = $title;

			if (isset($section['description'][$lang_code])) $description = $section['description'][$lang_code];else if (isset($section['description'][$default_lang])) $description =  $section['description'][$default_lang];else $description = '';
			$data['section'][$nr]['description'] = $description;
		}
		
		return $this->_render('nicoimagegallery', $data);
	}
}
