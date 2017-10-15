<?php 
$nico_include_path = __DIR__. '/../../';
$_config =  $this->registry->get('config');
$theme_name = $_config->get('config_template');

//vqmod changes paths and the above path fails, check other paths
if (!file_exists($nico_include_path . 'nico_theme_editor/common.inc')) 
{
	$_config =  $this->registry->get('config');
	$nico_include_path = DIR_TEMPLATE . '/' . $theme_name . '/';
	
	if (!file_exists($nico_include_path . '/nico_theme_editor/common.inc')) $nico_include_path = dirname(__FILE__) . '/../../';
}

if (file_exists($nico_include_path . 'nico_theme_editor/common.inc')) require_once($nico_include_path . 'nico_theme_editor/common.inc');
global $_config, $opencart_version;
$opencart_version = (int)str_replace('.','',VERSION);
echo $header; 
?>

<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>


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
			<div class="col-md-12">
			  <p class="loginbox"><?php echo $text_account_already; ?> <?php echo $text_signup; ?></p>

			  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
				
				
				<div class="row">
					<div class="col-md-6">
						<h2><?php echo $text_your_details; ?></h2>
					<div class="registerbox">
				
						<div class="form-group">
							<?php if ($error_firstname) { ?>
							<div class="row">
								<span class="error col-md-12"><?php echo $error_firstname; ?></span>
							</div>
							<?php } ?>
							<label class="control-label col-md-4" for="firstname"><?php echo $entry_firstname; ?><span class="required">*</span></label>

							<div class="col-md-8">
								<input type="text" class="form-control" name="firstname" value="<?php echo $firstname; ?>">
							</div>
						</div>

						<div class="form-group">
							<?php if ($error_lastname) { ?>
							<div class="row">
								<span class="error col-md-12"><?php echo $error_lastname; ?></span>
							</div>
							<?php } ?>

							<label class="control-label col-md-4" for="lastname"><?php echo $entry_lastname; ?><span class="required">*</span></label>

							<div class="col-md-8">
								<input type="text" class="form-control" name="lastname" value="<?php echo $lastname; ?>">
							</div>
						</div>


						<div class="form-group">
							<?php if ($error_email) { ?>
							<div class="row">
								<span class="error col-md-12"><?php echo $error_email; ?></span>
							</div>
							<?php } ?>

							<label class="control-label col-md-4" for="email"><?php echo $entry_email; ?><span class="required">*</span></label>

							<div class="col-md-8">
								<input type="text" class="form-control" name="email" value="<?php if (isset($email) && !empty($email)) echo $email;else if (isset($_REQUEST['email'])) echo $_REQUEST['email'];?>">
							</div>
						</div>
					
						<div class="form-group">
							<?php if ($error_telephone) { ?>
							<div class="row">
								<span class="error col-md-12"><?php echo $error_telephone; ?></span>
							</div>
							<?php } ?>

							<label class="control-label col-md-4" for="telephone"><?php echo $entry_telephone; ?><span class="required">*</span></label>

							<div class="col-md-8">
								<input type="text" class="form-control" name="telephone" value="<?php echo $telephone; ?>">
							</div>
						</div>
						
						<div class="form-group">
							<label class="control-label col-md-4" for="fax"><?php echo $entry_fax; ?>c</label>
							<div class="col-md-8">
								<input type="text" class="form-control" name="fax" value="<?php echo $fax; ?>">
							</div>
						</div>
				</div>
				
				

				<h2><?php echo $text_payment; ?></h2>
				<div class="registerbox">
					<div class="form-group">
						<label class="control-label col-md-4" for="tax"><?php echo $entry_tax; ?></label>

						<div class="col-md-8">
							<input type="text" class="form-control" name="tax" value="<?php echo $tax; ?>">
						</div>
					</div>		

					<div class="form-group">
						<label class="control-label col-md-4" for="tax"><?php echo $entry_payment; ?></label>

						<div class="col-md-8">

						   <?php if ($payment == 'cheque') { ?>
						  <input type="radio" name="payment" value="cheque" id="cheque" checked="checked" />
						  <?php } else { ?>
						  <input type="radio" name="payment" value="cheque" id="cheque" />
						  <?php } ?>
						  <label for="cheque"><?php echo $text_cheque; ?></label>
						  <?php if ($payment == 'paypal') { ?>
						  <input type="radio" name="payment" value="paypal" id="paypal" checked="checked" />
						  <?php } else { ?>
						  <input type="radio" name="payment" value="paypal" id="paypal" />
						  <?php } ?>
						  <label for="paypal"><?php echo $text_paypal; ?></label>
						  <?php if ($payment == 'bank') { ?>
						  <input type="radio" name="payment" value="bank" id="bank" checked="checked" />
						  <?php } else { ?>
						  <input type="radio" name="payment" value="bank" id="bank" />
						  <?php } ?>
						  <label for="bank"><?php echo $text_bank; ?>
							
						</div>
					</div>	
					
					
					<div class="form-group">
						<label class="control-label col-md-4" for="tax"><?php echo $entry_tax; ?></label>

						<div class="col-md-8">
							<input type="text" class="form-control" name="tax" value="<?php echo $tax; ?>">
						</div>
					</div>	
					
					
					<div id="payment-cheque" class="payment">
						<div class="form-group">
							<label class="control-label col-md-4" for="cheque"><?php echo $entry_cheque; ?></label>

							<div class="col-md-8">
								<input type="text" class="form-control" name="cheque" value="<?php echo $cheque; ?>">
							</div>
						</div>	
					</div>
					
					<div class="payment" id="payment-paypal">
						<div class="form-group">
							<label class="control-label col-md-4" for="cheque"><?php echo $entry_paypal; ?></label>

							<div class="col-md-8">
								<input type="text" class="form-control" name="paypal" value="<?php echo $paypal; ?>">
							</div>
						</div>							
					</div>
					
					
					<div id="payment-bank" class="payment">
						<div class="form-group">
							<label class="control-label col-md-4" for="cheque"><?php echo $entry_bank_name; ?></label>

							<div class="col-md-8">
								<input type="text" class="form-control" name="bank_name" value="<?php echo $bank_name; ?>">
							</div>
						</div>							

						<div class="form-group">
							<label class="control-label col-md-4" for="cheque"><?php echo $entry_bank_swift_code; ?></label>

							<div class="col-md-8">
								<input type="text" class="form-control" name="bank_swift_code" value="<?php echo $bank_swift_code; ?>">
							</div>
						</div>							

						<div class="form-group">
							<label class="control-label col-md-4" for="cheque"><?php echo $entry_bank_account_name; ?></label>

							<div class="col-md-8">
								<input type="text" class="form-control" name="bank_account_name" value="<?php echo $bank_account_name; ?>">
							</div>
						</div>	
						
						
						<div class="form-group">
							<label class="control-label col-md-4" for="cheque"><?php echo $entry_bank_branch_number; ?></label>

							<div class="col-md-8">
								<input type="text" class="form-control" name="bank_branch_number" value="<?php echo $bank_branch_number; ?>">
							</div>
						</div>	
						
						
						<div class="form-group">
							<label class="control-label col-md-4" for="cheque"><?php echo $entry_bank_account_number; ?></label>

							<div class="col-md-8">
								<input type="text" class="form-control" name="bank_account_number" value="<?php echo $bank_account_number; ?>">
							</div>
						</div>	
				</div>
			</div>
		</div>
					
				
				
					<div class="col-md-6">
						<h2><?php echo $text_your_address; ?></h2>

						<div class="registerbox">
						
						<div class="form-group">
							<label class="control-label col-md-4" for="company"><?php echo $entry_company; ?></label>
							<div class="col-md-8">
								<input type="text" class="form-control" name="company" value="<?php echo $company; ?>">
							</div>
						</div>


						<div class="form-group">
							<label class="control-label col-md-4" for="company"><?php echo $entry_website; ?></label>
							<div class="col-md-8">
								<input type="text" class="form-control" name="website" value="<?php echo $website; ?>">
							</div>
						</div>						
						

						<div class="form-group">
							<?php if ($error_address_1) { ?>
							<div class="row">
								<span class="error col-md-12"><?php echo $error_address_1; ?></span>
							</div>
							<?php } ?>

							<label class="control-label col-md-4" for="address_1"><?php if (isset($entry_address_1)) echo $entry_address_1; ?><span class="required">*</span></label>

							<div class="col-md-8">
								<input type="text" class="form-control" name="address_1" value="<?php echo $address_1; ?>">
							</div>
						</div>

						<div class="form-group">
							<label class="control-label col-md-4" for="address_2"><?php if (isset($entry_address_2)) echo $entry_address_2; ?></label>
							<div class="col-md-8">
								<input type="text" class="form-control" name="address_2" value="<?php echo $address_2; ?>">
							</div>
						</div>
						
						<div class="form-group">
							<?php if ($error_city) { ?>
							<div class="row">
								<span class="error col-md-12"><?php echo $error_city; ?></span>
							</div>
							<?php } ?>

							<label class="control-label col-md-4" for="city"><?php if (isset($entry_city)) echo $entry_city; ?><span class="required">*</span></label>

							<div class="col-md-8">
								<input type="text" class="form-control" name="city" value="<?php echo $city; ?>">
							</div>
						</div>
						
						<div class="form-group">
							<?php if ($error_postcode) { ?>
							<div class="row">
								<span class="error col-md-12"><?php echo $error_postcode; ?></span>
							</div>
							<?php } ?>
							<label class="control-label col-md-4" for="postcode"><?php if (isset($entry_postcode)) echo $entry_postcode; ?><span class="required">*</span></label>

							<div class="col-md-8">
								<input type="text" class="form-control" name="postcode" value="<?php echo $postcode; ?>">
							</div>
						</div>
						
						<div class="form-group">
							<?php if ($error_country) { ?>
							<div class="row">
								<span class="error col-md-12"><?php echo $error_country; ?></span>
							</div>
							<?php } ?>
							<label class="control-label col-md-4" for="country_id"><?php if (isset($entry_country)) echo $entry_country; ?><span class="required">*</span></label>

							<div class="col-md-8">
								<select name="country_id"  name="country_id">
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
						
						<div class="form-group">
							<?php if ($error_zone) { ?>
							<div class="row">
								<span class="error col-md-12"><?php echo $error_zone; ?></span>
							</div>
							<?php } ?>

							<label class="control-label col-md-4" for="zone_id"><?php if (isset($entry_zone)) echo $entry_zone; ?><span class="required">*</span></label>

							<div class="col-md-8">
								<select name="zone_id">
								</select>
							</div>
						</div>
				</div>
				
				
				<h2><?php echo $text_your_password; ?></h2>
				<div class="registerbox">
					<div class="form-group">
						<?php if ($error_password) { ?>
						<div class="row">
							<span class="error col-md-12"><?php echo $error_password; ?></span>
						</div>
						<?php } ?>

						<label class="control-label col-md-4" for="email"><?php echo $entry_password; ?><span class="required">*</span></label>

						<div class="col-md-8">
							<input type="password" class="form-control" name="password" value="<?php if (isset($password) && !empty($password)) echo $password;else if (isset($_REQUEST['password'])) echo $_REQUEST['password'];?>">
						</div>
					</div>
					

					<div class="form-group">
						<?php if ($error_confirm) { ?>
						<div class="row">
							<span class="error col-md-12"><?php echo $error_confirm; ?></span>
						</div>
						<?php } ?>

						<label class="control-label col-md-4" for="confirm"><?php echo $entry_confirm; ?><span class="required">*</span></label>

						<div class="col-md-8">
							<input type="password" class="form-control" name="confirm" value="<?php if (isset($confirm) && !empty($confirm)) echo $confirm;else if (isset($_REQUEST['confirm'])) echo $_REQUEST['confirm'];?>">
						</div>
					</div>
				</div>				
				
				<div class="registerbox">					
					<?php if (isset($captcha)) echo $captcha; ?>
					<?php if ($text_agree) { ?>
					<div class="form-group">
						<label class="control-label col-md-10" for="agree"><?php echo $text_agree; ?><span class="required">*</span></label>
						<div class="col-md-2">
							<?php if ($agree) { ?>
							<input type="checkbox" name="agree" value="1" checked="checked" />
							<?php } else { ?>
							<input type="checkbox" name="agree" value="1" />
							<?php } ?>
						</div>
					</div>
					<?php } ?>

						
					<div class="buttons">
					  <div class="right">
						<input type="submit" value="<?php echo $button_continue; ?>" class="button btn btn-primary" />
					  </div>
					</div>
					
				</div>				
		 </div>				
	  </form>
	  </div>
	</div>
</div>
</div>
<script type="text/javascript"><!--
$('select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=<?php if ($opencart_version >= 2000) {?>affiliate<?php } else {?>account<?php }?>/register/country&country_id=' + this.value,
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
			
			if (json['zone'] != '') {
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

$('select[name=\'country_id\']').trigger('change');
//--></script>
<script type="text/javascript"><!--
$('input[name=\'payment\']').bind('change', function() {
	$('.payment').hide();
	
	$('#payment-' + this.value).show();
});

$('input[name=\'payment\']:checked').trigger('change');
//--></script>
<script type="text/javascript"><!--
/*
$('.colorbox').colorbox({
	width: 640,
	height: 480
});*/
//--></script> 
<?php echo $footer; ?>
