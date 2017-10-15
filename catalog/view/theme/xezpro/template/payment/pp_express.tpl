<div class="buttons">
  <div class="pull-right">
    <a href="<?php if (isset($continue)) echo $continue;else if (isset($button_continue_action)) echo $button_continue_action; ?>" class="btn btn-primary" id="button-confirm" <?php if (isset($text_loading)) {?>data-loading-text="<?php echo $text_loading; ?>"<?php }?>><?php echo $button_continue; ?></a>
  </div>
</div>
<?php if (isset($text_loading)) {?>
<script type="text/javascript"><!--
$('#button-confirm').on('click', function() {
	$('#button-confirm').button('loading');
});
//--></script>
<?php }?>
