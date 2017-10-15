<?php
$directory = DIR_CATALOG . '/view/theme/';
$themes = array_diff(scandir($directory), array('..', '.','default'));
$theme_config = '';

foreach($themes as $theme_directory)
{
	$theme_config = $directory . $theme_directory . '/theme_config.inc';
	if (file_exists($theme_config)) break;
}


if (file_exists($theme_config)) include_once($theme_config);

$layouts[0] = 'None';  

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

	'filter_type'=>array('select', 
					array(
						 '' => 'No filtering',
						 'product' => 'Product page',
						  'category' => 'Category page',
						  /*'accordion' => 'Accordion',*/
						  'manufacturer' => 'Manufacturer page',
						  'information' => 'Information page',
						  ),
					'Filter <span class="help">(show module only for certain items)</span>'
				),
				
	'filter_products' =>array('input',null,'Show only for product id','',null, 'filter_section filter_products'), 

	'filter_category'=>array('select', (isset($categories))?$categories:array(),
			'Show only for category','',null, 'filter_section filter_category'
		),
	'filter_manufacturer'=>array('select', (isset($manufacturers))?$manufacturers:array(),
			'Show only for manufacturer','',null, 'filter_section filter_manufacturer'
		),
	'filter_information'=>array('input',null,'Show only for information page id', '',null, 'filter_section filter_information'),
);


global $theme_name;
$modules_config_file = dirname($_SERVER['SCRIPT_FILENAME']) . '/../catalog/view/theme/' . $theme_name . '/nico_theme_editor/modules/' . $module_name . '.inc';
if (file_exists($modules_config_file)) 
{
	include_once($modules_config_file);
	$module_config = array_merge($_module_config, $module_config);
}

if (isset($no_grid_layout))  
{
	unset($module_layout_config['grid_cols']);
	unset($module_layout_config['grid_offset']);
	unset($module_layout_config['grid_padding']);
}

if (!isset($no_module_layout)) $module_config = array_merge($module_layout_config, $module_config);


$config_size =  count($module_config);
if (!isset($section_text)) $section_text = 'section';

