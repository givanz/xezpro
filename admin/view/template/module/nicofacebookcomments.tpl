<?php 
global $module_name,  $autocomplete_products, $module_row, $module_name, $module_config, $config_size, $section_config, $section_text, $font_awesome_icons, $nico_theme_positions, $opencart_version;

$module_name = 'nicofacebookcomments';
$section_text = 'section';


$module_config = array(
	'colorscheme'=>array('select', 
					array('light' => 'Light',
						  'dark' => 'Dark'),
					'Color scheme'
				),
				
	'href'=>array('input',null,'Url <br/><span class="help">(leave empty to use the page url, recommended)</span>', '', 20),

	'mobile'=>array('select', 
					array('' => 'Autodetect',
						'0' => 'No',
						'1' => 'Yes'),
					'Mobile'
					),
						
	'order_by'=>array('select', 
					array('social' => 'Social',
						'reverse_time' => 'Newest',
						'time' => 'Oldest'),
					'Order by'
					),

	'numposts'=>array('input',null,'Number of comments', '10', 20),
	
	'width'=>array('input',null,'Width<br/><span class="help">(a pixel value or a percentage (such as 100%) for fluid width)</span>', '100%', 20),
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
