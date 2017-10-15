<?php 
global $module_name,  $autocomplete_products, $module_row, $module_name, $module_config, $config_size, $section_config, $section_text, $font_awesome_icons, $nico_theme_positions, $opencart_version;
$module_name = 'nicoparallax';
$section_text = 'slide';


$module_config = array(
	'resize_method'=>array('select', 
					array('0' => 'Opencart default',
						  '1' => 'Crop and resize',
						  '2' => 'Width',
						  '3' => 'Height',
						  ),
					'Background image resize method'
				),
	'image_width'=>array('input',null,'Image width', 1200),
	'image_height'=>array('input',null,'Image Height', 300),

	'background_image'=>array('image',null, 'Background image <span class="help help-block">(takes precendence over video)</span>'),
	'youtube_id'=>array('input',null,'Youtube id  <span class="help help-block">(for optional video background)</span>', ''),
	'vimeo_id'=>array('input',null,'Vimeo id <span class="help help-block">(for optional video background)</span>', ''),

	'title'=>array('multilanguage',null,'Title (optional)', '0', 20, ''),				

	'type'=>array('select', 
					array(
						   'text' => 'Text',
						   'module' => 'Module (render another module inside)',
						   'html' => 'Custom HTML',
						  ),
					'Content Type'
				),
	'container'=>array('select', 
					array(
						   true => 'True (default)',
						   false => 'False'
						  ),
					'Inside container'
				),
	
	'overlay_opacity'=>array('input',null,'Overlay opacity <span class="help help-block">(value between 0 for full transparent and 1 for opaque, recommended 0.3)</span>', '0.3'),
	'overlay_color'=>array('colorpicker',null, 'Overlay color','#333',15),

	'_module'=>array('module',$extensions,'Module instance', '0', 20, 'type_module_content'),				
	
	'content'=>array('multilanguage_html',null,'Content', '0', 20, 'type_text_content type_html_content'),				

	'subtitle'=>array('multilanguage',null,'Subtitle', '0', 20, 'type_text_content'),				
	'button_text'=>array('multilanguage',null,'Button text', '0', 20, 'type_text_content'),				
	'url'=>array('input',null,'Url', '/index.php?route=product/category&path=20'),

	'text_color'=>array('select', 
					array('black' => 'Black',
						  'white' => 'White'
						  ),
					'Text color', 0, 20, 'cover_content'
				),
	'padding'=>array('input',null,'Padding (px)', 60),
	'margin'=>array('input',null,'Margin (px)', 0)
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