function section($module = false)
{
	global $module_row, $module_name, $button_remove, $section_config, $config_size, $module_name, $button_remove_txt, $languages, $autocomplete_products, $section_text;
	
	if ($module && $module !== true)
	{
		$module_row_section = $module_row;
	} else
	{
		$module_row_section = '__MODULE_ROW__';
	}
?>
    <?php if ($module) {?>
	<div id="section-<?php  echo $module_row_section; ?>" class="htabs">
    <?php if (isset($module['section'])) { ?>
			 <?php $nr = 0; foreach ($module['section'] as $_nr => $section) { $nr++;?>
					<a style="display:block;" class="tab-<?php  echo $module_row_section; ?>-section" href="#tab-section-<?php  echo $module_row_section; ?>-<?php  echo $nr; ?>">
						<?php echo ucfirst($section_text);?> <?php echo $nr;?> 
						<img onclick="$('#tab-section-<?php  echo $module_row_section; ?>-<?php  echo $nr; ?>').remove(); $(this.parentNode).remove();$('.tab-<?php  echo $module_row_section; ?>-section:first').trigger('click');return false;" alt="" src="view/image/delete.png">
					</a>
			 <?php }?>	    
	<?php } else { $nr = 1;?>
		<a style="display:block;" class="tab-<?php  echo $module_row_section; ?>-section" href="#tab-section-<?php  echo $module_row_section; ?>-<?php  echo $nr; ?>">
						<?php echo ucfirst($section_text);?> <?php echo $nr;?> 
						<img onclick="$('#tab-section-<?php  echo $module_row_section; ?>-<?php  echo $nr; ?>').remove(); $(this.parentNode).remove();$('.tab-<?php  echo $module_row_section; ?>-section:first').trigger('click');return false;" alt="" src="view/image/delete.png">
					</a>
		<?php } ?>				
	    <span href="#" class="section-add" onclick="addSection(<?php echo $module_row_section; ?>);">Add <?php echo $section_text;?> <img alt="" src="view/image/add.png"></span>
	</div>
	<?php } ?>
<?php
	$elements_count = 0;
	if (isset($module['section'])) 
	{
		$sections = $module['section'];
	}
	else if ($module == false) {
		$sections = array('__SECTION_NR__' => array());
	}
	else 
	{
		$sections = array('1' => array());
	}
	$nr = 0;
	foreach ($sections  as $_nr => $section)
	{	
		$nr++;
		if ($_nr == '__SECTION_NR__') $nr = $_nr;
	?>
	<div id="tab-section-<?php echo $module_row_section; ?>-<?php  echo $nr; ?>">
    <table class="form">
<?php
	$elements_count = 0;
	$section_open = false;
	if (isset($section_config))
	foreach ($section_config as $input => $type) if ($type != null)
	{
		?>
		<?php if ($type[0] != 'section_type') {?> 
		<tr>
		<td><?php echo $type[2];?></td>
		<td>
		<?php } ?>		
		<?php
			if (is_array($type))
			{
				switch ($type[0])
				{
					case'input':
					?>
					<input type="text" size="<?php if (isset($type[4])) echo $type[4];else echo '5';?>" name="<?php echo $module_name;?>_module[<?php echo $module_row_section; ?>][section][<?php echo $nr;?>][<?php echo $input; ?>]" 
					value="<?php if (isset($module) && isset($module['section'][$nr][$input])) echo $module['section'][$nr][$input];else if (isset($type[3])) echo $type[3];?>"/>
					<?php
					break;
					case'colorpicker':
					?>
					<input type="text" class="colorpicker" size="<?php if (isset($type[4])) echo $type[4];else echo '5';?>" name="<?php echo $module_name;?>_module[<?php echo $module_row_section; ?>][section][<?php echo $nr;?>][<?php echo $input; ?>]" 
					value="<?php if (isset($module) && isset($module['section'][$nr][$input])) echo $module['section'][$nr][$input];else if (isset($type[3])) echo $type[3];?>"
					<?php if (isset($module) && isset($module['section'][$nr][$input])) echo 'style="background:' . $module['section'][$nr][$input] . ';"';?>/>
					<?php
					break;
					case'image':
					?>
					<div class="image">
						<img src="<?php if (isset($module['section'][$nr][$input . '_thumb']) && !empty($module['section'][$nr][$input . '_thumb'])) echo $module['section'][$nr][$input . '_thumb']; else echo '/image/cache/no_image-100x100.jpg';?>" alt="" id="thumb<?php echo $module_row_section; ?>-<?php echo $nr;?>-<?php echo $input;?>" />
						<input type="hidden" name="<?php echo $module_name;?>_module[<?php echo $module_row_section; ?>][section][<?php echo $nr;?>][<?php echo $input; ?>_image]" 
							value="<?php if (isset($module['section'][$nr][$input . '_image'])) echo $module['section'][$nr][$input . '_image']; ?>" id="image<?php echo $module_row_section; ?>-<?php echo $nr;?>-<?php echo $input;?>"  />                
						<input type="hidden" name="<?php echo $module_name;?>_module[<?php echo $module_row_section; ?>][section][<?php echo $nr;?>][<?php echo $input; ?>_thumb]" 
							value="<?php if (isset($module['section'][$nr][$input . '_thumb'])) echo $module['section'][$nr][$input . '_thumb']; ?>" id="thumb_<?php echo $module_row_section; ?>-<?php echo $nr;?>-<?php echo $input;?>"  />                
						<br/>
						<a onclick="image_upload('<?php echo $module_row_section; ?>', '<?php echo $nr;?>','<?php echo $input;?>');">Browse</a>&nbsp;&nbsp;|&nbsp;&nbsp;
						<a onclick="$('#thumb<?php echo $module_row_section; ?>-<?php echo $nr;?>-<?php echo $input;?>').attr('src', '/image/cache/no_image-100x100.jpg'); $('#image<?php echo $module_row_section; ?>-<?php echo $nr;?>-<?php echo $input;?>, #thumb_<?php echo $module_row_section; ?>-<?php echo $nr;?>-<?php echo $input;?>').attr('value', '');">Clear</a>                
					</div>
					<?php
					break;
					case'autocomplete':
					?>
						<input type="text" _name="product" value="" module="<?php echo $module_row_section; ?>"  section="<?php echo $nr; ?>" autocomplete="off"/>
						<div id="<?php echo $module_name;?>-product-autocomplete-<?php echo $module_row_section; ?>-<?php echo $nr; ?>" class="scrollbox" module="<?php echo $module_row_section; ?>"  section="<?php echo $nr; ?>">
								<?php $class = 'odd'; ?>
								<?php if(isset($autocomplete_products[$module_row_section][$nr])) foreach ($autocomplete_products[$module_row_section][$nr] as $product) { ?>
								<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
								<div id="<?php echo $module_name;?>-product-<?php echo $module_row_section; ?>-<?php echo $nr; ?>-<?php echo $product['product_id']; ?>"
						 class="<?php echo $class; ?>"><?php echo $product['name']; ?> <img src="view/image/delete.png" alt="" />
								  <input type="hidden" value="<?php echo $product['product_id']; ?>" />
								</div>
								<?php } ?>
						</div>
						<input type="hidden" name="<?php echo $module_name;?>_module[<?php echo $module_row_section; ?>][section][<?php  echo $nr; ?>][<?php echo $input;?>]" 
						value="<?php if (isset($module['section'][$nr][$input])) echo $module['section'][$nr][$input]; ?>" /><?php
					break;
					case'select':
					?>
					<select class="<?php echo $input; ?>" name="<?php echo $module_name;?>_module[<?php echo $module_row_section; ?>][section][<?php echo $nr;?>][<?php echo $input; ?>]" section="tab-section-<?php  echo $module_row_section; ?>-<?php  echo $nr; ?>">
					  <?php foreach($type[1] as $value => $name) {?>
						<option value="<?php echo $value;?>" <?php if (isset($module) && isset($module['section'][$nr][$input]) && $module['section'][$nr][$input] == $value) {?>selected="selected"<?php } ?>>
						<?php echo $name;?>
						</option>
					  <?php }?>
					</select>
					<?php
					break;
					case 'module':
					?>
					<select class="<?php echo $input; ?>" name="<?php echo $module_name;?>_module[<?php echo $module_row_section; ?>][section][<?php echo $nr;?>][<?php echo $input; ?>]" section="tab-section-<?php  echo $module_row_section; ?>-<?php  echo $nr; ?>">

					<?php foreach ($type[1] as $extension) { ?>
                    <?php if (!$extension['module']) { ?>
                    <option value="<?php echo $extension['code']; ?>" <?php if ((isset($module) && isset($modules[$input]) && $modules[$input] == $extension['code']) || (isset($type[3]) && $type[3] == $extension['code'])) {?>selected="selected"<?php } ?>><?php echo $extension['name']; ?></option>
                    <?php } else { ?>
                    <optgroup label="<?php echo strip_tags($extension['name']); ?>">
                    <?php foreach ($extension['module'] as $_module) { ?>
                    <option value="<?php echo $_module['code']; ?>" <?php if ((isset($module) && isset($modules[$input]) && $modules[$input] == $_module['code']) || (isset($type[3]) && $type[3] == $_module['code'])) {?>selected="selected"<?php } ?>><?php echo $_module['name']; ?></option>
                    </optgroup>
                    <?php } ?>
                    <?php } }?>


					</select>
					<?php
					break;
					case'multilanguage':
					foreach ($languages as $language) { ?>
					<div class="lang">
					<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><span><?php echo $language['name']; ?></span> &nbsp; 
					<input type="text" name="<?php echo $module_name;?>_module[<?php echo $module_row_section; ?>][section][<?php echo $nr;?>][<?php echo $input; ?>][<?php echo $language['code']; ?>]"
					 value="<?php if (isset($module) && isset($module['section'][$nr][$input][$language['code']])) echo $module['section'][$nr][$input][$language['code']]; ?>" />
					 </div>
					<?php } 
					break;
					case'multilanguage_html':?>
					<div id="lang-<?php  echo $module_row_section; ?>-<?php  echo $nr; ?>" class="htabs">
					<?php foreach ($languages as $language) { ?>
					<a style="display:block;" class="lang-<?php  echo $module_row_section; ?>-<?php echo $nr;?>-<?php echo $language['code']; ?>" href="#lang-<?php  echo $module_row_section; ?>-<?php  echo $nr; ?>-<?php echo $language['code']; ?>">
						<?php echo $language['name']; ?>
						<img onclick="$('#lang-<?php  echo $module_row_section; ?>-<?php  echo $nr; ?>-<?php echo $language['code']; ?>').remove(); $(this.parentNode).remove();$('.lang-<?php  echo $module_row_section; ?>-<?php  echo $nr; ?>:first').trigger('click');return false;" alt="" src="view/image/delete.png">
					</a>
					<?php }?>	    
					</div>
					<?php foreach ($languages as $language) { ?>
					<div id="lang-<?php  echo $module_row_section; ?>-<?php  echo $nr; ?>-<?php echo $language['code']; ?>">
						<textarea class="html" name="<?php echo $module_name;?>_module[<?php echo $module_row_section; ?>][section][<?php echo $nr;?>][<?php echo $input; ?>][<?php echo $language['code']; ?>]">
						<?php if (isset($module) && isset($module['section'][$nr][$input][$language['code']])) echo $module['section'][$nr][$input][$language['code']]; ?></textarea>
					</div>
					<?php } 
					break;
					case'section_type':
					if ($section_open) {?></tbody><?php } ?>
					<tbody class="<?php echo $input;?> section_type"<?php 
						if (!(isset($module) && 
							((isset($module['section'][$nr]['section_type']) && $module['section'][$nr]['section_type'] . '_section'  == $input) || 
							(isset($module['module_type']) && $module['module_type'] . '_section'  == $input))
						 || (!isset($module['section']) && $section_open == false ))) echo ' style="display:none;"';
					?>>
					<?php $section_open = true;
					break;
					case'module':
					?>
					<select name="<?php echo $module_name;?>_module[<?php echo $_module_row; ?>][<?php echo $input; ?>]" class="<?php echo $input;?>" module="<?php echo $_module_row;?>">
						<optgroup>
						<?php 
						$current_extension = '';
						foreach ($type[1] as $extension) { 
						$name = ucfirst(str_replace('nico', 'nico ', $extension['name']));	
						?>
						<?php if ($current_extension != $extension['name']){ $current_extension = $extension['name'] ?></optgroup><optgroup label="<?php echo $name; ?>"><?php }?>
						<option value="<?php echo $extension['name'] . '.' . $extension['code']; ?>" <?php if ((isset($module) && isset($module[$input]) && $module[$input] == ($extension['name'] . '.' . $extension['code'])) || (isset($type[3]) && $type[3] == ($extension['name'] . '.' . $extension['code']))) {?>selected="selected"<?php } ?>><?php echo $name . ' &raquo ' . $extension['code'] ;?></option>
						<?php } ?>

					</select>
					<?php
					break;				}
			}
		?>
		<?php if ($type[0] != 'section_type') {?> 
		  </td>
		</tr>
		<?php } 
	}
	if ($section_open) {
	?></tbody><?php }?>
	  </table>	
  	</div>
	<?php
	}
}

