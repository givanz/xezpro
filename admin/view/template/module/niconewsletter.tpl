<?php 
global $module_name,  $autocomplete_products, $module_row, $module_name, $module_config, $config_size, $section_config, $section_text, $font_awesome_icons, $nico_theme_positions, $opencart_version;

$module_name = 'niconewsletter';
$section_text = 'slide';


$module_config = array(
	'type'=>array('select', 
					array(
						  '1' => 'Opencart default',
						  '2' => 'Mailchimp'),
					'Type'
				),

/*	'app'=>array('input',null,'Mailchimp app', 1),
	'list_id'=>array('input',null,'Mailchimp list id', 1),*/
	'mailchimp_key'=>array('input',null,'Mailchimp submit url<span class="help">(<a href="https://docs.shopify.com/manual/configuration/store-customization/communicating-with-customers/accounts-and-newsletters/get-a-mailchimp-form-action-url" target="_blank">how to get mailchimp url?</a>)</span>', '//myexampleapp.us5.list-manage.com/subscribe/post?u=key123456789&amp;id=123456', 100),

	'newsletter_text'=>array('multilanguage',null,'Newsletter text', 100),
	'subscribe_text'=>array('multilanguage',null,'Subscribe text', 100),
	'email_text'=>array('multilanguage',null,'Email text', 100),
	'additional_text'=>array('multilanguage_html',null,'Additional text', 100)
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
