<?php 
global $module_name,  $autocomplete_products, $module_row, $module_name, $module_config, $config_size, $section_config, $section_text, $font_awesome_icons, $nico_theme_positions, $opencart_version;

$module_name = 'nicologin';
$section_text = 'slide';


$module_config = array(
	'align'=>array('select', 
					array('left' => 'Left',
						  'right' => 'Right'
						  ),
					'Login button align'
				),

	'hide_on_mobile'=>array('select', 
					array('false' => 'No',
						  'true' => 'Yes'),
					'Hide on mobile'
				),

	'dropdown'=>array('select', 
					array('false' => 'On Hover',
						  'true' => 'On Dropdown (click)'),
					'Display dropdown'
				),

	'button_text'=>array('multilanguage',null,'Button text', 'Login', 20),
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
