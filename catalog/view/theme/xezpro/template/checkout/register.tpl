<?php $opencart_version = (int)str_replace('.','',VERSION);?>
<div class="row">
  <div class="col-sm-6">
    <fieldset id="account">
      <legend><?php echo $text_your_details; ?></legend>
      <div class="form-group" style="display: <?php echo (count($customer_groups) > 1 ? 'block' : 'none'); ?>;">
        <label class="control-label"><?php echo $entry_customer_group; ?></label>
        <?php foreach ($customer_groups as $customer_group) { ?>
        <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
        <div class="radio">
          <label>
            <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
            <?php echo $customer_group['name']; ?></label>
        </div>
        <?php } else { ?>
        <div class="radio">
          <label>
            <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" />
            <?php echo $customer_group['name']; ?></label>
        </div>
        <?php } ?>
        <?php } ?>
      </div>
      <div class="form-group required">
        <label class="control-label" for="input-payment-firstname"><?php echo $entry_firstname; ?></label>
        <input type="text" name="firstname" value="" placeholder="<?php echo $entry_firstname; ?>" id="input-payment-firstname" class="form-control" />
      </div>
      <div class="form-group required">
        <label class="control-label" for="input-payment-lastname"><?php echo $entry_lastname; ?></label>
        <input type="text" name="lastname" value="" placeholder="<?php echo $entry_lastname; ?>" id="input-payment-lastname" class="form-control" />
      </div>
      <div class="form-group required">
        <label class="control-label" for="input-payment-email"><?php echo $entry_email; ?></label>
        <input type="text" name="email" value="" placeholder="<?php echo $entry_email; ?>" id="input-payment-email" class="form-control" />
      </div>
      <div class="form-group required">
        <label class="control-label" for="input-payment-telephone"><?php echo $entry_telephone; ?></label>
        <input type="text" name="telephone" value="" placeholder="<?php echo $entry_telephone; ?>" id="input-payment-telephone" class="form-control" />
      </div>
      <div class="form-group">
        <label class="control-label" for="input-payment-fax"><?php echo $entry_fax; ?></label>
        <input type="text" name="fax" value="" placeholder="<?php echo $entry_fax; ?>" id="input-payment-fax" class="form-control" />
      </div>
      <?php if (isset($custom_fields) && $custom_fields) foreach ($custom_fields as $custom_field) { ?>
      <?php if ($custom_field['location'] == 'account') { ?>
      <?php if ($custom_field['type'] == 'select') { ?>
      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
        <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
        <select name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
          <option value=""><?php echo $text_select; ?></option>
          <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
          <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
          <?php } ?>
        </select>
      </div>
      <?php } ?>
      <?php if ($custom_field['type'] == 'radio') { ?>
      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
        <label class="control-label"><?php echo $custom_field['name']; ?></label>
        <div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
          <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
          <div class="radio">
            <label>
              <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
              <?php echo $custom_field_value['name']; ?></label>
          </div>
          <?php } ?>
        </div>
      </div>
      <?php } ?>
      <?php if ($custom_field['type'] == 'checkbox') { ?>
      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
        <label class="control-label"><?php echo $custom_field['name']; ?></label>
        <div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
          <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
          <div class="checkbox">
            <label>
              <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
              <?php echo $custom_field_value['name']; ?></label>
          </div>
          <?php } ?>
        </div>
      </div>
      <?php } ?>
      <?php if ($custom_field['type'] == 'text') { ?>
      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
        <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
        <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
      </div>
      <?php } ?>
      <?php if ($custom_field['type'] == 'textarea') { ?>
      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
        <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
        <textarea name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo $custom_field['value']; ?></textarea>
      </div>
      <?php } ?>
      <?php if ($custom_field['type'] == 'file') { ?>
      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
        <label class="control-label"><?php echo $custom_field['name']; ?></label>
        <br />
        <button type="button" id="button-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo isset($text_loading)?$text_loading:'Loading...'; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
        <input type="hidden" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="" />
      </div>
      <?php } ?>
      <?php if ($custom_field['type'] == 'date') { ?>
      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
        <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
        <div class="input-group date">
          <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo $custom_field['name']; ?>" data-format="YYYY-MM-DD" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
          <span class="input-group-btn">
          <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
          </span></div>
      </div>
      <?php } ?>
      <?php if ($custom_field['type'] == 'time') { ?>
      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
        <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
        <div class="input-group time">
          <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo $custom_field['name']; ?>" data-format="HH:mm" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
          <span class="input-group-btn">
          <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
          </span></div>
      </div>
      <?php } ?>
      <?php if ($custom_field['type'] == 'datetime') { ?>
      <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
        <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
        <div class="input-group datetime">
          <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo $custom_field['name']; ?>" data-format="YYYY-MM-DD HH:mm" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
          <span class="input-group-btn">
          <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
          </span></div>
      </div>
      <?php } ?>
      <?php } ?>
      <?php } ?>
    </fieldset>
    <fieldset>
      <legend><?php echo $text_your_password; ?></legend>
      <div class="form-group required">
        <label class="control-label" for="input-payment-password"><?php echo $entry_password; ?></label>
        <input type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>" id="input-payment-password" class="form-control" />
      </div>
      <div class="form-group required">
        <label class="control-label" for="input-payment-confirm"><?php echo $entry_confirm; ?></label>
        <input type="password" name="confirm" value="" placeholder="<?php echo $entry_confirm; ?>" id="input-payment-confirm" class="form-control" />
      </div>
    </fieldset>
  </div>
  <div class="col-sm-6">
    <fieldset>
      <legend><?php echo $text_your_address; ?></legend>
      <div class="form-group">
        <label class="control-label" for="input-payment-company"><?php echo $entry_company; ?></label>
        <input type="text" name="company" value="" placeholder="<?php echo $entry_company; ?>" id="input-payment-company" class="form-control" />
      </div>
      
      <?php if (isset($entry_company_id)) { ?>
      <div id="company-id-display">
      <div class="form-group required">
	<label class="control-label" for="input-payment-company"><?php echo $entry_company_id; ?></label>
	<input type="text" name="company_id" value="<?php if (isset($company_id)) echo $company_id; ?>" placeholder="<?php echo $entry_company_id; ?>" id="input-payment-company-id" class="form-control" />
      </div>
      </div>

      <div id="tax-id-display">
      <div class="form-group required">
	<label class="control-label" for="input-tax-id"><?php echo $entry_tax_id; ?></label>
	<input type="text" name="tax_id" value="<?php if (isset($tax_id)) echo $tax_id; ?>" placeholder="<?php echo $entry_tax_id; ?>" id="input-tax-id" class="form-control" />
      </div>
      </div>
       <?php } ?>
      
      <div class="form-group required">
        <label class="control-label" for="input-payment-address-1"><?php echo $entry_address_1; ?></label>
        <input type="text" name="address_1" value="" placeholder="<?php echo $entry_address_1; ?>" id="input-payment-address-1" class="form-control" />
      </div>
      <div class="form-group">
        <label class="control-label" for="input-payment-address-2"><?php echo $entry_address_2; ?></label>
        <input type="text" name="address_2" value="" placeholder="<?php echo $entry_address_2; ?>" id="input-payment-address-2" class="form-control" />
      </div>
      <div class="form-group required">
        <label class="control-label" for="input-payment-city"><?php echo $entry_city; ?></label>
        <input type="text" name="city" value="" placeholder="<?php echo $entry_city; ?>" id="input-payment-city" class="form-control" />
      </div>
      <div class="form-group required">
        <label class="control-label" for="input-payment-postcode"><?php echo $entry_postcode; ?></label>
        <input type="text" name="postcode" value="<?php if (isset($postcode)) echo $postcode; ?>" placeholder="<?php echo $entry_postcode; ?>" id="input-payment-postcode" class="form-control" />
      </div>
      <div class="form-group required">
        <label class="control-label" for="input-payment-country"><?php echo $entry_country; ?></label>
        <select name="country_id" id="input-payment-country" class="form-control">
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
      <div class="form-group required">
        <label class="control-label" for="input-payment-zone"><?php echo $entry_zone;; ?></label>
        <select name="zone_id" id="input-payment-zone" class="form-control">
        </select>
      </div>
    </fieldset>
    <?php if (isset($custom_fields)) foreach ($custom_fields as $custom_field) { ?>
    <?php if ($custom_field['type'] == 'select') { ?>
    <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field">
      <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
      <select name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
        <option value=""><?php echo $text_select; ?></option>
        <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
        <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
        <?php } ?>
      </select>
    </div>
    <?php } ?>
    <?php if ($custom_field['type'] == 'radio') { ?>
    <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field">
      <label class="control-label"><?php echo $custom_field['name']; ?></label>
      <div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
        <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
        <div class="radio">
          <label>
            <input type="radio" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
            <?php echo $custom_field_value['name']; ?></label>
        </div>
        <?php } ?>
      </div>
    </div>
    <?php } ?>
    <?php if ($custom_field['type'] == 'checkbox') { ?>
    <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field">
      <label class="control-label"><?php echo $custom_field['name']; ?></label>
      <div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
        <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
        <div class="checkbox">
          <label>
            <input type="checkbox" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
            <?php echo $custom_field_value['name']; ?></label>
        </div>
        <?php } ?>
      </div>
    </div>
    <?php } ?>
    <?php if ($custom_field['type'] == 'text') { ?>
    <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field">
      <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
      <input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
    </div>
    <?php } ?>
    <?php if ($custom_field['type'] == 'textarea') { ?>
    <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field">
      <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
      <textarea name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo $custom_field['value']; ?></textarea>
    </div>
    <?php } ?>
    <?php if ($custom_field['type'] == 'file') { ?>
    <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field">
      <label class="control-label"><?php echo $custom_field['name']; ?></label>
      <button type="button" id="button-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
      <input type="hidden" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" />
    </div>
    <?php } ?>
    <?php if ($custom_field['type'] == 'date') { ?>
    <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field">
      <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
      <input type="date" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
    </div>
    <?php } ?>
    <?php if ($custom_field['type'] == 'datetime') { ?>
    <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field">
      <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
      <input type="datetime-local" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
    </div>
    <?php } ?>
    <?php if ($custom_field['type'] == 'time') { ?>
    <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field">
      <label class="control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
      <input type="time" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
    </div>
    <?php } ?>
    <?php } ?>

	<?php if (isset($captcha)) echo $captcha; ?>
  </div>
