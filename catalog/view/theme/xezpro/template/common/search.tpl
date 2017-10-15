<?php 
if (isset($_GET['route']) && $_GET['route'] == 'module/cart') $_GET['ajax'] = true;
global $_config;

$nico_include_path = __DIR__. '/../../';
//vqmod changes paths and the above path fails, check other paths
if (!file_exists($nico_include_path . 'nico_theme_editor/common.inc')) 
{
	$_config =  $this->registry->get('config');
	$nico_include_path = DIR_TEMPLATE . '/' . $_config->get('config_template') . '/';
	
	if (!file_exists($nico_include_path . '/nico_theme_editor/common.inc')) $nico_include_path = dirname(__FILE__) . '/../../';
}

if (file_exists($nico_include_path . 'nico_theme_editor/common.inc')) require_once($nico_include_path . 'nico_theme_editor/common.inc');
?>
	<form action="/" class="navbar-form navbar-search" role="search">
	  <div class="input-group"> 

		  <button type="submit" class="btn btn-default icon-search"></button> 

		  <?php if (isset($search)) {?>
		  <input type="text" name="search" class="search-query col-sm-4" autocomplete="off" placeholder="<?php if (isset($text_search)) echo $text_search; ?>" value="<?php if (isset($search)) echo $search; ?>" />
		  <?php } else {?>
			<?php if (isset($filter_name)) { ?>
				<input type="text" name="filter_name" autocomplete="off" class="search-query col-sm-8" value="<?php echo $filter_name; ?>" /> 
			<?php } else { ?>
				<input type="text" id="search_input" autocomplete="off" class="search-query col-sm-4" name="filter_name" value="<?php echo $text_search;?>"/>
			<?php } ?>
		  <?php }?>	

		  <div class="select">
		  <select name="category_id">
			<option value="0">All categories</option>
			<?php $category_id = isset($_GET['category_id'])?$_GET['category_id']:isset($_GET['path'])?$_GET['path']:0;$nico_categories = nico_get_categories();foreach ($nico_categories as $category_1) { ?>
			<?php if ($category_1['category_id'] == $category_id) { ?>
			<option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
			<?php } else { ?>
			<option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
			<?php } ?>
			<?php foreach ($category_1['children'] as $category_2) { ?>
			<?php if ($category_2['category_id'] == $category_id) { ?>
			<option value="<?php echo $category_2['category_id']; ?>" selected="selected">&ensp;<?php echo $category_2['name']; ?></option>
			<?php } else { ?>
			<option value="<?php echo $category_2['category_id']; ?>">&ensp;<?php echo $category_2['name']; ?></option>
			<?php } ?>
			<?php foreach ($category_2['children'] as $category_3) { ?>
			<?php if ($category_3['category_id'] == $category_id) { ?>
			<option value="<?php echo $category_3['category_id']; ?>" selected="selected">&ensp;&ensp;<?php echo $category_3['name']; ?></option>
			<?php } else { ?>
			<option value="<?php echo $category_3['category_id']; ?>">&ensp;&ensp;<?php echo $category_3['name']; ?></option>
			<?php } ?>
			<?php } ?>
			<?php } ?>
			<?php } ?>
		  </select>
		  </div>
	  </div>
	  </form>		
