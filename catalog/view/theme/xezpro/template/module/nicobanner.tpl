<!--cols:<?php if (isset($grid_cols) && $grid_cols) echo $grid_cols + $grid_offset;else echo 12;?>   -->
<div class="<?php if (isset($grid_cols) &&$grid_cols) {?>col-md-<?php echo $grid_cols;}?> <?php if (isset($grid_offset) && $grid_offset) {?>col-md-offset-<?php echo $grid_offset;}?> <?php if (isset($grid_padding) && $grid_padding) {?>no_padding<?php if (isset($grid_padding) && $grid_padding == 2) echo 'left';else if (isset($grid_padding) && $grid_padding == 3) echo 'right'; }?>">
<?php
switch ($type)
{
    case 'title':
?> 
		<div class="banners clearfix">
			<?php foreach ($section as $banner) {?>
			<div class="col-sm-<?php echo $cols;?> banner">
				<a href="<?php echo $banner['image_url']; ?>">
				<div class="icon fa fa-<?php echo $banner['icon_title']; ?>"></div>
				<div>
					<?php echo $banner['title']; ?>
				</div>
				</a>
			</div>
			<?php } ?>
		</div>
<?php 
	break;
	case 'image':
?>
		<div class="banners clearfix">
			<?php foreach ($section as $banner) {?>
			<div class="col-sm-<?php echo $cols;?> banner">
				<a href="<?php echo $banner['image_url']; ?>">
					<img src="<?php echo $banner['image']; ?>" alt="">
				</a>
			</div>
			<?php } ?>
		</div>
<?php 
	break;
    case 'icon':
?> 
		<div class="banners clearfix">
			<?php foreach ($section as $banner) {?>
			<a href="<?php echo $banner['image_url']; ?>">
			<div class="col-sm-<?php echo $cols;?> banner-icon img-circle">
				<div class="icon fa fa-<?php echo $banner['icon']; ?>"></div>
			</div>
			</a>
			<?php } ?>
		</div>
<?php 
	break;
}
?>
</div>
