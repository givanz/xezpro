<!--cols:<?php if ($grid_cols) echo $grid_cols + $grid_offset;else echo 12;?>   -->
<?php 
global $_button_cart, $_config, $_config, $nico_include_path, $opencart_version;
if(!isset($_config)) $_config =  $this->registry->get('config');
$_button_cart = $button_cart;

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
//$theme_directory = DIR_TEMPLATE . '/' . $theme_directory . '/';
require_once(DIR_TEMPLATE . $theme_directory . '/nico_theme_editor/common.inc');
$module_id = 'grid_' . $module_id;
ob_start();
?>
#<?php echo $module_id;?> .row {
    min-height: <?php echo $row_height * 10;?>px;
 	height: <?php echo $row_height?>vw;
 	margin:0px;
 	padding:0px;
}

@media only screen and (min-width : 768px) {
	#<?php echo $module_id;?> .row {
		height: <?php echo $row_height?>vw;
		min-height: <?php echo $row_height * 10;?>px;
	}
}

#<?php echo $module_id;?> .grid_item {
	position:absolute;
	padding:0px;
}	

#<?php echo $module_id;?> .grid_item > div, #<?php echo $module_id;?> .grid_item > div .background{
	padding-top:<?php echo $margin_top;?>px;
	padding-left:<?php echo $margin_left;?>px;
}


<?php for ($i = 0;$i<=12;$i++) {?>
#<?php echo $module_id;?> .size-y-<?php echo $i;?>
{
	height:<?php echo $row_height * $i;?>vw;
	min-height:<?php echo $row_height * 10 * $i;?>px;
}	
<?php }?>

@media only screen and (min-width : 1400px) 
{

	#<?php echo $module_id;?> .row {
		min-height: <?php echo ($row_height - 1) * 10;?>px;
		height: <?php echo ($row_height - 1)?>vw;
	}
	
	<?php for ($i = 0;$i<=12;$i++) {?>
	#<?php echo $module_id;?> .size-y-<?php echo $i;?>
	{
		height:<?php echo ($row_height - 1)  * $i;?>vw;
	}	
	<?php }?>
}


@media only screen and (min-width : 2000px) 
{

	#<?php echo $module_id;?> .row {
		min-height: <?php echo ($row_height - 2) * 10;?>px;
		height: <?php echo ($row_height - 2)?>vw;
	}
	
	<?php for ($i = 0;$i<=12;$i++) {?>
	#<?php echo $module_id;?> .size-y-<?php echo $i;?>
	{
		height:<?php echo ($row_height - 2)  * $i;?>vw;
	}	
	<?php }?>
}
<?php
$nico_grid_css = ob_get_clean();
nico_add_css(str_replace(array("\r","\n", '  ',"\t"),array('','','',''), $nico_grid_css));
nico_add_style('');
?>
<div class="grid_list <?php if ($grid_cols) {?>col-md-<?php echo $grid_cols;}?> <?php if ($grid_offset) {?>col-md-offset-<?php echo $grid_offset;}?> <?php if ($grid_padding) {?>no_padding<?php if ($grid_padding == 2) echo 'left';else if ($grid_padding == 3) echo 'right'; }?> clearfix"  id="<?php echo $module_id;?>">
<?php
		
		for ($i=1;$i<=$max_row;$i++)
		{
				$last_row_maxheight = 0;
				if (isset($group[$i])) {?> <div class="row col-md-12 col-sm-12 col-xs-12"><?php
				$offset = 0;
				foreach($group[$i] as $item) 
				{
					if ($item['size_y'] > $last_row_maxheight) $last_row_maxheight = $item['size_y'];
					$offset = $item['col'] - 1;
					?>
						<div onclick="window.location.href='<?php echo htmlentities($item['url']);?>'" class="col-md-<?php echo $item['size_x'];?> col-sm-<?php echo $item['size_x'];?> col-xs-<?php echo $item['size_x'];?> col-md-offset-<?php echo $offset;?> col-sm-offset-<?php echo $offset;?> col-xs-offset-<?php echo $offset;?> size-y-<?php echo $item['size_y'];?> grid_item">
								<div>
									<div>
										<div style="<?php if (isset($item['background'])) {?>background-color:<?php echo $item['background'];}?>;">
											<?php if (isset($item['img']) && !empty($item['img'])) {?><div class="background" style="background-image:url('<?php echo $item['img'];?>')">
<div><div></div></div>
</div><?php }?>
											<div class="grid_text">
											<?php if (isset($item['subtitle']) && !empty($item['subtitle'])) {?><h3><?php echo $item['subtitle'];?></h3><?php }?>
											<br/>
											<?php if (isset($item['title']) && !empty($item['title'])) {?><h2><?php echo $item['title'];?></h2><?php }?>
											<br/>
											<?php if (isset($item['button']) && !empty($item['button'])) {?><a href="<?php echo htmlentities($item['url']);?>"><?php echo $item['button'];?></a><?php }?>
											</div>
										</div>
									</div>
								</div>
								
						
						</div>
					<?php
				}?></div><?php } else
				{?>
					<div class="row col-md-12 col-sm-12 col-xs-12"></div>	
				<?php 
				}
		}
?>
<div class="row col-md-12 col-sm-12 col-xs-12 size-y-<?php echo $last_row_maxheight - 1;;?>"></div>
</div>
