<?php 
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

$cam_module_id = 'cam_' . $module_id;
?><!--cols:<?php if (isset($grid_cols) && $grid_cols) echo $grid_cols + $grid_offset;else echo 12;?>   -->
<div id="camera-<?php echo $cam_module_id?>" class="slideshow <?php if ($hide_on_mobile == 'true') {?>hide_on_mobile<?php }?> <?php if (isset($grid_cols) &&$grid_cols) {?>col-md-<?php echo $grid_cols;}?> <?php if (isset($grid_offset) && $grid_offset) {?>col-md-offset-<?php echo $grid_offset;}?> <?php if (isset($grid_padding) && $grid_padding) {?>no_padding<?php if (isset($grid_padding) && $grid_padding == 2) echo 'left';else if (isset($grid_padding) && $grid_padding == 3) echo 'right'; }?>">

        <div class="camera_wrap camera_emboss"  style=" height: <?php echo $height; ?>px;" >
			<?php $_slide_counter = 0;foreach ($section as $slide) { ?>
				<div data-thumb="<?php echo $slide['image']; ?>" data-src="<?php echo $slide['image']; ?>" <?php if ($slide['url']) { ?>data-link="<?php echo $slide['url']; ?>"<?php }?>></div>
            <?php }?>
        </div>
</div>
<?php
nico_add_style('catalog/view/theme/' . $theme_directory . '/css/camera.css');
nico_add_script('catalog/view/theme/' . $theme_directory . '/js/camera.js');

$_camslider_js = <<<JSS
		$(document).ready( function()
		{	
			$('#camera-$cam_module_id.slideshow > div').camera({});
		});	
JSS;
nico_add_js($_camslider_js);

if ($height_style == '1') {
$_camera_css = <<<CSS
@media(min-width:767px)
{
	#camera-$cam_module_id 
	{
			height:{$image_height}px;
			width:{$image_width}px;
			margin:30px auto;
	}
}
CSS;
nico_add_css($_camera_css);
}
