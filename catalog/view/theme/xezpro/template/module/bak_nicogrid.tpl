<?php 
global $_config;
$_config =  $this->registry->get('config');
$module_id = substr(str_shuffle("abcdefghijklmnopqrstuvwxyz"), 0, 5);
?>
<div class="grid_list" id="<?php echo $module_id;?>" style="height:<?php echo $height;?>px">
<?php 
$max_col = 0;
$max_row = 0;
$max_y = 0;
$max_x = 0;
$size = '';
foreach ($grid as $nr => $item) {
if ($item['row'] > $max_row) $max_row = $item['row'];
if ($item['col'] > $max_col) $max_col = $item['col'];

if ($item['size_x'] > $max_x) $max_x = $item['size_x'];
if ($item['size_y'] > $max_y) $max_y = $item['size_y'];
$size .= '[' . $item['size_x'] . ',' . $item['size_y'] . '],';
?>
<div class="grid_item size_x_<?php echo $item['size_x'];?> size_y_<?php echo $item['size_y'];?> col<?php echo $item['col'];?> row<?php echo $item['row'];?>" 
	<?php /*if (isset($item['color']) || isset($item['img'])) {?>style="background-color:<?php echo $item['color'];?>;background-image:url(<?php echo $item['img'];?>)"<?php }*/?>>
	<div>
		<div>
			<div>
				<?php if (isset($item['title'])) {?><h2><?php echo $item['title'];?></h2><?php }?>
				<br/>
				<?php /*if (isset($item['subtitle'])) {?><h3><?php echo $item['subtitle'];?></h3><?php }*/?>
				<?php if (isset($item['button'])) {?><a href="<?php echo $item['url'];?>"><?php echo $item['button'];?></a><?php }?>
			</div>
		</div>
	</div>
	<?php if (isset($item['img'])) {?><div class="background" style="background-image:url('<?php echo $item['img'];?>')"></div><?php }?>
</div>
<?php }?>
</div>
<style>
<?php 
$max_y;
//size y
$size_y = round(($height - ($margin_top * ($max_row)))/($max_row + 1));
for ($i = 1;$i <= $max_row + 5;$i++)
{
?>
#<?php echo $module_id;?> .size_y_<?php echo $i;?>
{
	height:<?php echo ($size_y * $i) + ($margin_top * ($i - 1));?>px;
}
<?php }?>


<?php 
//row 
$row = floor(($height - ($margin_top * ($max_row)))/($max_row + 1));
for ($i = 2;$i <= $max_row;$i++)
{
?>
#<?php echo $module_id;?> .row<?php echo $i+1;?>
{
	top:<?php echo ($row * ($i)) + ($margin_top * ($i)) + $i;?>px;
}
<?php }?>

/* Custom, iPhone Retina */ 
@media only screen and (max-width : 480px) {
	#<?php echo $module_id;?> {width:<?php echo $tiny_width;?>px;}
	<?php 
	//size x
	for ($i = 1;$i <= 12;$i++)
	{
	?>
	#<?php echo $module_id;?> .size_x_<?php echo $i;?>
	{
		width:<?php echo round(($tiny_width/(12))*($i)) - $margin_left;?>px;
	}
	<?php }?>

	<?php 
	//col
	for ($i = 1;$i <= 12;$i++)
	{
	?>
	#<?php echo $module_id;?> .col<?php echo $i;?>
	{
		left:<?php echo round(($tiny_width/(12))*($i - 1));?>px;
	}
	<?php }?>
}

/* Extra Small Devices, Phones */ 
@media only screen and (min-width : 480px) 
{
	#<?php echo $module_id;?> {width:<?php echo $extrasmall_width;?>px;}
	<?php 
	//size x
	for ($i = 1;$i <= 12;$i++)
	{
	?>
	#<?php echo $module_id;?> .size_x_<?php echo $i;?>
	{
		width:<?php echo round(($extrasmall_width/(12))*($i)) - $margin_left;?>px;
	}
	<?php }?>

	<?php 
	//col
	for ($i = 1;$i <= 12;$i++)
	{
	?>
	#<?php echo $module_id;?> .col<?php echo $i;?>
	{
		left:<?php echo round(($extrasmall_width/(12))*($i - 1));?>px;
	}
	<?php }?>
}

/* Small Devices, Tablets */
@media only screen and (min-width : 768px) {
	#<?php echo $module_id;?> {width:<?php echo $small_width;?>px;}
	<?php 
	//size x
	for ($i = 1;$i <= 12;$i++)
	{
	?>
	#<?php echo $module_id;?> .size_x_<?php echo $i;?>
	{
		width:<?php echo round(($small_width/(12))*($i)) - $margin_left;?>px;
	}
	<?php }?>

	<?php 
	//col
	for ($i = 1;$i <= 12;$i++)
	{
	?>
	#<?php echo $module_id;?> .col<?php echo $i;?>
	{
		left:<?php echo round(($small_width/(12))*($i - 1));?>px;
	}
	<?php }?>
}

/* Medium Devices, Desktops */
@media only screen and (min-width : 992px) 
{
	#<?php echo $module_id;?> {width:<?php echo $medium_width;?>px;}
	<?php 
	//size x
	for ($i = 1;$i <= 12;$i++)
	{
	?>
	#<?php echo $module_id;?> .size_x_<?php echo $i;?>
	{
		width:<?php echo round(($medium_width/(12))*($i)) - $margin_left;?>px;
	}
	<?php }?>

	<?php 
	//col
	for ($i = 1;$i <= 12;$i++)
	{
	?>
	#<?php echo $module_id;?> .col<?php echo $i;?>
	{
		left:<?php echo round(($medium_width/(12))*($i - 1));?>px;
	}
	<?php }?>
}

/* Large Devices, Wide Screens */
@media only screen and (min-width : 1200px) 
{
	#<?php echo $module_id;?> {width:<?php echo $width;?>px;}
	<?php 
	//size x
	for ($i = 1;$i <= 12;$i++)
	{
	?>
	#<?php echo $module_id;?> .size_x_<?php echo $i;?>
	{
		width:<?php echo round(($width/(12))*($i)) - $margin_left;?>px;
	}
	<?php }?>

	<?php 
	//col
	for ($i = 1;$i <= 12;$i++)
	{
	?>
	#<?php echo $module_id;?> .col<?php echo $i;?>
	{
		left:<?php echo round(($width/(12))*($i - 1));?>px;
	}
	<?php }?>
}
</style>
