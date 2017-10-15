<?php
define('NICO_PAGE_CACHE_PREFIX', 'nico_speed_cache_');
define('NICO_PAGE_CACHE', true);
define('NICO_CACHE_IGNORE_USER', true);
define('NICO_PAGE_CACHE_GZIP', 0);
define('NICO_PAGE_CACHE_STRIP_EXTRA_SPACE', true);
define('NICO_PAGE_CACHE_TIMEOUT', 1800000);
define('NICO_PAGE_CACHE_IGNORE', 'feed/ api/ tool/ module/ checkout/ account/ affiliate/ ebay/ payment/ product/compare common/cart/info module/nicosocialauth /captcha');

$_nico_page_cache_ignore = false;
$_nico_cache_file = '';

function nico_speed_cache_page_init()
{
	global $_nico_cache_file, $_nico_page_cache_ignore, $_nico_cache_route;
	
	if (isset($_GET['route'])) $route = $_GET['route']; else $route = 'common/home';
	if (isset($_GET['_route'])) $route = $_GET['_route'];
	if (isset($_GET['_route_'])) $route = $_GET['_route_'];

	$controller = '';
	$action = '';
	if (!empty($route))
	{
		$route = substr($route, 0, 28);//make sure page name is not too long
		if (strpos($route, '-') === false/*always cache seo pages as they are*/)
		{
			$controller = substr($route, 0, strpos($route, '/')) . '/ ';
			$action = substr($route, strpos($route, '/') + 1);
			$action = $action?$action:$controller;
			$action = str_replace(array(' ','/'), array('', '_'), $action);
			$action = preg_replace("/[^A-Za-z0-9 ]/", '', $action);
		} else
		{
			$action = preg_replace("/[^A-Za-z0-9 -]/", '', $route);
		}
	}
	
	$language = '';
	$currency = '';
	if (isset($_COOKIE['language']) && $_COOKIE['language'] != 'en') $language = '_' . preg_replace("/[^A-Za-z0-9 ]/", '', $_COOKIE['language']);
	if (isset($_COOKIE['currency'])) $currency = '_' . preg_replace("/[^A-Za-z0-9 ]/", '', $_COOKIE['currency']);
	if (isset($_GET['code'])) $currency = '_' . preg_replace("/[^A-Za-z0-9 ]/", '', $_GET['code']);
	//var_dump($_SERVER);
	//don't cache if admin is logged in
	if (NICO_CACHE_IGNORE_USER && isset($_SESSION) && isset($_SESSION[key($_SESSION)]['user_id']))
	{
		$_nico_page_cache_ignore = true;
		return false;
	}
	
 	//don't cache post, authenticated users, guests with products added to cart or ignored pages
	if (
	 	isset($_COOKIE['_npc_cust']) || 
	 	$_POST ||
		(!empty($controller) && strpos(NICO_PAGE_CACHE_IGNORE, $controller) !== false) ||
		strpos(NICO_PAGE_CACHE_IGNORE, $route) !== false ||
		strpos($_SERVER['REQUEST_URI'], 'filter_') !== false
	) {
		$_nico_page_cache_ignore = true;
		return false;
	}
	
	$key = md5($_SERVER['REQUEST_URI'] . $_SERVER['HTTP_HOST']);
	
	$page = str_replace(array(' ','/'), array('', '_'), $route);
	
	$_nico_cache_file = DIR_CACHE . NICO_PAGE_CACHE_PREFIX . $key . '-' . $action . $language. $currency;// . str_replace(array('/','&', '=','index.php?'),'_', $_SERVER['REQUEST_URI']);
	if (file_exists($_nico_cache_file) && (time() - NICO_PAGE_CACHE_TIMEOUT < filemtime($_nico_cache_file)))
	{
		if (NICO_PAGE_CACHE_GZIP > 0)
		{
			if (isset($_SERVER['HTTP_ACCEPT_ENCODING']) && (strpos($_SERVER['HTTP_ACCEPT_ENCODING'], 'gzip') !== false)) {
				$encoding = 'gzip';
			}

			if (isset($_SERVER['HTTP_ACCEPT_ENCODING']) && (strpos($_SERVER['HTTP_ACCEPT_ENCODING'], 'x-gzip') !== false)) {
				$encoding = 'x-gzip';
			}

			header('Content-Encoding: ' . $encoding);
		}

		readfile($_nico_cache_file);
		exit;		
		//die(file_get_contents($_nico_cache_file));
	} else
	{
		if (NICO_PAGE_CACHE_GZIP == 0)
		{
			@ini_set('zlib.output_compression', 'Off');
			@ini_set('output_buffering', 'Off');
			@ini_set('output_handler', '');
		}		
		
		ob_start();
	}
}

function nico_speed_cache_page_save()
{
 global $_nico_cache_file, $_nico_cache_route, $_nico_page_cache_ignore;

 if ($_nico_page_cache_ignore) return;
 
 $html = ob_get_contents();
 if (NICO_PAGE_CACHE_STRIP_EXTRA_SPACE)
 {
	 $html = preg_replace('/[ \t]+/', ' ',  $html);
	 
	 $html = str_replace("\r", "\n", $html);
	 
	 $html = preg_replace('/\s*\n+\s*/', "\n", $html);
 }	 
 
 file_put_contents($_nico_cache_file, $html);
}