function module_row($module = null)
{
	global $module_row, $module_name, $module_config, $config_size, $module_name, $languages;

	if ($module !== true)
	{
		$_module_row = $module_row;
	} else
	{
		$_module_row = '__MODULE_ROW__';
	}
	?>
	
	<div id="tab-module-<?php echo $_module_row; ?>" class="vtabs-content">
       <table class="form">
<?php
	$elements_count = 0;
	if (isset($module_config) && is_array($module_config))
	foreach ($module_config as $input => $type) if ($type != null)
	{
		?>
		<?php if ($type[0] != 'section' && $type[0] != 'custom') { ?> 
		<tr<?php if ($type[0] == 'hidden') {?> style="display:none"<?php }?><?php if (isset($type[5])) echo ' class="' . $type[5] . '"';?>>
		<td><?php if (isset($type[2]) && !is_array($type[2])) echo $type[2];?></td>
		<td>
		<?php } else { ?>
		<tr>
		<td colspan="2">
		<?php } ?>		
		<?php
			if (is_array($type))
			{
				switch ($type[0])
				{
					case'input':
					?>
					<input type="text" size="<?php if (isset($type[4])) echo $type[4];else echo '5';?>" name="<?php echo $module_name;?>_module[<?php echo $_module_row; ?>][<?php echo $input; ?>]" value="<?php if (isset($module) && isset($module[$input])) echo $module[$input];else if (isset($type[3])) echo $type[3];?>"/>
					<?php
					break;
					case'hidden':
					?>
					<input type="hidden" name="<?php echo $module_name;?>_module[<?php echo $_module_row; ?>][<?php echo $input; ?>]" value="<?php if (isset($module) && isset($module[$input])) echo $module[$input];else if (isset($type[3])) echo $type[3];?>"/>
					<?php
					break;
					case'autocomplete':
					?>
						<input type="text" _name="product" value="" module="<?php echo $_module_row; ?>" autocomplete="off" section="0"/>
						<div id="<?php echo $module_name;?>-product-autocomplete-<?php echo $_module_row; ?>" class="scrollbox" module="<?php echo $_module_row; ?>"  section="0">
								<?php $class = 'odd'; ?>
								<?php if(isset($autocomplete_products[$module_row_section][$nr])) foreach ($autocomplete_products[$module_row_section][$nr] as $product) { ?>
								<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
								<div id="<?php echo $module_name;?>-product-<?php echo $module_row_section; ?>-<?php echo $nr; ?>-<?php echo $product['product_id']; ?>"
						 class="<?php echo $class; ?>"><?php echo $product['name']; ?> <img src="view/image/delete.png" alt="" />
								  <input type="hidden" value="<?php echo $product['product_id']; ?>" />
								</div>
								<?php } ?>
						</div>
						<input type="hidden" name="<?php echo $module_name;?>_module[<?php echo $module_row_section; ?>][section][<?php  echo $nr; ?>][<?php echo $input;?>]" 
						value="<?php if (isset($module['section'][$nr][$input])) echo $module['section'][$nr][$input]; ?>" /><?php
					break;					
					case'select':
					?>
					<select name="<?php echo $module_name;?>_module[<?php echo $_module_row; ?>][<?php echo $input; ?>]" class="<?php echo $input;?>" module="<?php echo $_module_row;?>">
					  <?php foreach($type[1] as $value => $name) {?>
						<option value="<?php echo $value;?>" <?php if ((isset($module) && isset($module[$input]) && $module[$input] == $value) || (!isset($module[$input]) && isset($type[3]) && $type[3] == $value)) {?>selected="selected"<?php } ?>><?php echo $name;?></option>
					  <?php }?>
					</select>
					<?php
					break;
					case'module':
					?>
					<select name="<?php echo $module_name;?>_module[<?php echo $_module_row; ?>][<?php echo $input; ?>]" class="<?php echo $input;?>" module="<?php echo $_module_row;?>">
						<optgroup>
						<?php 
						$current_extension = '';
						foreach ($type[1] as $extension) { 
						$name = ucfirst(str_replace('nico', 'nico ', $extension['name']));	
						?>
						<?php if ($current_extension != $extension['name']){ $current_extension = $extension['name'] ?></optgroup><optgroup label="<?php echo $name; ?>"><?php }?>
						<option value="<?php echo $extension['name'] . '.' . $extension['code']; ?>" <?php if ((isset($module) && isset($module[$input]) && $module[$input] == ($extension['name'] . '.' . $extension['code'])) || (isset($type[3]) && $type[3] == ($extension['name'] . '.' . $extension['code']))) {?>selected="selected"<?php } ?>><?php echo $name . ' &raquo ' . $extension['code'] ;?></option>
						<?php } ?>

					</select>
					<?php
					break;
					case'colorpicker':
					?>
					<input type="text"  class="colorpicker"  size="<?php if (isset($type[4])) echo $type[4];else echo '5';?>" name="<?php echo $module_name;?>_module[<?php echo $_module_row; ?>][<?php echo $input; ?>]" value="<?php if (isset($module) && isset($module[$input])) echo $module[$input];else if (isset($type[3])) echo $type[3];?>" <?php if (isset($module) && isset($module[$input])) echo 'style="background:' . $module[$input];?>"/>
					<?php
					break;
					case'image':
					?>
					<div class="image">
						<img src="<?php if (isset($module[$input . '_thumb']) && !empty($module[$input . '_thumb'])) echo $module[$input . '_thumb']; else echo '/image/cache/no_image-100x100.jpg';?>" alt="" id="thumb<?php echo $_module_row; ?>-<?php echo $input;?>" />
						<input type="hidden" name="<?php echo $module_name;?>_module[<?php echo $_module_row; ?>][<?php echo $input; ?>]" 
							value="<?php if (isset($module[$input])) echo $module[$input]; ?>" id="image<?php echo $_module_row; ?>-<?php echo $input;?>"  />                
						<input type="hidden" name="<?php echo $module_name;?>_module[<?php echo $_module_row; ?>][<?php echo $input; ?>_thumb]" 
							value="<?php if (isset($module[$input . '_thumb'])) echo $module[$input . '_thumb']; ?>" id="thumb_<?php echo $_module_row; ?>-<?php echo $input;?>"  />                
						<br/>
						<a onclick="image_upload('<?php echo $_module_row; ?>', '<?php echo $nr;?>','<?php echo $input;?>');">Browse</a>&nbsp;&nbsp;|&nbsp;&nbsp;
						<a onclick="$('#thumb<?php echo $_module_row; ?>-<?php echo $input;?>').attr('src', '/image/cache/no_image-100x100.jpg'); $('#image<?php echo $_module_row; ?>-<?php echo $input;?>, #thumb_<?php echo $_module_row; ?>-<?php echo $input;?>').attr('value', '');">Clear</a>                
					</div>
					<?php
					break;					
					case'multilanguage':
					foreach ($languages as $language) { ?>
					<div class="lang">
					<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><span><?php echo $language['name']; ?></span> &nbsp; 
					<input type="text" name="<?php echo $module_name;?>_module[<?php echo $_module_row; ?>][<?php echo $input; ?>][<?php echo $language['code']; ?>]"
					 value="<?php if (isset($module) && isset($module[$input][$language['code']])) echo $module[$input][$language['code']]; ?>" />
					 </div>
					<?php } 
					break;
					case'multilanguage_html':?>
					<div id="lang-<?php  echo $_module_row; ?>" class="htabs">
					<?php foreach ($languages as $language) { ?>
					<a style="display:block;" class="lang-<?php  echo $_module_row; ?>-<?php echo $language['code']; ?>" href="#lang-<?php  echo $_module_row; ?>-<?php echo $language['code']; ?>">
						<?php echo $language['name']; ?>
						<img onclick="$('#lang-<?php  echo $_module_row; ?>-<?php echo $language['code']; ?>').remove(); $(this.parentNode).remove();$('.lang-<?php  echo $_module_row; ?>:first').trigger('click');return false;" alt="" src="view/image/delete.png">
					</a>
					<?php }?>	    
					</div>
					<?php foreach ($languages as $language) { ?>
					<div id="lang-<?php  echo $_module_row; ?>-<?php echo $language['code']; ?>">
						<textarea class="html" name="<?php echo $module_name;?>_module[<?php echo $_module_row; ?>][<?php echo $input; ?>][<?php echo $language['code']; ?>]">
						<?php if (isset($module) && isset($module[$input][$language['code']])) echo $module[$input][$language['code']]; ?></textarea>
					</div>
					<?php } 
					break;
					case'section':
					section($module);
					break;
					case'custom':
					$type[1](isset($module)?$module:array());
					break;
				}
			}
			$elements_count++;
		?>
		  </td>
		</tr>
		<?php
	}
?>
	  </table>
	  </div>
<?php
}

