<?php
global $theme_name, $opencart_version, $lang_img_path, $_languages;
$_languages = $languages;

if ($opencart_version >= 2200) $lang_img_path = 'language/'; else  $lang_img_path = '../image/flags/';


$directory = DIR_CATALOG . '/view/theme/';
$theme_directory = 'default';
$themes = array_diff(scandir($directory), array('..', '.','default'));
$theme_config = '';

foreach($themes as $theme_directory)
{
	$theme_config = $directory . $theme_directory . '/theme_config.inc';
	if (file_exists($theme_config)) break;
}


if (file_exists($theme_config)) include_once($theme_config);

$modules_config_file = dirname($_SERVER['SCRIPT_FILENAME']) . '/../catalog/view/theme/' . $theme_directory . '/nico_theme_editor/modules/' . $module_name . '.inc';

if (file_exists($modules_config_file)) 
{
	include_once($modules_config_file);
	$module_config = array_merge($module_config, $_module_config);
}

if (!isset($no_module_layout))  
{
	$module_layout_config = array(
	/*	'layout_id'=>array('select', $layouts, 'Layout'),

		'position'=>array('select',	$nico_theme_positions, 'Position'),

		'status'=>array('select', 
						array('1' => 'Enabled',
							  '0' => 'Disabled'),
						'Status'
					),
		'sort_order'=>array('input',null,'Sort Order', 1),
	*/
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

		'filter_category'=>array('select', $categories,
				'Show only for category','',null, 'filter_section filter_category'
			),
		'filter_manufacturer'=>array('select', $manufacturers,
				'Show only for manufacturer','',null, 'filter_section filter_manufacturer'
			),
		'filter_information'=>array('input',null,'Show only for information page id', '',null, 'filter_section filter_information'),
	);
	
	if (defined('ADMIN_MODULE_CSS_LAYOUT') && ADMIN_MODULE_CSS_LAYOUT)
	{

		$module_layout_config['layout'] = array('heading',null,'<h3>Layout options</h3>','',null);
		
		
	$module_layout_config['container'] = array('select', 
					array('' => 'none',
						  'container' => 'Container',
						  'container-fluid' => 'Container fluid',
						  ),
					'Enclose the module in a container', 0
	);
	
		//margin padding	
		foreach (array('m' => 'Margin', 'p' => 'Padding') as $layout => $layout_text)
		{
			//'all', 'top', 'bottom', 'left', 'right'
			foreach (array('' => 'all', 'x' => 'horizontal' , 'y' => 'vertical', 't' => 'top', 'b' => 'bottom', 'l' => 'left', 'r' => 'right') as $position => $position_text)
			{
				
				$module_layout_config["layout[$layout{$position}]"] =
					array('select', 
						array(-1 => 'default',
							  0 => '0 (none)',
							  1 => '1',
							  2 => '2',
							  3 => '3',/*
							  4 => '4',
							  5 => '5',
							  6 => '6',
							  7 => '7',
							  8 => '8',
							  9 => '9',
							  10 => '10',*/
							  ),
						"$layout_text $position_text <span class='help'><a target='_blank' href='http://v4-alpha.getbootstrap.com/utilities/spacing/'>bootstrap spacing</a></span>", -1
					);	
			}
		}
		
	}
	

	if (isset($no_grid_layout))  
	{
		unset($module_layout_config['grid_cols']);
		unset($module_layout_config['grid_offset']);
		unset($module_layout_config['grid_padding']);
	}

	$module_config = array_merge($module_config, $module_layout_config);	
}	



$config_size =  count($module_config);

if (!isset($section_text)) $section_text = 'section';

