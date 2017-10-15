<!--cols:<?php if (isset($grid_cols) && $grid_cols) echo $grid_cols + $grid_offset;else echo 12;?>   -->
<div class="<?php if (isset($grid_cols) &&$grid_cols) {?>col-md-<?php echo $grid_cols;}?> <?php if (isset($grid_offset) && $grid_offset) {?>col-md-offset-<?php echo $grid_offset;}?> <?php if (isset($grid_padding) && $grid_padding) {?>no_padding<?php if (isset($grid_padding) && $grid_padding == 2) echo 'left';else if (isset($grid_padding) && $grid_padding == 3) echo 'right'; }?> nicopopup">
<?php 
$popup_module_id = 'popup_' . $module_id;
$show = 'show()';
switch ($popup_type)
{
	case 'block':
	$show = 'show()';
	?>
	<div id="<?php echo $popup_module_id;?>">
	<div role="alert" class="alert alert-warning alert-dismissible fade in text-center">
      <div class="container">
		  <button aria-label="Close" data-dismiss="alert" class="close" type="button"><span aria-hidden="true">×</span></button>
		  <?php echo $content;?>&nbsp;
		  
		  <?php if ($visibility == "checkbox") {?><input type="checkbox" name="visibility" onclick="popup_checkbox('<?php echo $popup_module_id;?>', this.checked)"> <label for="visibility"><?php echo $checkbox_text;?></label>&nbsp;&nbsp;<?php }?>
		  <button aria-label="Close" data-dismiss="alert" class="btn btn-default push-right" type="button"<?php if ($visibility == "close") {?> onclick="popup_close('<?php echo $popup_module_id;?>')"<?php }?>><?php echo $close_button_text;?></button>
	  </div>
     </div>
     </div>
	<?php
	break;
	case 'modal':
	$show = 'modal("show")';
	?>
	
		<!-- Modal -->
		<div class="modal fade" id="<?php echo $popup_module_id;?>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
		  <div class="modal-dialog" role="document" >
      		<div class="modal-content">
			  <div class="modal-body">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			  <?php echo $content;?>
			  </div>
			  <div class="modal-footer">
				<?php if ($visibility == "checkbox") {?><input type="checkbox" name="visibility" onclick="popup_checkbox('<?php echo $popup_module_id;?>', this.checked)"> <label for="visibility"><?php echo $checkbox_text;?></label>&nbsp;&nbsp;<?php }?>
				<button type="button" class="btn btn-default btn-sm" data-dismiss="modal"<?php if ($visibility == "close") {?> onclick="popup_close('<?php echo $popup_module_id;?>')"<?php }?>><?php echo $close_button_text;?></button>
			  </div>
			</div>
		  </div>
		</div>	
	<?php
	break;
}

$_popup_js = <<<JSS
JSS;


switch ($visibility)
{
	case 'always':
$_popup_js .= <<<JSS
		$(document).ready( function()
		{	
			$('#$popup_module_id').$show;
		});	
JSS;
	break;
	case 'checkbox':
$_popup_js .= <<<JSS
		$(document).ready( function()
		{	
			if (!Cookies.get("$popup_module_id") == "1")
			{
				$('#$popup_module_id').$show;
			} else 
			$('#$popup_module_id').hide();
		});	
JSS;
	break;
	case 'first':
$_popup_js .= <<<JSS
		$(document).ready( function()
		{	
			if (!Cookies.get("$popup_module_id") == "1")
			{
				$('#$popup_module_id').$show;
			} else 
			$('#$popup_module_id').hide();
			
			Cookies.set("$popup_module_id", "1", { expires: 365 });
		});	
JSS;
	break;
	case 'close':
$_popup_js .= <<<JSS
		$(document).ready( function()
		{	
			if (!Cookies.get("$popup_module_id") == "1")
			{
				$('#$popup_module_id').$show;
			} else 
			$('#$popup_module_id').hide();
			
			Cookies.set("$popup_module_id", "1", { expires: 365 });
		});	
JSS;
	break;
};

if (!isset($overlay_color) || empty($overlay_color)) $overlay_color = '#fff';
if (!isset($overlay_opacity) || empty($overlay_opacity)) $overlay_opacity = '0.3';

nico_add_js($_popup_js);
$_popup_css = <<<CSS
#$popup_module_id
{
	display:none;
}

#$popup_module_id .modal-content
{
	background-color:$overlay_color;
	z-index:1;
}

#$popup_module_id .modal-content::after {
    background-image: url($background_image);
    content: "";
    display: block;
    height: 100%;
    left: 0;
    opacity: $overlay_opacity;
    position: absolute;
    top: 0;
    width: 100%;
    z-index: -1;
    background-size:100%;
    background-size:cover;
}
CSS;
nico_add_css($_popup_css);
?>		
</div>