function module_tab($subsections = null, $_module_config = array())
{
	global $module_row, $module_name, $module_config, $languages, $_modules;
	if (isset($_modules[1])) $modules = $_modules[1]; else 
	if (isset($_module_config[1])) $modules = $_module_config[1];

	if ($subsections !== true)
	{
		$_module_row = $module_row;
	} else
	{
		$_module_row = '__MODULE_ROW__';
	}
	?>
	
	<div id="tab-module-<?php echo $_module_row; ?>" class="vtabs-content">
		   
		<div id="section-<?php  echo $module_row; ?>" class="htabs">
		<?php if (is_array($subsections)) { ?>
			 <?php foreach ($subsections as $nr => $section_text) { ?>
					<a style="display:block;" class="tab-<?php  echo $nr; ?>-section" href="#tab-section-<?php  echo $module_row; ?>-<?php  echo $nr; ?>">
						<?php echo ucfirst($section_text);?>
					</a>
			 <?php } }?>	
		</div>
		   
<?php
	$elements_count = 0;
	foreach ($subsections as $nr => $section_text) { 
?>
	<div id="tab-section-<?php  echo $module_row; ?>-<?php  echo $nr; ?>">
    <table class="form">
<?php		
	if (isset($module_config[$_module_row][$nr])) foreach ($module_config[$_module_row][$nr] as $input => $type)
	{
		?>
		<?php if ($type[0] != 'section' && $type[0] != 'custom') { ?> 
		<tr<?php if ($type[0] == 'hidden') {?> style="display:none"<?php }?>>
		<td><?php echo $type[2];?></td>
		<td>
		<?php } else { ?>
		<tr>
		<td colspan="2">
		<?php } ?>		
		<?php
			if (is_array($type))
			{
				switch ($type[0])
				{
					case'input':
					?>
					<input type="text" size="20" name="<?php echo $module_name;?>_module[1][<?php echo $input; ?>]" value="<?php if (isset($modules) && isset($modules[$input])) echo $modules[$input];else if (isset($type[3])) echo $type[3];?>"/>
					<?php
					break;
					case'textarea':
					?>
					<textarea name="<?php echo $module_name;?>_module[1][<?php echo $input; ?>]" class="form-control" /><?php if (isset($modules) && isset($modules[$input])) echo $modules[$input];else if (isset($type[3])) echo $type[3];?></textarea>
					<?php
					break;
					case'hidden':
					?>
					<input type="hidden" size="5" name="<?php echo $module_name;?>_module[1][<?php echo $input; ?>]" value="<?php if (isset($modules) && isset($modules[$input])) echo $modules[$input];else if (isset($type[3])) echo $type[3];?>"/>
					<?php
					break;
					case'select':
					?>
					<select name="<?php echo $module_name;?>_module[1][<?php echo $input; ?>]" class="<?php echo $input;?>" module="<?php echo $_module_row;?>">
					  <?php foreach($type[1] as $value => $name) {?>
						<option value="<?php echo $value;?>" <?php if ((isset($modules) && isset($modules[$input]) && $modules[$input] == $value) || (isset($type[3]) && $type[3] == $value)) {?>selected="selected"<?php } ?>><?php echo $name;?></option>
					  <?php }?>
					</select>
					<?php
					break;
					case'multilanguage':
					foreach ($languages as $language) { ?>
					<div class="lang">
					<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><span><?php echo $language['name']; ?></span> &nbsp; 
					<input type="text" name="<?php echo $module_name;?>_module[1][<?php echo $input; ?>][<?php echo $language['code']; ?>]"
					 value="<?php if (isset($modules) && isset($modules[$input][$language['code']])) echo $modules[$input][$language['code']]; ?>" />
					 </div>
					<?php } 
					break;
					case'multilanguage_html':
					foreach ($languages as $language) { ?>
					<div class="lang">
					<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><span><?php echo $language['name']; ?></span> &nbsp; 
					<textarea name="<?php echo $module_name;?>_module[1][<?php echo $input; ?>][<?php echo $language['code']; ?>]" class="html">
					<?php if (isset($modules) && isset($modules[$input][$language['code']])) echo $modules[$input][$language['code']]; ?></textarea>
					 </div>
					<?php } 
					break;
					case'section':
					section($modules);
					break;
					case'custom':
					$type[1](isset($modules)?$modules:array());
					break;
				}
			}
			$elements_count++;
		?>
		  </td>
		</tr>
		<?php
	}
?>
	  </table>
	  </div>
<?php } ?>
</div>
<?php
 }
