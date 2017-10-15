<?php 
global $module_name,  $autocomplete_products, $module_row, $module_name, $module_config, $config_size, $section_config, $section_text, $font_awesome_icons, $nico_theme_positions, $opencart_version;
$autocomplete_products = $products;

$module_name = 'nicocustomproducts';
$section_text = 'section';

$module_config = array(
	'module_cols_xs'=>array('select', 
				array('12' => '1',
					  '6' => '2',
					  '4' => '3',
					  '3' => '4',
					  '2' => '6',
					  '1' => '12',
					  ),
				'Products per row<span class="help">(extra small devices, phones)</span>', 12
			),
			
	'module_cols_sm'=>array('select', 
				array('12' => '1',
					  '6' => '2',
					  '4' => '3',
					  '3' => '4',
					  '2' => '6',
					  '1' => '12',
					  ),
				'Products per row<span class="help">(small devices, tablets)</span>', 12
			),			

	'module_cols_md'=>array('select', 
				array('12' => '1',
					  '6' => '2',
					  '4' => '3',
					  '3' => '4',
					  '2' => '6',
					  '1' => '12',
					  ),
				'Products per row<span class="help">(medium devices, desktops)</span>', 3
			),			

	'module_cols_lg'=>array('select', 
				array('12' => '1',
					  '6' => '2',
					  '4' => '3',
					  '3' => '4',
					  '2' => '6',
					  '1' => '12',
					  ),
				'Products per row<span class="help">(large devices, desktops)</span>', 3
			),			


			
	'additional_image'=> array('select', 
					array(
						0 => 'Disabled',
						1 => 'Enabled'
						),
					'Change image on hover'
				),

	'resize_method'=>array('select', 
					array('0' => 'Opencart default',
						  '1' => 'Crop and resize',
						  '2' => 'Width',
						  '3' => 'Height',
						  ),
					'Product image resize method'
				),

				
	'image_width'=>array('input',null,'Image width', 200),
	'image_height'=>array('input',null,'Image Height', 256),


	'type'=>array('select', 
					array('filter' => 'Filter',
						  'tabs' => 'Tabs',
						  /*'accordion' => 'Accordion',*/
						  'carousel' => 'Carousel',
						  'tabs_carousel' => 'Tabs + Carousel',
						  'grid' => 'Grid',
						  'list' => 'List',
						  ),
					'Type'
				),
	'title'=>array('multilanguage',null,'Module title'),


	'show_cover'=>array('select', 
					array('0' => 'No',
						  '1' => 'Yes',
						  ),
					'Show cover', 0, 20, ''
				),
	
	'cover_resize_method'=>array('select', 
					array('0' => 'Opencart default',
						  '1' => 'Crop and resize',
						  '2' => 'Width',
						  '3' => 'Height',
						  ),
					'Background image resize method <span class="help help-block">(takes precendence over video)</span>', 0, 20, 'cover_content'
				),
				
	'cover_image_width'=>array('input',null,'Cover image width', 300, 20, 'cover_content'),
	'cover_image_height'=>array('input',null,'Cover image Height', 450, 20, 'cover_content'),

	'cover_background_image'=>array('image',null, 'Cover background image', 0, 20, 'cover_content'),
	'cover_youtube_id'=>array('input',null,'Cover youtube id  <span class="help help-block">(for optional video background)</span>', 0, 20, 'cover_content'),
	'cover_vimeo_id'=>array('input',null,'Cover vimeo id <span class="help help-block">(for optional video background)</span>', 0, 20, 'cover_content'),

	'cover_text_color'=>array('select', 
					array('white' => 'White',
						  'black' => 'Black',
						  ),
					'Text color', 0, 20, 'cover_content'
				),
				
	'cover_alignment'=>array('select', 
					array('left' => 'Left',
						  'right' => 'Right',
						  ),
					'Text color', 0, 20, 'cover_content'
				),

	'cover_title'=>array('multilanguage',null,'Cover title', 'Title', 20, 'cover_content'),
	'cover_text'=>array('multilanguage_html',null,'Cover text', 'Text', 20, 'cover_content'),
	'cover_button'=>array('multilanguage',null,'Cover button', 'View all', 20, 'cover_content'),
	'cover_url'=>array('input',null,'Cover url', '/index.php?route=product/category&path=20', 20, 'cover_content'),

	'section' => array('section'),
);

$section_config = array(
	'order'=>array('input',null,'Sort order', '0', 20),
	'title'=>array('multilanguage',null,'Section title'),
	'section_type'=>array('select', 
					array('autocomplete' => 'Autocomplete',
						  'category' => 'Category',
						  'manufacturer' => 'Manufacturer',
						  'latest' => 'Latest',
						  'bestsellers' => 'Bestsellers',
						  'specials' => 'Specials',
						  'popular' => 'Popular',
						  'recentlyviewed' => 'Recentlyviewed',
						  'random' => 'Random',
						  'alsobought' => 'Alsobought',
						  'related' => 'Related',
						  ),
					'Get products from'
				),

	'autocomplete_section'=>array('section_type'),
	'product_list'=>array('autocomplete',null,'Products'),


	'category_section'=>array('section_type'),
	'category'=>array('select', $categories,
			'Category'
		),
		
	'category_sort'=>array('select', 
			array('asc' => 'ASC',
				  'desc' => 'DESC'
				  ),
			'Sort order'
		),
	'category_limit'=>array('input',null,'Limit'),


	'manufacturer_section'=>array('section_type'),
	'manufacturer'=>array('select', $manufacturers,
			'Manufacturer'
		),
	'manufacturer_sort'=>array('select', 
			array('asc' => 'ASC',
				  'desc' => 'DESC'
				  ),
			'Sort order'
		),
	'manufacturer_limit'=>array('input',null,'Limit', 5),


	'latest_section'=>array('section_type'),
	'latest_limit'=>array('input',null,'Limit', 5),

	'bestsellers_section'=>array('section_type'),
	'bestsellers_limit'=>array('input',null,'Limit', 5),


	'specials_section'=>array('section_type'),
	'specials_limit'=>array('input',null,'Limit', 5),


	'popular_section'=>array('section_type'),
	'popular_limit'=>array('input',null,'Limit', 5),


	'recentlyviewed_section'=>array('section_type'),
	'recentlyviewed_limit'=>array('input',null,'Limit', 5),

	'random_section'=>array('section_type'),
	'random_limit'=>array('input',null,'Limit', 5),
	'random_cache'=>array('select', 
				array('true' => 'True',
					  'false' => 'False'
					  ),
				'Cache results', 'true'
			),
	'related_section'=>array('section_type'),
	'related_limit'=>array('input',null,'Limit', 5),
	'related_same_category'=>array('select', 
				array(true => 'True',
					  false => 'False'
					  ),
				'Same category complete<span class="help">(Add products from same category if not enough related products)</span>', 'true'
			),

	'alsobought_section'=>array('section_type'),
	'alsobought_limit'=>array('input',null,'Limit',5),
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
}?>
<script>
jQuery(".show_cover").change(function()
{
	if (this.value == 1) jQuery(".cover_content").show(); else jQuery(".cover_content").hide();
});
jQuery(".show_cover").change();
</script>
