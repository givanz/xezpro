<?php 
if (!isset($_POST['ajax']) && strpos($_SERVER['REQUEST_URI'],'ajax=true') == false) {
global $_config, $opencart_version, $is_css_file_writable,$_nico_head_script, $_nico_head_style, $_nico_head_js, $_nico_head_css;
$opencart_version = (int)str_replace('.','',VERSION);
if (isset($this->registry)) $registry = $this->registry;
$_config =  $registry->get('config');
if (!isset($theme_name))
{
	if (!($theme_name = $_config->get('config_template')))
	{
		$theme_name = $_config->get('config_theme');
	}
}
if (!isset($theme_directory))
{
	$theme_directory = $theme_name;
}

//$theme_directory = DIR_TEMPLATE . '/' . $theme_directory . '/';
require_once(DIR_TEMPLATE . $theme_directory . '/nico_theme_editor/common.inc');
?><!doctype html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
    <head>
	    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		
		<base href="<?php 
		$url = parse_url($base);
		if (!isset($url['scheme'])) $url['scheme'] = '';
		$url['scheme'] .= '://';
		$url['host'] = $_SERVER['HTTP_HOST'];
		echo implode($url);?>" />
		<?php if ($description) { ?>
		<meta name="description" content="<?php echo $description; ?>" />
		<?php } ?>
		<?php if ($keywords) { ?>
		<meta name="keywords" content="<?php echo $keywords; ?>" />
		<?php } ?>
		<?php if (isset($icon)) { ?>
		<link href="<?php echo $icon; ?>" rel="icon" />
		<?php } ?>
		<!--[if IE]><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'><![endif]-->
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="apple-touch-icon" href="/apple-touch-icon.png">

		<!--script type="text/javascript" src="https://getfirebug.com/firebug-lite-debug.js"></script-->	
		<!--[if lt IE 9]>
 		<script type="text/javascript" src="catalog/view/theme/<?php echo $theme_directory;?>/js/respond.js"></script>
 		<style>
 		img.img-responsive {max-width:none;width:auto;}
 		</style>
		<![endif]-->
		<!--[if gt IE 8]>
 		<style>
 		img.img-responsive {max-width:none;width:auto;}
 		</style>
		<![endif]-->
		<?php 
		if (isset($_nico_head_script ['common'][0])) $_nico_head_script ['common'][] = $_nico_head_script ['common'][0];
		$_nico_head_script ['common'][0] = 'catalog/view/theme/' .$theme_directory. '/js/jquery-2.1.4.min.js';
		$_nico_head_script ['common'][] = 'catalog/view/theme/' .$theme_directory. '/js/bootstrap.min.js';
		$_nico_head_script ['common'][] = 'catalog/view/theme/' .$theme_directory. '/js/bootstrap-select.min.js';
		$_nico_head_script ['common'][] = 'catalog/view/theme/' .$theme_directory. '/js/jquery.autocomplete.js';
		$_nico_head_script ['common'][] = 'catalog/view/theme/' .$theme_directory. '/js/jquery.colorbox-min.js';
		$_nico_head_script ['common'][] = 'catalog/view/theme/' .$theme_directory. '/js/cloud-zoom.1.0.3.js';
		$_nico_head_script ['common'][] = 'catalog/view/theme/' .$theme_directory. '/js/jquery.flexslider.js';
		$_nico_head_script ['common'][] = 'catalog/view/theme/' .$theme_directory. '/js/moment.js';
		$_nico_head_script ['common'][] = 'catalog/view/theme/' .$theme_directory. '/js/bootstrap-datetimepicker.min.js';
		$_nico_head_script ['common'][] = 'catalog/view/theme/' .$theme_directory. '/js/bootstrap-slider.min.js';
		$_nico_head_script ['common'][] = 'catalog/view/theme/' .$theme_directory. '/js/js.cookie.js';
		$_nico_head_script ['common'][] = 'catalog/view/theme/' .$theme_directory. '/js/main.js';
		?>

		<?php if (nico_get_config('container_width') == 'small') 
		$_nico_head_style ['common'][] = 'catalog/view/theme/' .$theme_directory. '/css/bootstrap_small.css';else
		$_nico_head_style ['common'][] = 'catalog/view/theme/' .$theme_directory. '/css/bootstrap.css';
		
		if ($direction == 'rtl' || nico_get_config('text_direction') == 'rtl') 
		$_nico_head_style ['common'][] = 'catalog/view/theme/' .$theme_directory. '/css/bootstrap-rtl.css';

		if (nico_get_config('fonts') == 1) $_nico_head_style ['common'][] = 'catalog/view/theme/' .$theme_directory. '/css/builtinfonts.css'; else 
		{?><link href='//fonts.googleapis.com/css?family=<?php if ($google_fonts = nico_get_config('google_fonts')) echo  str_replace('|','%7C',$google_fonts);else echo str_replace('|','%7C','Montserrat:400,600,700|Open+Sans:300,400,600,700|Hind:300,400,600,700|Maven+Pro');?>' rel='stylesheet' type='text/css'/><?php }  
		
		$_nico_head_style ['common'][] = 'catalog/view/theme/' .$theme_directory. '/css/bootstrap-select.min.css';
		$_nico_head_style ['common'][] = 'catalog/view/theme/' .$theme_directory. '/css/style.css';
		$_nico_head_style ['common'][] = 'catalog/view/theme/' .$theme_directory. '/css/colorbox.css';
		$_nico_head_style ['common'][] = 'catalog/view/theme/' .$theme_directory. '/css/font-awesome.min.css';
		$_nico_head_style ['common'][] = 'catalog/view/theme/' .$theme_directory. '/css/cloud-zoom.css';
		$_nico_head_style ['common'][] = 'catalog/view/theme/' .$theme_directory. '/css/flexslider.css';
		$_nico_head_style ['common'][] = 'catalog/view/theme/' .$theme_directory. '/css/bootstrap-datetimepicker.min.css';

		$settings_css_file_name = 'editor_settings.css';
		/*demo*/if (strpos($_SERVER['HTTP_HOST'], 'xezpro2') !== false) {$settings_css_file_name = 'editor_settings2.css';}
		/*demo*/if (strpos($_SERVER['HTTP_HOST'], 'xezpro3') !== false) {$settings_css_file_name = 'editor_settings3.css';}
		/*demo*/if (strpos($_SERVER['HTTP_HOST'], 'xezpro4') !== false) {$settings_css_file_name = 'editor_settings4.css';}
		/*demo*/if (strpos($_SERVER['HTTP_HOST'], 'xezpro5') !== false) {$settings_css_file_name = 'editor_settings5.css';}
		/*demo*/if (strpos($_SERVER['HTTP_HOST'], 'xezpro6') !== false) {$settings_css_file_name = 'editor_settings6.css';}

		$is_css_file_writable = is_readable(DIR_TEMPLATE . $theme_directory . '/css/' . $settings_css_file_name) && is_writable(DIR_TEMPLATE . $theme_directory . '/css/' . $settings_css_file_name);
		if ($is_css_file_writable)
		$_nico_head_style ['common'][] = 'catalog/view/theme/' .$theme_directory. '/css/' . $settings_css_file_name;
		else
		$_nico_css = $_config->get('nicoeditorsettings_css');
		?>

		<?php 
		$concatenate_js = (nico_get_config('concatenate_js') == '1'); 
		$minify_js = (nico_get_config('minify_js') == '1'); 
		
		//write js files
		if ($_nico_head_script) 
		{
			$regenerate_js = false;
			ksort($_nico_head_script);
			foreach($_nico_head_script as $group => $nico_scripts)
			{
				$nico_scripts = array_unique($nico_scripts);
				if ($concatenate_js)
				{
					$group_js = DIR_TEMPLATE .$theme_directory. '/js/_nico_'. $group . '.js';

					$max_time = 0;
					$group_mtime = 0;
					if (
						(is_writable($group_js) && $group_mtime = filemtime($group_js))
						|| (@touch($group_js) && $group_mtime = -1)) 
					{

						foreach($nico_scripts as $script)
						{
							$time = filemtime($script);
							if ($time > $max_time) $max_time = $time;
						}

						if ($group_mtime < $max_time)
						{
							$regenerate_js = true;
							$js_contents = '';
							foreach($nico_scripts as $script)
							{
								$js_contents .= "/*$script*/\n\n" . file_get_contents($script) . "\n";
							}
							if ($minify_js)
							{
								include_once(DIR_TEMPLATE . $theme_directory . '/nico_theme_editor/minifier.inc');
								$js_contents = Minifier::minify($js_contents);
							}
							file_put_contents($group_js, $js_contents);
						} 
						?><script src="catalog/view/theme/<?php echo $theme_directory;?>/js/_nico_<?php echo $group;?>.js<?php echo '?t=' . $max_time;?>"></script><?php			
					} else $concatenate_js = false;
				} 
				if (!$concatenate_js) foreach($nico_scripts as $script)
				{
				?><script src="<?php echo $script;?>"></script><?php 
				}

			}
		}
		$concatenate_css = (nico_get_config('concatenate_css') == '1'); 
		$minify_css = (nico_get_config('minify_css') == '1'); 

		
		if ($_nico_head_style) 
		{
			$regenerate_css = false;
			ksort($_nico_head_style);
			foreach($_nico_head_style as $group => $nico_styles)
			{
				$nico_styles = array_unique($nico_styles);
				if ($concatenate_css)
				{
					$group_css = DIR_TEMPLATE .$theme_directory. '/css/_nico_'. $group . '.css';

					$max_time = 0;
					$group_mtime = 0;
					if (
						(is_writable($group_css) && $group_mtime = filemtime($group_css))
						|| (@touch($group_css) && $group_mtime = -1)) 
					{
					foreach($nico_styles as $style)
					{
						if (file_exists($style)) 
						{
						$time = filemtime($style);
						if ($time > $max_time) $max_time = $time;
					}
					}
					
					if ($group_mtime < $max_time)
					{
						$regenerate_css = true;
						$css_contents = '';
						foreach($nico_styles as $style)
						{
							if (file_exists($style))
							$css_contents .= "/*$style*/\n\n" .file_get_contents($style) . "\n\n";
						}

						if ($minify_css)
						{
							//remove comments
							$css_contents = preg_replace('!/\*[^*]*\*+([^/][^*]*\*+)*/!', '', $css_contents);

							// Remove whitespace
							$css_contents = preg_replace('/\s+/', ' ', $css_contents);
						}
						
							//move import url (fonts) at the top
							if (preg_match_all('/@import url\([^\)]*?\);?/', $css_contents, $imports, PREG_PATTERN_ORDER) && $imports[0] > 0)
							{
								$css_contents  = str_replace(array('||', ';;'), array('|', ';'), implode("\n", $imports[0])) . ";\n\n" . str_replace($imports[0], '', $css_contents);
							}
							
							file_put_contents(DIR_TEMPLATE . $theme_directory. '/css/_nico_'. $group . '.css', $css_contents);
						} 
						?><link href='catalog/view/theme/<?php echo $theme_directory;?>/css/_nico_<?php echo $group;?>.css<?php echo '?t='. $max_time;?>' rel='stylesheet' type='text/css' property='stylesheet'/><?php
					} else $concatenate_css = false;
				} 
				if (!$concatenate_css)  foreach($nico_styles as $style)
				{
					?><link href='<?php echo $style;?>' rel='stylesheet' type='text/css' property='stylesheet'/><?php			
				}

			}
		}

		if ($_nico_head_js) 
		{
			$js_write = false;
			$_head_js = '';
			$_nico_head_js = array_reverse($_nico_head_js, true);
			foreach($_nico_head_js as $group => $js)
			{
				$group_js = 'catalog/view/theme/' .$theme_directory. '/js/_nico_'. $group . '.js';

				$_head_js = "jQuery(document).ready(function() {\n" . $js . "\n});";
				
				if ($concatenate_js)
				{
					if (isset($_nico_head_script[$group]))
					{
						if ($regenerate_js)
						{
							if (!file_put_contents($group_js, $_head_js . "\n", FILE_APPEND)) echo "<script>\n" . $_head_js . "\n</script>\n";
						} else 
						{
							if (!file_exists($group_js))
							{
								if (!file_put_contents($group_js, $_head_js . "\n")) echo "<script>\n" . $_head_js . "\n</script>\n";
							}
						}
					} else { if (!file_exists($group_js)) file_put_contents($group_js, $_head_js . "\n");?><script src="<?php echo $group_js;?>"></script><?php }
				} else echo "<script>\n" . $_head_js . "\n</script>\n";
			}
		}

		if ($_nico_head_css) 
		{
			$css_write = false;
			$_head_css = '';
			$_nico_head_css = array_reverse($_nico_head_css, true);
			foreach($_nico_head_css as $group => $css)
			{
				$_head_css = $css; 

				$group_css = 'catalog/view/theme/' .$theme_directory. '/css/_nico_'. $group . '.css';

				if ($concatenate_css)
				{
					if (isset($_nico_head_style[$group]))
					{
						if ($regenerate_css)
						{
							if (!file_put_contents($group_css, $_head_css, FILE_APPEND)) echo "<style>$_head_css</style>";
						} else
						{
							 if (!file_exists($group_css))
							{
								if (!file_put_contents($group_css, $_head_css)) echo "<style>$_head_css</style>";  
							}
						}
					} else { if (!file_exists($group_css)) file_put_contents($group_css, $_head_css . "\n"); ?><link href='<?php echo $group_css;?>' rel='stylesheet' type='text/css' property='stylesheet'/><?php }
				} else echo "<style>$_head_css</style>";
			}
		}

		if (!$is_css_file_writable) echo '<style>' . $_nico_css . '</style>';
		$custom_css = html_entity_decode(nico_get_config('custom_css'));

		if ($custom_css) 
			if (!file_put_contents(DIR_TEMPLATE .$theme_directory. '/css/_nico_common.css', $custom_css, FILE_APPEND)) echo "<style>\n" . $custom_css . "\n</style>";
	
	
		foreach ($links as $link) { ?><link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" /><?php } 
		
		foreach ($styles as $style) if (strpos($style['href'], 'colorbox.css') == false && strpos($style['href'], 'blog_custom.css') == false && strpos($style['href'], 'pavblog.css') == false && strpos($style['href'], 'bootstrap-datetimepicker.min.css') == false) 
		{
			?><link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" /><?php
		} 
		
		
		foreach ($scripts as $script) 
		{ 
			if (strpos($script, 'nivo.slider') == false && strpos($script, 'colorbox') == false  && strpos($script, 'tabs.js') == false && strpos($script, 'bootstrap-datetimepicker.min.js') == false  && strpos($script, 'moment.js') == false) 
			{
				?><script type="text/javascript" src="<?php echo $script; ?>"></script><?php 
			} 
		}
				
		if (isset($google_analytics)) echo $google_analytics; ?>
		<?php if (isset($analytics)) foreach ($analytics as $analytic) { ?>
		<?php echo $analytic; ?>
		<?php } ?>
	    <title><?php if(empty($title)) echo $name; else echo $title; ?></title>
	</head>
<body>
	
<?php $_header = nico_get_modules('top');if($_header) {?>
<div class="page_top">
<?php foreach ($_header as $module) echo $module;?>
</div>
<?php }?>
	
<div id="top">
  <div class="container">
	<?php $_top_links = nico_get_modules('top_links');if($_top_links) foreach ($_top_links as $module) echo $module;?>
	<div id="top-links" class="pull-left">
	
	<ul class="list-inline">
        <?php if (isset($text_welcome)) {?>
		<li class="top-login">
	<?php if (!$logged && isset($text_welcome)) { ?>
	<?php echo $text_welcome; ?>
	<?php } else if (isset($text_logged) && $text_logged != 'text_logged') { ?>
	<?php echo $text_logged; ?>
	<?php } ?>
		</li>
		<?php } else { ?>
        <li class="dropdown top-login"><a href="<?php echo $account; ?>" title="<?php echo $text_account; ?>" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <span class="hidden-xs hidden-sm hidden-md">
			<?php 
			if ($logged) 
			{
				$customer = $registry->get('customer');
				$email = $customer->getEmail();
				echo $email;  
			} else echo $text_account; 
			?> 
			</span> <i class="fa fa-caret-down"></i></a>
          <ul class="dropdown-menu">
            <?php if ($logged) { ?>
            <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
            <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
            <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
            <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
            <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
            <?php } else { ?>
            <li><a href="<?php echo $register; ?>"><?php echo $text_register; ?></a></li>
            <li><a href="<?php echo $login; ?>"><?php echo $text_login; ?></a></li>
            <?php } ?>
          </ul>
        </li>
        <?php } ?>
        <li><a href="<?php echo $wishlist; ?>" id="wishlist-total" title="<?php echo $text_wishlist; ?>"><i class="fa fa-heart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_wishlist; ?></span></a></li>
        <li><a href="<?php echo $shopping_cart; ?>" title="<?php echo $text_shopping_cart; ?>"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_shopping_cart; ?></span></a></li>
        <li><a href="<?php echo $checkout; ?>" title="<?php echo $text_checkout; ?>"><i class="fa fa-share"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_checkout; ?></span></a></li>
        <?php if (isset($telephone)) { ?><li class="phone-number"><a href="<?php echo $contact; ?>"><i class="fa fa-phone"></i></a> <span class="hidden-xs hidden-sm hidden-md"><?php echo $telephone; ?></span></li><?php } ?>
      </ul>
	</div>
	<!-- div id="welcome" class="pull-right">
	<?php if (!$logged && isset($text_welcome)) { ?>
	<?php echo $text_welcome; ?>
	<?php } else if (isset($text_logged) && $text_logged != 'text_logged') { ?>
	<?php echo $text_logged; ?>
	<?php } ?>
	</div -->
	<div class="pull-right"><?php echo $currency; ?></div>
	<div class="pull-right"><?php echo $language; ?></div>
  </div>
</div>

	<div class="container">
	<?php $_header = nico_get_modules('header');if($_header) foreach ($_header as $module) echo $module;?>
	<?php if ($header_type = (int)nico_get_config('header_type')) include(DIR_TEMPLATE . $theme_directory . '/template/common/header' . $header_type . '.tpl'); else include(DIR_TEMPLATE . $theme_directory . '/template/common/header1.tpl');?>
	</div>		
	
	<div class="menu">
	<div class="header container">
		<?php $menu = nico_get_modules('menu');if($menu) foreach ($menu as $module) echo $module;?>
	</div>
	</div>
		
  
<?php if (isset($error) && $error) { ?>
    
    <div class="warning"><?php echo $error ?><img src="catalog/view/theme/<?php echo $theme_directory;?>/img/close.png" alt="" class="close" /></div>
    
<?php } ?>
<div id="notification"></div>

<div class="page-container">
<?php }
