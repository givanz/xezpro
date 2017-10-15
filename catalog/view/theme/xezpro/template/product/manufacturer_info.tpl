<?php 
$nico_include_path = __DIR__. '/../../';
//vqmod changes paths and the above path fails, check other paths
if (!file_exists($nico_include_path . 'nico_theme_editor/common.inc')) 
{
	$_config =  $this->registry->get('config');
	$nico_include_path = DIR_TEMPLATE . '/' . $_config->get('config_template') . '/';
	
	if (!file_exists($nico_include_path . '/nico_theme_editor/common.inc')) $nico_include_path = dirname(__FILE__) . '/../../';
}

if (file_exists($nico_include_path . 'nico_theme_editor/common.inc')) require_once($nico_include_path . 'nico_theme_editor/common.inc');
global $_config;
echo $header;
?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
		
		<div class="row">
		    <div class="col-md-12">
			    <div class="cat_header">
				    <h2><?php echo $heading_title; ?></h2>
			    </div>

			</div>
		</div>
		

		      <div class="row sort_show">
			<div class="col-md-4">
			  <div class="btn-group">
			    <button type="button" id="grid-view" class="btn btn-default" data-toggle="tooltip" title="<?php if (isset($button_grid)) echo $button_grid; ?>"><i class="fa fa-th"></i> <?php if (isset($text_grid)) echo $text_grid; ?></button>
			    <button type="button" id="list-view" class="btn btn-default" data-toggle="tooltip" title="<?php if (isset($button_list)) echo $button_list; ?>"><i class="fa fa-th-list"></i> <?php if (isset($text_list))  echo $text_list; ?></button>
			  </div>
			</div>
			<div class="col-md-2 text-right">
			  <label class="control-label" for="input-sort"><?php echo $text_sort; ?></label>
			</div>
			<div class="col-md-3 text-right">
			  <select id="input-sort" class="form-control col-sm-3 selectpicker" onchange="location = this.value;">
			    <?php foreach ($sorts as $sorts) { ?>
			    <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
			    <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
			    <?php } else { ?>
			    <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
			    <?php } ?>
			    <?php } ?>
			  </select>
			</div>
			<div class="col-md-1 text-right">
			  <label class="control-label" for="input-limit"><?php echo $text_limit; ?></label>
			</div>
			<div class="col-md-2 text-right">
			  <select id="input-limit" class="form-control selectpicker" onchange="location = this.value;">
			    <?php foreach ($limits as $limits) { ?>
			    <?php if ($limits['value'] == $limit) { ?>
			    <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
			    <?php } else { ?>
			    <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
			    <?php } ?>
			    <?php } ?>
			  </select>
			</div>
		      </div>


		<div class="row products product-layout">
			<div>
		    <?php 
				global $_button_cart, $_config;
				$_button_cart = $button_cart;

				$category_page_products_row = nico_get_config('category_page_products_row');
				if (empty($category_page_products_row)) $category_page_products_row = 3;

				include($nico_include_path . '/template/module/nico_product.tpl');
				foreach ($products as $product) { ?>
				<div class="col-md-<?php echo $category_page_products_row;?> prod">
					<?php nico_product($product);?>
				</div>
				<?php } ?>
			</div>	
		</div>	
		
		
		<?php echo $content_bottom; ?>
		
		  <?php if (!$products) { ?>
		  <div class="row">
			  <div class="col-md-12">
				  <div class="content registerbox"><?php echo $text_empty; ?></div>
				  <div class="buttons">
					<div class="right"><a href="<?php echo $continue; ?>" class="btn btn-primary button"><?php echo $button_continue; ?></a></div>
				  </div>
			</div>
		  </div>
		  <?php } ?>
		
		<?php if ($pagination) { ?>
		<div class="row pag">
			<div class="col-md-12">
				<div class="row">
				<?php echo $pagination; ?>
				</div>
			</div>
		</div>
		<?php } ?>
	</div>	
	<?php echo $column_right; ?></div>
</div>
<script>
var _nico_category_cols = 'col-md-<?php echo $category_page_products_row;?>';
</script>
<?php echo $footer; ?>
