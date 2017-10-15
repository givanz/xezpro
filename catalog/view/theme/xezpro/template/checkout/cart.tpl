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

echo $header; ?>
<div class="container" id="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($attention) { ?>
  <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
	<div class="cat_header">
	    <h2>	  
		<?php echo $heading_title; ?>
		<?php if ($weight) { ?>
		&nbsp;(<?php echo $weight; ?>)
		<?php } ?>
	    </h2>
	</div>

      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        <div class="table-responsive cart-info">
          <table class="table table-bordered">
            <thead>
              <tr>
                <th class="text-center"><?php echo $column_image; ?></th>
                <th class="text-left"><?php echo $column_name; ?></th>
                <th class="text-left"><?php echo $column_model; ?></th>
                <th class="text-left"><?php echo $column_quantity; ?></th>
                <th class="text-right"><?php echo $column_price; ?></th>
                <th class="text-right"><?php echo $column_total; ?></th>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($products as $product) { ?>
              <tr>
                <td class="text-center"><?php if ($product['thumb']) { ?>
                  <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail" /></a>
                  <?php } ?></td>
                <td class="text-left"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                  <?php if (!$product['stock']) { ?>
                  <span class="text-danger">***</span>
                  <?php } ?>
                  <?php if ($product['option']) { ?>
                  <?php foreach ($product['option'] as $option) { ?>
                  <br />
                  <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                  <?php } ?>
                  <?php } ?>
                  <?php if ($product['reward']) { ?>
                  <br />
                  <small><?php echo $product['reward']; ?></small>
                  <?php } ?>
                  <?php if (isset($product['recurring']) && $product['recurring']) { ?>
                  <br />
                  <span class="label label-info"><?php echo $text_recurring_item; ?></span> <small><?php echo $product['recurring']; ?></small>
                  <?php } ?></td>
                <td class="text-left"><?php echo $product['model']; ?></td>
                <td class="text-left"><div class="input-group btn-block" style="max-width: 200px;">
                    <input type="text" name="quantity[<?php if ($opencart_version < 2100) echo $product['key'];else echo $product['cart_id']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" class="form-control" />
                    <span class="input-group-btn">
                    <button type="submit" data-toggle="tooltip" title="<?php echo $button_update; ?>" class="btn btn-primary"><i class="fa fa-refresh"></i></button>
                    <a type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger" 
                    <?php /* onclick="cart.remove('<?php echo $product['key']; ?>');"*/?> <?php if ($opencart_version >= 2000) {?>onclick="cart.remove('<?php if ($opencart_version < 2100) echo $product['key'];else echo $product['cart_id']; ?>');return false;"<?php } else {?>href="<?php echo $product['remove']; ?>"<?php }?>><i class="fa fa-times-circle"></i></a></span></div></td>
                <td class="text-right"><?php echo $product['price']; ?></td>
                <td class="text-right"><?php echo $product['total']; ?></td>
              </tr>
              <?php } ?>
              <?php foreach ($vouchers as $vouchers) { ?>
              <tr>
                <td></td>
                <td class="text-left"><?php echo $vouchers['description']; ?></td>
                <td class="text-left"></td>
                <td class="text-left"><div class="input-group btn-block" style="max-width: 200px;">
                    <input type="text" name="" value="1" size="1" disabled="disabled" class="form-control" />
                    <span class="input-group-btn"><button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger" onclick="voucher.remove('<?php echo $vouchers['key']; ?>');"><i class="fa fa-times-circle"></i></button></span></div></td>
                <td class="text-right"><?php echo $vouchers['amount']; ?></td>
                <td class="text-right"><?php echo $vouchers['amount']; ?></td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
        </div>
      </form>
      
      <?php 
	  if ($opencart_version  >= 2000) {?>
	  <?php if ((isset($coupon) && $coupon) || (isset($voucher) && $voucher) || (isset($reward) && $reward) || (isset($shipping_status) && $shipping_status) || (isset($shipping) && $shipping)) { ?>
	  <h2><?php echo $text_next; ?></h2>
	  <p><?php echo $text_next_choice; ?></p>
	  <div class="panel-group" id="accordion"><?php echo $coupon; ?><?php echo $voucher; ?><?php echo $reward; ?><?php if (isset($shipping)) echo $shipping;else $shipping_status; ?></div>
	  <?php } } else {?>
	   
	  <?php if (isset($coupon_status)) { ?>
	  <table class="radio">
	  <?php if ($coupon_status) { ?>
	  <tr class="highlight">
	    <td><?php if ($next == 'coupon') { ?>
	      <input type="radio" name="next" value="coupon" id="use_coupon" checked="checked" />
	      <?php } else { ?>
	      <input type="radio" name="next" value="coupon" id="use_coupon" />
	      <?php } ?></td>
	    <td><label for="use_coupon"><?php echo $text_use_coupon; ?></label></td>
	  </tr>
	  <?php } ?>
	  <?php if ($voucher_status) { ?>
	  <tr class="highlight">
	    <td><?php if ($next == 'voucher') { ?>
	      <input type="radio" name="next" value="voucher" id="use_voucher" checked="checked" />
	      <?php } else { ?>
	      <input type="radio" name="next" value="voucher" id="use_voucher" />
	      <?php } ?></td>
	    <td><label for="use_voucher"><?php echo $text_use_voucher; ?></label></td>
	  </tr>
	  <?php } ?>
	  <?php if ($reward_status) { ?>
	  <tr class="highlight">
	    <td><?php if ($next == 'reward') { ?>
	      <input type="radio" name="next" value="reward" id="use_reward" checked="checked" />
	      <?php } else { ?>
	      <input type="radio" name="next" value="reward" id="use_reward" />
	      <?php } ?></td>
	    <td><label for="use_reward"><?php echo $text_use_reward; ?></label></td>
	  </tr>
	  <?php } ?>
	  <?php if (isset($shipping_status) && $shipping_status) { ?>
	  <tr class="highlight">
	    <td><?php if ($next == 'shipping') { ?>
	      <input type="radio" name="next" value="shipping" id="shipping_estimate" checked="checked" />
	      <?php } else { ?>
	      <input type="radio" name="next" value="shipping" id="shipping_estimate" />
	      <?php } ?></td>
	    <td><label for="shipping_estimate"><?php echo $text_shipping_estimate; ?></label></td>
	  </tr>
	  <?php } ?>
	</table>
	  <?php }?>
	  
	<div class="cart-module">
	<div id="coupon" class="content loginbox" style="display: <?php echo ($next == 'coupon' ? 'block' : 'none'); ?>;">
	  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
	    <div class="form-group row">
		    <label for="coupon" class="control-label col-md-4"><?php echo $entry_coupon; ?>:<span class="required">*</span></label>
		    <div class="col-md-5">
			    <input type="text" name="coupon" class="form-control" value="<?php echo $coupon; ?>" />
			    <input type="hidden" name="next" value="button" />
		    </div>
		    <div class="col-md-3">
			<input type="submit" value="<?php echo $button_coupon; ?>" class="btn btn-primary" />
		    </div>
	    </div>
	  </form>
	</div>
       <div id="voucher" class="content loginbox" style="display: <?php echo ($next == 'voucher' ? 'block' : 'none'); ?>;">
	  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
	    <div class="form-group row">
		    <label for="coupon" class="control-label col-md-4"><?php echo $entry_voucher; ?>:<span class="required">*</span></label>
		    <div class="col-md-5">
			    <input type="text" name="voucher" class="form-control" value="<?php echo $voucher; ?>" />
			    <input type="hidden" name="next" value="button" />
		    </div>
		    <div class="col-md-3">
			<input type="submit" value="<?php echo $button_voucher; ?>" class="btn btn-primary" />
		    </div>
	    </div>
	  </form>
	</div>    

	<div id="reward" class="content  loginbox" style="display: <?php echo ($next == 'reward' ? 'block' : 'none'); ?>;">
	  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
	    <?php echo $entry_reward; ?>&nbsp;
	    <input type="text" name="reward" value="<?php echo $reward; ?>" />
	    <input type="hidden" name="next" value="reward" />
	    &nbsp;
	    <input type="submit" value="<?php echo $button_reward; ?>" class="btn btn-primary" />
	  </form>
	</div>
	
	<div id="shipping" class="content loginbox" style="display: <?php echo ($next == 'shipping' ? 'block' : 'none'); ?>;">
	
	  <p><?php if (isset($text_shipping)) echo $text_shipping;else if (isset($text_shipping_detail)) echo $text_shipping_detail; ?></p>
      <form class="form-horizontal">
        <div class="form-group required">
          <label class="col-sm-2 control-label" for="input-country"><?php echo $entry_country; ?></label>
          <div class="col-sm-10">
            <select name="country_id" id="input-country" class="form-control">
              <option value=""><?php echo $text_select; ?></option>
              <?php foreach ($countries as $country) { ?>
              <?php if ($country['country_id'] == $country_id) { ?>
              <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
          </div>
        </div>
        <div class="form-group required">
          <label class="col-sm-2 control-label" for="input-zone"><?php echo $entry_zone; ?></label>
          <div class="col-sm-10">
            <select name="zone_id" id="input-zone" class="form-control">
            </select>
          </div>
        </div>
        <div class="form-group required">
          <label class="col-sm-2 control-label" for="input-postcode"><?php echo $entry_postcode; ?></label>
          <div class="col-sm-10">
            <input type="text" name="postcode" value="<?php echo $postcode; ?>" placeholder="<?php echo $entry_postcode; ?>" id="input-postcode" class="form-control" />
          </div>
        </div>
        <input type="button" value="<?php echo $button_quote; ?>" id="button-quote" data-loading-text="<?php echo isset($text_loading)?$text_loading:'Loading...'; ?>" class="btn btn-primary" />
      </form>
	
	</div>
      </div>
       
	    <script type="text/javascript"><!--
	    $('input[name=\'next\']').bind('click', function() {
		    $('.cart-module > div').hide();
		    
		    $('#' + this.value).show();
	    });
	    //--></script>
	    <?php if (isset($shipping_status) && $shipping_status) { ?>
	    <script type="text/javascript"><!--
	    $('#button-quote').bind('click', function() {
		    $.ajax({
			    url: 'index.php?route=checkout/cart/quote',
			    type: 'post',
			    data: 'country_id=' + $('select[name=\'country_id\']').val() + '&zone_id=' + $('select[name=\'zone_id\']').val() + '&postcode=' + encodeURIComponent($('input[name=\'postcode\']').val()),
			    dataType: 'json',		
			    beforeSend: function() {
				    $('#button-quote').attr('disabled', true);
				    $('#button-quote').after('<span class="wait">&nbsp;<img src="catalog/view/theme/<?php echo $theme_name;?>/img/loading.gif" alt="" /></span>');
			    },
			    complete: function() {
				    $('#button-quote').attr('disabled', false);
				    $('.wait').remove();
			    },		
			    success: function(json) {
				    $('.success, .warning, .attention, .error').remove();			
							    
				    if (json['error']) {
					    if (json['error']['warning']) {
						    $('#notification').html('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/<?php echo $theme_name;?>/img/close.png" alt="" class="close" /></div>');
						    
						    $('.warning').fadeIn('slow');
						    
						    $('html, body').animate({ scrollTop: 0 }, 'slow'); 
					    }	
								    
					    if (json['error']['country']) {
						    $('select[name=\'country_id\']').after('<span class="error">' + json['error']['country'] + '</span>');
					    }	
					    
					    if (json['error']['zone']) {
						    $('select[name=\'zone_id\']').after('<span class="error">' + json['error']['zone'] + '</span>');
					    }
					    
					    if (json['error']['postcode']) {
						    $('input[name=\'postcode\']').after('<span class="error">' + json['error']['postcode'] + '</span>');
					    }					
				    }
				    
				    if (json['shipping_method']) {
					    html  = '<h2><?php echo $text_shipping_method; ?></h2>';
					    html += '<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">';
					    html += '  <table class="radio">';
					    
					    for (i in json['shipping_method']) {
						    html += '<tr>';
						    html += '  <td colspan="3"><b>' + json['shipping_method'][i]['title'] + '</b></td>';
						    html += '</tr>';
					    
						    if (!json['shipping_method'][i]['error']) {
							    for (j in json['shipping_method'][i]['quote']) {
								    html += '<tr class="highlight">';
								    
								    if (json['shipping_method'][i]['quote'][j]['code'] == '<?php echo $shipping_method; ?>') {
									    html += '<td><input type="radio" name="shipping_method" value="' + json['shipping_method'][i]['quote'][j]['code'] + '" id="' + json['shipping_method'][i]['quote'][j]['code'] + '" checked="checked" /></td>';
								    } else {
									    html += '<td><input type="radio" name="shipping_method" value="' + json['shipping_method'][i]['quote'][j]['code'] + '" id="' + json['shipping_method'][i]['quote'][j]['code'] + '" /></td>';
								    }
									    
								    html += '  <td><label for="' + json['shipping_method'][i]['quote'][j]['code'] + '">' + json['shipping_method'][i]['quote'][j]['title'] + '</label></td>';
								    html += '  <td style="text-align: right;"><label for="' + json['shipping_method'][i]['quote'][j]['code'] + '">' + json['shipping_method'][i]['quote'][j]['text'] + '</label></td>';
								    html += '</tr>';
							    }		
						    } else {
							    html += '<tr>';
							    html += '  <td colspan="3"><div class="error">' + json['shipping_method'][i]['error'] + '</div></td>';
							    html += '</tr>';						
						    }
					    }
					    
					    html += '  </table>';
					    html += '  <br />';
					    html += '  <input type="hidden" name="next" value="shipping" />';
					    
					    <?php if ($shipping_method) { ?>
					    html += '  <input type="submit" value="<?php echo $button_shipping; ?>" id="button-shipping" class="btn btn-primary" />';	
					    <?php } else { ?>
					    html += '  <input type="submit" value="<?php echo $button_shipping; ?>" id="button-shipping" class="btn btn-primary" disabled="disabled" />';	
					    <?php } ?>
								    
					    html += '</form>';
					    
					    $.colorbox({
						    overlayClose: true,
						    opacity: 0.5,
						    width: '600px',
						    height: '400px',
						    href: false,
						    html: html
					    });
					    
					    $('input[name=\'shipping_method\']').bind('change', function() {
						    $('#button-shipping').attr('disabled', false);
					    });
				    }
			    }
		    });
	    });
	    //--></script> 
	    <script type="text/javascript"><!--
	    $('select[name=\'country_id\']').bind('change', function() {
		    $.ajax({
			    url: 'index.php?route=checkout/cart/country&country_id=' + this.value,
			    dataType: 'json',
			    beforeSend: function() {
				    $('select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/<?php echo $theme_name;?>/img/loading.gif" alt="" /></span>');
			    },
			    complete: function() {
				    $('.wait').remove();
			    },			
			    success: function(json) {
				    if (json['postcode_required'] == '1') {
					    $('#postcode-required').show();
				    } else {
					    $('#postcode-required').hide();
				    }
				    
				    html = '<option value=""><?php echo $text_select; ?></option>';
				    
				    if (json['zone'] && json['zone'] != '') {
					    for (i = 0; i < json['zone'].length; i++) {
					    html += '<option value="' + json['zone'][i]['zone_id'] + '"';
					    
						    if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
						    html += ' selected="selected"';
					    }
		    
					    html += '>' + json['zone'][i]['name'] + '</option>';
					    }
				    } else {
					    html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
				    }
				    
				    $('select[name=\'zone_id\']').html(html);
			    },
			    error: function(xhr, ajaxOptions, thrownError) {
				    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			    }
		    });
	    });

	    $('select[name=\'country_id\']').trigger('change');
	    //--></script>
	    <?php } ?>      
      <?php }?>      
      <br />
      <div class="row">
		<div class="col-md-12">
        <div class="total-table">
          <table class="table">
            <?php foreach ($totals as $total) { ?>
            <tr>
              <td class="text-right"><strong><?php echo $total['title']; ?>:</strong></td>
              <td class="text-right"><?php echo $total['text']; ?></td>
            </tr>
            <?php } ?>
          </table>
        </div>
       </div>
      </div>
      <div class="buttons">
        <div class="pull-left"><a href="<?php echo $continue; ?>" class="btn btn-default"><?php echo $button_shopping; ?></a></div>
        <div class="pull-right"><a href="<?php if (nico_get_config('checkout')  == '1') echo str_replace('/checkout', '/nicocheckout', $checkout); else echo $checkout; ?>" class="btn btn-primary"><?php echo $button_checkout; ?></a></div>
      </div>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?> 
