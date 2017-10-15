<?php 
global $module_name,  $autocomplete_Articles, $module_row, $module_name, $module_config, $config_size, $section_config, $section_text, $font_awesome_icons, $nico_theme_positions, $opencart_version;

$module_name = 'nicobloglatest';
$section_text = 'slide';


$module_config = array(
	'title' => array('multilanguage',null,'Module title'),
	'limit' => array('input',null,'Limit', 4),
	'width' => array('input',null,'Image width', 300),
	'height' => array('input',null,'Image height', 150),

	'resize_method'=>array('select', 
					array('default' => 'Opencart default',
						  'cropresize' => 'Crop and resize',
						  ),
					'Image resize method'
				),

	'cols_xs'=>array('select', 
				array('12' => '1',
					  '6' => '2',
					  '4' => '3',
					  '3' => '4',
					  '2' => '6',
					  '1' => '12',
					  ),
				'Articles per row<span class="help">(extra small devices, phones)</span>', 12
			),
			
	'cols_sm'=>array('select', 
				array('12' => '1',
					  '6' => '2',
					  '4' => '3',
					  '3' => '4',
					  '2' => '6',
					  '1' => '12',
					  ),
				'Articles per row<span class="help">(small devices, tablets)</span>', 12
			),			

	'cols_md'=>array('select', 
				array('12' => '1',
					  '6' => '2',
					  '4' => '3',
					  '3' => '4',
					  '2' => '6',
					  '1' => '12',
					  ),
				'Articles per row<span class="help">(medium devices, desktops)</span>', 3
			),			

	'cols_lg'=>array('select', 
				array('12' => '1',
					  '6' => '2',
					  '4' => '3',
					  '3' => '4',
					  '2' => '6',
					  '1' => '12',
					  ),
				'Articles per row<span class="help">(large devices, desktops)</span>', 3
			),			
);

//check installed blog module

$blog_module = array();
$blog_route = '';

//check pavblog
if (file_exists(dirname($_SERVER['SCRIPT_FILENAME']) . '/../catalog/controller/pavblog'))
{
	$blog_module['pavblog'] = 'Pav Blog';
	$blog_route = '<br/><a target="_blank" href="index.php?route=module/pavblog&token=' . $_GET['token']. '"> Edit Pav Blog content</a>';
}

//check easy blog
if (file_exists(dirname($_SERVER['SCRIPT_FILENAME']) . '/../catalog/controller/blog'))
{
	$blog_module['easyblog'] = 'Easy Blog';
	$blog_route .= '<br/><a target="_blank" href="index.php?route=blog/article&token=' . $_GET['token']. '"> Edit Easy Blog content</a>';
}

//check simple blog
if (file_exists(dirname($_SERVER['SCRIPT_FILENAME']) . '/../catalog/controller/simple_blog'))
{
	$blog_module['simpleblog'] = 'Simple Blog';
	$blog_route .= '<br/><a target="_blank" href="index.php?route=simple_blog/article&token=' . $_GET['token']. '"> Edit Simple Blog content</a>';
}

if ($blog_module)
{
	$module_config['blog'] = array('select', 
				$blog_module,
				 'Blog module to use, <span class="help">supported <a target="_blank" href="http://www.opencart.com/index.php?route=extension/extension/info&amp;extension_id=11287" rel="nofollow">pavblog (1.5.6)</a>,  <a target="_blank" href="http://www.opencart.com/index.php?route=extension/extension/info&amp;extension_id=18315&amp;filter_search=blog&amp;filter_license=0&amp;filter_download_id=37" rel="nofollow">simpleblog (1.5.6)</a>, <a target="_blank" href="http://www.opencart.com/index.php?route=extension/extension/info&amp;extension_id=21431&amp;path=8&amp;filter_license=0&amp;filter_download_id=39&amp;page=2" rel="nofollow">easy blog (2.0.x)</a></span><br/>' . $blog_route
			);	
	
} else
{
	$module_config['blog'] = array('',null,'<strong>No blog module installed</strong> You need to install one of the supported blog modules <ul><li><a target="_blank" href="http://www.opencart.com/index.php?route=extension/extension/info&extension_id=11287">pavblog (oc 1.5.6 only)</a></li><li><a target="_blank" href="http://www.opencart.com/index.php?route=extension/extension/info&extension_id=18315&filter_search=blog&filter_license=0&filter_download_id=37">simpleblog (oc 1.5.6 only)</a></li><li><a target="_blank" href="http://www.opencart.com/index.php?route=extension/extension/info&extension_id=21431&path=8&filter_license=0&filter_download_id=39&page=2">easy blog (2.0.x only)</a></li></ul>', 5);
}

if ($opencart_version >= 2010) 
{
	require('nicomodule2010.tpl');
} else
if ($opencart_version >= 2000) 
{
	require('nicomodule2.tpl');
} else
{
	require('nicomodule.tpl');
}