function section($module = false)
{
	global $module_row, $module_name, $section_config, $config_size, $module_name, $_languages, $autocomplete_products, $section_text, $opencart_version, $lang_img_path, $_modules;
?>
    <?php if ($module) {?>
	<ul class="nav nav-tabs" id="section">
    <?php if (isset($module['section'])) { ?>
			 <?php $nr = 0; foreach ($module['section'] as $_nr => $section) { $nr++;?>
					<li>
					<a style="display:block;" class="tab-section" href="#tab-section-<?php  echo $nr; ?>" data-toggle="tab">
		 				<?php echo ucfirst($section_text);?> <?php echo $nr;?> 
						<?php if ($nr > 1) { ?>
						<i class="fa fa-minus-circle" onclick="$(this).parent().parent().remove();
						 $('#tab-section-<?php  echo $nr; ?>').remove(); $('#section a:first').tab('show');"></i>
						 <?php } ?>
					</a>
					</li>
			 <?php }?>	    
	<?php } else { $nr = 1;?>
		<li>
			<a style="display:block;" class="tab-section" href="#tab-section-<?php  echo $nr; ?>" data-toggle="tab">
				<?php echo ucfirst($section_text);?> <?php echo $nr;?> 
			</a>
		</li>
		<?php } ?>				
	    <li class="section-add"><a onclick="addSection();"><i class="fa fa-plus-circle"></i> Add <?php echo $section_text;?> </a></li>
	</ul>
    <div class="tab-content tab-content-section">
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
    <div class="tab-pane" id="tab-section-<?php  echo $nr; ?>">
<?php
	$elements_count = 0;
	$section_open = false;
	if (is_array($section_config)) foreach ($section_config as $input => $type) if ($type != null)
	{
		?>
		<?php if ($type[0] != 'section_type') {?> 
		<div class="form-group">
		<label class="col-sm-2 control-label" for="<?php echo $nr . $input;?>"><?php echo ucfirst($type[2]);?></label>
		<div class="col-sm-10">
		<?php }?>
		<?php
			if (is_array($type))
			{
				switch ($type[0])
				{
					case'input':
					?>
					<input type="text" size="5" id="<?php echo  $nr . $input;?>" name="section[<?php echo $nr;?>][<?php echo $input; ?>]"  class="form-control" 
					value="<?php if (isset($module) && isset($module['section'][$nr][$input])) echo $module['section'][$nr][$input];else if (isset($type[3])) echo $type[3];?>"/>
					<?php
					break;
					case'colorpicker':
					?>
					<input type="text" class="colorpicker" size="<?php if (isset($type[4])) echo $type[4];else echo '5';?>" name="section[<?php echo $nr;?>][<?php echo $input; ?>]" 
					value="<?php if (isset($module) && isset($module['section'][$nr][$input])) echo $module['section'][$nr][$input];else if (isset($type[3])) echo $type[3];?>"
					<?php if (isset($module) && isset($module['section'][$nr][$input])) echo 'style="background:' . $module['section'][$nr][$input] . ';"';?>/>
					<?php
					break;
					case'image':
					?>
					<div>
						<a href="#" onclick="window.getSelection().removeAllRanges();" id="thumb-<?php echo $nr;?>-<?php echo $input;?>" class="img-thumbnail" data-toggle="image" data-original-title="">
						<?php if (isset($module['section'][$nr][$input . '_image']) && !empty($module['section'][$nr][$input . '_image'])) {?>
						<img src="../image/<?php echo $module['section'][$nr][$input . '_image']; ?>" data-placeholder="../image/<?php echo $module['section'][$nr][$input . '_image']; ?>" alt="" title="" id="thumb-<?php echo $nr;?>-<?php echo $input;?>" />
						<?php } else {?>
							<img src="../image/cache/no_image-100x100.png" data-placeholder=="../image/cache/no_image-100x100.png" alt="" title="" id="thumb-<?php echo $nr;?>-<?php echo $input;?>" />
						<?php } ?>
						</a>
						<input id="input-<?php echo $nr;?>-<?php echo $input;?>" type="hidden" name="section[<?php echo $nr;?>][<?php echo $input; ?>_image]" 
						value="<?php if (isset($module['section'][$nr][$input . '_image'])) echo $module['section'][$nr][$input . '_image']; ?>" id="image-<?php echo $nr;?>-<?php echo $input;?>" />
					</div>
					<?php
					break;
					case'autocomplete':
					?>
						<input type="text" _name="product" value="" 
						section="<?php echo $nr; ?>"
						placeholder="Product" id="input-product-<?php echo $nr; ?>" class="form-control" autocomplete="off"/>
						<span class="help-block">(Autocomplete)</span>
						<div id="autocomplete-<?php echo $nr;?>" class="well well-sm" style="height: 150px; overflow: auto;">
						  <?php if(isset($autocomplete_products[$nr])) foreach ($autocomplete_products[$nr] as $product) { ?>
						  <div id="autocomplete-<?php echo $nr;?>-<?php echo $product['product_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $product['name']; ?>
							<input type="hidden" value="<?php echo $product['product_id']; ?>" />
						  </div>
						  <?php } ?>
						</div>
						<input type="hidden" _name="autocomplete"
						name="section[<?php  echo $nr; ?>][<?php echo $input;?>]" 
						value="<?php if (isset($module['section'][$nr][$input])) echo $module['section'][$nr][$input]; ?>"
						 class="form-control" />
					<?php
					break;
					case'select':
					?>
					<select id="<?php echo $nr . $input;?>" class="<?php echo $input; ?> form-control" name="section[<?php echo $nr;?>][<?php echo $input; ?>]" 
							section="tab-section-<?php  echo $nr; ?>">
					  <?php foreach($type[1] as $value => $_name) {?>
						<option value="<?php echo $value;?>" <?php if (isset($module) && isset($module['section'][$nr][$input]) && $module['section'][$nr][$input] == $value) {?>selected="selected"<?php } ?>>
						<?php echo $_name;?>
						</option>
					  <?php }?>
					</select>
					<?php
					break;
					case'multilanguage':
					/* ?>
					<div class="row"> 
					<?php */
					foreach ($_languages as $language) { ?>
					<div class="col-md-2">						
					<label for="<?php echo $nr . $input;?>"><img src="<?php if ($opencart_version >= 2200) $image = $lang_img_path . $language['code']  .'/' . $language['code'] . '.png'; else  $image = $lang_img_path . $language['image'];echo $image;?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></label>
					<input type="text" name="section[<?php echo $nr;?>][<?php echo $input; ?>][<?php echo $language['code']; ?>]" id="<?php echo $nr . $input;?>"
					 value="<?php if (isset($module) && isset($module['section'][$nr][$input][$language['code']])) echo $module['section'][$nr][$input][$language['code']]; ?>" class="form-control" />
					 </div>
					<?php } /* ?>
					</div>
					<?php */
					break;					
					case'multilanguage_html':?>
	                <div class="tab-pane" id="lang-<?php  echo $nr . $input; ?>">
	                <ul class="nav nav-tabs lang-tab" id="language-tab-<?php  echo $nr . $input; ?>">
					<?php foreach ($_languages as $language) { ?>
						<li>
							<a class="lang-<?php echo $nr;?>-<?php echo $language['code']; ?>" href="#lang-<?php  echo $nr. $input; ?>-<?php echo $language['code']; ?>"  data-toggle="tab">
								<img src="<?php if ($opencart_version >= 2200) $image = $lang_img_path . $language['code']  .'/' . $language['code'] . '.png'; else  $image = $lang_img_path . $language['image'];echo $image;?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?>
							</a>
						</li>
					<?php }?>	    
					</ul>
					<div class="tab-content">
					<?php foreach ($_languages as $language) { ?>
					<div id="lang-<?php  echo $nr . $input; ?>-<?php echo $language['code']; ?>" class="tab-pane" >
						<textarea class="html summernote" name="section[<?php echo $nr;?>][<?php echo $input; ?>][<?php echo $language['code']; ?>]">
						<?php if (isset($module) && isset($module['section'][$nr][$input][$language['code']])) echo $module['section'][$nr][$input][$language['code']]; ?></textarea>
					</div>
					<?php } ?>
					</div>
					</div>
					<?php
					break;
					case'section_type':
					if ($section_open) {?></div><?php } ?>
					<div class="<?php echo $input;?> section_type"<?php 
						if (!(isset($module) && 
							((isset($module['section'][$nr]['section_type']) && $module['section'][$nr]['section_type'] . '_section'  == $input) || 
							(isset($module['module_type']) && $module['module_type'] . '_section'  == $input))
						 || (!isset($module['section']) && $section_open == false ))) echo ' style="display:none;"';
					?>>
					<?php $section_open = true;
					break;
					case'module':
					?>
					<select id="<?php echo $nr . $input;?>" class="<?php echo $input; ?> form-control" name="section[<?php echo $nr;?>][<?php echo $input; ?>]" 
							section="tab-section-<?php  echo $nr; ?>">					
					<?php foreach ($type[1] as $extension) { ?>
                    <?php if (!$extension['module']) { ?>
                    <option value="<?php echo $extension['code']; ?>" <?php if ((isset($modules) && isset($modules[$input]) && $modules[$input] == $extension['code']) || (isset($type[3]) && $type[3] == $extension['code'])) {?>selected="selected"<?php } ?>><?php echo $extension['name']; ?></option>
                    <?php } else { ?>
                    <optgroup label="<?php echo strip_tags($extension['name']); ?>">
                    <?php foreach ($extension['module'] as $_module) { ?>
                    <option value="<?php echo $_module['code']; ?>" <?php if ((isset($modules) && isset($modules[$input]) && $modules[$input] == $_module['code']) || (isset($type[3]) && $type[3] == $_module['code'])) {?>selected="selected"<?php } ?>><?php echo $_module['name']; ?></option>
                    </optgroup>
                    <?php } ?>
                    <?php } }?>
					</select>
					<?php
					break;				}
			}
		?>
		<?php if ($type[0] != 'section_type') {?> 
		  </div>
		</div>
		<?php } 
	}
	if ($section_open) {
	?>
  	</div>
	<?php
	} 
?></div>
<?php
}
if ($module) {?>
</div>
<?php } ?>
<?php	
}

