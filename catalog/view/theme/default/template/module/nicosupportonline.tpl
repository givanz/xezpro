<!--cols:<?php if (isset($grid_cols) && $grid_cols) echo $grid_cols + $grid_offset;else echo 12;?>   -->
<div id="support-<?php echo $module_id;?>" class="support-online <?php if ($hide_on_mobile == 'true') {?>hide_on_mobile<?php }?> <?php if (isset($grid_cols) &&$grid_cols) {?>col-md-<?php echo $grid_cols;}?> <?php if (isset($grid_offset) && $grid_offset) {?>col-md-offset-<?php echo $grid_offset;}?> <?php if (isset($grid_padding) && $grid_padding) {?>no_padding<?php if (isset($grid_padding) && $grid_padding == 2) echo 'left';else if (isset($grid_padding) && $grid_padding == 3) echo 'right'; }?>">

<div class="panel <?php echo $list_style;?>">
  <!-- Default panel contents -->
  <?php if (isset($title) && empty($title)) {?> <div class="panel-heading"><?php echo $title;?></div><?php }?>
  <?php if (isset($text) && empty($text)) {?>
	<div class="panel-body">
		<p><?php echo $text;?></p>
  </div>
  <?php }?>

	<ul class="list-group">
	  <?php foreach ($section as $person) if ($person['status'] != 0){?>
	  <li class="list-group-item clearfix">
		
		<div class="pull-left">
		<img class="img-responsive <?php echo $avatar_style; ?>" src="<?php echo $person['image']; ?>" alt="<?php echo $person['name']; ?>" />
		</div>
		
		<div class="pull-left">
		<h4 class="list-group-item-heading"><?php echo $person['name'];?></h4>
		<p class="list-group-item-text"><?php echo $person['position'];?></p>
		<p class="list-group-item-text"><a href="tel:<?php echo $person['phone'];?>"><?php echo $person['phone'];?></a></p>
		<p class="list-group-item-text"><a href="mailto:<?php echo $person['phone'];?>"><?php echo $person['email'];?></a></p>
		
		
		

			
		<script type="text/javascript" src="//secure.skypeassets.com/i/scom/js/skype-uri.js"></script>
		<div id="SkypeButton_Call_<?php echo $person['skype'];?>_1" class="skype-button">
		 <script type="text/javascript">
		 Skype.ui({
		 "name": "<?php echo $person['skype_type'];?>",
		 "element": "SkypeButton_Call_<?php echo $person['skype'];?>_1",
		 "participants": ["<?php echo $person['skype'];?>"],
		 "imageColor": "<?php echo $person['skype_color'];?>",
		 "imageSize": <?php echo $person['skype_size'];?>
		 });
		 </script>
		</div>

		<a href="ymsgr:sendim?<?php echo $person['yahoo']; ?>"><img src="//opi.yahoo.com/online?u=<?php echo $person['yahoo']; ?>&t=<?php echo  $person['yahoo_thumb']; ?>" title="<?php echo $person['yahoo']; ?>"></a>			
		</div>
		
	  </li>
	  <?php }?>
	</ul>
	
</div>
</div>
<?php
if (!isset($display)) $display = 'block';

$_css = <<<CSS
#support-$module_id a
{
	color:#999;
}

#support-$module_id
{
	border-top:1px solid #eee;
	margin-top:20px;
	text-align:center;
}

#support-$module_id .list-group-item
{
	display:$display;
	padding:10px;
	text-align:left;
}

#support-$module_id .list-group-item-heading
{
	font-size:14px;
	margin-bottom:10px;
}

#support-$module_id .list-group-item-text
{
	margin-bottom:2px;
}

.support-online .pull-left:first-child
{
	margin:10px;
}

.support-online .skype-button
{
	display:inline-block
}
.support-online .skype-button p
{
	margin:0px;
	line-height:normal;
}
.support-online .skype-button img
{
	margin:0px 5px 0px 0px !important; 
	vertical-align:middle !important; 
}
CSS;
nico_add_css($_css);

