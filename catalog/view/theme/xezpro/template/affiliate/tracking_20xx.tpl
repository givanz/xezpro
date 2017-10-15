<?php echo $header;?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
    <div class="row">
	<div class="col-md-12">
		<div class="cat_header">
			<h2><?php echo $heading_title; ?></h2>
		</div>
	    </div>
    </div>
      <p><?php echo $text_description; ?></p>
      <form class="form-horizontal">
        <div class="form-group">
          <label class="col-sm-2 control-label" for="input-code"><?php if (isset($entry_code)) echo $entry_code;else echo $text_code; ?></label>
          <div class="col-sm-10">
            <textarea cols="40" rows="5" placeholder="<?php if (isset($entry_code)) echo $entry_code; ?>" id="input-code" class="form-control"><?php echo $code; ?></textarea>
          </div>
        </div>
        <div class="form-group">
          <label class="col-sm-2 control-label" for="input-generator"><?php if (isset($entry_generator)) echo $entry_generator;else echo $text_generator; ?></label>
          <div class="col-sm-10">
            <input type="text" name="product" value="" placeholder="" id="input-generator" class="form-control" />
            <span class="help-block"><?php if (isset($help_generator)) echo $help_generator; ?></span> </div>
        </div>
        <div class="form-group">
          <label class="col-sm-2 control-label" for="input-link"><?php if (isset($entry_link)) echo $entry_link;else echo $text_link; ?></label>
          <div class="col-sm-10">
            <textarea name="link" cols="40" rows="5" placeholder="<?php if (isset($entry_link)) echo $entry_link; ?>" id="input-link" class="form-control"></textarea>
          </div>
        </div>
      </form>
      <div class="buttons clearfix">
        <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
      </div>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/<?php echo $theme_name;?>/css/ui-lightness/jquery-ui-1.10.4.css">
<script src="catalog/view/theme/<?php echo $theme_name;?>/js/jquery-ui-1.10.4.min.js"></script>

<script type="text/javascript"><!--
$('input[name=\'product\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=affiliate/tracking/autocomplete&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',			
			success: function(json) {
				response($.map(json, function(item) 
				{
					return {
						label: item['name'],
						value: item['name'],
						url: item['link'],
					}
				}));
			}
		});
		return false;
	},
	'select': function(e,item) {
		$('input[name=\'product\']').val(item.item['value']);
		$('textarea[name=\'link\']').val(item.item['url']);	
	}	
});
//--></script> 
<?php echo $footer; ?> 