?>
<?php echo str_replace(array('jquery-1.7.1.min.js','jquery-1.7.2.min.js','/ui/jquery-ui-1.8.16.custom.min.js'), array('jquery.js','jquery.js','/ui-10/jquery-ui.min.js'), $header); ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo strip_tags($breadcrumb['text']); ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="return module_save();" class="button">Save</a><a href="<?php echo $cancel; ?>" class="button">Cancel</a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div class="vtabs">
		
          <?php 
			$module_row = 1; 
			if (isset($custom_tabs)) 
			{
				foreach ($custom_tabs as $name => $subsections) 
				{?> 
				<a href="#tab-module-<?php echo $module_row; ?>" id="module-<?php echo $module_row; ?>"><?php echo $name; ?>&nbsp;
				<!-- img src="view/image/delete.png" alt="" 
				onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $module_row; ?>').remove(); $('#tab-module-<?php echo $module_row; ?>').remove(); return false;" /-->
				</a>
				<?php	
					$module_row++;
				} 
			}else 
			{
			   $module_count = count($modules);
			   for ($module_row = 1;$module_row <= $module_count;$module_row++) { ?>
				<a href="#tab-module-<?php echo $module_row; ?>" id="module-<?php echo $module_row; ?>">Module <?php echo $module_row; ?>&nbsp;
				<img src="view/image/delete.png" alt="" 
				onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $module_row; ?>').remove(); $('#tab-module-<?php echo $module_row; ?>').remove(); return false;" />
				</a>
          <?php } } ?>
          <?php if (!isset($custom_tabs)) {?><span id="module-add" onclick="addModule();">Add module&nbsp;<img src="view/image/add.png" alt=""/></span><?php }?> </div>
          <?php $module_row = 1; 
          if (isset($custom_tabs)) 
          {
				  $_module_name = $module_name . '_module';
				  if (isset($$_module_name)) $_module_name = $$_module_name;else $_module_name = array();
			  foreach ($custom_tabs as $tab => $subsections) 
			  { 
					module_tab($subsections, $_module_name);
				$module_row++;
			  } 
		  } else
          {
			  foreach ($modules as $module) 
			  { 
				module_row($module);
				$module_row++;
			  } 
          }
          
          ?>
	  </form>
  </div>
