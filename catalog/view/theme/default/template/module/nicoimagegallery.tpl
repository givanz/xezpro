<?php 
global $_button_cart, $_config, $_config, $nico_include_path;
if(!isset($_config)) $_config =  $this->registry->get('config');

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

$gallery_module_id = 'gal_' . $module_id;
$cols = 'col-xs-' . $cols_xs . ' col-sm-' . $cols_sm . ' col-md-' . $cols_md . ' col-lg-' . $cols_lg;

?><!--cols:<?php if (isset($grid_cols) && $grid_cols) echo $grid_cols + $grid_offset;else echo 12;?>   -->
<div class="<?php if ($hide_on_mobile == 'true') {?>hide_on_mobile<?php }?> <?php if (isset($grid_cols) &&$grid_cols) {?>col-md-<?php echo $grid_cols;}?> <?php if (isset($grid_offset) && $grid_offset) {?>col-md-offset-<?php echo $grid_offset;}?> <?php if (isset($grid_padding) && $grid_padding) {?>no_padding<?php if (isset($grid_padding) && $grid_padding == 2) echo 'left';else if (isset($grid_padding) && $grid_padding == 3) echo 'right'; }?>">
	<div id="gallery-<?php echo $gallery_module_id;?>">
		<?php $_slide_counter = 0;foreach ($section as $slide) { ?>
		<div class="<?php echo $cols;?>">
		<a href="<?php echo $slide['image']; ?>" class="img-thumbnail" title="">
			<img src="<?php echo $slide['thumb']; /* height="<?php echo $thumb_image_height; ?>" width="<?php echo $thumb_image_width; ?>" */?>">
			<?php if (isset($slide['title'])) {?><h3><?php echo $slide['title'];?></h3><?php }?>
			<?php if (isset($slide['description'])) {?><p><?php echo $slide['description'];?></p><?php }?>
		</a>
		</div>
		<?php }?>
	</div>
</div>
<?php
nico_add_style('catalog/view/javascript/jquery/magnific/magnific-popup.css');
nico_add_script('catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js');

$_gallery_js = <<<JSS
$(document).ready(function() {
	$('#gallery-$gallery_module_id').magnificPopup({
		delegate: 'a',
		type: 'image',
		tLoading: 'Loading image #%curr%...',
		mainClass: 'mfp-img-mobile',
		gallery: {
			enabled: true,
			navigateByImgClick: true,
			preload: [0,1] // Will preload 0 - before current, and 1 after the current image
		},
		image: {
			tError: '<a href="%url%">The image #%curr%</a> could not be loaded.',
			titleSrc: function(item) {
				return item.el.attr('title');
			}
		}
	});
});

JSS;
nico_add_js($_gallery_js);
?>
