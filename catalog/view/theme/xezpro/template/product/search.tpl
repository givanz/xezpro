<?php /*$_SERVER['HTTP_X_REQUESTED_WITH'] != 'XMLHttpRequest'*/ if (!isset($_GET['ajax']) && !isset($_POST['ajax']) && !isset($_SERVER['HTTP_X_REQUESTED_WITH'])) {
global $_config, $opencart_version;
$opencart_version = (int)str_replace('.','',VERSION);

if (isset($this->registry)) $registry = $this->registry;
$_config =  $registry->get('config');
if (!isset($theme_name))
{
	if (!($theme_name = $_config->get('config_template')))
	{
		$theme_name = $_config->get('config_theme');
	}
}
if (!isset($theme_directory))
{
	$theme_directory = $theme_name;
}

//$theme_directory = DIR_TEMPLATE . '/' . $theme_directory . '/';
require_once(DIR_TEMPLATE . $theme_directory . '/nico_theme_editor/common.inc');

echo $header; 
?>
<div class="container">
	        
		<div class="row">
		    <div class="col-md-12">
			    <div class="breadcrumbs">
					
						<ul class="breadcrumb">
						<?php foreach ($breadcrumbs as $breadcrumb) { ?>
						<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
						<?php } ?>
						</ul>
				</div>
			</div>
		</div>
		
		<div class="row">
		    <div class="col-md-12">
			    <div class="cat_header">
				    <h2><?php echo $heading_title; ?></h2>
			    </div>

			</div>
		</div>
		
		
	<div class="row">
	<?php if (!empty($column_left)) { 
		$cols = 9;
		?> 
		<?php echo $column_left; ?> 
		<div class="col-md-9">
	<?php } else {
		$cols = 12;?>
		<div class="col-md-12">
	<?php } ?>
	<div class="well">
			  <b><?php if (isset($text_critea)) echo $text_critea; ?></b>
			  <div class="content">
				<p><?php echo $entry_search; ?></p>

				  <div class="form-group">
				  <?php if (isset($search) && $search) { ?>
				  <input id="search-input" type="text" name="search" placeholder="<?php if (isset($text_keyword)) echo $text_keyword; ?>" value="<?php if (isset($search)) echo $search; ?>" class="form-control"/>
				  <?php } else if (isset($search)) { ?>
				  <input id="search-input" type="text" name="search" placeholder="<?php if (isset($text_keyword)) echo $text_keyword; ?>" value="<?php if (isset($search)) echo $search; ?>"  class="form-control"/>
				  <?php } else { ?>
					  <?php if (isset($filter_name)) { ?>
					  <input id="search-input" type="text" name="filter_name" placeholder="<?php echo $filter_name; ?>" class="form-control"/>
					  <?php } else { ?>
					  <input id="search-input" type="text" name="filter_name" placeholder="" class="form-control"/>
					  <?php } ?>
				  <?php } ?>
				  </div>
				  <?php if (isset($search))	{?>
				  <select name="category_id">
					<option value="0"><?php echo $text_category; ?></option>
					<?php foreach ($categories as $category_1) { ?>
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
					<option value="<?php echo $category_3['category_id']; ?>" selected="selected">&ensp;>&ensp;<?php echo $category_3['name']; ?></option>
					<?php } else { ?>
					<option value="<?php echo $category_3['category_id']; ?>">&ensp;>&ensp;<?php echo $category_3['name']; ?></option>
					<?php } ?>
					<?php } ?>
					<?php } ?>
					<?php } ?>
				  </select>
				 <?php } else { ?>
				  <select name="filter_category_id">
					<option value="0"><?php echo $text_category; ?></option>
					<?php foreach ($categories as $category_1) { ?>
					<?php if ($category_1['category_id'] == $filter_category_id) { ?>
					<option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
					<?php } else { ?>
					<option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
					<?php } ?>
					<?php foreach ($category_1['children'] as $category_2) { ?>
					<?php if ($category_2['category_id'] == $filter_category_id) { ?>
					<option value="<?php echo $category_2['category_id']; ?>" selected="selected">&ensp;<?php echo $category_2['name']; ?></option>
					<?php } else { ?>
					<option value="<?php echo $category_2['category_id']; ?>">&ensp;<?php echo $category_2['name']; ?></option>
					<?php } ?>
					<?php foreach ($category_2['children'] as $category_3) { ?>
					<?php if ($category_3['category_id'] == $filter_category_id) { ?>
					<option value="<?php echo $category_3['category_id']; ?>" selected="selected">&ensp;&ensp;<?php echo $category_3['name']; ?></option>
					<?php } else { ?>
					<option value="<?php echo $category_3['category_id']; ?>">&ensp;&ensp;<?php echo $category_3['name']; ?></option>
					<?php } ?>
					<?php } ?>
					<?php } ?>
					<?php } ?>
				  </select>
				  <?php } ?>
				  <?php if (isset($sub_category) && $sub_category) { ?>
				  <input type="checkbox" name="sub_category" value="1" id="sub_category" checked="checked" />
				  <?php } else if (isset($sub_category)) { ?>
				  <input type="checkbox" name="sub_category" value="1" id="sub_category" />
				  <?php } else {?>
					  <?php if (isset($filter_sub_category)) { ?>
					  <input type="checkbox" name="filter_sub_category" value="1" id="sub_category" checked="checked" />
					  <?php } else { ?>
					  <input type="checkbox" name="filter_sub_category" value="1" id="sub_category" />
					  <?php } ?>
				  <?php } ?>	
				  <label for="sub_category"><?php echo $text_sub_category; ?></label>

				<?php if (isset($description) && $description) { ?>
				<input type="checkbox" name="description" value="1" id="description" checked="checked" />
				<?php } else if (isset($description)) { ?>
				<input type="checkbox" name="description" value="1" id="description" />
				<?php } else { ?>
					<?php if (isset($filter_description)) { ?>
					<input type="checkbox" name="filter_description" value="1" id="description" checked="checked" />
					<?php } else { ?>
					<input type="checkbox" name="filter_description" value="1" id="description" />
					<?php } ?>
				<?php } ?>
				<label for="description"><?php echo $entry_description; ?></label>
			  </div>
			  <div class="buttons">
				<div class="right"><input type="button" value="<?php echo $button_search; ?>" id="button-search" class="button btn btn-primary" /></div>
			  </div>
		 </div>
			
	
	  <h2 class="margin-bottom"><?php echo $text_search; ?></h2>

		<div class="row products product-layout">
		    <?php 
				global $_button_cart, $_config;
				$_button_cart = $button_cart;

				$cols_lg = nico_get_config('category_page_products_row');
				$cols_md = nico_get_config('category_page_products_row_md');
				$cols_sm = nico_get_config('category_page_products_row_sm');
				$cols_xs = nico_get_config('category_page_products_row_xs');
				
				$cols = 'col-xs-' . $cols_xs . ' col-sm-' . $cols_sm . ' col-md-' . $cols_md . ' col-lg-' . $cols_lg;
				
				$category_page_products_row = nico_get_config('category_page_products_row');
				if (empty($category_page_products_row)) $category_page_products_row = 3;

				if (isset($products) && $products) 
				{
					include(DIR_TEMPLATE . $theme_directory . '/template/module/nico_product.tpl');
					foreach ($products as $product) { ?>
					<div class="<?php echo $cols;?> prod">
						<?php nico_product($product);?>
					</div>
				<?php } 
				} else { ?>
			<div class="well"><?php echo $text_empty; ?></div>
			<?php }	?>	
			</div>	
		</div>	
	  </div>	

		
		<div class="row">
			<div class="col-md-12">
				<div class="row">
				<?php if (isset($pagination)) echo $pagination; ?>
				</div>
			</div>
		</div>
	</div>	
	</div>	
