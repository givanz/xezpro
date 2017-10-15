<?php
if (!function_exists("nico_get_config"))
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
if (!function_exists('nico_product')) {

    if (!function_exists('toFloat')) 
    {
		function toFloat($str)
		{
			return (float)trim(preg_replace("/([^0-9,\\.])/i", "", $str), ' .,');
		}
    }


    function nico_product($product)
    {
		global $_button_cart, $_config, $sale_badge_text, $new_product_days, $new_product_days_text, $most_viewed, $most_viewed_text;
		if (!$sale_badge_text) $sale_badge_text = nico_get_config('sale_badge_text');
		if (!$new_product_days) $new_product_days = nico_get_config('new_product_days');
		if (!$new_product_days_text) $new_product_days_text = nico_get_config('new_product_days_text');
		if (!$most_viewed) $most_viewed = nico_get_config('most_viewed');
		if (!$most_viewed_text) $most_viewed_text = nico_get_config('most_viewed_text');
    ?>
    <div class="product">
	   <div class="image<?php if (!empty($product['additional_image'])) {?> hover_img<?php }?>">

	  <?php 
		if (isset($product['_price']) && !empty($product['_price']))
		{
			$price = toFloat($product['_price']);
			$special = toFloat($product['_special']);
		} else
		{
			$price = toFloat($product['price']);
			$special = toFloat($product['special']);
		}
		
		if ($special && ($price > 0)) { ?>
		<span class="product_sale">
	    <?php if (!empty($sale_badge_text)) echo $sale_badge_text; 
		else 
		{
		    echo '-' . round((($price - $special) / $price) * 100) . '%';
		}?>
		</span>
	  <?php }
	  

	   if (isset($product['days_added']) && $product['days_added'] && ($product['days_added'] <= $new_product_days)) { ?>
		<span class="product_sale new">
		<?php if (!empty($new_product_days_text)) echo $new_product_days_text;?>
		</span>
	  <?php }
	  
	   if (isset($product['viewed']) && $product['viewed'] && ($product['viewed'] >= $most_viewed)) { ?>
		<span class="product_sale popular">
		<?php if (!empty($most_viewed_text)) echo $most_viewed_text;?>
		</span>
	  <?php }?>

			<?php if (isset($product['quantity'])) {
			  if ($product['quantity'] < 1) { ?>
				<div class="product_sale left"><?php if (isset($product['stock_status'])) echo $product['stock_status']; ?></div>
			<?php } }?>
			
		   <a href="<?php echo $product['href']; ?>">
			<img class="thumb" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" />
			<?php if (!empty($product['additional_image'])) {?><img  class="additional_image" src="<?php echo $product['additional_image']; ?>" alt="<?php echo $product['name']; ?>" /><?php } ?>
			</a>
			
			<div class="hover">
				 <div>
					 <a href="<?php echo $product['href']; ?>">
					   <?php
					  if (isset($product['quantity']) && $product['quantity'] <= 0) { ?>
					  <span class="add-to-cart"><?php if (isset($product['stock_status'])) echo $product['stock_status']; ?></span>
					  <?php } else { ?>
					  <span class="add-to-cart" onclick="return addToCart('<?php echo $product['product_id']; ?>'<?php if (isset($product['minimum'])) {?>, '<?php echo $product['minimum']; ?>'<?php }?>); return false"><i class="fa fa-shopping-cart"></i></span>
					  <?php }?>
					  <span class="quickview"><i class="fa fa-search "></i></span>
					 </a>
				 </div>
			 </div>
		 </div>

		 

	    <div class="actions clearfix">
		<div class="name"><div><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div></div>
		<div class="rating">
		  <?php for ($i = 1; $i <= 5; $i++) { ?>
		  <?php if ($product['rating'] < $i) { ?>
		  <span class="fa"><i class="fa fa-star"></i></span>
		  <?php } else { ?>
		  <span class="fa"><i class="fa fa-star star_rating"></i></span>
		  <?php } ?>
		  <?php } ?>
		</div>
		<div class="description"><?php if (isset($product['description'])) echo $product['description']; ?></div>				    
		<?php if ($product['price'] && ($price) > 0) { ?>
		<div class="price<?php if ($product['special']) { ?> price_sale<?php }?>">
		  <?php if (!$product['special']) { ?>
		  <p><?php echo $product['price']; ?></p>
		  <?php } else { ?>
		  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
		  <?php } ?>
		</div>
		<?php } ?>
		
		  <?php
		  if (isset($product['quantity']) && $product['quantity'] <= 0) { ?>
		  <button class="btn btn-primary btn-sm"><?php if (isset($product['stock_status'])) echo $product['stock_status']; ?></button>
		  <?php } else { ?>
		  <button class="btn btn-primary btn-sm" onclick="return addToCart('<?php echo $product['product_id']; ?>'<?php if (isset($product['minimum'])) {?>, '<?php echo $product['minimum']; ?>'<?php }?>);"><?php echo $_button_cart; ?></button>
		  <?php }?>
	    </div>
    </div>
    <?php
    }
}
