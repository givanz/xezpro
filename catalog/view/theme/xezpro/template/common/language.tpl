<?php 
$opencart_version = (int)str_replace('.','',VERSION);
if ($opencart_version >= 2200) $image_path = 'catalog/language/'; else  $image_path = 'image/flags/';
if (count($languages) > 1) { ?>
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="language">
  <div class="btn-group">
    <button class="btn btn-link dropdown-toggle" data-toggle="dropdown">
    <?php 
    $code = isset($code)?$code:$language_code;
    foreach ($languages as $language) { ?>
    <?php if ($language['code'] == $code) { 
    if ($opencart_version >= 2200) $image = $image_path . $language['code']  .'/' . $language['code'] . '.png'; else  $image = $image_path . $language['image'];
     ?>
    <img src="<?php echo $image; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>">
    <?php } ?>
    <?php } ?>
    <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_language; ?></span> <i class="fa fa-chevron-down"></i></button>
    <ul class="dropdown-menu pull-right">
      <?php foreach ($languages as $language) { 
	if ($opencart_version >= 2200) $image = $image_path . $language['code']  .'/' . $language['code'] . '.png'; else  $image = $image_path . $language['image'];
      ?>
      <li>
<a href="#<?php echo $language['code']; ?>" onclick=" $('input[name=\'language_code\'],input[name=\'code\']').attr('value', '<?php echo $language['code']; ?>');$('#language').submit();return false;"><img src="<?php echo $image; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
      <?php } ?>
    </ul>
  </div>
  <input type="hidden" name="code" value="" />
  <input type="hidden" name="language_code" value="" />
  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>
<?php } ?>