</div>

<script type="text/javascript"><!--

$('#search-input').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#button-search').trigger('click');
	}
});


$('select[name=\'category_id\']').on('change', function() {
	if (this.value == '0') {
		$('input[name=\'sub_category\']').prop('disabled', 'disabled');
		$('input[name=\'sub_category\']').removeAttr('checked');
	} else {
		$('input[name=\'sub_category\']').removeAttr('disabled');
	}
});

$('select[name=\'category_id\']').trigger('change');
$('#button-search').on('click', function() {
	url = 'index.php?route=product/search';
	
	if ($('#search-input').length)
    {
		var search = $('#search-input').prop('value');
	
		if (search) {
			url += '&search=' + encodeURIComponent(search);
		}

		var category_id = $('.container select[name=\'category_id\']').prop('value');
	
		if (category_id > 0) {
			url += '&category_id=' + encodeURIComponent(category_id);
		}
	
		var sub_category = $('.container input[name=\'sub_category\']:checked').prop('value');
	
		if (sub_category) {
			url += '&sub_category=true';
		}
		
		var filter_description = $('.container input[name=\'description\']:checked').prop('value');
	
		if (filter_description) {
			url += '&description=true';
		}
    } else 
	{
 
		var filter_name = $('#search-input').prop('value');
	
		if (filter_name) {
			url += '&filter_name=' + encodeURIComponent(filter_name);
		}

		var filter_category_id = $('.container select[name=\'filter_category_id\']').prop('value');
	
		if (filter_category_id > 0) {
			url += '&filter_category_id=' + encodeURIComponent(filter_category_id);
		}
	
		var filter_sub_category = $('.container input[name=\'filter_sub_category\']:checked').prop('value');
	
		if (filter_sub_category) {
			url += '&filter_sub_category=true';
		}
		
		var filter_description = $('.container input[name=\'filter_description\']:checked').prop('value');
	
		if (filter_description) {
			url += '&filter_description=true';
		} 
    }
	window.location = url;
});
</script>


<?php echo $footer; ?>
<?php } else { echo json_encode($products); }?>
