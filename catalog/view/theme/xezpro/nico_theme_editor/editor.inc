<?php
/*
 * Nico open cart theme editor module
 * Copyright nicole_89
 * All rights reserved
 */
define('DEMO', false);
define('CHARSET', 'all');

if (isset($this->registry)) $registry = $this->registry;
if (!class_exists("User") || !class_exists("Cart/User")) 
{
	if (file_exists(DIR_SYSTEM . 'library/user.php')) 
	{
		if (function_exists('modification')) require_once(modification(DIR_SYSTEM . 'library/user.php')); 
		else require_once(DIR_SYSTEM . 'library/user.php'); 
		$user = new User($registry);
	}
	else 
	{
		require_once(modification(DIR_SYSTEM . 'library/cart/user.php'));
		$user = new Cart\User($registry);
	}
} else 
{
	
	if (file_exists(DIR_SYSTEM . 'library/user.php')) $user = new User($registry);
	else $user = new Cart\User($registry);
}

$_config =  $registry->get('config');

$_config =  $registry->get('config');
$load = new Loader($registry);

if ($user) define('HAS_PERMISSION', $user->hasPermission('modify', 'design/layout')); 
else define('HAS_PERMISSION', false);

$opencart_version = (int)str_replace('.','',VERSION);
$db = $registry->get('db');
if (!$db)
{
	$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE, DB_PREFIX);
}


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


include(DIR_TEMPLATE . '/' . $theme_directory. '/theme_config.inc');

$config_name = 'nicoeditorsettings';
$_nico_settings = $_config->get($config_name);
$sql_update = true;
$group_code = 'group';
if ($opencart_version > 2000)
{
	$group_code = 'code';
}
if ($_nico_settings)
{
	if (!is_array($_nico_settings))	
	{
		$_nico_settings = @json_decode($_nico_settings,true);
		if ($_nico_settings == null) $_nico_settings = @unserialize($_nico_settings);
	}
}
else
{

	$_nico_settings = array();
	$query = $db->query('SELECT * FROM ' . DB_PREFIX . 'setting WHERE `key` = \''. $config_name  .'\' LIMIT 1');
	if ($query->rows)
	{
		if ($query->rows[0])
		{
			if (!empty($query->rows[0]))
			{

				$_nico_settings = @json_decode($query->rows[0]['value'], true);
				if ($_nico_settings == null) $_nico_settings = @unserialize($query->rows[0]['value']);
				
			}
		}
		else 
		{
			$_nico_settings = array();
			$sql_update = false;
		}
	} else
	{
		$sql_update = false;
		$_nico_settings = array();
	}
}

//$last_modification_ts = filemtime(dirname(__FILE__) . '/settings.inc');

