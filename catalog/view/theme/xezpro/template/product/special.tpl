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
		<div class="row">
			<?php foreach ($products as $product) { ?>
		    <div class="col-md-<?php echo $column_left?4:3?>">
			    <div class="product">
				    <?php if ($product['special']) { ?><div class="product_sale"><?php if (isset($_nico_settings['settings']['sale_text']) && !empty($_nico_settings['settings']['sale_text'])) echo $_nico_settings['settings']['sale_text']; 
					else echo 'sale';?></div><?php } ?>
		
				    <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
				    <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>

					  <div class="price<?php if ($product['special']) { ?> price_sale<?php }?>">
						<?php if (!$product['special']) { ?>
						<?php echo $product['price']; ?>
						<?php } else { ?>
						<span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
						<?php } ?>
						<?php if ($product['tax']) { ?>
						<span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
						<?php } ?>
					  </div>
					
				    
				  <div class="addcart">
					<input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button btn btn-primary btn-small" />
				  </div>

				</div>
			</div>
			<?php } ?>
		</div>	
		
		
		
		<div class="row">
			<div class="col-md-12">
				<div class="row">
				<?php echo $pagination; ?>
				</div>
			</div>
		</div>
	</div>	
	</div>	
</div>
<?php echo $footer; ?>