</div>


<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript" src="view/javascript/ckeditor/adapters/jquery.js"></script>

<script type="text/javascript" src="view/javascript/jquery/colorpicker/jquery.colorpicker.js"></script> 
<link rel="stylesheet" type="text/css" href="view/javascript/jquery/colorpicker/jquery.colorpicker.css" />

<script type="text/javascript"><!--
$(document).on("keyup.autocomplete", 'input[_name=\'product\']', function()
{ 
$(this).autocomplete({
	delay: 500,
	source: function(request, response) 
	{
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {		
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.product_id
					}
				}));
			}
		});
	}, 
	select: function(event, ui) 
	{
		var module = jQuery(this).attr('module');
		var section = jQuery(this).attr('section');
		$('#<?php echo $module_name;?>-product-autocomplete-' + module + '-' + section + ' #<?php echo $module_name;?>-product' + ui.item.value).remove();
		
		$('#<?php echo $module_name;?>-product-autocomplete-' + module + '-' + section).append('<div id="<?php echo $module_name;?>-product' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" value="' + ui.item.value + '" /></div>');

		$('#<?php echo $module_name;?>-product-autocomplete-' + module + '-' + section + ' div:odd').attr('class', 'odd');
		$('#<?php echo $module_name;?>-product-autocomplete-' + module + '-' + section + ' div:even').attr('class', 'even');
		
		data = $.map($('#<?php echo $module_name;?>-product-autocomplete-' + module + '-' + section + ' input'), function(element){
			return $(element).attr('value');
		});
		
		$('input[name=\'<?php echo $module_name;?>_module\['+ module + '\]\[section\]\['+ section + '\]\[product_list\]\']').attr('value', data.join());
					
		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});
});