if (HAS_PERMISSION || (DEMO && strpos($_SERVER['HTTP_USER_AGENT'],'validator') === false))
{
	$settings_css_file_name = 'editor_settings.css';
	
	if ($_POST && HAS_PERMISSION)
	{
		if (isset($_POST['_nico_save_theme']))
		{
			unset($_POST['_nico_save_theme']);
			
			if (!isset($_nico_settings) || !is_array($_nico_settings)) $_nico_settings = array();
			if (!empty($_POST)) $_nico_settings = array_merge_recursive($_nico_settings, $_POST);
			
			$css = '';
			if (isset($_nico_settings['options'])) foreach($_nico_settings['options'] as $selector => &$data)
			{
				$attributes = '';
				foreach ($data as $attribute => &$value)
				{
					if (is_array($value)) 
					{
						$value = end($value);
					}
						//$_nico_settings['colors'][$selector][$attribute] = $value;
					$attributes .= $attribute . ':' . $value .';';
				}
				if ($attributes) $css .= $selector . '{' . $attributes . "}\n";
			}			
			
			if (isset($_nico_settings['colors'])) foreach($_nico_settings['colors'] as $selector => &$data)
			{
				foreach ($data as $attribute => &$color)
				{
					if (is_array($color)) 
					{
						$color = end($color);
						//$_nico_settings['colors'][$selector][$attribute] = $color;
					}
					$css .= $selector . '{' . $attribute . ':' . $color . "}\n";
				}
			}

			$fonts = array();
			if (isset($_nico_settings['fonts'])) foreach($_nico_settings['fonts'] as $selector => &$font)
			{
				if (isset($font['font-family']) && is_array($font['font-family'])) 
				{
					$font['font-family'] = end($font['font-family']);
				}
				
				if (isset($font['size']) && is_array($font['size'])) 
				{
					$font['size'] = end($font['size']);
				}
				
				$font_size = '';
				$font_family = '';
				
				if (isset($font['font-family']) && !empty($font['font-family'])) 
				{
					$font_family = 'font-family:\'' . $font['font-family'] . '\';';
				}
				
				if (isset($font['size']) && !empty($font['size'])) 
				{
					$font_size = 'font-size:' . $font['size'] . 'px';
				}
				
				if (!empty($font_family) || !empty($font_size))
				{
					$css .= $selector . '{' .$font_family . $font_size . '}' ."\n";
					if (isset($font['font-family'])) $fonts[] = urlencode($font['font-family']);
				}
			}

			if ((isset($_nico_settings['background-image']) && $_nico_settings['background-image'] != 'disabled') || isset($_nico_settings['background-style']))
			{	
				if (is_array($_nico_settings['background-image'])) 
				{
					$_nico_settings['background-image'] = end($_nico_settings['background-image']);
				}

				if (isset($_nico_settings['background-style']) && is_array($_nico_settings['background-style'])) 
				{
					$_nico_settings['background-style'] = end($_nico_settings['background-style']);
				}

				$background_style = '';
				if (isset($_nico_settings['background-style'])) switch($_nico_settings['background-style'])
				{
					case 'repeat':
						$background_style = 'background-repeat:repeat';
					break;
					case 'repeat-x':
						$background_style = 'background-repeat:repeat-x';
					break;
					case 'repeat-y':
						$background_style = 'background-repeat:repeat-y';
					break;
					case 'stretch':
						$background_style = 'background-size:100%;background-size:cover';
					break;
					case 'no-repeat':
						$background_style = 'background-repeat:no-repeat';
					break;
				}
				
				//$css .= 'body {'. preg_replace('@catalog/view/theme/[^/]+/@', '../', urldecode($_nico_settings['background-image'])) . ';' . $background_style . "}\n\n";	
				$css .= 'body {'. urldecode($_nico_settings['background-image']) . ';' . $background_style . "}\n\n";	
			}
			
			if (isset($_nico_settings['sliders'])) foreach($_nico_settings['sliders'] as $page => &$sliders)
			{
				if (isset($sliders)) foreach($sliders as $slider => &$options)
				{
					if ($slider == 'active')
					{
						if (is_array($options)) 
						{
							$options = end($options);
						}
					} else
					foreach($options as $_name => &$data)
					{
						if (is_array($data)) 
						{
							$data = end($data);
							//$_nico_settings['sliders'][$page][$slider][$_name] = $data;
						}
					}
				}
			}
			
			if (isset($_nico_settings['settings'])) foreach($_nico_settings['settings'] as $selector => &$data)
			{
				if (is_array($data)) 
				{
					$data = end($data);
					//$_nico_settings['settings'][$selector] = $data;
				}
			}			
			
			if (isset($_nico_settings['styles'])) foreach($_nico_settings['styles'] as $group => &$css_file)
			{
				if (is_array($css_file)) 
				{
					$css_file = end($css_file);
					//$_nico_settings['styles'][$group] = $css_file;
				}
			}			
			
			$_styles = '';
			if (isset($_nico_settings['styles'])) 
			{
				foreach($_nico_settings['styles'] as $group => $cssfile) 
				{
					//echo $cssfile;
					$_styles .= "\n\n/* " . $group . ' - ' . $cssfile . " */\n\n";
					$_styles .= file_get_contents(DIR_TEMPLATE . '/' . $theme_directory. '/styles/' . $cssfile);
				}
				
				$css = $_styles . $css;
			}
			
			if (isset($fonts) && !empty($fonts))
			{
				$fonts = array_unique($fonts);
				$font_names = implode( '|', $fonts);

				if (!empty($font_names))
				$css = '@import url(https://fonts.googleapis.com/css?family=' . $font_names . '&subset=' . CHARSET . ");\n\n" . $css;	
			}
			
			if (is_array($_nico_settings) && !empty($_nico_settings))
			{
				if ($opencart_version >= 2200) $_nico_settings= json_encode($_nico_settings); else $_nico_settings = serialize($_nico_settings);

				if ($sql_update)
				{
					
					$query = $db->query('UPDATE  ' . DB_PREFIX . 'setting SET value = \'' . $db->escape($_nico_settings) . '\' WHERE `key` = \''. $config_name  .'\'');
					$query = $db->query('UPDATE  ' . DB_PREFIX . 'setting SET value = \'' . $db->escape(html_entity_decode($css)) . '\' WHERE `key` = \''. $config_name  .'_css\'');
				} else
				{
					$query = $db->query('INSERT INTO  ' . DB_PREFIX . 'setting (`'. $group_code .'`,`key`,`value`) VALUES (\'config\', \''.$config_name. '\', \'' . $db->escape($_nico_settings) . '\') ON DUPLICATE KEY UPDATE `value`=VALUES(`value`)');
					$query = $db->query('INSERT INTO  ' . DB_PREFIX . 'setting (`'. $group_code .'`,`key`,`value`) VALUES (\'config\', \''.$config_name.'_css\', \'' . $db->escape(html_entity_decode($css)) . '\') ON DUPLICATE KEY UPDATE `value`=VALUES(`value`)');
				}
			}
			
			file_put_contents(dirname(__FILE__) . '/../css/' . $settings_css_file_name, html_entity_decode($css));
			//file_put_contents(dirname(__FILE__) . '/' . $settings_file_name, 
			//'<?php $_nico_settings  = ' . var_export($_nico_settings, true) . ';');


			//clear css
			$files = glob(DIR_TEMPLATE . '/*/css/_nico*.css');

			if ($files) {
				foreach ($files as $file) {
					if (file_exists($file)) {
						unlink($file);
					}
				}
			}

			//clear speed cache
			$files = glob(DIR_CACHE . 'nico_speed_cache_*');

			if ($files) {
				foreach ($files as $file) {
					if (file_exists($file)) {
						unlink($file);
					}
				}
			}
			
			
			die('saved');
			
		} else if (isset($_POST['_nico_reset_theme']))
		{
			$query = $db->query('UPDATE  ' . DB_PREFIX . 'setting SET value = \'\' WHERE `key` = \''. $config_name  .'\'');
			$query = $db->query('UPDATE  ' . DB_PREFIX . 'setting SET value = \'\' WHERE `key` = \''. $config_name  .'_css\'');

			file_put_contents(dirname(__FILE__) . '/../css/' . $settings_css_file_name, '');
			//file_put_contents($dirname. '/settings.inc', '');
			die('saved');
		}
	}
	
	include(DIR_TEMPLATE . '/' . $theme_directory. '/nico_config.inc');
	$editor_path = 'catalog/view/theme/' . $theme_directory . '/nico_theme_editor/';

//	$model_localisation_language = $registry->get('model_localisation_language');

//	$nico_languages = $model_localisation_language->getLanguages();
//	$nico_languages = array('en' => array('code' => 'en','image' => 'en.png'));
?>	
<link href='<?php echo $editor_path;?>jquery-ui-1.10.3.custom.min.css' rel='stylesheet' type='text/css'  property='stylesheet'>
<link href='<?php echo $editor_path;?>editor_panel.css' rel='stylesheet' type='text/css'  property='stylesheet'>

<script type="text/javascript" src="<?php echo $editor_path;?>jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="<?php echo $editor_path;?>colorpicker/jquery.colorpicker.js"></script>
<link rel="stylesheet" href="<?php echo $editor_path;?>colorpicker/jquery.colorpicker.css" type="text/css"  property='stylesheet'/>
<link rel="stylesheet" href="<?php echo $editor_path;?>themes/default/style.min.css" type="text/css"  property='stylesheet'/>
<script src="<?php echo $editor_path;?>jstree.js"></script>
<script>
var _nico_demo = <?php if (DEMO || !HAS_PERMISSION) echo 'true'; else echo 'false';?>;
var nico_theme_name = '<?php echo $theme_directory;?>';
var _editor_path = "<?php echo $editor_path;?>";
var opencart_version = <?php echo $opencart_version;?>;
var enable_effects_tab = <?php if (defined('GALLERY_EFFECTS') && GALLERY_EFFECTS == true) echo 'true'; else echo 'false';?>;
/*var lang = [<?php /*
	$first = true;
	foreach ($nico_languages as $lang)
	{
		if ($first) { $first = false;} else echo ',';
		echo '"' . $lang['code'] . '"';
	} */
?>];
var current_lang = '<?php /*echo $session->data['language'];*/?>';
var is_writable = <?php /*if (is_writable($dirname. '/settings.inc')) echo 'true'; else echo 'false';*/ ?>;
var is_writable_css = <?php /*if (is_writable($dirname. '/editor_settings.css')) echo 'true'; else echo 'false';*/ ?>;
*/
</script>
<script src="<?php echo $editor_path;?>editor.js"></script>

	<div id="nico_theme_editor">
		<a href="#" id="show_hide_editor" class="no_mobile"><i class="fa fa-gears"></i>&ensp;Customize theme</a>

		<a href="#" id="nico_save_settings" class="no_mobile"><i class="fa fa-floppy-o"></i>&ensp; Save settings</a>
		<div id="nico_zoom"  class="no_mobile">
			<a href="#" id="nico_zoom_bottomscreen" title="Bottom screen">Bottom screen</a>
			<a href="#" id="nico_zoom_halfscreen" title="Half screen">Half screen</a>
			<a href="#" id="nico_zoom_fullscreen" title="Full screen">Full screen</a>
		</div>
		
		<!-- a href="#" id="nico_reset" class="no_mobile">Reset to default theme settings</a -->

		<ul class="nico_tabs">
			<li>Styles</li>
			<?php if (defined('GALLERY_EFFECTS') && GALLERY_EFFECTS == true) {?><li class="selected">Gallery effects</li><?php }?>
			<li>Colors</li>
			<li>Fonts</li>
			<!--li>Sliders &amp; Gallery</li-->
			<li>Options</li>
			<!--li>Settings</li-->
			<!--li>Menu editor</li-->
			<!-- li>Slider text</li -->
			<li>Background</li>
			<li>Sample Data Import</li>
		 </ul>
		 
		
	 <div class="nico_tab">
		 <div>
			<?php 
			$current_group = '';
			$pattern_dir = DIR_TEMPLATE . '/' . $theme_directory . '/styles';
			if (is_dir($pattern_dir)) {
				if ($dh = opendir($pattern_dir)) 
				{
					while (($file = readdir($dh)) !== false) 
					{
						if ($file[0] != '.' && strrpos($file, '.css') != false) 
						{
							if (!preg_match('@([a-zA-Z_]+)-([a-zA-Z_]+)(-[\da-f]+)?\.css@', $file, $matches)) continue;
							
							$group = $matches[1];
							$group_title = ucfirst(str_replace('_', ' ', $matches[1]));
							$_name = str_replace('_', ' ', $matches[2]);
							$color = isset($matches[3])?str_replace('-', '',$matches[3]):'fafafa';
							$image = str_replace('.css', '.png', $file);
							$_nico_styles[$group][] = array('name' => $_name, 'image' => $image, 'file' => $file, 'color' => $color);
						}
					}
					closedir($dh);
					ksort($_nico_styles);
				 }	
				 
				 foreach($_nico_styles as $group => $_nico_styles)
				 {
							?>  <div style="display:inline-block;margin-right:10px;">
								<h2><span><?php echo ucfirst(str_replace('_', ' ',$group));?></span></h2>
								 <div class="style">
									 <div class="value <?php echo $group;?>" data-file="" data-group="<?php echo $group;?>" data-css="" style=""></div>
									 <div class="name">Default style</div>
								</div>
					<?php foreach ($_nico_styles as $style) 
					{?>
					 <div class="style">
						 <div style="background:#<?php echo $style['color'];?>" class="value <?php echo $group;if (isset($_nico_settings['styles'][$group]) && $style['file'] == $_nico_settings['styles'][$group]) echo ' selected';?>" data-group="<?php echo $group;?>" data-file="<?php echo $style['file'];?>" data-css="<?php echo $editor_path . '../styles/' . $style['file'];?>" <?php /* ?>style="background-image:url('<?php echo $editor_path . 'styles/' . $style['image']?>');" <?php */?>></div>
						 <div class="name"><?php echo ucfirst($style['name']);?></div>
					</div>
					<?php } ?></div><?php } }?>			 
			</div>
		 </div>				 
			
		 <div class="nico_tab">
			 <div>
