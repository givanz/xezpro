<!--cols:<?php if (isset($grid_cols) && $grid_cols) echo $grid_cols + $grid_offset;else echo 12;?>   -->
<div class="<?php if (isset($grid_cols) &&$grid_cols) {?>col-md-<?php echo $grid_cols;}?> <?php if (isset($grid_offset) && $grid_offset) {?>col-md-offset-<?php echo $grid_offset;}?> <?php if (isset($grid_padding) && $grid_padding) {?>no_padding<?php if (isset($grid_padding) && $grid_padding == 2) echo 'left';else if (isset($grid_padding) && $grid_padding == 3) echo 'right'; }?>">
<?php
$module_id = 'prod_' . $module_id;
$cols = 'col-xs-' . $cols_xs . ' col-sm-' . $cols_sm . ' col-md-' . $cols_md . ' col-lg-' . $cols_lg;

global $_button_cart, $_config, $_config, $nico_include_path;
if(!isset($_config)) $_config =  $this->registry->get('config');
$theme_name = $_config->get('config_template');
$_button_cart = $button_cart;

if (!isset($nico_include_path))
{
	$nico_include_path = __DIR__. '/../../';
	//vqmod changes paths and the above path fails, check other paths
	if (!file_exists($nico_include_path . 'nico_theme_editor/common.inc')) 
	{
		$_config =  $this->registry->get('config');
		$nico_include_path = DIR_TEMPLATE . '/' . $_config->get('config_template') . '/';
		
		if (!file_exists($nico_include_path . '/nico_theme_editor/common.inc')) $nico_include_path = dirname(__FILE__) . '/../../';
	}

	if (file_exists($nico_include_path . 'nico_theme_editor/common.inc')) require_once($nico_include_path . 'nico_theme_editor/common.inc');
}

require_once($nico_include_path . 'template/module/nico_product.tpl');

