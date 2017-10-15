<?php 
global $module_name,  $autocomplete_products, $module_row, $module_name, $module_config, $config_size, $section_config, $section_text, $font_awesome_icons, $nico_theme_positions, $opencart_version;
if (isset($products)) $autocomplete_products = $products;

$module_name = 'nicoproducttabs';
$section_text = 'product tab';

$module_config = array(
	'section' => array('section'),
);

$section_config = array(
	'title'=>array('multilanguage',null,'Tab name'),

	'content_type'=>array('select', 
					array(
						   'text' => 'Text',
						   'module' => 'Module (render another module inside)',
						  ),
					'Content Type'
				),


	'_module'=>array('module',$extensions,'Module instance', '0', 20, 'type_module_content'),				

	'youtube'=>array('input',null,'Youtube video id', '0', 20, 'type_youtube_content'),
	'vimeo'=>array('input',null,'Vimeo video id', '0', 20, 'type_vimeo_content'),

	'text'=>array('multilanguage_html',null,'Tab content', '0', 20, 'type_text_content type_html_content'),
/*
	'section_type'=>array('select', 
					array(
						  'global' => 'All products',
						  'autocomplete' => 'Some products',
						  'category' => 'For a certain category',
						  'manufacturer' => 'For a certain manufacturer',
						  ),
					'Show for'
				),

	'global_section'=>array('section_type'),
	'autocomplete_section'=>array('section_type'),
	'product_list'=>array('autocomplete',null,'Products'),


	'category_section'=>array('section_type'),
	'category'=>array('select', $categories,
			'Category'
		),

	'manufacturer_section'=>array('section_type'),
	'manufacturer'=>array('select', $manufacturers,
			'Manufacturer'
		),*/
);				

if ($opencart_version >= 2010) 
{?>
	<style>
	.type_module_content, .type_text_content, .type_html_content
{
		display:none;	
	}
		
	.type_module .type_module_content, .type_text .type_text_content, .type_html .type_html_content
	{
		display:block;
	}	
	</style>
<?php
	require('nicomodule2010.tpl');
} else
if ($opencart_version >= 2000) 
{
	require('nicomodule2.tpl');
} else
{?>
	<style>
	.type_module_content, .type_text_content, .type_html_content
{
		display:none;	
	}
		
	.type_module .type_module_content, .type_text .type_text_content, .type_html .type_html_content
	{
		display:table-row;
	}	
	</style>
<?php
	require('nicomodule.tpl');
}