</div>
<div class="checkbox">
  <label for="newsletter">
    <input type="checkbox" name="newsletter" value="1" id="newsletter" />
    <?php echo $entry_newsletter; ?></label>
</div>
<?php if ($shipping_required) { ?>
<div class="checkbox">
  <label>
    <input type="checkbox" name="shipping_address" value="1" checked="checked" />
    <?php echo $entry_shipping; ?></label>
</div>
<?php } ?>
<?php if ($text_agree) { ?>
<div class="buttons clearfix">
  <div class="pull-right"><?php echo $text_agree; ?> &nbsp;
    <input type="checkbox" name="agree" value="1" />
    <input type="button" value="<?php echo $button_continue; ?>" id="button-register" data-loading-text="<?php if (isset($text_loading)) echo $text_loading;else echo 'loading ...' ?>" class="btn btn-primary" />
  </div>
</div>
<?php } else { ?>
<div class="buttons clearfix">
  <div class="pull-right">
    <input type="button" value="<?php echo $button_continue; ?>" id="button-register" data-loading-text="<?php if (isset($text_loading)) echo $text_loading;else echo 'loading ...' ?>" class="btn btn-primary" />
  </div>
</div>
<?php } ?>
<script type="text/javascript"><!--
<?php if (isset($custom_fields)) { ?>	
$('#collapse-payment-address input[name=\'customer_group_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=checkout/checkout/<?php if ($opencart_version >= 2000) { ?>customfield<?php } else {?>custom_field<?php }?>&customer_group_id=' + this.value,
		dataType: 'json',	
		success: function(json) {
			$('#collapse-payment-address .custom-field').hide();
			$('#collapse-payment-address .custom-field').removeClass('required');
			
			for (i = 0; i < json.length; i++) {
				custom_field = json[i];
				
				$('#payment-custom-field' + custom_field['custom_field_id']).show();
				
				if (custom_field['required']) {
					$('#payment-custom-field' + custom_field['custom_field_id']).addClass('required');
				} else {
					$('#payment-custom-field' + custom_field['custom_field_id']).removeClass('required');
				}
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});
<?php } ?>
$('#collapse-payment-address input[name=\'customer_group_id\']:checked').trigger('change');
//--></script> 

<script type="text/javascript"><!--
$('#collapse-payment-address input[name=\'customer_group_id\']').on('change', function() {
	var customer_group = [];
<?php foreach ($customer_groups as $customer_group) { ?>
	customer_group[<?php echo $customer_group['customer_group_id']; ?>] = [];
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_display'] = '<?php if (isset($customer_group['company_id_display']))  echo $customer_group['company_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_required'] = '<?php if (isset($customer_group['company_id_required'])) echo $customer_group['company_id_required']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_display'] = '<?php if (isset($customer_group['tax_id_display'])) echo $customer_group['tax_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_required'] = '<?php if (isset($customer_group['tax_id_required'])) echo $customer_group['tax_id_required']; ?>';
<?php } ?>	
	if (customer_group[this.value]) {
		if (customer_group[this.value]['company_id_display'] == '1') {
			$('#company-id-display').show();
		} else {
			$('#company-id-display').hide();
		}
		
		if (customer_group[this.value]['company_id_required'] == '1') {
			$('#company-id-display .form-group').addClass("required");
		} else {
			$('#company-id-display .form-group').removeClass("required");
		}
		
		if (customer_group[this.value]['tax_id_display'] == '1') {
			$('#tax-id-display').show();
		} else {
			$('#tax-id-display').hide();
		}
		
		if (customer_group[this.value]['tax_id_required'] == '1') {
			$('#tax-id-display .form-group').addClass("required");
		} else {
			$('#tax-id-display .form-group').removeClass("required");
		}	
	}
});

