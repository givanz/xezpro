<?php if (!isset($_POST['ajax']) && strpos($_SERVER['REQUEST_URI'],'ajax=true') == false) {?>
<?php if ($modules && !empty($modules)) {?>
	<div class="col-md-3 left-menu">
	<?php 
	$position_cols = 0;
	foreach ($modules as $module) { ?>
	<?php 
		$position_cols += $module_cols = (int)substr($module, 9, 2);
		echo $module; 
	 }  ?>
</div>	 
<?php } }
