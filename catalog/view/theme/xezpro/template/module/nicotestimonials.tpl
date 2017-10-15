<!--cols:<?php if (isset($grid_cols) && $grid_cols) echo $grid_cols + $grid_offset;else echo 12;?>   -->
<div class="<?php if (isset($grid_cols) &&$grid_cols) {?>col-md-<?php echo $grid_cols;}?> <?php if (isset($grid_offset) && $grid_offset) {?>col-md-offset-<?php echo $grid_offset;}?> <?php if (isset($grid_padding) && $grid_padding) {?>no_padding<?php if (isset($grid_padding) && $grid_padding == 2) echo 'left';else if (isset($grid_padding) && $grid_padding == 3) echo 'right'; }?>">
<?php
$module_id = 'prod_' . $module_id;
$cols = 'col-xs-' . $cols_xs . ' col-sm-' . $cols_sm . ' col-md-' . $cols_md . ' col-lg-' . $cols_lg;

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

require_once(DIR_TEMPLATE . $theme_directory . 'template/module/nico_testimonial.tpl');

switch ($type)
{
    /* ------------------------------ grid ----------------------*/
    case 'grid':
?>
<div class="heading clearfix">
<?php if ($title) {?><h2><?php echo $title;?></h2><?php }?>
</div>

<div class="row testimonial-grid">
	<?php foreach ($section as $testimonial) {?>
		<div class="<?php echo $cols;?> prod">
			<?php nico_testimonial($testimonial);?>
		    </div>
    <?php } ?>
</div>
<?php
    break;
    /* ------------------------------ carousel ----------------------*/
    case 'carousel':
?>
<div class="heading clearfix">
<?php if ($title) {?><h2><?php echo $title;?></h2><?php }?>
</div>
<div class="carousel" id="<?php echo $module_id;?>">
    <div>
	<ul class="slides">    
		<?php foreach ($section as $testimonial) {?>
		    <li>
			<div class="prod">
				<?php nico_testimonial($testimonial);?>
			</div>
			</li>
	    <?php } ?>
       </ul>
    </div>
</div>

<?php 
//nico_add_style('catalog/view/theme/' . $theme_directory . '/css/flexslider.css');
//nico_add_script('catalog/view/theme/' . $theme_directory . '/js/jquery.flexslider.js');
nico_add_js('nico_carousel(\''. $module_id .'\',' . $cols_xs .' ,'. $cols_sm .',' . $cols_md .',' . $cols_lg. ');');
?>
<?php
    break;
}
?>
</div>