$('#collapse-payment-address input[name=\'customer_group_id\']:checked').trigger('change');
//--></script> 
<script type="text/javascript"><!--
$('#collapse-payment-address select[name=\'country_id\']').on('change', function() {
	$.ajax({
        url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
        dataType: 'json',
        beforeSend: function() {
			$('#collapse-payment-address select[name=\'country_id\']').after(' <i class="fa fa-spinner fa-spin"></i>');
        },
        complete: function() {
			$('.fa-spinner').remove();
        },          
        success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#collapse-payment-address input[name=\'postcode\']').parent().parent().addClass('required');
			} else {
				$('#collapse-payment-address input[name=\'postcode\']').parent().parent().removeClass('required');
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
            
            $('#collapse-payment-address select[name=\'zone_id\']').html(html);
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
});

$('#collapse-payment-address select[name=\'country_id\']').trigger('change');
//--></script> 
<script type="text/javascript"><!--
$('#collapse-payment-address button[id^=\'button-payment-custom-field\']').on('click', function() {
	var node = this;
	
	$('#form-upload').remove();
	
	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

	$('#form-upload input[name=\'file\']').trigger('click');

	$('#form-upload input[name=\'file\']').on('change', function() {
		$.ajax({
			url: 'index.php?route=checkout/checkout/upload',
			type: 'post',		
			dataType: 'json',
			data: new FormData($(this).parent()[0]),
			cache: false,
			contentType: false,
			processData: false,		
			beforeSend: function() {
				$(node).find('i').replaceWith('<i class="fa fa-spinner fa-spin"></i>');
				$(node).prop('disabled', true);
			},
			complete: function() {
				$(node).find('i').replaceWith('<i class="fa fa-upload"></i>');
				$(node).prop('disabled', false);			
			},		
			success: function(json) {
				if (json['error']) {
					$(node).parent().find('input[name^=\'custom_field\']').after('<div class="text-danger">' + json['error'] + '</div>');
				}
							
				if (json['success']) {
					alert(json['success']);
					
					$(node).parent().find('input[name^=\'custom_field\']').attr('value', json['file']);
				}
			},			
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});
});
//--></script> 
<script>
jQuery(document).ready(function()
{
	$('.colorbox, .agree').colorbox({
		width: 640,
		height: 480
	});
});
</script>
