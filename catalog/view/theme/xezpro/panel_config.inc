<?php

$custom_tabs = 
array(
	'General Options' => 
	array('General', 'Layout', 'Social band', 'Footer', 'Translations', 'Checkout', 'Custom css', 'Speed cache')/*,
	'Footer' => 
	array('Contact details', 'Follow us', 'Custom columns'),*/
);



$module_config = array( 
	1 => //general options
	array(
		0 => //general
		array(
		'permission_check' => array('custom', 'permission_check', 'File Permissions'),
		'text_direction'=>array('select', 
				array(
					  'auto' => 'Auto (read from language config)',
					  'ltr' => 'Left to right',
					  'rtl' => 'Right to Left'),
				'Text direction'
			),

		'container_width'=>array('select', 
				array('default' => 'Default (wide 1200px)',
					  'small' => 'Small (970px)'),
				'Container width'
			),
		'concatenate_css'=>array('select', 
				array('0' => 'No',
					  '1' => 'Yes'),
				'Concatenate css<span class="help help-block">for faster page loading<br/><b>css folder must be php writable</b></span>'
			),

		'concatenate_js'=>array('select', 
				array('0' => 'No',
					  '1' => 'Yes'),
				'Concatenate js<span class="help help-block">for faster page loading<br/><b>js folder must be php writable</b></span>'
			),
		'minify_css'=>array('select', 
				array('0' => 'No',
					  '1' => 'Yes'),
				'Minify css<span class="help help-block">makes css files smaller</span>'
			),

		'minify_js'=>array('select', 
				array('0' => 'No',
					  '1' => 'Yes'),
				'Minify js<span class="help help-block">makes js files smaller</span>'
			),
		'fonts'=>array('select', 
				array('0' => 'Google fonts',
					  '1' => 'Built in'),
				'Fonts'
			),

		
		'google_fonts' =>array('input',null,'Google fonts <span class="help help-block">separate font name by using |</b></span>', 'Montserrat:400,600,700|Open+Sans'),
		/*'fixed_header'=>array('select', 
				array('0' => 'No',
					  '1' => 'Yes'),
				'Fixed header'
			),*/
		'text_under_logo'=>array('multilanguage',null,'Text under logo', ''),
		'logo_first_word_length'=>array('input',null,'Logo first word length <span class="help">used to make first word have a different color</span>', ''),
		'position'=>array('hidden',	null, 'Position', 'hidden'),
		'layout_id'=>array('hidden',	null, 'Layout id', 'hidden'),
		),
		1 => //layout
		array(
		'category_page_products_row'=>array('select', 
					array('12' => '1',
					  '6' => '2',
					  '4' => '3',
					  '3' => '4',
					  '2' => '6',
					  '1' => '12',
					  ),
					'Category page products per row <span class="help">(large devices, desktops)</span>', 4
					),
					
		'category_page_products_row_md'=>array('select', 
				array('12' => '1',
					  '6' => '2',
					  '4' => '3',
					  '3' => '4',
					  '2' => '6',
					  '1' => '12',
					  ),
				'Category page products per row<span class="help">(medium devices, desktops)</span>', 3
			),			

		'category_page_products_row_sm'=>array('select', 
				array('12' => '1',
					  '6' => '2',
					  '4' => '3',
					  '3' => '4',
					  '2' => '6',
					  '1' => '12',
					  ),
				'Category page products per row<span class="help">(small devices, tablets)</span>', 12
			),			

		'category_page_products_row_xs'=>array('select', 
				array('12' => '1',
					  '6' => '2',
					  '4' => '3',
					  '3' => '4',
					  '2' => '6',
					  '1' => '12',
					  ),
				'Category page products per row<span class="help">(extra small devices, phones)</span>', 12
			),
			
	
		'product_page_image_cols'=>array('select', 
					array(
						  '1' => '1',
						  '2' => '2',
						  '3' => '3',
						  '4' => '4',
						  '5' => '5',
						  '6' => '6',
						  '7' => '7',
						  '8' => '8',
						  '9' => '9',
						  '10' => '10',
						  '11' => '11',
						  ),
					'Product page image column size', 5
					),

		'product_page_image_gallery'=>array('select', 
					array('zoom' => 'Cloud zoom',
					  'popup' => 'Popup',
					  ),
					'Product page image gallery', 3
					),

		'product_page_tabs_location'=>array('select', 
					array('0' => 'Under image gallery',
					  '1' => 'On image gallery left',
					  ),
					'Product page tabs location', 3
					),
		'show_main_image_thumb'=>array('select', 
					array('0' => 'Yes',
					  '1' => 'No',
					  ),
					'Show main image thumb <span class="help help-block">To allow going back to main image</span>'
					),
		'price_change_quantity'=>array('select', 
					array('0' => 'Yes',
					  '1' => 'No',
					  ),
					'Change product price on quantity change on product page</span>'
					),

		'sticky_header'=>array('select', 
					array('1' => 'Yes',
					  '0' => 'No',
					  ),
					'Sticky header on page scroll'
					),
		'sale_badge_text'=>array('input',null,'Sale badge text <span class="help help-block">leave empty to display percentage discount</span>', ''),

		'new_product_days_text'=>array('input',null,'New product badge text <span class="help help-block">Badge added to new products</span>', ''),
		'new_product_days'=>array('input',null,'New product days interval<span class="help help-block">how many days a product is considered new after is added</span>', ''),

		'most_viewed_text'=>array('input',null,'Most viewed badge text <span class="help help-block">Badge added to products that exceed a certain number of views</span>', ''),
		'most_viewed'=>array('input',null,'Most viewed products threshold<span class="help help-block">products with more viewes than this number will have the badge added</span>', ''),
		),		
		2 => //social band
		array(
			'about_heading'=>array('multilanguage',null,'About heading', ''),
			'about_text'=>array('multilanguage_html',null,'About text', ''),
			'twitter_profile_id'=>array('input',null,'Twitter id (<a target="_blank" href="http://themeforest.net/item/nico-fullscreen-responsive-opencart-theme/3554648/faqs/16899">how to get</a>)', ''),
			'twitter_count'=>array('input',null,'Tweet count', '2'),
			'twitter_url'=>array('input',null,'Twitter url', ''),
			'fb_profile_id'=>array('input',null,'Facebook id (<a target="_blank" href="http://findmyfacebookid.com/">get id</a>)', ''),
			'fb_width'=>array('input',null,'Facebook like box width', '300'),
			'fb_height'=>array('input',null,'Facebook like box height', '250'),
			'fb_small_header' =>array('select', 
				array('true' => 'Yes',
					  'false' => 'No'),
				'Use the small header instead'
			),
			'fb_hide_cover'=>array('select', 
				array('true' => 'Yes',
					  'false' => 'No'),
				'Hide cover photo in the header'
			),
			'fb_show_facepile'=>array('select', 
				array('true' => 'Yes',
					  'false' => 'No'),
				'Show profile photos when friends like this'
			),
			'fb_show_posts'=>array('select', 
				array('true' => 'Yes',
					  'false' => 'No'),
				'Show posts from the Page\'s timeline.'
			),
			'fb_hide_cta'=>array('select', 
				array('true' => 'Yes',
					  'false' => 'No'),
				'Hide the custom call to action button (if available)'
			),
		),		
		3 => //Footer
		array(
			'footer_about_heading'=>array('multilanguage',null,'About column heading', ''),
			'footer_about_text'=>array('multilanguage_html',null,'About column text', ''),
			'footer_column_text'=>array('multilanguage_html',null,'Footer right column content', ''),
			'wordpress_url'=>array('input',null,'Wordpress url', ''),
			'twitter_url'=>array('input',null,'Twitter url', ''),
			'pinterest_url'=>array('input',null,'Pinteres url', ''),
			'github_url'=>array('input',null,'Github url', ''),
			'rss_url'=>array('input',null,'Rss url', ''),
			'google_url'=>array('input',null,'Google url', ''),
			'instagram_url'=>array('input',null,'Instagram url', ''),
			'linkedin_url'=>array('input',null,'linkedin url', ''),
			'tumblr_url'=>array('input',null,'tumblr url', ''),
			'phone_number'=>array('input',null,'phone number', '+40 535 480'),
		'show_information_column'=>array('select', 
				array('0' => 'Yes',
					  '1' => 'No'),
				'Show information column'
			),

		'show_extra_column'=>array('select', 
				array('0' => 'Yes',
					  '1' => 'No'),
				'Show extra column'
			),


		'show_extra_voucher'=>array('select', 
				array('0' => 'Yes',
					  '1' => 'No'),
				'Show voucher link <span class="help help-block">Extra column</span>'
			),

		'show_extra_affiliate'=>array('select', 
				array('0' => 'Yes',
					  '1' => 'No'),
				'Show affiliate link <span class="help help-block">Extra column</span>'
			),

		'show_service_column'=>array('select', 
				array('0' => 'Yes',
					  '1' => 'No'),
				'Show service column'
			),

			
		'show_account_column'=>array('select', 
				array('0' => 'Yes',
					  '1' => 'No'),
				'Show account column'
			),

		'show_powered'=>array('select', 
				array('0' => 'Yes',
					  '1' => 'No'),
				'Show powered by opencart'
			),
		),		
		4 => //translations
		array(
			'buynow_text'=>array('multilanguage',null,'Buy now text', ''),
			'loading_text'=>array('multilanguage',null,'Loading text', ''),
			'call_us_text'=>array('multilanguage',null,'Call us now text (header)', 'Call us now'),
		),		
		5 => //checkout
		array(
			'checkout'=>array('select', 
				array('0' => 'Opencart default',
					  '1' => 'One page quick checkout'),
				'Checkout'
			),

		),		
		6 => //custom css
		array(
			'custom_css'=>array('textarea',null,'Custom css', ''),
		),		
		7 => //speed cache
		array(
			'speed_cache' => array('custom', 'speed_cache', 'Speed cache'),
		),		
	)/*,
	2 => //Footer
	array(
		0 => //contact
		array(
		'layout_id'=>array('select', $layouts, 'Layout footer 1'),
		'position'=>array('hidden',	null, 'Position', 'hidden'),

		'status'=>array('select', 
						array('1' => 'Enabled',
							  '0' => 'Disabled'),
						'Status'
					),
		'sort_order'=>array('input',null,'Sort Order', 1),
		'image_width'=>array('input',null,'Image width', 1027),
		'image_height'=>array('input',null,'Image Height', 768),

		'effect'=>array('select', 
						array(
							  'none' => 'None',
							  'grayscale' => 'Grayscale',
							  'blur' => 'Blur'),
						'Image effect'
					),

		'fade'=>array('input',null,'Fade', 750),
		'duration'=>array('input',null,'Duration', 4000),
		),
		1 => //follow us
		array(
		'layout_id'=>array('select', $layouts, 'Layout footer 2'),
		'position'=>array('hidden',	null, 'Position', 'hidden'),

		'status'=>array('select', 
						array('1' => 'Enabled',
							  '0' => 'Disabled'),
						'Status'
					),
		'sort_order'=>array('input',null,'Sort Order', 1),
		'image_width'=>array('input',null,'Image width', 1027),
		'image_height'=>array('input',null,'Image Height', 768),

		'effect'=>array('select', 
						array(
							  'none' => 'None',
							  'grayscale' => 'Grayscale',
							  'blur' => 'Blur'),
						'Image effect'
					),

		'fade'=>array('input',null,'Fade', 750),
		'duration'=>array('input',null,'Duration', 4000),
		),		
	),*/	
);
