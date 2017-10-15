<?php 
global $module_name,  $autocomplete_products, $module_row, $module_name, $module_config, $config_size, $section_config, $section_text, $font_awesome_icons, $nico_theme_positions, $opencart_version;

$module_name = 'nicocameraslider';
$section_text = 'slide';

$module_config = array(
/*	'color'=>array('select', 
					array('0' => 'Black',
						  '1' => 'White'),
					'Color style'
				),
*/
	'resize_method'=>array('select', 
					array('default' => 'Opencart default',
						  'cropresize' => 'Crop and resize',
						  ),
					'Image resize method'
				),

	'image_width'=>array('input',null,'Image width', 1027),
	'image_height'=>array('input',null,'Image Height', 768),
	
	'autoplay'=>array('select', 
					array('false' => 'No',
						  'true' => 'Yes'),
					'Autoplay'
				),
	
	'height_style'=>array('select', 
					array('0' => 'Proportional',
						  '1' => 'Fixed'),
					'Height style'
				),
				
	'autoplay_interval'=>array('input',null,'Autoplay interval <span class="help">(miliseconds)</span>', 5000),

	'hide_on_mobile'=>array('select', 
					array('false' => 'No',
						  'true' => 'Yes'),
					'Hide on mobile'
				),

	'Slides' => array('section'),
);

$section_config = array(
    'order'=>array('input',null,'Sort order', '0', 20),
	'url'=>array('input',null,'Url', '', 50),
	'image'=>array('image',null, 'Slide image'),
);				

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
