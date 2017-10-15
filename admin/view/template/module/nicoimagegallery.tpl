<?php 
global $module_name,  $autocomplete_products, $module_row, $module_name, $module_config, $config_size, $section_config, $section_text, $font_awesome_icons, $nico_theme_positions, $opencart_version;

$module_name = 'nicoimagegallery';
$section_text = 'image';


$module_config = array(
/*	'color'=>array('select', 
					array('0' => 'Black',
						  '1' => 'White'),
					'Color style'
				),
*/
	'module_cols_xs'=>array('select', 
				array('12' => '1',
					  '6' => '2',
					  '4' => '3',
					  '3' => '4',
					  '2' => '6',
					  '1' => '12',
					  ),
				'Products per row<span class="help">(extra small devices, phones)</span>', 12
			),
			
	'module_cols_sm'=>array('select', 
				array('12' => '1',
					  '6' => '2',
					  '4' => '3',
					  '3' => '4',
					  '2' => '6',
					  '1' => '12',
					  ),
				'Products per row<span class="help">(small devices, tablets)</span>', 12
			),			

	'module_cols_md'=>array('select', 
				array('12' => '1',
					  '6' => '2',
					  '4' => '3',
					  '3' => '4',
					  '2' => '6',
					  '1' => '12',
					  ),
				'Products per row<span class="help">(medium devices, desktops)</span>', 3
			),			

	'module_cols_lg'=>array('select', 
				array('12' => '1',
					  '6' => '2',
					  '4' => '3',
					  '3' => '4',
					  '2' => '6',
					  '1' => '12',
					  ),
				'Products per row<span class="help">(large devices, desktops)</span>', 3
			),			

	'resize_method'=>array('select', 
					array('default' => 'Opencart default',
						  'cropresize' => 'Crop and resize',
						  ),
					'Image resize method'
				),

	'thumb_image_width'=>array('input',null,'Thumb image width', 100),
	'thumb_image_height'=>array('input',null,'Thumb image Height', 100),

	'image_width'=>array('input',null,'Image width', 1027),
	'image_height'=>array('input',null,'Image Height', 768),
	
	'hide_on_mobile'=>array('select', 
					array('false' => 'No',
						  'true' => 'Yes'),
					'Hide on mobile'
				),

	'Slides' => array('section'),
);

$section_config = array(
    'order'=>array('input',null,'Sort order', '0', 20),
	'image'=>array('image',null, 'Slide image'),
	'url'=>array('input',null,'Url', '', 50),
	'title'=>array('multilanguage',null, 'Title'),
	'description'=>array('multilanguage_html',null,'Description', '', 20),
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
