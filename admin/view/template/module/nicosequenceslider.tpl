<?php 
global $module_name,  $autocomplete_products, $module_row, $module_name, $module_config, $config_size, $section_config, $section_text, $font_awesome_icons, $nico_theme_positions, $opencart_version;

$module_name = 'nicosequenceslider';
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

	'background_image_width'=>array('input',null,'Background Image width', 1027),
	'background_image_height'=>array('input',null,'Background Image Height', 768),

	'image_width'=>array('input',null,'Image width', 1027),
	'image_height'=>array('input',null,'Image Height', 768),
	
	'height_style'=>array('select', 
					array('0' => 'Fixed',
						  '1' => 'Proportional'),
					'Height style'
				),

	'autoplay'=>array('select', 
					array('false' => 'No',
						  'true' => 'Yes'),
					'Autoplay'
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
	'text_align'=>array('select', 
					array('left' => 'Left',
						  'right' => 'Right',
						  'center' => 'Center'),
					'Text align'
				),
	'image_slide'=>array('select', 
					array(
						  'right' => 'From right',
						  'left' => 'From left',
						  'top' => 'From top',
						  'bottom' => 'From bottom'
						  ),
					'Image slide'
				),
	'title'=>array('multilanguage',null,'Title', '', 20),
	'subtitle'=>array('multilanguage',null,'Subtitle', '', 20),
	'button'=>array('multilanguage',null,'Button text', '', 20),
	'url'=>array('input',null,'Url', '', 50),
	'text'=>array('multilanguage_html',null,'Text', '', 20),
	'image'=>array('image',null, 'Slide image'),


	'section_type'=>array('select', 
					array('' => 'none',
						  'image' => 'Image',
						  'youtube' => 'Youtube',
						  'vimeo' => 'Vimeo',
						  ),
					'Background type'
				),

	'image_section'=>array('section_type'),
	'background'=>array('image',null, 'Background'),

	'youtube_section'=>array('section_type'),
	'youtube_id'=>array('input',null,'Youtube video id', '', 20),

	'vimeo_section'=>array('section_type'),
	'vimeo_id'=>array('input',null,'Vimeo video id', '', 20),
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
