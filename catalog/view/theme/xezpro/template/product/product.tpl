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

$_head_append = '<meta property="og:image" content="'. $popup .'" />';
if ($opencart_version < 2000) $_head_append .= '<link rel="stylesheet" property="stylesheet" type="text/css" href="catalog/view/javascript/jquery/magnific/magnific-popup.css" media="screen" /><script type="text/javascript" src="catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js"></script>';

echo str_replace('</head>', $_head_append . '</head>', $header);//add facebook image preview
?>
<div class="container"  vocab="http://rdf.data-vocabulary.org/#">
    <div>
	<ul class="breadcrumb">
	<?php 
	$b_count = 0;
	foreach ($breadcrumbs as $breadcrumb) { 
	$b_count++;
	if ($breadcrumb['href'] && $breadcrumb['text'] && $b_count > 1) {?>
	<li typeof="v:Breadcrumb">
	    <a rel="v:url" property="v:title" href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a> 
	    <span class="divider"></span>
	</li>
	<?php } else { ?>
	<li>
	    <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a> 
	    <span class="divider"></span>
	</li>
	<?php } } ?>
	</ul>
   </div>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <div class="row product-info" itemscope itemtype="http://data-vocabulary.org/Product">
        <?php 
			$order_out_stock = nico_get_config('order_out_stock');
			$show_main_image_thumb = nico_get_config('show_main_image_thumb');
			$price_change_quantity = nico_get_config('price_change_quantity');
			$product_page_image_cols = nico_get_config('product_page_image_cols');
			$product_page_image_cols = empty($product_page_image_cols)?7:$product_page_image_cols;
			$class = 'col-md-' . $product_page_image_cols; 
		?>
        <div class="<?php echo $class; ?> col-sm-12 product-image">
          <?php if ($thumb || $images) { ?>
            <?php if ($thumb) { ?>
            <div class="image"><a class="cloud-zoom" id="zoom1" data-zoom="adjustX:0, adjustY:0" href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>"><img src="<?php echo $popup; ?>" itemprop="image" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a></div>
            <?php } ?>
            <?php if ($images) { ?>
	       <div class="image-additional">
				<ul class="slides">    
				<?php foreach ($images as $image) { ?>
				<li>
					<a class="cloud-zoom-gallery item <?php if (strpos($image['popup'], 'http') !== false && (strpos($image['popup'], HTTP_SERVER) === false && strpos($image['popup'], HTTPS_SERVER) === false)) echo 'mfp-iframe';?>"  href="<?php echo $image['popup']; ?>" data-zoom="useZoom:zoom1, smallImage:<?php echo $image['popup']; ?>" title=""><img src="<?php echo $image['thumb']; ?>" title="" alt="" /><img src="<?php echo $image['popup']; ?>" title="" alt="" class="popup" /></a>
				</li>
				<?php } if ($show_main_image_thumb != 1) {?>
				<li>
					<a class="cloud-zoom-gallery item <?php if (strpos($image['popup'], 'http') !== false && (strpos($image['popup'], HTTP_SERVER) === false && strpos($image['popup'], HTTPS_SERVER) === false)) echo 'mfp-iframe';?>"  href="<?php echo $popup; ?>" data-zoom="useZoom:zoom1, smallImage:<?php echo $popup; ?>" title=""> <img src="<?php echo $popup; ?>" title="" alt="" /></a>
				</li>
				<?php }?>
				</ul>
			</div>
            <?php } ?>
          <?php } ?>
	</div>
        <?php 
			$class = 'col-md-' . (12 - $product_page_image_cols); 
		?>
        <div class="<?php echo $class; ?> col-sm-12" id="product">
          <h1  itemprop="name"><?php echo $heading_title; ?></h1>
          <ul class="list-unstyled">
            <?php if ($manufacturer) { ?>
            <li><?php echo $text_manufacturer; ?> <a href="<?php echo $manufacturers; ?>" itemprop="brand"><?php echo $manufacturer; ?></a></li>
            <?php } ?>
            <li><?php echo $text_model; ?> <?php echo $model; ?></li>
            <?php if ($reward) { ?>
            <li><?php echo $text_reward; ?> <?php echo $reward; ?></li>
            <?php } ?>
          </ul>
          <?php
          if (!isset($_price))
		  {
			  $_price = trim(preg_replace("/([^0-9,\\.])/i", "", $price), ' .,');
		  }
		  
		  $__price = trim(preg_replace("/([^0-9,\\.])/i", "", $price), ' .,');
		  
		  if (!isset($_currency))
		  {
			  
			  $_currency = trim(preg_replace("/([0-9])/i", "", $price), ' .,');
		  } 

          if ($price) { ?>
          <ul class="list-unstyled" itemprop="offerDetails" itemscope="" itemtype="http://data-vocabulary.org/Offer">
            <?php if (!$special) { ?>
            <li><?php echo $text_stock; ?> <?php echo $stock; ?></li>
            <li>
			  <span itemprop="currency" class="hide"><?php echo $_config->get('config_currency');?></span>
			  <?php if (isset($_currency) && isset($_price) && $_currency && $_price) {?>
			  <?php if (!isset($currency_symbol_right) || empty($currency_symbol_right)) {?>
              <span class="currency">
  			   <?php 
					echo $_currency;
				?>
			  </span>
			  <?php }?>              <h2 class="price" itemprop="price" <?php if ($price_change_quantity != 1) {?>data-price="<?php  echo $_price;?>" data-currency="<?php echo $_config->get('config_currency');?>"<?php }?>> 
  			    <?php 
					echo $__price;
				?>
			  </h2>
			  <?php if (isset($currency_symbol_right) && !empty($currency_symbol_right)) {?>
              <span class="currency">
  			   <?php 
					echo $_currency;
				?>
			  </span>
			  <?php }?>
			  <?php } else { ?>
              <h2 class="price" itemprop="price">
  			    <?php 
					echo $price;
				?>
			  </h2>
			  <?php }?>	
            </li>
            <?php } else { ?>
            <li>
              <h2 class="price strike"><?php echo $price; ?></h3> <h2 class="price" itemprop="price" price="<?php echo $special;?>"><?php echo $special; ?></h2>
            </li>
            <?php } ?>
            <?php if ($tax) { ?>
            <li class="ex-tax-price"><?php echo $text_tax; ?> <?php echo $tax; ?></li>
            <?php } ?>
            <?php if ($points) { ?>
            <li><?php echo $text_points; ?> <?php echo $points; ?></li>
            <?php } ?>
            <?php if ($discounts) { ?>
            <li>
              <hr>
            </li>
            <?php foreach ($discounts as $discount) { ?>
            <li><?php if ($opencart_version < 2000) echo sprintf($text_discount, $discount['quantity'], $discount['price']); else  { echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; }?></li>
            <?php } ?>
            <?php } ?>
          </ul>
          <?php } ?>
          <div>
            <?php if ($options) {?>
            <hr>
            <h3><?php echo $text_option; ?></h3>
            <?php foreach ($options as $option) { 

            $option_values = isset($option['option_value'])?$option['option_value']:$option['product_option_value'];
            $opt_value = isset($option['option_value'])?$option['option_value']:$option['value'];
			?>
            <?php if ($option['type'] == 'select') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                <option value=""><?php echo $text_select; ?></option>
                <?php if (isset($option_values)) foreach ($option_values as $option_value) { ?>
                <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                <?php if ($option_value['price']) { ?>
                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                <?php } ?>
                </option>
                <?php } ?>
              </select>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'radio') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <div id="input-option<?php echo $option['product_option_id']; ?>">
                <?php if (isset($option_values)) foreach ($option_values as $option_value) { ?>
                <div class="radio">
                  <label>
                    <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                    <?php if ($option_value['image']) { ?>
                    <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> 
                    <?php } ?>                    
                    <?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                  </label>
                </div>
                <?php } ?>
              </div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'checkbox') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <div id="input-option<?php echo $option['product_option_id']; ?>">
                <?php if (isset($option_values)) foreach ($option_values as $option_value) { ?>
                <div class="checkbox">
                  <label>
                    <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                    <?php if (isset($option_value['image']) && $option_value['image']) { ?>
                    <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> 
                    <?php } ?>
                    <?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                  </label>
                </div>
                <?php } ?>
              </div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'image') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> image">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <div id="input-option<?php echo $option['product_option_id']; ?>">
                <?php if (isset($option_values)) foreach ($option_values as $option_value) { ?>
                <div class="radio">
                  <label>
                    <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                    <?php if (isset($option_value['image']) && $option_value['image']) {?>
		     <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" />
		     <?php }?>
		      &nbsp;<span><?php echo $option_value['name']; ?></span>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                  </label>
                </div>
                <?php } ?>
              </div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'text') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $opt_value; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'textarea') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $opt_value; ?></textarea>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'file') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
              <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'date') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group date">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php if (isset($opt_value)) echo $opt_value; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                <span class="input-group-btn input-group-addon">
                <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'datetime') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group datetime">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $opt_value; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                <span class="input-group-btn input-group-addon">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'time') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group time">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $opt_value; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                <span class="input-group-btn input-group-addon">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
            <?php } ?>
            <?php } ?>
            <?php } ?>
            <?php if (isset($profiles) && $profiles) { ?>
            <hr>
            <h3><?php echo $text_payment_profile ?></h3>
            <div class="form-group required">
              <select name="profile_id" class="form-control">
                <option value=""><?php echo $text_select; ?></option>
                <?php foreach ($profiles as $profile) { ?>
                <option value="<?php echo $profile['profile_id'] ?>"><?php echo $profile['name'] ?></option>
                <?php } ?>
              </select>
              <div class="help-block" id="profile-description"></div>
            </div>
            <?php } ?>
            <?php if (isset($recurrings) && $recurrings) { ?>
            <hr>
            <h3><?php echo $text_payment_recurring ?></h3>
            <div class="form-group required">
              <select name="recurring_id" class="form-control">
                <option value=""><?php echo $text_select; ?></option>
                <?php foreach ($recurrings as $recurring) { ?>
                <option value="<?php echo $recurring['recurring_id'] ?>"><?php echo $recurring['name'] ?></option>
                <?php } ?>
              </select>
              <div class="help-block" id="recurring-description"></div>
            </div>
            <?php } ?>

	      <?php if ($review_status) { ?>
	      <div class="rating">
			  <?php 
			  preg_match('@[\d\.\,]+@', $reviews, $matches);
			  $votes =  $matches[0];
			  if ($votes) {?>
			  <span itemprop="review" class="hidden" itemscope itemtype="http://data-vocabulary.org/Review-aggregate">
					<span itemprop="itemreviewed"><?php echo $heading_title; ?></span>
					<span itemprop="rating"><?php echo $rating;?></span>
					<span itemprop="votes"><?php echo $votes; ?></span>
			  </span>
			  <?php } ?>


		<?php $above_addcart = nico_get_modules('above_addcart');if($above_addcart) foreach ($above_addcart as $module) echo $module;?>
			  
		<p>
		  <?php for ($i = 1; $i <= 5; $i++) { ?>
		  <?php if ($rating < $i) { ?>
		  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
		  <?php } else { ?>
		  <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x star_rating"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
		  <?php } ?>
		  <?php } ?>
		  <span class="review_link">
		  <a href="" onclick="$('a[href=\'#tab-review\']').trigger('click');$('html, body').animate({scrollTop: $('#tab-review').offset().top}, 2000);return false;"><?php echo $reviews; ?></a> / <a href="" onclick="$('a[href=\'#tab-review\']').trigger('click');$('html, body').animate({scrollTop: $('#tab-review').offset().top}, 2000);return false;"><?php echo $text_write; ?></a>
		  </span>
		</p>



		<hr>

	      </div>
	      <?php } ?>
	      
		<!-- AddThis Button BEGIN -->
            <div class="addthis_toolbox addthis_default_style" data-url="<?php if (isset($share)) echo $share; ?>"><a class="addthis_button_facebook_like" fb:like:layout="button_count"></a> <a class="addthis_button_tweet"></a> <a class="addthis_button_pinterest_pinit"></a> <a class="addthis_counter addthis_pill_style"></a></div>
            <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-515eeaf54693130e"></script>
		<!-- AddThis Button END --> 

            <div class="form-group">

              <label class="control-label" for="input-quantity"><?php if (isset($entry_qty))echo $entry_qty; ?></label>&nbsp;
 
              <?php if (isset($quantity) && $quantity <= 0 && $order_out_stock == false) {?>
			  <button type="button" data-loading-text="<?php if (isset($text_loading)) echo $text_loading;else echo 'loading ...' ?>" class="btn btn-danger"><?php echo $stock_status; ?></button>
			  <?php } else { ?>
              
              <div class="quantity">
              <div class="input-group spinner">
				<div class="input-group-btn-vertical">
				  <button class="btn btn-default"><i class="fa fa-caret-down"></i></button>
					<input type="text" name="quantity" value="<?php echo $minimum; ?>" size="1" id="input-quantity" class="form-control">
				  <button class="btn btn-default"><i class="fa fa-caret-up"></i></button>
				</div>
			  </div>
			  </div>
              
              <button type="button" id="button-cart" data-loading-text="<?php if (isset($text_loading)) echo $text_loading;else echo 'loading ...' ?>" class="btn btn-primary button-cart"><?php echo $button_cart; ?></button>&nbsp;
              
              <a href="index.php?route=checkout/nicocheckout&amp;product_id=<?php echo $product_id; ?>" id="buynow" data-checkout="<?php if (nico_get_config('checkout')  == '1') echo 'nicocheckout'; else echo 'checkout'; ?>" data-loading-text="<?php if (isset($text_loading)) echo $text_loading;else echo 'loading ...' ?>" class="btn btn-primary buynow"><?php $buynow_text = nico_get_config('buynow_text');$buynow_text = isset($buynow_text[$_config->get('config_language')])?$buynow_text[$_config->get('config_language')]:$buynow_text['en'];if (!empty($buynow_text)) echo $buynow_text; else echo 'Buy now';?></a>
			  <?php }?>

              <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />&nbsp;

	      <div class="product_wish_compare">
		<button type="button" data-toggle="tooltip" class="btn btn-default" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product_id; ?>');"><i class="fa fa-heart"></i> <?php echo $button_wishlist; ?></button>
		<button type="button" data-toggle="tooltip" class="btn btn-default" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product_id; ?>');"><i class="fa fa-exchange"></i> <?php echo $button_compare; ?></button>
	      </div>

		<?php $below_addcart = nico_get_modules('below_addcart');if($below_addcart) foreach ($below_addcart as $module) echo $module;?>

            </div>
            <?php if ($minimum > 1) { ?><br/>
            <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
            <?php } ?>

		  <?php if ($tags) { ?>
		  <p id="product-tags"><?php echo $text_tags; ?>
			<?php for ($i = 0; $i < count($tags); $i++) { ?>
			<?php if ($i < (count($tags) - 1)) { ?>
			<a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
			<?php } else { ?>
			<a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
			<?php } ?>
			<?php } ?>
		  </p>
		  <?php } ?>
          </div>
	    
	    <?php
	    $product_page_tabs_location = nico_get_config('product_page_tabs_location');
	    $products_tabs = nico_get_modules('product_tabs');
	    if ((!isset($_GET['ajax']) && !isset($_POST['ajax'])) && ($product_page_tabs_location != '1')) {?></div><?php }
	    
	    $tabs = $tab_content = '';
	    if( $products_tabs && count($products_tabs) ) { 
		    foreach ($products_tabs as $module) 
		    {
			    $start = strpos($module, '<!-- tabs start -->');
			    $end = strpos($module, '<!-- tabs end -->');
			    
			    $tabs .= substr($module, $start, $end - $start);
			    
			    $start = strpos($module, '<!-- content start -->');
			    $end = strpos($module, '<!-- content end -->');
			    $tab_content .= substr($module, $start, $end - $start);
		    }
	    } ?>


      <br/>
	  <?php $above_description = nico_get_modules('above_desc');if($above_description) foreach ($above_description as $module) echo $module;?>
	  <div class="tabs tabs_product">
          <ul class="nav nav-tabs">
            <li class="active"><a href="#tab-description" data-toggle="tab"><?php echo $tab_description; ?></a></li>
            <?php if ($attribute_groups) { ?>
            <li><a href="#tab-specification" data-toggle="tab"><?php echo $tab_attribute; ?></a></li>
            <?php } ?>
            <?php if ($review_status) { ?>
            <li><a href="#tab-review" data-toggle="tab"><?php echo $tab_review; ?></a></li>
            <?php } ?>
	    <?php echo $tabs;?>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="tab-description" itemprop="description"><?php echo $description; ?></div>
            <?php if ($attribute_groups) { ?>
            <div class="tab-pane" id="tab-specification">
              <table class="table table-bordered">
                <?php foreach ($attribute_groups as $attribute_group) { ?>
                <thead>
                  <tr>
                    <td colspan="2"><strong><?php echo $attribute_group['name']; ?></strong></td>
                  </tr>
                </thead>
                <tbody>
                  <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                  <tr>
                    <td><?php echo $attribute['name']; ?></td>
                    <td><?php echo $attribute['text']; ?></td>
                  </tr>
                  <?php } ?>
                </tbody>
                <?php } ?>
              </table>
            </div>
            <?php } ?>
            <?php if ($review_status) { ?>
            <div class="tab-pane" id="tab-review">
              <form class="form-horizontal">
                <div id="review"></div>
                <h2><?php echo $text_write; ?></h2>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="name" value="<?php if (isset($customer_name)) echo $customer_name; ?>" id="input-name" class="form-control" />
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-review"><?php echo $entry_review; ?></label>
                  <div class="col-sm-10">
                    <textarea name="text" cols=10 rows=5 id="input-review" class="form-control"></textarea>
                    <div class="help-block"><?php echo $text_note; ?></div>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label"><?php echo $entry_rating; ?></label>
                  <div class="col-sm-10"><?php echo $entry_bad; ?>&nbsp;
                    <input type="radio" name="rating" value="1" />
                    &nbsp;
                    <input type="radio" name="rating" value="2" />
                    &nbsp;
                    <input type="radio" name="rating" value="3" />
                    &nbsp;
                    <input type="radio" name="rating" value="4" />
                    &nbsp;
                    <input type="radio" name="rating" value="5" />
                    &nbsp;<?php echo $entry_good; ?></div>
                </div>
			<?php 
			if (isset($captcha)) echo $captcha; //oc 2.1.x
			else 
			if (isset($site_key) && $site_key) //oc 2.0.3
			{?> 
				<div class="form-group">
                    <div class="col-sm-12">
                      <div class="g-recaptcha" data-sitekey="<?php echo $site_key; ?>"></div>
                    </div>
                </div>					
			<?php 
			} else  if (isset($entry_captcha))  // oc 2.0.1 - 1.5.6 
			{?>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-captcha"><?php if (isset($entry_captcha)) echo $entry_captcha; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="captcha" value="" id="input-captcha" class="form-control" />
					<br/>
                    <img src="<?php if ($opencart_version >= 2000) {?>index.php?route=tool/captcha<?php } else { ?>index.php?route=product/product/captcha<?php }?>" alt="" id="captcha" /></div>
                </div>
			<?php } ?>
                <div class="buttons">
                  <div class="pull-right">
                    <button type="button" id="button-review" data-loading-text="<?php if (isset($text_loading)) echo $text_loading;else echo 'loading ...' ?>" class="btn btn-primary"><?php echo $button_continue; ?></button>
                  </div>
                </div>
              </form>
            </div>
            <?php } ?>
	    <?php echo $tab_content;?>
          </div>
         </div>
      </div>
      <?php if ((isset($_GET['ajax']) || isset($_POST['ajax'])) || ($product_page_tabs_location == '1')) {?></div><?php } ?>
      <?php 
      if ($products && count($products) > 0) { 
      include_once(DIR_TEMPLATE . $theme_directory . '/template/module/nico_product.tpl');
	  ?>
      </div>
      <?php if ($product_page_tabs_location  == 1) {?>
	  <div>
	  <?php }?>
	  <div class="related-products col-sm-12">
	  <div class="heading title clearfix">
      <h2><?php if (isset($text_related)) echo $text_related;else echo $tab_related;?></h2>
      </div>
      <div class="row">
        <?php $i = 0; ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $cols = 'col-lg-6 col-md-6 col-sm-12 col-xs-12'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $cols = 'col-lg-4 col-md-4 col-sm-6 col-xs-12'; ?>
        <?php } else { ?>
        <?php $cols = 'col-lg-3 col-md-3 col-sm-6 col-xs-12'; ?>
        <?php } ?>
        <?php foreach ($products as $product) { ?>
	<div class="<?php echo $cols;?>">
		<?php nico_product($product);?>
	</div>
        <?php if (($column_left && $column_right) && ($i % 2 == 0)) { ?>
        <div class="clearfix visible-md visible-sm"></div>
        <?php } elseif (($column_left || $column_right) && ($i % 3 == 0)) { ?>
        <div class="clearfix visible-md"></div>
        <?php } elseif ($i % 4 == 0) { ?>
        <div class="clearfix visible-md"></div>
        <?php } ?>
        <?php $i++; ?>
        <?php } ?>
      </div>
      <?php if ($product_page_tabs_location  == 1) {?>
      </div>
      <?php } }?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<script>
<?php $product_page_image_gallery = nico_get_config('product_page_image_gallery');
if ($product_page_image_gallery == 'popup') 
{?>
nico_magnific_popup()
<?php } else { ?> 
nico_cloud_zoom();
<?php }?>
$('.date').datetimepicker({
	format:"Y-M-D",
//	pickTime: false
});

$('.datetime').datetimepicker({
	format:"Y-M-D hh:mm",
//	pickDate: true,
//	pickTime: true
});

$('.time').datetimepicker({
	format:"hh:mm",
//	pickDate: false
});
</script>
<?php echo $footer;