<?php foreach ($nico_colors as $_name => $options) {
			if (is_array($options))
			{?>			 
			 <div class="color">
				 <div class="value" data-selector="<?php echo $options[0];?>" data-attribute="<?php echo $options[1];?>" data-default="<?php if (isset($_nico_settings['colors'][$options[0]][$options[1]])) echo $_nico_settings['colors'][$options[0]][$options[1]];?>"></div>
				 <div class="name"><?php echo $_name;?></div>
			 </div>
<?php } else { ?><h2><span><?php echo $options;?></span></h2><?php } }?> 
			</div>
		 </div>
		 <div class="nico_tab">
			<div>
<?php foreach ($nico_fonts as $_name => $option) {			
			if (!empty($option))
			{?>			 
			 <div class="font">
				 <div class="name"><?php echo $_name;?></div>
				 <div class="value">
					 <select class="form-control _font_select" data-selector="<?php echo $option;?>" data-default="<?php if (isset($_nico_settings['fonts'][$option]['font-family'])) echo $_nico_settings['fonts'][$option]['font-family'];?>">
					 </select>
					 <select class="form-control  _font_select_size" data-selector="<?php echo $option;?>" data-default="<?php if (isset($_nico_settings['fonts'][$option]['size'])) echo $_nico_settings['fonts'][$option]['size'];?>">
					 </select>
				 </div>
			 </div>
<?php } else { ?><h2><span><?php echo $_name;?></span></h2><?php } }?> 
			</div>
		 </div>
		 

		 <div class="nico_tab">
			<div>
