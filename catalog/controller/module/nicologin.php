<?php
include_once(DIR_APPLICATION . '/controller/module/nicomodule.inc');
global $_nico_module_counter;
class ControllerModuleNicologin  extends NicoModule
{
	public function index($setting) 
	{
		if (!$this->is_filter_ok($setting)) return false;
		$opencart_version = (int)str_replace('.','',VERSION);

		$data = $setting;		

		global $_nico_module_counter;
		if (isset($_nico_module_counter['nicologin'])) $_nico_module_counter['nicologin']++; else $_nico_module_counter['nicologin'] = 0;
		$data['module_id'] = $_nico_module_counter['nicologin'];

		//$this->load->language('common/header');
		$this->load->language('account/logout');
		$this->load->language('account/login');
		$this->load->language('account/account');
		
		$lang_code = isset($this->session->data['language'])?$this->session->data['language']:$this->language->get('code');
		
		if (!$lang_code || is_object($lang_code)) $lang_code = $lang_code->get('code');
		
		$lang_code = strtolower($lang_code);

		$default_lang = 'en';

		if ($opencart_version >= 2200)
		{
			$default_lang = 'en-gb';
		}

		if (isset($data['button_text'][$lang_code])) $data['button_text'] = $data['button_text'][$lang_code];else if (isset($data['button_text'][$default_lang])) $data['button_text'] = $data['button_text'][$default_lang];else $data['button_text'] = '';

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_new_customer'] = $this->language->get('text_new_customer');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_register_account'] = $this->language->get('text_register_account');
		$data['text_returning_customer'] = $this->language->get('text_returning_customer');
		$data['text_i_am_returning_customer'] = $this->language->get('text_i_am_returning_customer');
		$data['text_forgotten'] = $this->language->get('text_forgotten');

		$data['entry_email'] = $this->language->get('entry_email');
		$data['entry_password'] = $this->language->get('entry_password');

		$data['button_continue'] = $this->language->get('button_continue');
		$data['button_login'] = $this->language->get('button_login');

		$data['action'] = $this->url->link('account/login', '', 'SSL');
		$data['register'] = $this->url->link('account/register', '', 'SSL');
		$data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');

		$data['text_logged'] =  $this->customer->getFirstName();//$this->customer->getEmail()

		$data['text_account'] = $this->language->get('text_account');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_login'] = $this->language->get('text_login');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_logout'] = $this->language->get('text_logout');
		$data['text_transaction'] = $this->language->get('text_transaction');
		$data['text_download'] = $this->language->get('text_download');
		$data['text_all'] = $this->language->get('text_all');

		
		$data['logged'] = $this->customer->isLogged();
		$data['account'] = $this->url->link('account/account', '', 'SSL');
		$data['order'] = $this->url->link('account/order', '', 'SSL');
		$data['transaction'] = $this->url->link('account/transaction', '', 'SSL');
		$data['download'] = $this->url->link('account/download', '', 'SSL');
		$data['logout'] = $this->url->link('account/logout', '', 'SSL');




		$opencart_version = (int)str_replace('.','',VERSION);
		return $this->_render('nicologin', $data);
	}
}