$('#container').delegate('.scrollbox div img', 'click', function() {
     scrollbox = $(this).parent().parent();
	var module = scrollbox.attr('module');
	var section = scrollbox.attr('section');
	
	$(this).parent().remove();
	
	$('div:odd', scrollbox).attr('class', 'odd');
	$('div:even', scrollbox).attr('class', 'even');

	data = $.map($('#<?php echo $module_name;?>-product-autocomplete-' + module + '-' + section + ' input'), function(element){
		return $(element).attr('value');
	});
	
	$('input[name=\'<?php echo $module_name;?>_module\['+ module + '\]\[section\]\['+ section + '\]\[product_list\]\']').attr('value', data.join());
});

$('#container').delegate('select.section_type', 'change', function() 
{
    section = jQuery(this).attr('section');
    jQuery("#" + section + " tbody.section_type").hide();
    jQuery("#" + section + " .section_type." + this.value + '_section').show();
    
});

$('#container').delegate('select.module_type', 'change', function() 
{
    module = jQuery(this).attr('module');
    jQuery("#tab-module-" + module + " tbody.section_type").hide();
    jQuery("#tab-module-" + module + " .section_type." + this.value + '_section').show();
    
});

var module_row = <?php echo $module_row; ?>;

<?php 	
	ob_start();

	module_row(true);

	$html = str_replace(array("\n", "\r"), '', ob_get_contents());
	$html =  addslashes(preg_replace('/\s+/', ' ', $html));
	ob_end_clean();
?>
var module_html = '<?php echo $html;?>';

<?php 	
	$html = '';
	ob_start();

	section();

	$html = str_replace(array("\n", "\r"), '', ob_get_contents());
	$html =  addslashes(preg_replace('/\s+/', ' ', $html));
	ob_end_clean();
?>
section_html = '<?php echo $html;?>';

function addModule() 
{	
	html = module_html.replace(/__MODULE_ROW__/g, module_row).replace(/__SECTION_NR__/g, '1');
	
	$('#form').append(html);

//	addSection(module_row);

	$('#module-add').before('<a href="#tab-module-' + module_row + '" id="module-' + module_row + '">Module ' + module_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module-' + module_row + '\').remove(); $(\'#tab-module-' + module_row + '\').remove(); return false;" /></a>');
	
	$('.vtabs a').tabs();
	
	$('#tab-module-' + module_row + ' .htabs').each(function() 
	{
		$('#' + this.id +' a').tabs();
	});
	
	$('#module-' + module_row).trigger('click');
	
	jQuery('#tab-module-' + module_row + ' .html').ckeditor({
		filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
	});
	
	$('#tab-module-' + module_row + ' .colorpicker').colorpicker(picker_options);	
	
	module_row++;
}	

function addSection(module_row) 
{	
	section_row = jQuery('.tab-'+ module_row + '-section').length + 1;

	html = section_html.replace(/__SECTION_NR__/g, section_row);

	html = '<a class="tab-'+ module_row + '-section" href="#tab-section-'+ module_row + '-' + section_row + '"><?php echo ucfirst($section_text);?> ' + section_row + ' <img onclick="$(\'#tab-section-'+ module_row + '-' + section_row + '\').remove(); $(this.parentNode).remove();$(\'.tab-'+ module_row + '-section:first\').trigger(\'click\');return false;" alt="" src="view/image/delete.png"></a>';
	jQuery("#section-" + module_row + ' .section-add').before(html);

	html = section_html.replace(/__SECTION_NR__/g, section_row).replace(/__MODULE_ROW__/g, module_row);
	
	$('#section-' + module_row).parent().append(html);
	
	$('#section-' + module_row + ' a').tabs();
	$('#tab-section-'+ module_row + '-' + section_row +' .htabs').each(function() 
	{
		$('#' + this.id +' a').tabs();
	});
	
	$('#section-' + module_row + ' a:last').trigger('click');
	
	jQuery('#tab-section-'+ module_row + '-' + section_row + ' .html').ckeditor({
		filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
	});	
	
	$('#tab-section-'+ module_row + '-' + section_row + ' .colorpicker').colorpicker(picker_options);	
}

