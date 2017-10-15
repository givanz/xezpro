<?php 
global $module_name,  $autocomplete_products, $module_row, $module_name, $module_config, $config_size, $section_config, $section_text, $font_awesome_icons, $nico_theme_positions, $opencart_version;

$module_name = 'nicogooglemaps';
$section_text = 'Location';


$module_config = array(
	'width'=>array('input',null,'Width', '100%'),
	'height'=>array('input',null,'Height', '300px'),

	'lat'=>array('input',null,'Latitude <span class="help">(<a target="_blank" href="http://www.gps-coordinates.net/">get coordinates</a>)</span>', '0', 10),
	'long'=>array('input',null,'Longitude', '0', 10),
	'zoom'=>array('input',null,'Zoom', '5'),
	'key'=>array('input',null,'Google API Key', 'AIzaSyDY0kkJiTPVd2U7aTOAwhc9ySH6oHxOIYM'),

	'Locations' => array('section'),
);

$section_config = array(
	'lat'=>array('input',null,'Latitude <span class="help">(<a target="_blank" href="http://www.gps-coordinates.net/">get coordinates</a>)</span>', 0, 10),
	'long'=>array('input',null,'Longitude', 0, 10),
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
