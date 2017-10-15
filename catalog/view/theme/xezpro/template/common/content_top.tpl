<?php if ($modules && !empty($modules)) {?>
<div class="row">
<?php 
$position_cols = 0;
foreach ($modules as $module) { ?>
<?php 
	$position_cols += $module_cols = (int)substr($module, 9, 2);
	echo $module; 
	if ($position_cols % 12 == 0 || $module_cols == 0) { ?>
	</div><div class="row">
<?php } } ?>
</div>
<?php }