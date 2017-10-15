<div class="row heading">
	<div class="col-md-12">
	    <div class="clearfix">
		<h2><?php echo $heading_title;?></h2>
	    </div>
	</div>
</div>

<div class="row">
	<?php foreach ($products as $product) {?>
		    <div class="col-md-4">
			    <div class="product">
					<?php /* if ($product['special']) { ?>
						<div class="product_sale">
						<?php if (isset($_nico_settings['settings']['sale_text'])) echo $_nico_settings['settings']['sale_text']; 
						else echo 'Sale';?>
						</div>
					<?php }*/ ?>
				    <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
					<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>				    
					
					<?php if ($product['price']) { ?>
					<div class="price<?php if ($product['special']) { ?> price_sale<?php }?>">
					  <?php if (!$product['special']) { ?>
					  <p><?php echo $product['price']; ?></p>
					  <?php } else { ?>
					  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
					  <?php } ?>
					</div>
					<?php } ?>

				  <div class="addcart">
					<input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button btn btn-small" />
				  </div>


				</div>
			</div>
      <?php } ?>
</div>
