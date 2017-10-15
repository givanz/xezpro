<!--cols:<?php if (isset($grid_cols) && $grid_cols) echo $grid_cols + $grid_offset;else echo 12;
$parallax_module_id = 'parallax_' . $module_id;
?>   -->
</div>
</div>
</div>
<div class="<?php if (isset($grid_cols) &&$grid_cols) {?>col-md-<?php echo $grid_cols;}?> <?php if (isset($grid_offset) && $grid_offset) {?>col-md-offset-<?php echo $grid_offset;}?> <?php if (isset($grid_padding) && $grid_padding) {?>no_padding<?php if (isset($grid_padding) && $grid_padding == 2) echo 'left';else if (isset($grid_padding) && $grid_padding == 3) echo 'right'; }?>">


	<section id="<?php echo $parallax_module_id;?>" class="module parallax <?php echo $text_color;?>">
	<div>
        <div class="container">
          <?php if ($title) {?><h3><?php echo $title;?></h3><?php }?>
          <?php if ($type == 'html' || $type == 'text') {?><p><?php echo $content;?></p><?php } else echo $content;?>
          <?php if ($button_text) {?><a href="<?php echo $url;?>" class="btn btn-default"><?php echo $button_text;?></a><?php }?>
        </div>
	</div>
      </section>

</div>
<div class="container"><div class="col-md-12"><div class="row">
<?php 

$_parallax_css = <<<CSS
#$parallax_module_id
{
	background-image:url($background_image);
}

#$parallax_module_id > div
{
	position:relative;
}

#$parallax_module_id > div::before
{
    background-color: $overlay_color;
    content: "";
    height: 100%;
    left: 0;
    opacity: $overlay_opacity;
    position: absolute;
    top: 0;
    width: 100%;
    z-index: 2;
}
CSS;
nico_add_css($_parallax_css);