switch ($type)
{
    /* ------------------------------ grid ----------------------*/
    case 'filter':
?>  
	<div class="heading">
		<?php if ($title) {?><h2><?php echo $title;?></h2><?php }?>
		<ol class="filters <?php echo $module_id;?>">
		  <?php foreach ($products as $nr => $section_products) {?>
		<li data-filter="<?php echo $nr;?>"><?php echo $section[$nr]['title'];?></li>
		<?php foreach ($section_products as $product) 
		{ 
			$prod_filters[$product['product_id']][] = $nr;
			$unique_products[$product['product_id']] = $product;
		}?>
		  <?php } if (isset($unique_products)) $unique_products = array_reverse($unique_products);?>
		</ol> 
	</div>
	
    <div class="grid" id="<?php echo $module_id;?>">
	<?php if (isset($unique_products)) foreach ($unique_products as $product) {?>
	    <div class="<?php echo $cols;?> prod" data-filter-class="[<?php echo implode(",", $prod_filters[$product['product_id']]);?>]">
		<?php nico_product($product);?>
	    </div>
	<?php } ?>
	</div>
<?php 
nico_add_script('catalog/view/theme/' . $theme_name . '/js/jquery.wookmark.js');
nico_add_js('nico_grid(\''. $module_id .'\');');
?>		
<?php
    break;
    /* ------------------------------ grid ----------------------*/
    case 'grid':
?>
<div class="heading clearfix">
<?php if ($title) {?><h2><?php echo $title;?></h2><?php }?>
</div>

<div class="row product-grid">
    <?php foreach ($products as $nr => $section_products) {?>
	<?php foreach ($section_products as $product) {?>
		<div class="<?php echo $cols;?> prod">
			<?php nico_product($product);?>
		    </div>
    <?php } ?>
  <?php } ?>
</div>
<?php
    break;
    /* ------------------------------ list ----------------------*/
    case 'list':
?>
<?php if ($title) {?>
<div class="heading clearfix">
<h2><?php echo $title;?></h2>
</div>
<?php }?>
<div class="row products product-layout">
	<div class="product-list">
    <?php foreach ($products as $nr => $section_products) {?>
	<?php foreach ($section_products as $product) {?>
		<div class="<?php echo $cols;?> prod">
			<?php nico_product($product);?>
		    </div>
    <?php } ?>
  <?php } ?>
  </div>
</div>
<?php
    break;
    /* ------------------------------ tabs ----------------------*/
    case 'tabs':
?>
<div class="tabs">
<ul class="nav nav-tabs" id="<?php echo $module_id;?>">
  <?php foreach ($products as $nr => $section_products) {?>
	<li><a href="#tab-<?php echo $module_id . '-' . $nr;?>" data-toggle="tab"><?php echo $section[$nr]['title'];?></a></li>
  <?php } ?>
</ul>
<div class="tab-content">
  <?php foreach ($products as $nr => $section_products) {?>
	<div class="tab-pane fade in" id="tab-<?php echo $module_id . '-' . $nr;?>">
	    <?php foreach ($section_products as $product) {?>
	    <div class="<?php echo $cols;?> prod">
	    <?php nico_product($product);?>
	    </div>
	    <?php }?>
	</div>
 <?php } ?>
</div>
</div>
<?php 
//nico_add_style('catalog/view/theme/' . $theme_name . '/css/flexslider.css');
//nico_add_script('catalog/view/theme/' . $theme_name . '/js/jquery.flexslider.js');
nico_add_js('nico_carousel(\''. $module_id .'\',' . $cols_xs .' ,'. $cols_sm .',' . $cols_md .',' . $cols_lg. ');');
?>
<script>
jQuery(document).ready(function() 
{
    $('#<?php echo $module_id;?> a').click(function (e) {
	    e.preventDefault();
	    $(this).tab('show');
    });
    $('#<?php echo $module_id;?> a:first').tab('show');
});
</script>
<?php
    break;
    /* ------------------------------ carousel ----------------------*/
    case 'carousel':
?>
<?php if (isset($show_cover) && $show_cover == 1) {?>
	<div class="products_cover col-md-3 <?php echo $cover_text_color;?> <?php echo $cover_alignment;?>">
		<?php if ($cover_background_image) {?><img src="<?php echo $cover_background_image;?>"><?php }?>
		<div>
			<div>
			<div>
				<div><div></div></div>
				<?php if ($cover_title) {?><h3><?php echo $cover_title;?></h3><?php }?>
				<?php if ($cover_text) {?><p><?php echo $cover_text;?></p><?php }?>
				<?php if ($cover_button) {?><a href="<?php echo $cover_url;?>"><?php echo $cover_button;?></a><?php }?>
			</div>
			</div>
		</div>
	</div>

	<div class="products_cover_content col-md-9">
<?php }?>
<?php if ($title) {?>
<div class="heading clearfix">
<h2><?php echo $title;?></h2>
</div>
<?php }?>
<div class="carousel" id="<?php echo $module_id;?>">
    <div>
	<ul class="slides">    
	<?php foreach ($products as $nr => $section_products) {?>
		<?php foreach ($section_products as $product) {?>
		    <li>
			<div class="prod">
				<?php nico_product($product);?>
			</div>
			</li>
	    <?php } ?>
	  <?php } ?>
       </ul>
    </div>
</div>

<?php if (isset($show_cover) && $show_cover == 1) {?></div><?php }?>
<?php 
//nico_add_style('catalog/view/theme/' . $theme_name . '/css/flexslider.css');
//nico_add_script('catalog/view/theme/' . $theme_name . '/js/jquery.flexslider.js');
nico_add_js('nico_carousel(\''. $module_id .'\',' . $cols_xs .' ,'. $cols_sm .',' . $cols_md .',' . $cols_lg. ');');
?>
<?php
    break;
    /* ------------------------------ tabs_carousel ----------------------*/
    case 'tabs_carousel':
?>
<?php if (isset($show_cover) && $show_cover == 1) {?>
	<div class="products_cover col-md-3 <?php echo $cover_text_color;?> <?php echo $cover_alignment;?>">
		<?php if ($cover_background_image) {?><img src="<?php echo $cover_background_image;?>"><?php }?>
		<div>
			<div>
			<div>
				<div><div></div></div>
				<?php if ($cover_title) {?><h3><?php echo $cover_title;?></h3><?php }?>
				<?php if ($cover_text) {?><p><?php echo $cover_text;?></p><?php }?>
				<?php if ($cover_button) {?><a href="<?php echo $cover_url;?>"><?php echo $cover_button;?></a><?php }?>
			</div>
			</div>
		</div>
	</div>

	<div class="products_cover_content col-md-9">
<?php }?>
<div class="tabs">
<ul class="nav nav-tabs" id="<?php echo $module_id;?>_tabs">
  <?php foreach ($products as $nr => $section_products) {?>
	<li><a href="#tab-<?php echo $module_id . '-' . $nr;?>" data-toggle="tab"><?php echo $section[$nr]['title'];?></a></li>
  <?php } ?>
</ul>

<div class="tab-content" id="<?php echo $module_id;?>">
  <?php foreach ($products as $nr => $section_products) {?>
	<div class="tab-pane" id="tab-<?php echo $module_id . '-' . $nr;?>">
		<div class="carousel">
		    <div>
			<ul class="slides">    
				<?php foreach ($section_products as $product) {?>
				    <li  class="prod">
					<div>
						<?php nico_product($product);?>
					</div>
				    </li>
			  <?php } ?>
		       </ul>
		    </div>
		</div>
	</div>
    <?php } ?>
</div>
</div>
<?php if (isset($show_cover) && $show_cover == 1){?></div><?php }?>
<?php 
//nico_add_style('catalog/view/theme/' . $theme_name . '/css/flexslider.css');
//nico_add_script('catalog/view/theme/' . $theme_name . '/js/jquery.flexslider.js');
nico_add_js('nico_tabs_carousel(\''. $module_id .'\',' . $cols_xs .' ,'. $cols_sm .',' . $cols_md .',' . $cols_lg. ');');
?>
<?php    
    break;
}
?>
</div>
