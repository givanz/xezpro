<?php 
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
		

		 <!-- p><a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a></p -->
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
		      
			<div class="row">
				<div class="col-md-12">
					<div class="cat_header">
						<h2><?php echo $heading_title; ?></h2>
					</div>

					<?php if ($categories) { ?>
					<div class="refine_categories">
					  <h3 class="refine"><?php echo $text_refine; ?></h3>
					  <?php if (count($categories) <= 5) { ?>
					  <div class="refine">
					<div><!-- class="col-sm-3"-->
					  <ul>
						<?php foreach ($categories as $category) { ?>
						<li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
						<?php } ?>
					  </ul>
					</div>
					  </div>
					  <?php } else { ?>
					  <div class="">
					<?php foreach (array_chunk($categories, ceil(count($categories) / 4)) as $categories) { ?>
					<div><!-- class="col-sm-3"-->
					  <ul>
						<?php foreach ($categories as $category) { ?>
						<li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
						<?php } ?>
					  </ul>
					</div>
					<?php } ?>
					  </div>
					  <?php } ?>
					  </div>	
					  <?php } ?>

				</div>
			</div>
		
		  <?php if ($thumb || $description) { ?>
		  <div class="row category-info">
		    <?php if ($thumb) { ?>
		    <div class="col-sm-2"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" class="img-thumbnail" /></div>
		    <?php } ?>
		    <?php if ($description) { ?>
		    <div class="col-sm-10"><?php echo $description; ?></div>
		    <?php } ?>
		  </div>
		  <?php } ?>
					      
		      

		

		<div class="row products product-layout">
			<div>
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

				include(DIR_TEMPLATE . $theme_directory . '/template/module/nico_product.tpl');
				foreach ($products as $product) { ?>
		  		<div class="<?php echo $cols;?> prod">
					<?php nico_product($product);?>
				</div>
				<?php } ?>
			</div>	
		</div>	
		
		
		<?php echo $content_bottom; ?>
		
		  <?php if (!$categories && !$products) { ?>
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
		<div class="pag clearfix">
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
var _nico_category_cols = '<?php echo $cols;?>';
</script>
<?php echo $footer; ?>