function module_tab($subsections = null, $_module_config = array())
{
	global $module_row, $module_name, $module_config, $_languages, $_modules, $opencart_version, $lang_img_path;
	
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
   <div class="tab-pane" id="tab-module-<?php echo $_module_row; ?>">
	
	
	<?php if ($subsections) {?>
	<ul class="nav nav-tabs" id="section-<?php  echo $module_row; ?>">
    <?php if (is_array($subsections)) { ?>
			 <?php foreach ($subsections as $nr => $section_text) { ?>
					<li>
					<a style="display:block;" class="tab-<?php echo $module_row . '-'. $nr; ?>-section" href="#tab-section-<?php echo $module_row . '-'. $nr; ?>" data-toggle="tab">
		 				<?php echo ucfirst($section_text);?>
					</a>
					</li>
			 <?php }?>	    
	<?php } ?>
	</ul>
    <div class="tab-content tab-content-section">
	<?php } ?>
		   
<?php
	$elements_count = 0;
	foreach ($subsections as $nr => $section_text) { 
?>
	<div class="tab-pane" id="tab-section-<?php echo $module_row . '-'. $nr; ?>">
<?php
	if (isset($module_config[$_module_row][$nr])) foreach ($module_config[$_module_row][$nr] as $input => $type)
	{
		?>
		<?php if ($type[0] != 'section' && $type[0] != 'custom') { ?> 
		<div class="form-group<?php if (isset($type[5]) && !is_array($type[5])) echo ' ' . $type[5];?>" <?php if ($type[0] == 'hidden') {?> style="display:none"<?php }?>>
		<label class="col-sm-2 control-label" for="<?php echo $module_name . $nr . $input;?>"><?php echo ucfirst($type[2]);?></label>
		<div class="col-sm-10">
		<?php } else { ?>
		<div class="form-group">
		<div class="col-sm-12">
		<?php } ?>		
		<?php
			if (is_array($type))
			{
				switch ($type[0])
				{
					case'input':
					?>
					<input type="text" size="5" name="<?php echo $module_name;?>_module[1][<?php echo $input; ?>]" value="<?php if (isset($modules) && isset($modules[$input])) echo $modules[$input];else if (isset($type[3])) echo $type[3];?>" class="form-control" />
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
					<select name="<?php echo $module_name;?>_module[1][<?php echo $input; ?>]" class="<?php echo $input;?> form-control" module="<?php echo $_module_row;?>" >
					  <?php foreach($type[1] as $value => $_name) {?>
						<option value="<?php echo $value;?>" <?php if ((isset($modules) && isset($modules[$input]) && $modules[$input] == $value) || (isset($type[3]) && $type[3] == $value)) {?>selected="selected"<?php } ?>><?php echo $_name;?></option>
					  <?php }?>
					</select>
					<?php
					break;
					case'module':
					?>
					<select name="<?php echo $module_name;?>_module[1][<?php echo $input; ?>]" class="<?php echo $input;?> form-control" module="<?php echo $_module_row;?>" >
					<?php foreach ($type[1] as $extension) { ?>
                    <?php if (!$extension['module']) { ?>
                    <option value="<?php echo $extension['code']; ?>" <?php if ((isset($modules) && isset($modules[$input]) && $modules[$input] == $extension['code']) || (isset($type[3]) && $type[3] == $extension['code'])) {?>selected="selected"<?php } ?>><?php echo $extension['name']; ?></option>
                    <?php } else { ?>
                    <optgroup label="<?php echo strip_tags($extension['name']); ?>">
                    <?php foreach ($extension['module'] as $_module) { ?>
                    <option value="<?php echo $_module['code']; ?>" <?php if ((isset($modules) && isset($modules[$input]) && $modules[$input] == $_module['code']) || (isset($type[3]) && $type[3] == $_module['code'])) {?>selected="selected"<?php } ?>><?php echo $_module['name']; ?></option>
                    </optgroup>
                    <?php } ?>
                    <?php } }?>
					</select>
					<?php
					break;
					case'multilanguage':
					foreach ($_languages as $language) { ?>
					<div class="lang">
					<img src="<?php if ($opencart_version >= 2200) $image = $lang_img_path . $language['code']  .'/' . $language['code'] . '.png'; else  $image = $lang_img_path . $language['image'];echo $image;?>" title="<?php echo $language['name']; ?>" /><span><?php echo $language['name']; ?></span> &nbsp; 
					<input type="text" name="<?php echo $module_name;?>_module[1][<?php echo $input; ?>][<?php echo $language['code']; ?>]"
					 value="<?php if (isset($modules) && isset($modules[$input][$language['code']])) echo $modules[$input][$language['code']]; ?>" />
					 </div>
					<?php } 
					break;
					case'multilanguage_html':
					foreach ($_languages as $language) { ?>
					<div class="lang">
					<img src="<?php if ($opencart_version >= 2200) $image = $lang_img_path . $language['code']  .'/' . $language['code'] . '.png'; else  $image = $lang_img_path . $language['image'];echo $image;?>" title="<?php echo $language['name']; ?>" /> <span><?php echo $language['name']; ?></span> &nbsp; 
					<textarea class="html summernote" name="<?php echo $module_name;?>_module[1][<?php echo $input; ?>][<?php echo $language['code']; ?>]">
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
		  </div>
		</div>
		<?php
	}
?>
 </div>
<?php } ?>
</div>
</div>
<?php
 }
?>
<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-html" onclick="return module_save();" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary button"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default button"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body" id="tab-module">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-html" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="status" id="input-status" class="form-control">
                <?php if (isset($status) && $status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
              <?php if ($error_name) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
          </div>          
<?php 
$module_row = 1; 
if (isset($custom_tabs)) 
{
?>          
          <div class="row">
            <div class="col-sm-2">
              <ul class="nav nav-pills nav-stacked" id="module">
			<?php
				foreach ($custom_tabs as $_name => $subsections) 
				{?> 
				<li><a href="#tab-module-<?php echo $module_row; ?>" data-toggle="tab"></i><?php echo  $_name; ?></a></li>
				<?php	
					$module_row++;
				} 
			?>
              <!-- li id="module-add"><a onclick="addModule();"><i class="fa fa-plus-circle"></i> Add module</a></li -->
            </ul>
          </div>
          <div class="col-sm-10">
            <div class="tab-content tab-content-module">
<?php } ?>				
			<?php $module_row = 1; 
			  if (isset($custom_tabs)) 
			  {
				  $_module_name = $module_name . '_module';
				  if (isset($$_module_name)) $_module_name = $$_module_name; else $_module_name = '';
				  foreach ($custom_tabs as $tab => $subsections) 
				  { 
					module_tab($subsections, $_module_name);
					$module_row++;
				  } 
			  } else
			  {
	$elements_count = 0;
	foreach ($module_config as $input => $type) if ($type != null)
	{
		?>
		<?php if ($type[0] != 'section' && $type[0] != 'custom') {?> 
		<div class="form-group<?php if (isset($type[5])) echo ' ' . $type[5];?>" <?php if ($type[0] == 'hidden') {?> style="display:none"<?php }?>>
		<label class="col-sm-2 control-label" for="input-<?php echo $input;?>"><?php if (!is_array($type[2])) echo ucfirst($type[2]);?></label>
		<div class="col-sm-10">
		<?php } else { ?>
		<div>
		<?php } ?>		
		<?php
			if (is_array($type))
			{
				switch ($type[0])
				{
					case'input':
					?>
					<input type="text" size="5" name="<?php echo $input; ?>" value="<?php if (isset($module) && isset($module[$input])) echo $module[$input];else if (isset($type[3])) echo $type[3];?>" class="form-control"/>
					<?php
					break;
					case'hidden':
					?>
					<input type="hidden" size="5" name="<?php echo $input; ?>" value="<?php if (isset($module) && isset($module[$input])) echo $module[$input];else if (isset($type[3])) echo $type[3];?>"/>
					<?php
					break;
					case'select':
					//select name is array
					if ($array_start = strpos($input, '[')) 
					{
						$input1 = substr($input, 0, $array_start);
						$input2 = substr($input, $array_start + 1, -1);
						if (isset($module[$input1][$input2])) $saved_value = $module[$input1][$input2];
					}
					else
					if (isset($module[$input])) $saved_value = $module[$input];
					?>
					<select name="<?php echo $input; ?>" class="<?php echo $input;?> form-control">
					  <?php foreach($type[1] as $value => $_name) {?>
						<option value="<?php echo $value;?>" <?php if ((isset($module) && isset($saved_value) && $saved_value == $value) || (!isset($saved_value) && isset($type[3]) && $type[3] == $value)) {?>selected="selected"<?php } ?>><?php echo $_name;?></option>
					  <?php }?>
					</select>
					<?php
					break;
					case'module':
					?>
					<select name="<?php echo $input; ?>" class="<?php echo $input;?> form-control">
					<?php foreach ($type[1] as $extension) { ?>
                    <?php if (!$extension['module']) { ?>
                    <option value="<?php echo $extension['code']; ?>" <?php if ((isset($module) && isset($module[$input]) && $module[$input] == $extension['code']) || (isset($type[3]) && $type[3] == $extension['code'])) {?>selected="selected"<?php } ?>><?php echo $extension['name']; ?></option>
                    <?php } else { ?>
                    <optgroup label="<?php echo strip_tags($extension['name']); ?>">
                    <?php foreach ($extension['module'] as $_module) { ?>
                    <option value="<?php echo $_module['code']; ?>" <?php if ((isset($module) && isset($module[$input]) && $module[$input] == $_module['code']) || (isset($type[3]) && $type[3] == $_module['code'])) {?>selected="selected"<?php } ?>><?php echo $_module['name']; ?></option>
                    </optgroup>
                    <?php } ?>
                    <?php } }?>
					</select>
					<?php
					break;
					case'colorpicker':
					?>
					<input type="text" class="colorpicker" size="<?php if (isset($type[4])) echo $type[4];else echo '5';?>" name="<?php echo $input; ?>" 
					value="<?php if (isset($module) && isset($module[$input])) echo $module[$input];else if (isset($type[3])) echo $type[3];?>" 
					<?php if (isset($module) && isset($module[$input])) echo 'style="background:' . $module[$input] . ';"';?>/>
					<?php
					break;
					case'image':
					$_image = $input .'_image';
					//$_image = $$_image;
					?>
					<div>
						<a href="#" onclick="window.getSelection().removeAllRanges();" id="thumb-<?php echo $input;?>" class="img-thumbnail" data-toggle="image" data-original-title="">
						<?php if (isset($module[$input]) && !empty($module[$input])) {?>
						<img src="../image/<?php echo $module[$input]; ?>" data-placeholder="../image/<?php echo $module[$input]; ?>" alt="" title="" id="thumb-<?php echo $input;?>" />
						<?php } else {?>
							<img src="../image/cache/no_image-100x100.png" data-placeholder=="../image/cache/no_image-100x100.png" alt="" title="" id="thumb-<?php echo $input;?>" />
						<?php } ?>
						</a>
						<input id="input-<?php echo $input;?>" type="text" style="visibility:hidden" name="<?php echo $input; ?>" 
						value="<?php if (isset($module[$input])) echo $module[$input]; ?>" id="image-<?php echo $input;?>" />
					</div>
					<?php
					break;
					case'multilanguage':
					?>
					<div class="row">
					<?php
					foreach ($languages as $language) { ?>
					<div class="col-md-2">						
					<label for="<?php echo $input;?>"><img src="<?php if ($opencart_version >= 2200) $image = $lang_img_path . $language['code']  .'/' . $language['code'] . '.png'; else  $image = $lang_img_path . $language['image'];echo $image;?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></label>
					<input type="text" name="<?php echo $input; ?>[<?php echo $language['code']; ?>]" id="<?php echo $input;?>"
					 value="<?php if (isset($module) && isset($module[$input][$language['code']])) echo $module[$input][$language['code']]; ?>" class="form-control" />
					 </div>
					<?php } ?>
					</div>
					<?php
					break;
					case'multilanguage_html':?>
					<ul class="nav nav-tabs lang-tab" id="lang-tab">
					<?php foreach ($languages as $language) { ?>
					<li><a style="display:block;" class="lang-<?php echo $language['code']; ?>" href="#lang-<?php echo $language['code'] . '-' . $input; ?>" data-toggle="tab">
						<?php echo $language['name']; ?>
						<img onclick="$('#lang-<?php echo $language['code'] . '-' . $input; ?>').remove(); $(this.parentNode).remove();$('.lang:first').trigger('click');return false;" alt="" src="view/image/delete.png">
					</a>
					</li>
					<?php }?>	    
					</uL>
                    <div class="tab-content">
					<?php foreach ($languages as $language) { ?>
					<div id="lang-<?php echo $language['code'] . '-' . $input; ?>"  class="tab-pane">
						<textarea class="html summernote" name="<?php echo $input; ?>[<?php echo $language['code']; ?>]">
						<?php if (isset($module) && isset($module[$input][$language['code']])) echo $module[$input][$language['code']]; ?></textarea>
					</div>
					<?php } ?>
					</div> 
					<?php
					break;
					case'section':
					section($module);
					break;
					case'custom':
					$type[1]($module);
					break;
				}
			}
			$elements_count++;
		  if ($type[0] != 'section' && $type[0] != 'custom') {?> 
		  </div>
		  </div>
		<?php
	   } else {
	   ?></div>
	   <?php }
	}
// -- module row
}
if (isset($custom_tabs)) 
{?>
           </div>
          </div>
<?php }?>          
        </div>
      </form>
    </div>
  </div>
</div>
<!-- script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript" src="view/javascript/ckeditor/adapters/jquery.js"></script -->
<!--
<script type="text/javascript" src="view/javascript/jquery/ui-10/jquery-ui.min.js"></script>
-->
<link rel="stylesheet" type="text/css" href="view/javascript/jquery/bootstrap-colorpicker/css/bootstrap-colorpicker.min.css">
<script type="text/javascript" src="view/javascript/jquery/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"></script> 

<script type="text/javascript"><!--

<?php if ($opencart_version > 2000) {?>

	$('input[_name=\'product\']').autocomplete({
		'source': function(request, response) {
	if (typeof request != "string" && request.term) request = request.term;
	
			$.ajax({
				url: 'index.php?route=catalog/product/autocomplete&token=<?php if (isset($token)) echo $token;else if (isset($user_token)) echo $user_token; ?>&user_token=<?php if (isset($token)) echo $token;else if (isset($user_token)) echo $user_token; ?>&filter_name=' +  encodeURIComponent(request),
				dataType: 'json',			
				success: function(json) {
					response($.map(json, function(item) {
						return {
							label: item['name'],
							value: item['product_id'],
						}
					}));
				}
			});
		},
		
	'select': function(item) {
		autocomplete_container = this.parentNode;
		console.log(autocomplete_container);

		$('#autocomplete-' + item['value'], autocomplete_container).remove();
		
		$('div.well', autocomplete_container).append('<div id="autocomplete-' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" value="' + item['value'] + '"  _label="' + item['label'] + '"/></div>');	
	
		data = $.map($('div > input', autocomplete_container), function(element){
			return $(element).attr('value');
		});

		data_label = $.map($('div > input', autocomplete_container), function(element){
			return $(element).attr('_label');
		});		
							
		$(jQuery('input[_name="autocomplete"]', autocomplete_container)).attr('value', data.join());
		
	},
});

$('.well').on('click', '.fa-minus-circle', function() {
	var autocomplete_container = this.parentNode.parentNode.parentNode;
	$(this.parentNode).remove();

	data = $.map($('.well input', autocomplete_container), function(element){
		return $(element).attr('value');
	});
	
	data_label = $.map($('.well input', autocomplete_container), function(element){
		return $(element).attr('_label');
	});		
					
	$(jQuery('input[_name="autocomplete"]', autocomplete_container)).attr('value', data.join());
	$(jQuery('input[_name="autocomplete_names"]', autocomplete_container)).attr('value', data_label.join());
});

<?php } else {?>
$(document).on("keyup.autocomplete", 'input[_name=\'product\']', function()
{ 
	
var input = jQuery(this);
var autocomplete_container = this.parentNode;
	
$(this).autocomplete({
	delay: 500,
	source: function(request, response) 
	{
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php if (isset($token)) echo $token;else if (isset($user_token)) echo $user_token; ?>&user_token=<?php if (isset($token)) echo $token;else if (isset($user_token)) echo $user_token; ?>&filter_name=' +  encodeURIComponent(request.term),
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
		scrollbox = jQuery('.scrollbox', autocomplete_container);
		node_id = scrollbox.closest('li').attr('id');
		
		$('.product' + ui.item.value, scrollbox).remove();
		
		scrollbox.append('<div node_id="' + node_id + '" class="product' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" value="' + ui.item.value + '" _label="' + escape(ui.item.label) +'"/></div>');

		$(' div:odd', scrollbox).addClass('odd').removeClass('even');
		$(' div:even', scrollbox).addClass('even').removeClass('odd');
		
		data = $.map($('input', scrollbox), function(element){
			return $(element).attr('value');
		});
		
		data_label = $.map($('input', scrollbox), function(element){
			return $(element).attr('_label');
		});

		$(jQuery('input[_name="autocomplete"]', this.parentNode)).attr('value', data.join());
		$(jQuery('input[_name="autocomplete_names"]', this.parentNode)).attr('value', data_label.join());
					
		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});
});

$('.scrollbox div').on('click', 'img', function() {
	var scrollbox = this.parentNode.parentNode;
	$(this.parentNode).remove();
	
	$('div:odd', scrollbox).attr('class', 'odd');
	$('div:even', scrollbox).attr('class', 'even');

	data = $.map($('input', scrollbox), function(element){
		return $(element).attr('value');
	});

	data_label = $.map($('input', scrollbox), function(element){
		return $(element).attr('_label');
	});
	
	$('input[_name="autocomplete"]', scrollbox.parentNode).attr('value', data.join());
	$(jQuery('input[_name="autocomplete_names"]', scrollbox.parentNode)).attr('value', data_label.join());
});
<?php } ?>



$('.panel-body').delegate('select.section_type', 'change', function() 
{
    section = jQuery(this).attr('section');
    jQuery("#" + section + " div.section_type").hide();
    jQuery("#" + section + " .section_type." + this.value + '_section').show();
    
});

$('.panel-body').delegate('select.module_type', 'change', function() 
{
    module = jQuery(this).attr('module');
    jQuery("#tab-module  div.section_type").hide();
    jQuery("#tab-module .section_type." + this.value + '_section').show();
    
});

<?php 	
	$html = '';
	ob_start();

	section();

	$html = str_replace(array("\n", "\r"), '', ob_get_contents());
	$html =  addslashes(preg_replace('/\s+/', ' ', $html));
	ob_end_clean();
?>
section_html = '<?php echo $html;?>';

function addSection() 
{	
	section_row = jQuery('.tab-content-section > div').length + 1;

	/*html = '<a class="tab-'+ module_row + '-section" href="#tab-section-'+ module_row + '-' + section_row + '">Section ' + section_row + ' <img onclick="$(\'#tab-section-'+ module_row + '-' + section_row + '\').remove(); $(this.parentNode).remove();$(\'.tab-'+ module_row + '-section:first\').trigger(\'click\');return false;" alt="" src="view/image/delete.png"></a>';
	jQuery("#section-" + module_row + ' .section-add').before(html);*/
	html = section_html.replace(/__SECTION_NR__/g, section_row);
	
	$('.tab-content-section').append(html);

	$('#section .section-add').before('<li><a href="#tab-section-' + section_row + '" data-toggle="tab"><?php echo ucfirst($section_text);?> ' + section_row + ' <i class="fa fa-minus-circle" onclick="$(\'a[href=\\\'#tab-section-' + section_row + '\\\']\').parent().remove(); $(\'#tab-section-' + section_row +  '\').remove(); $(\'#section a:first\').tab(\'show\');"></i></a></li>');
	
	$('#section a[href=\'#tab-section-' + section_row + '\']').tab('show');
	
	$('#tab-section-' + section_row + ' .lang-tab li:first-child a').tab('show');
	
	if (jQuery.summernote) jQuery('#tab-section-' + section_row + ' .html').summernote({
		height: 300
	});
/*
	jQuery('#tab-section-'+ module_row + '-' + section_row + ' .html').ckeditor({
		filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
	});	
*/	
	jQuery('#tab-section-' + section_row + ' .colorpicker').colorpicker(picker_options);	
}

$('#tab-module').delegate('select.type', 'change', function() 
{
    jQuery("#section a:first").tab('show');
    jQuery("#tab-module").attr("class", "panel-body active type_" + this.value + " filter_type_" + jQuery("select.filter_type").val());
    
});
/*
$('.panel-body').delegate('select.type', 'change', function() 
{
    module = jQuery(this).attr('module');
    jQuery("#section-" + module + " .htabs a:first").trigger("click");
    jQuery("#section-" + module).attr("class", "tab-pane active type_" + this.value + " filter_type_" + jQuery("select.filter_type").val());
    
});
*/
$('#tab-module').delegate('select.filter_type', 'change', function() 
{
    jQuery("#tab-module").attr("class", "panel-body active filter_type_" + this.value + " type_" + jQuery("select.type").val());
    
});

$('.panel-body select.filter_type').change();


//--></script>
<script type="text/javascript"><!--
$('.lang-tab li:first-child a').tab('show');
$('.nav-tabs li:first-child a').tab('show');

<?php $module_row = 1; 
if (isset($custom_tabs)) 
{?>
	$('#module li:first-child a').tab('show');
<?php	
foreach ($custom_tabs as $tab => $subsections) 
{?>
  $('#section-<?php echo $module_row; ?>  li:first-child a').tab('show');
<?php $module_row++;
}
} else 
{	  
foreach ($modules as $module) { ?>
$('#section-<?php echo $module_row; ?>  li:first-child a').tab('show');
<?php $module_row++; ?>
<?php } 
}?>


var picker_options =
		{
			/*parts:['map', 'bar', 'hex', 'hsv', 'rgb', 'alpha', 'preview'],
			showOn: 'click',
			alpha: true,
			inline:false,
			buttonColorize: true,
			showNoneButton: true,
			colorFormat: 'RGBA',
			mode:"r",
			select:	function(event, color) 
			{
				var element = $(this);
				element.css('backgroundColor', color.formatted);
				element.attr('color', color.formatted);
			}*/
		};
	
jQuery(document).ready(function ()
{
	$('.colorpicker').colorpicker(picker_options);	
});

if (jQuery.summernote) jQuery('textarea.html').summernote({
		height: 300
	});
/*
jQuery('.html').ckeditor({
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});*/
//--></script> 
<script>
function module_save()
{
	ret = true;
/*
	for (name in CKEDITOR.instances)
	{
		CKEDITOR.instances[name].destroy(true);
	}
*/
	
	if (typeof before_save !== 'undefined') 
	{
		ret = before_save();
	}
	
	return ret && $('#form').submit();
}
</script>
<style>

.well .fa.fa-minus-circle
{
	cursor:pointer;
}

.well .fa.fa-minus-circle:hover
{
	color:red;
}
	
	
#module-add, .section-add
{
    cursor:pointer;
}

.tab-content-module .tab-pane.type_list .section-add,
.tab-content-module .tab-pane.type_list .nav-tabs li:not(:first-child),

.tab-content-module .tab-pane.type_carousel .section-add,
.tab-content-module .tab-pane.type_carousel .nav-tabs li:not(:first-child)
{
    display:none !important;
}

.autocomplete i, .nav-tabs i, .nav-pills i
{
	cursor:pointer;
	margin:0px 5px;
	font-size:14px;
}

.thumb, .img-thumbnail img
{
	max-width:150px;
	max-height:150px;
}

.filter_section
{
	display:none;
}

.filter_type_product .filter_section.filter_products
{
		display:block;
}


.filter_type_category .filter_section.filter_category
{
		display:block;
}

.filter_type_manufacturer .filter_section.filter_manufacturer
{
		display:block;
}


.filter_type_information .filter_section.filter_information
{
		display:block;
}

.help-block 
{
  font-weight: 400;
}
</style>
<script type="text/javascript" src="view/javascript/summernote/summernote.js"></script>
<link href="view/javascript/summernote/summernote.css" rel="stylesheet" />
<?php if ($opencart_version >= 2200) {?><script type="text/javascript" src="view/javascript/summernote/opencart.js"></script><?php }?>  
<?php if (isset($module_js)) echo $module_js;echo $footer; ?>
