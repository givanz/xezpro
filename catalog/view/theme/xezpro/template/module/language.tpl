<?php /* if (count($languages) > 1) { ?>
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="language" class="navbar-form navbar-left">
	<select class="selectpicker" onchange=" $('input[name=\'language_code\']').attr('value', this.value);$(this).parent().submit();" data-width="100px" >
    <?php foreach ($languages as $language) { ?>
      <option <?php if ($language['code'] == $language_code) { ?>selected<?php }?> 
		value="<?php echo $language['image']; ?>" data-content="<img src='image/flags/<?php echo $language['image']; ?>' alt='<?php echo $language['name']; ?>' title='<?php echo $language['name']; ?>'>&nbsp;<?php echo $language['name']; ?>">
		<?php echo $language['name']; ?>
      </option>
    <?php } ?>
  </div>
  <select>
  <input type="hidden" name="language_code" value="" />
  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>
<?php } */?>
<?php if (count($languages) > 1) { ?>
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="language">
  <div class="btn-group">
    <button class="btn btn-link dropdown-toggle" data-toggle="dropdown">
    <?php 
    $code = isset($code)?$code:$language_code;
    foreach ($languages as $language) { ?>
    <?php if ($language['code'] == $code) { ?>
    <img src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>">
    <?php } ?>
    <?php } ?>
    <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_language; ?></span> <i class="fa fa-chevron-down"></i></button>
    <ul class="dropdown-menu pull-right">
      <?php foreach ($languages as $language) { ?>
      <li><a href="#<?php echo $language['code']; ?>" onclick=" $('input[name=\'language_code\'],input[name=\'code\']').attr('value', '<?php echo $language['code']; ?>');$('#language').submit();return false;"><img src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
      <?php } ?>
    </ul>
  </div>
  <input type="hidden" name="code" value="" />
  <input type="hidden" name="language_code" value="" />
  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>
<?php } ?>
