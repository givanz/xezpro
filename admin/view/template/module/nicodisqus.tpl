<?php 
global $module_name,  $autocomplete_products, $module_row, $module_name, $module_config, $config_size, $section_config, $section_text, $font_awesome_icons, $nico_theme_positions, $opencart_version;

$module_name = 'nicodisqus';
$section_text = 'section';


$module_config = array(
	'shortname'=>array('input',null,'Forum Shortname <br/><span class="help">(copy from disqus account)</span>', '', 20),
	'url'=>array('input',null,'Url <br/><span class="help">(leave empty to use the automatic page url, recommended)</span>', '', 20),
	'identifier'=>array('input',null,'Identifier <br/><span class="help">(leave empty to use automatic page identifier, recommended)</span>', '', 20),
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
