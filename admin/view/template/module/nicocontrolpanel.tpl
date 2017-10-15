<?php 
global $module_name,  $autocomplete_products, $module_row, $module_name, $module_config, $config_size, $section_config, $section_text, $_modules, $nico_theme_positions, $_clear_speed_cache, $_clear_opencart_cache;
$_modules = $modules;
if (isset($clear_speed_cache)) $_clear_speed_cache = $clear_speed_cache; else $_clear_speed_cache = NULL;
if (isset($clear_opencart_cache)) $_clear_opencart_cache = $clear_opencart_cache; else $_clear_opencart_cache = NULL;
$module_name = 'nicocontrolpanel';
$section_text = 'slide';
$no_module_layout = true;

$directory = DIR_CATALOG . '/view/theme/';
$themes = array_diff(scandir($directory), array('..', '.','default'));
$theme_config = '';

$theme_directory = current($themes);
while (!empty($theme_directory)  && !(
		file_exists($theme_config = $directory . $theme_directory . '/panel_config.inc') ||
		file_exists($theme_config = $directory . $theme_directory . '/nico_theme_editor/panel_config.inc')
))
{
	$theme_directory = next($themes);
}


if (empty($theme_config) || !file_exists($theme_config))
{
	echo $header;
	die('<h2 style="text-align:center;padding:30px;">Theme not installed!</h2>' . $footer);
}


include($theme_config);

if ($opencart_version >= 2010) 
{
	require('nicomodule2.tpl');
} else
if ($opencart_version >= 2000) 
{
	require('nicomodule2.tpl');
} else
{
	require('nicomodule.tpl');
}

function _nico_is_speed_cache()
{
//	return true;
		$index_php = file_get_contents(DIR_APPLICATION . '/../index.php');
		return (!empty($index_php) && strpos($index_php, 'nico_speed_cache.inc') !== false);
}
function speed_cache($module)
{
	global $theme_name, $_clear_speed_cache, $_clear_opencart_cache;
	if (($_clear_speed_cache && $_clear_speed_cache == 'clear') || ($_clear_opencart_cache && $_clear_opencart_cache == 'clear'))
	{?>
	    <div class="alert alert-information bg-success"><i class="fa fa-exclamation-circle"></i> 
			Cache cleared
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>

		<script>
			jQuery(document).ready(function() 
			{ 
				jQuery(".tab-7-section").click();
			});
		</script>
	<?php }
	if (!_nico_is_speed_cache()) 
	{
		?>
		
		<h3 style="color:red">Speed cache not installed</h3>
		<h4>To install it set write permission for opencart's index.php and use <a target="_blank" href="http://<?php echo $theme_name;?>.nicolette.ro/docs/index.html#sample">import tool</a> with only <i>speed cache option</i> checked then set back read only permission for index.php</h4>
		
		<?php
		return;
	}
	?>
	<h4 style="color:green">Speed cache installed</h4><br/>
	<a href="?route=module/nicocontrolpanel/clear_speed_cache&token=<?php echo $_GET['token'];?>#tab-section-1-7" class="btn btn-primary button" name="clear_speed_cache" value="clear_speed_cache">Clear speed cache</a>
	<a href="?route=module/nicocontrolpanel/clear_opencart_cache&token=<?php echo $_GET['token'];?>#tab-section-1-7" class="btn btn-default button" name="clear_speed_cache" value="clear_speed_cache">Clear opencart cache</a>
	<?php
}

function permission_check($module)
{
	?>
	<div style="line-height:24px;" class="well">
		<div role="alert" class="alert">
			<h4>
				<span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-info fa-stack-1x fa-inverse"></i></span> 
				File permission info
			</h4>
		<hr style="border-color:#ccc">
<?php		
	global $theme_name, $_clear_speed_cache, $_clear_opencart_cache;

	$directory = DIR_CATALOG . '/view/theme/';
	$themes = array_diff(scandir($directory), array('..', '.','default'));
	
	foreach($themes as $theme_directory)
	{
	
	if (!file_exists($directory . $theme_directory . '/panel_config.inc')) continue;
	
	$css_dir = $directory . '/'. $theme_directory . '/css/';
	$js_dir = $directory . '/'. $theme_directory . '/js/';
	//$index_php_file = DIR_APPLICATION . '/../index.php';
	//$index_php = file_get_contents($index_php_file);
	$php_version = (int)str_replace('.', '',substr(PHP_VERSION, 0, 5));
	if ($php_version < 530) '<b>PHP ' . $php_version . ' is too old, please upgrade to at least PHP 5.3.0+</b><br/>';

	if (!is_writable($css_dir . '/editor_settings.css'))
	{
		if (!@chmod($css_dir . '/editor_settings.css', 0777)) echo '<b>Panel settings permission <span style="color:red">failed</span></b> to enable panel settings saving set write permission (0777) for <b>' .  $css_dir . '/css/editor_settings.css</b><br/>';
	} else
	{
		echo ucfirst($theme_directory) . ' <b>Panel settings writable - OK</b><br/>';
	}

	if (!is_writable($css_dir))
	{
		if (!@chmod($css_dir, 0777)) echo '<b>CSS folder write permission <span style="color:red">failed</span></b> to enable css concatenation set write permission (0777) for <b>' .  $css_dir . '/css/</b><br/>';
	} else
	{
		echo ucfirst($theme_directory) . ' <b>CSS folder writable - OK</b><br/>';
	}

	if (!is_writable($js_dir))
	{
		if (!@chmod($js_dir, 0777)) echo '<b>JS folder write permission <span style="color:red">failed</span></b> to enable js concatenation set write permission (0777) for <b>' .  $js_dir . '/js/</b><br/>';
	} else
	{
		echo ucfirst($theme_directory) . ' <b>JS folder writable - OK</b><br/>';
	}
	}
	?>
	</div>
</div>
	<?php
}