<?php foreach ($nico_options as $_name => $options) {
				if (is_array($options))
			{?>			 
			<div class="option">
				 <div class="name"><?php echo $_name;?></div>
				<select class="form-control  value" data-selector="<?php echo $options[0];?>" data-attribute="<?php echo $options[1];?>" name="<?php echo $options[1];?>"><?php 
					foreach ($options[2] as $title => $value) {?><option value="<?php echo $value;?>"<?php if (isset($_nico_settings['options'][$options[0]][$options[1]]) 
							&& $_nico_settings['options'][$options[0]][$options[1]] == $value) echo ' selected="selected"';?>><?php echo $title;?></option><?php }?>			 			 						
				</select>
			</div>
<?php } else { ?><h2><span><?php echo $options;?></span></h2><?php } }?> 
		 </div>
	</div>
		
		 <div class="nico_tab">
			 <div>
			 <div>
				 <div class="name">Background style</div>
				 <div class="value">
					<select name="form-control background-style" id="background-style">
						<option value="repeat">Repeat</option>
						<option value="repeat-x">Repeat horizontally only</option>
						<option value="repeat-y">Repeat vertically only</option>
						<option value="stretch">Stretch</option>
						<option value="no-repeat">No repeat</option>
					</select>
				 </div>
			</div>


			 <div class="pattern">
				 <div class="name">Disable background pattern</div>
				 <div class="value" data-file="disable" style=""></div>
			</div>
			<?php 
			$pattern_dir = DIR_TEMPLATE . '/' . $theme_directory . '/nico_theme_editor/patterns';
			if (is_dir($pattern_dir)) {
				if ($dh = opendir($pattern_dir)) 
				{
					while (($file = readdir($dh)) !== false) 
					{
						$_name = str_replace(array('_', '-', '.png'), ' ', $file);
						if ($file[0] != '.') {
			?>
			 <div class="pattern">
				 <div class="name"><?php echo ucfirst($_name);?></div>
				 <div class="value" data-file="<?php echo $file;?>" style="background-image:url('<?php echo $editor_path . 'patterns/' . $file?>');"></div>
			</div>
<?php } } }  closedir($dh); }?>		
			<div>&nbsp;&nbsp;Note: To add custom background image just upload the png images to the <i>nico_theme_editor/patterns</i> folder and they will be available here.</div>
			Patterns from <a href="http://subtlepatterns.com/">subtlepatterns.com</a>
			</div>
		 </div>	
		 
	 	 <div class="nico_tab nico_import_tab">
			 <!-- div class="col-md-2">
			 <label>Data to import</label>
			 <div>
				 <label>Images</label> <input type="checkbox" name="import[images]" value="images" checked="true">
				 <label>Modules</label> <input type="checkbox" name="import[modules]" value="modules"  checked="true">
			 </div>
			 </div -->

		 		 <p style="color:red;font-style:italic;text-align:center;line-height:20px;padding:0px">
					 The import tool overwrites your store settings such as product images and module configuration, please make backups before using and preferably use on a new opencart installation
				 </p>
			 
			<div class="row">
			 <div class="col-md-3">
				 <div class="name">Choose store to import</div>
				 <select class="form-control value" name="store">
					 <?php foreach($nico_import_stores as $url => $desc) {?>
					 <option value="<?php echo $url;?>"><?php echo $desc;?></option>
					 <?php } ?> 
				</select>
			</div>
			 

			 <div class="col-md-7">
				 <div class="name">Purchase key &nbsp;<a href="http://moda.nicolette.ro/docs/img/purchase_code.png"  target="_blank" style="color:#333;text-decoration: underline;">Where do I find my purchase key?</a></div>
				<input type="text" name="purchase_key" class="value form-control" placeholder="abcd1234-ab12-ab12-ab12-abcdef123456" size="70" style="border:1px solid #ccc;">
			</div>
			 
			  <div class="col-md-2">
				 <button id="nico-import" class="btn btn-default btn-primary" onclick="nico_import_start();"><i class="fa fa-download"></i>&ensp; Import</button>
			</div>
			</div>

			<div class="row" style="padding:0px;">


				<div class="col-md-3">
					<div class="list-group-item"><input type="checkbox" name="module_configuration" checked="true"> <label title="Includes modules configuration and module layout position">Modules configuration</label></div>
					<div class="list-group-item"><input type="checkbox" name="download_images" checked="true"> <label title="Images used in the modules like banners or slide images and product images">Download images</label></div>
					<div class="list-group-item"><input type="checkbox" name="speed_cache" checked="true"> <label title="Install speed cache module to speed up page opencart page rendering">Speed cache</label></div>
				</div>


				<div class="col-md-3">
					<div class="list-group-item"><input type="checkbox" name="product_images" checked="true"> <label title="Uncheck this option to keep your product images intact, useful if you already added product images and don't want to overwrite them (option works only if download images is also enabled)">Set product images</label></div>
					<div class="list-group-item"><input type="checkbox" name="product_images_additional" checked="true"> <label title="Uncheck this option to keep your product images intact, useful if you already added product images and don't want to overwrite them (option works only if download images is also enabled)">Product additional images</label></div>
					<div class="list-group-item"><input type="checkbox" name="store_configuration" checked="true"> <label title="Includes configuration like image size">Image sizes config</label></div>
					<div class="list-group-item"><input type="checkbox" name="ocmods" checked="true"> <label title="Automatically install theme ocmods to add extended functionality">Ocmods</label></div>
						<!-- a href="#" class="list-group-item"><input type="checkbox" name="logo"> <label title="Overwrites store logo with theme logo"	>Logo</label></a -->
				</div>
				
				<div class="col-md-6" style="line-height:20px;">
					<?php
					$css_dir = DIR_TEMPLATE . '/'. $theme_directory . '/css/';
					$js_dir = DIR_TEMPLATE . '/'. $theme_directory . '/js/';
					$index_php_file = DIR_APPLICATION . '/../index.php';
					$index_php = file_get_contents($index_php_file);
					$php_version = (int)str_replace('.', '',substr(PHP_VERSION, 0, 5));
					if ($php_version < 530) '<b>PHP ' . $php_version . ' is too old, please upgrade to at least PHP 5.3.0+</b><br/>';

					if (!is_writable($css_dir))
					{
						if (!@chmod($css_dir, 0777)) echo '<b>Css folder write permission failed</b> to enable css concatenation set write permission (0777) for ' .  $theme_directory . '/css/<br/>';
					} else
					{
						echo '<b>css folder writable - OK</b><br/>';
					}

					if (!is_writable($js_dir))
					{
						if (!@chmod($js_dir, 0777)) echo '<b>Js folder write permission failed</b> to enable js concatenation set write permission (0777) for ' .  $theme_directory . '/js/<br/>';
					} else
					{
						echo '<b>js folder writable - OK</b><br/>';
					}

					if (!is_writable($index_php_file))
					{
						if (!@chmod($index_php_file, 0777)) echo '<b>Notice: index.php write permission failed</b>, speed cache can\'t be automatically installed, you need to set write permission for  ' . $index_php_file . '<br/>';
					} else
					{
						echo '<b>index.php writable - OK</b><br/>';
					}

					if ($index_php)
					{
						if (strpos($index_php, 'nico_speed_cache.inc') !== false)
						{
							echo '<b>Speed cache already installed</b><br/>';
						}/* else
						{
							echo '<b>Speed cache not currently installed</b><br/>';
						}*/
					}
					?>
				</div>
			</div>

			 </div>
	

	</div>
</div>


<div class="modal fade" id="import_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Import data</h4>
      </div>
      <div class="modal-body" style="max-height:500px;overflow-y:scroll;">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<div class="nico_status">
	<?php if (DEMO) {?>Saving is disabled in the DEMO version!<?php } else {?>Saving ... <?php }?>
</div>
<?php
}
