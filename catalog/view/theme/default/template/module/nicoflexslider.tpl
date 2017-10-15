<?php 
global $_button_cart, $_config, $_config, $nico_include_path;
if(!isset($_config)) $_config =  $this->registry->get('config');
$theme_name = $_config->get('config_template');

if (!isset($nico_include_path))
{
	$nico_include_path = __DIR__. '/../../';
	//vqmod changes paths and the above path fails, check other paths
	if (!file_exists($nico_include_path . 'nico_theme_editor/common.inc')) 
	{
		$_config =  $this->registry->get('config');
		$nico_include_path = DIR_TEMPLATE . '/' . $_config->get('config_template') . '/';
		
		if (!file_exists($nico_include_path . '/nico_theme_editor/common.inc')) $nico_include_path = dirname(__FILE__) . '/../../';
	}

	if (file_exists($nico_include_path . 'nico_theme_editor/common.inc')) require_once($nico_include_path . 'nico_theme_editor/common.inc');
}
$flex_module_id = 'flex_' . $module_id;
?><!--cols:<?php if (isset($grid_cols) && $grid_cols) echo $grid_cols + $grid_offset;else echo 12;?>   -->
<div id="flexslider-<?php echo $flex_module_id?>" class="slideshow <?php if ($hide_on_mobile == 'true') {?>hide_on_mobile<?php }?> <?php if (isset($grid_cols) &&$grid_cols) {?>col-md-<?php echo $grid_cols;}?> <?php if (isset($grid_offset) && $grid_offset) {?>col-md-offset-<?php echo $grid_offset;}?> <?php if (isset($grid_padding) && $grid_padding) {?>no_padding<?php if (isset($grid_padding) && $grid_padding == 2) echo 'left';else if (isset($grid_padding) && $grid_padding == 3) echo 'right'; }?>">
	<div>
		<ul class="slides">
		<?php $first = true;foreach ($section as $slide) {?>
		<li>
			<?php if ($slide['url']) { ?>
			<a href="<?php echo $slide['url']; ?>">
				<img src="<?php echo $slide['image']; ?>" alt="" />
			</a>
			<?php } else { ?>
				<img src="<?php echo $slide['image']; ?>" alt="" />
			<?php } ?>
		</li>
		<?php } ?>
	   </ul>
	</div>
</div>
<?php
nico_add_style('catalog/view/theme/' . $theme_name . '/css/flexslider.css');
nico_add_script('catalog/view/theme/' . $theme_name . '/js/jquery.flexslider.js');

$_flexslider_js = <<<JSS

		$(document).ready( function()
		{	
			$('#flexslider-$flex_module_id.slideshow > div').flexslider({
				animation:"slide",
				easing:"",
				direction:"horizontal",
				startAt:0,
				initDelay:0,
				slideshowSpeed:7000,
				animationSpeed:600,
				prevText:"",
				nextText:"",
				pauseText:"",
				playText:"",
				pausePlay:false,
				controlNav:false,
				slideshow:true,
				animationLoop:true,
				randomize:false,
				smoothHeight:false,
				useCSS:true,
				pauseOnHover:true,
				pauseOnAction:true,
				touch:true,
				video:false,
				mousewheel:false,
				keyboard:false
		});
		});	
JSS;
nico_add_js($_flexslider_js);

if ($height_style == '1') {
$_flexslider_css = <<<CSS
@media(min-width:767px)
{
	#flexslider-$flex_module_id 
	{
			height:{$image_height}px;
			width:{$image_width}px;
			margin:30px auto;
	}
}
CSS;
nico_add_css($_flexslider_css);
}
