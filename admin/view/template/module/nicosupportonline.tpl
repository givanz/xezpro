<?php 
global $module_name,  $autocomplete_products, $module_row, $module_name, $module_config, $config_size, $section_config, $section_text, $font_awesome_icons, $nico_theme_positions, $opencart_version;

$module_name = 'nicosupportonline';
$section_text = 'person';


$module_config = array(
	'title'=>array('multilanguage',null,'Online support', '', 20),
	'text'=>array('multilanguage_html',null,'Text', '', 20),
	'image_width'=>array('input',null,'Image width', 32),
	'image_height'=>array('input',null,'Image Height', 32),
	'avatar_style'=>array('select', 
					array(
						'' => 'Square',
						'img-rounded' => 'Rounded',
						'img-thumbnail' => 'Thumbnail',
						'img-circle' => 'Circle'),
					'Avatar style'
					),	

	'resize_method'=>array('select', 
					array('default' => 'Opencart default',
						  'cropresize' => 'Crop and resize',
						  ),
					'Image resize method'
				),
	'hide_on_mobile'=>array('select', 
					array('false' => 'No',
						  'true' => 'Yes'),
					'Hide on mobile'
				),
	'list_style'=>array('select', 
					array('panel-default' => 'Border',
						  '' => 'No border'),
					'List style'
				),
	'display'=>array('select', 
					array('block' => 'Vertical',
						  'inline-block' => 'Horizontal'),
					'List display'
				),
	'Persons' => array('section'),
);

$section_config = array(
	'status'=>array('select', 
					array('1' => 'Enabled',
						  '0' => 'Disabled'),
					'Status'
				),
				
	'image'=>array('image',null, 'Avatar image'),

	'position'=>array('multilanguage',null,'Position <br/><span class="help">(tech support, marketing etc)</span>', 'Customer support', 20),

	'name'=>array('input',null,'Name', 'John Doe', 20),
	'phone'=>array('input',null,'Phone number <br/><span class="help">(optional)</span>', '', 20),
	'email'=>array('input',null,'Email <br/><span class="help">(optional)</span>', '', 20),
	'skype'=>array('input',null,'Skype <br/><span class="help">(optional)</span>', '', 20),

	'skype_type'=>array('select', 
					array(
						'call' => 'Call',
						'chat' => 'Chat',
						'dropdown' => 'Call and chat'),
					'Skype button type <br/><img src="https://secure.skypeassets.com/apollo/2.0.658/images/components/contactme-button/callbutton_24px.png">'
					),
					
	'skype_color'=>array('select', 
					array(
						'blue' => 'Blue',
						'white' => 'White'),
					'Skype button color'
					),
					
	'skype_size'=>array('select', 
					array(
						'10' => '10',
						'12' => '12',
						'14' => '14',
						'16' => '16',
						'24' => '24',
						'32' => '32'),
					'Skype button size'
					),
					

	'yahoo'=>array('input',null,'Yahoo <br/><span class="help">(optional)</span>', '', 20),
	
	'yahoo_thumb'=>array('select', 
					array('1' => '',
						'0' => 'No',
						'1' => 'Yes'),
					'Yahoo thumb type <br/><span class="help">(change to view each image)</span><br/><img src="http://opi.yahoo.com/online?u=online&t=1" id="yahoo_thumb_img">'
					),
						
);

$yahoo_thumb = array();
for ($i = 1;$i<25;$i++)
{
 $yahoo_thumb[$i] = 'Type ' . $i;
}

$section_config['yahoo_thumb'][1] = $yahoo_thumb;


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
}?>
<script>
jQuery(".yahoo_thumb").change(function()
{
	var user = jQuery("#1yahoo").val();
	if (user == "") user = "yahoo";
	jQuery("#yahoo_thumb_img").attr("src","http://opi.yahoo.com/online?u=" + user + "&t=" + this.value);
});
jQuery(".show_cover").change();
</script>

