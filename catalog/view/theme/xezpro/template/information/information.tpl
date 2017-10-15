<?php echo $header; ?>
<div class="container">
  <div class="row">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  </div>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = '';/*'col-sm-12';*/ ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>">
		
		<div>
			<h2><?php echo $heading_title; ?></h2>
		</div>

	   <div class="content">
	  <?php echo $content_top;?>

	  <?php echo $description;?>
	  
	  <?php echo $content_bottom;?>

	  <div class="buttons">
		<div class="right">
			<a href="<?php echo $continue; ?>" class="button btn btn-primary"><?php echo $button_continue; ?></a>
		</div>
     </div>

    </div>
</div>
</div>
</div>
<?php echo $footer; ?>
