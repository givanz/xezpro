<!-- tabs start -->
<?php foreach ($section as $i =>$tab) {?>
<li><a data-toggle="tab" href="#tab-<?php echo $i;?>"><?php echo $tab['title']; ?></a></li>		
<?php } ?>
<!-- tabs end -->
<!-- content start -->
<?php foreach ($section as $i =>$tab) {?>
<div class="tab-pane" id="tab-<?php echo $i;?>"><?php echo html_entity_decode($tab['text']); ?></div>
<?php } ?>
<!-- content end -->
