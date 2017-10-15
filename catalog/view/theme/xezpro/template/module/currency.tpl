<?php /* if (count($currencies) > 1) { ?>
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="currency" class="navbar-form navbar-left">

	<select class="selectpicker" onchange="$('input[name=\'currency_code\']').attr('value', this.value);$(this).parent().submit();" data-width="100px">
    <?php foreach ($currencies as $currency) { ?>
      <option <?php if ($currency['code'] == $currency_code) { ?>selected<?php }?> 
		value="<?php echo $currency['image']; ?>">
		<?php echo $currency['symbol_left']; ?><?php echo $currency['title']; ?><?php echo $currency['symbol_right']; ?> 
      </option>
    <?php } ?>

  <input type="hidden" name="currency_code" value="" />
  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>
<?php } */?>
<?php if (count($currencies) > 1) { ?>
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="currency">
  <div class="btn-group">
    <button class="btn btn-link dropdown-toggle" data-toggle="dropdown">
    <?php 
    $code = isset($code)?$code:$currency_code;
    foreach ($currencies as $currency) { ?>
    <?php if ($currency['symbol_left'] && $currency['code'] == $code) { ?>
    <strong><?php echo $currency['symbol_left']; ?></strong>
    <?php } elseif ($currency['symbol_right'] && $currency['code'] == $code) { ?>
    <strong><?php echo $currency['symbol_right']; ?></strong>
    <?php } ?>
    <?php } ?>
    <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_currency; ?></span> <i class="fa fa-chevron-down"></i></button>
    <ul class="dropdown-menu pull-right">
      <?php foreach ($currencies as $currency) { ?>
      <?php if ($currency['symbol_left']) { ?>
      <li><a href="<?php echo $currency['code']; ?>" title="<?php echo $currency['title']; ?>" onclick=" $('input[name=\'currency_code\'],input[name=\'code\']').attr('value', '<?php echo $currency['code']; ?>');$('#currency').submit();return false;"><?php echo $currency['symbol_left']; ?> <?php echo $currency['title']; ?></a></li>
      <?php } else { ?>
      <li><a href="<?php echo $currency['code']; ?>" title="<?php echo $currency['title']; ?>" onclick=" $('input[name=\'currency_code\'],input[name=\'code\']').attr('value', '<?php echo $currency['code']; ?>');$('#currency').submit();return false;"><?php echo $currency['symbol_right']; ?> <?php echo $currency['title']; ?></a></li>
      <?php } ?>
      <?php } ?>
    </ul>
  </div>
  <input type="hidden" name="code" value="" />
  <input type="hidden" name="currency_code" value="" />
  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>
<?php } ?>