$('#container').delegate('select.type', 'change', function() 
{
    module = jQuery(this).attr('module');
    jQuery("#tab-module-" + module + " .htabs a:first").trigger("click");
    jQuery("#tab-module-" + module).attr("class", "vtabs-content type_" + this.value + " filter_type_" + jQuery("select.filter_type").val());
    
});

$('#container').delegate('select.filter_type', 'change', function() 
{
    module = jQuery(this).attr('module');
    jQuery("#tab-module-" + module).attr("class", "vtabs-content filter_type_" + this.value + " type_" + jQuery("select.type").val());
    
});

$('#container select.filter_type').change();

function image_upload(module, section, input) {
	$('#dialog').remove();
	
	if (section)
	id = module +'-'+section + '-' + input;
	else id = module + '-' + input;
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=image' + encodeURIComponent(id) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: '<?php echo $module_name;?> image',
		close: function (event, ui) {
			//console.log($('#image' + module +'-'+section+ '-' + input));
			//console.log($('#image' + module +'-'+section+ '-' + input).attr('value'));
			
			
			if ($('#image' + id).attr('value')) 
			{
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#image' + id).attr('value')),
					dataType: 'text',
					success: function(data) {
						//console.log($('#thumb' + module+'-'+section+ '-' + input));
						$('#thumb' + id).replaceWith('<img src="' + data + '" alt="" id="thumb' + id + '" />');
						$('#thumb_' + id).attr('value', data);
					}
				});
			}
		},	
		bgiframe: false,
		width: 700,
		height: 400,
		resizable: false,
		modal: false
	});
};
//--></script>
<script type="text/javascript"><!--
	
var picker_options =
		{
			parts:['map', 'bar', 'hex', 'hsv', 'rgb', 'alpha', 'preview'],
			showOn: 'click',
			alpha: true,
			inline:false,
			buttonColorize: true,
			showNoneButton: true,
			colorFormat: 'RGBA',
			color:"#fff",
			mode:"r",
			select:	function(event, color) 
			{
				var element = $(this);
				element.css('backgroundColor', color.formatted);
				element.attr('color', color.formatted);
				//jQuery(element.attr("selector")).css(element.attr("attribute"), color.formatted);
/*
				if (!_nico_changes["colors"]) _nico_changes["colors"] = {};
				if (!_nico_changes["colors"][element.attr("selector")]) _nico_changes["colors"][element.attr("selector")] = {};
				if (color.formatted) _nico_changes['colors'][element.attr("selector")][element.attr("attribute")] = color.formatted;*/
			}
		};
	
$('.vtabs a').tabs();
$('.htabs').each(function() 
{
	$('#' + this.id +' a').tabs();
});

jQuery('.html').ckeditor({
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});

jQuery(document).ready(function ()
{
	$('.colorpicker').colorpicker(picker_options);	
});
//--></script> 
<style>
.htabs span {
  background: #F7F7F7;
  color: #000000;
  float: left;
  font-family: Arial,Helvetica,sans-serif;
  font-size: 13px;
  border-bottom:1px solid #DDDDDD;
  font-weight: bold;
  margin-right: 2px;
  padding: 7px 15px 6px;
  text-align: center;
  text-decoration: none;
}

.htabs a img, .htabs span img
{
  vertical-align: middle;
}

#module-add, .section-add
{
    cursor:pointer;
}

div.vtabs-content.type_list .section-add,
div.vtabs-content.type_list .htabs a img,
div.vtabs-content.type_list .htabs a:not(:first-child),

div.vtabs-content.type_carousel .section-add,
div.vtabs-content.type_carousel .htabs a img,
div.vtabs-content.type_carousel .htabs a:not(:first-child)
{
    display:none !important;
}

.htabs a
{
	outline:none;
}

.lang
{
	margin:5px 0px;
}

.lang > img
{
	margin:0px 5px;
}

.lang > span
{
	min-width:100px;
	display:inline-block;
}

.filter_section
{
	display:none;
}

.filter_type_product .filter_section.filter_products
{
		display:table-row;
}


.filter_type_category .filter_section.filter_category
{
		display:table-row;
}

.filter_type_manufacturer .filter_section.filter_manufacturer
{
		display:table-row;
}


.filter_type_information .filter_section.filter_information
{
		display:table-row;
}
</style>
<script>
function module_save()
{
	ret = true;

	if (CKEDITOR.instances)
	for (name in CKEDITOR.instances)
	{
			if (typeof CKEDITOR.instances[name] != null)
			{
				try
				{
					CKEDITOR.instances[name].updateElement().destroy(true);
				}
				catch (e)
				{
					delete CKEDITOR.instances[name];
				}
			}
			
	}

	if (typeof before_save !== 'undefined') 
	{
		ret = before_save();
	}
	
	return ret && $('#form').submit();
}
</script>

<?php if (isset($module_js)) echo $module_js;echo $footer; ?>
