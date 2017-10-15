<?php 
global $module_name,  $autocomplete_products, $module_row, $module_name, $module_config, $config_size, $section_config, $section_text, $font_awesome_icons, $nico_theme_positions, $opencart_version;

$module_name = 'nicofilter';
$section_text = 'section';

$custom_tabs = 
	array('General' => array('Config'), 'Price' => array('Config', 'Text'), 'Filters' => array('Config', 'Text') , 'Manufacturers' => array('Config', 'Text'), 'Availability' => array('Config', 'Text'), 'Options' => array('Config', 'Text'), 'Categories' => array('Config', 'Text'), 'Attributes' => array('Config', 'Text'), 'Tag' => array('Config', 'Text'), 'Name' => array('Config', 'Text'));
	//array('General', 'Layout', 'Social band', 'Footer', 'Translations', 'Checkout', 'Custom css', 'Speed cache')

$no_module_layout = false;

$module_config = array(
	1 => //general
	array(
		0 => //config
		array(
/*		'ajax'=>array('select', 
				array('1' => 'yes',
					  '0' => 'no',
					  ),
				'Use ajax to filter results', 1
			),*/
		
		'timeout'=>array('input',null,'Filter change timeout  <span class="help help-block">seconds to wait after filter change to refresh page</span>', 3),
		),
	),
	
	2 => //price
	array(
		0 => //config
		array(
		'price'=>array('select', 
				array('1' => 'show',
					  '0' => 'hide',
					  ),
				'Show price slider', 1
			),
		
		'price_sort_order'=>array('input',null,'Price sort order'),
		),
		1 => //text
		 array(
			'price_text'=>array('multilanguage',null,'Price title'),
		 )
	),

	3 => //filters
	array(
		0 => //config
		array(
		'filters'=>array('select', 
				array('1' => 'show',
					  '0' => 'hide',
					  ),
				'Show filters', 1
			),
		
		'filters_sort_order'=>array('input',null,'Filters sort order'),
		 ),
		 1 => //text
		 array(
			'filters_text'=>array('multilanguage',null,'Filters title'),
		 ),
	),

	4 => //manufacturer
	array(
		0 => //config
		array(
		'manufacturers'=>array('select', 
				array('1' => 'show',
					  '0' => 'hide',
					  ),
				'Show manufacturer filter', 1
			),
		
		'manufacturers_sort_order'=>array('input',null,'Manufacturers sort order'),
		'manufacturers_image_width'=>array('input',null,'Image width'),
		'manufacturers_image_height'=>array('input',null,'Image height'),

		'manufacturers_images'=>array('select', 
				array('1' => 'show',
					  '0' => 'hide',
					  ),
				'Show images', 1
			),

		'manufacturers_names'=>array('select', 
				array('1' => 'show',
					  '0' => 'hide',
					  ),
				'Show names', 1
			),
		 ),
		 1 => //text
		 array(
			'manufacturers_text'=>array('multilanguage',null,'Manufacturers title'),
		 ),
	),
	
	5 => //availability
	array(
		0 => //config
		array(
		'availability'=>array('select', 
				array('1' => 'show',
					  '0' => 'hide',
					  ),
				'Show availability filter', 1
			),
		
		'availability_sort_order'=>array('input',null,'Availability sort order'),
		 ),
		 1 => //text
		 array(
			'availability_text'=>array('multilanguage',null,'Availability title'),
			'in_stock_text'=>array('multilanguage',null,'In stock text'),
	 ),
	),
	
	6 => //options
	array(
		0 => //config
		array(
		'options'=>array('select', 
				array('1' => 'show',
					  '0' => 'hide',
					  ),
				'Show options filter', 1
			),
		
		'options_sort_order'=>array('input',null,'Options sort order'),
		 ),
		 1 => //text
		 array(
			'options_text'=>array('multilanguage',null,'Options title'),
		 ),
	),
	
	
	7 => //categories
	array(
		0 => //config
		array(
		'categories'=>array('select', 
				array('1' => 'show',
					  '0' => 'hide',
					  ),
				'Show categories filter', 1
			),
		
		'categories_sort_order'=>array('input',null,'Categories sort order'),
		 ),
		 1 => //text
		 array(
			'categories_text'=>array('multilanguage',null,'Categories title'),
		 ),
	),
	

	
	8 => //attributes
	array(
		0 => //config
		array(
		'attributes'=>array('select', 
				array('1' => 'show',
					  '0' => 'hide',
					  ),
				'Show attributes filter', 1
			),
		
		'attributes_sort_order'=>array('input',null,'Attributes sort order'),
		 ),
		 1 => //text
		 array(
			'attributes_text'=>array('multilanguage',null,'Attributes title'),
		 ),
	),	
	
	9 => //tag
	array(
		0 => //config
		array(
		'tag'=>array('select', 
				array('1' => 'show',
					  '0' => 'hide',
					  ),
				'Show tag filter', 1
			),
		
		'tag_sort_order'=>array('input',null,'Tag sort order'),
		 ),
		 1 => //text
		 array(
			'tag_text'=>array('multilanguage',null,'Tag title'),
		 ),
	),

	10 => //name
	array(
		0 => //config
		array(
		'name'=>array('select', 
				array('1' => 'show',
					  '0' => 'hide',
					  ),
				'Show name filter', 1
			),
		
		'name_sort_order'=>array('input',null,'Name sort order'),
		 ),
		 1 => //text
		 array(
			'name_text'=>array('multilanguage',null,'Name title'),
		 ),
	)
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
	$theme_config = DIR_CATALOG . '/view/theme/' . $theme_name . '/theme_config.inc';
	if (file_exists($theme_config)) include_once($theme_config);
	
	$module_layout_config = array(
		'layout_id'=>array('select', $layouts, 'Layout'),

		'position'=>array('select',	$nico_theme_positions, 'Position'),

		'status'=>array('select', 
						array('1' => 'Enabled',
							  '0' => 'Disabled'),
						'Status'
					),
		'sort_order'=>array('input',null,'Sort Order', 1),

		'grid_cols'=>array('select', 
					array('0' => 'auto',
						  '12' => '12',
						  '11' => '11',
						  '10' => '10',
						  '9' => '9',
						  '8' => '8',
						  '7' => '7',
						  '6' => '6',
						  '5' => '5',
						  '4' => '4',
						  '3' => '3',
						  '2' => '2',
						  '1' => '1',
						  ),
					'Grid columns to occupy <span class="help"><a target="_blank" href="http://getbootstrap.com/css/#grid-options">grid options</a></span>', 0
				),
		
		'grid_offset'=>array('select', 
					array('0' => 'none',
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
						  '11' => '11'
						  ),
					'Grid left offset <span class="help"><a target="_blank" href="http://getbootstrap.com/css/#grid-offsetting">grid offset</a></span>', 0
				),

		'grid_padding'=>array('select', 
					array('0' => 'default',
						  '1' => 'no padding',
						  '2' => 'no padding left',
						  '3' => 'no padding right',
						  ),
					'Grid elements spacing <span class="help"><a target="_blank" href="http://getbootstrap.com/css/#grid-options">grid options</a></span>', 0
			),
	);
	
	$custom_tabs['General'][] =	'Layout';
	$module_config[1][1] = $module_layout_config;
	require('nicomodule.tpl');
}
