<?php
class ControllerEventTheme extends Controller {
	public function index(&$route, &$args) {

		$opencart_version = (int)str_replace('.','',VERSION);

		if ($opencart_version >= 3000)
		{ 
			if (!$this->config->get('theme_' . $this->config->get('config_theme') . '_status')) {
				exit('Error: A theme has not been assigned to this store!');
			}
				
			// If the default theme is selected we need to know which directory its pointing to			
			$theme = $this->config->get('config_theme');
			if ($theme == 'default' || $theme == 'theme_default') {
				$theme = $this->config->get('theme_default_directory');
			} else {
				//$theme = $this->config->get('config_theme');
			}		
	
			// If there is a theme override we should get it				
			$this->load->model('design/theme');
		
			$theme_info = $this->model_design_theme->getTheme($route, $theme);
		
			if ($theme_info) {
				// include and register Twig auto-loader
				include_once DIR_SYSTEM . 'library/template/Twig/Autoloader.php';
			
				Twig_Autoloader::register();	

				// specify where to look for templates
				$loader = new \Twig_Loader_Filesystem(DIR_TEMPLATE);
			
				// initialize Twig environment
				$twig = new \Twig_Environment($loader, array('autoescape' => false));	

				$template = $twig->createTemplate(html_entity_decode($theme_info['code'], ENT_QUOTES, 'UTF-8'));
			
				return $template->render($args);
			} elseif (is_file(DIR_TEMPLATE . $theme . '/template/' . $route . '.tpl') || is_file(DIR_TEMPLATE . $theme . '/template/' . $route . '.twig')) { 
				$route = $theme . '/template/' . $route;
			} elseif (is_file(DIR_TEMPLATE . 'default/template/' . $route . '.twig')) {
				$route = 'default/template/' . $route;
			}
		
			$template = new Template($this->registry->get('config')->get('template_engine'));
			
			foreach ($args as $key => $value) {
				$template->set($key, $value);
			}

			$template->set('theme_name', $this->config->get('config_theme'));
			$template->set('theme_directory', $theme);
			$template->set('registry', $this->registry);
		
			return $template->render($route);	
		} else
		{	
			if (!$this->config->get($this->config->get('config_theme') . '_status')) {
				exit('Error: A theme has not been assigned to this store!');
			}
		
			// This is only here for compatibility with old themes.
			if (substr($route, -4) == '.tpl') {
				$route = substr($route, 0, -4);
			}
		
			$theme = $this->config->get('config_theme');
			if ($theme == 'default' || $theme == 'theme_default') {
				$theme = $this->config->get('theme_default_directory');
			} else {
				//$theme = $this->config->get('config_theme');
			}
		
			$args['theme_name'] = $this->config->get('config_theme');
			$args['theme_directory'] = $theme;
			$args['registry'] = $this->registry;

			if (is_file(DIR_TEMPLATE . $theme . '/template/' . $route . '.tpl')) {
				$route = $theme . '/template/' . $route;
			} else {
				$route = 'default/template/' . $route;
			}				
		}
	}
}
