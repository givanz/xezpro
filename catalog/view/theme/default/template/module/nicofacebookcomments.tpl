<!--cols:<?php if (isset($grid_cols) && $grid_cols) echo $grid_cols + $grid_offset;else echo 12;?>   -->
<div class="<?php if (isset($grid_cols) && $grid_cols) {?>col-md-<?php echo $grid_cols;}?> <?php if (isset($grid_offset) && $grid_offset) {?>col-md-offset-<?php echo $grid_offset;}?> <?php if (isset($grid_padding) && $grid_padding) {?>no_padding<?php if (isset($grid_padding) && $grid_padding == 2) echo 'left';else if (isset($grid_padding) && $grid_padding == 3) echo 'right'; }?>">
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.6&appId=<?php if (isset($appid) && !empty($appid)) echo $appid;?>";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
<div class="fb-comments" 
data-href="<?php if (isset($href) && !empty($href)) echo $href; else echo trim($_SERVER["HTTP_HOST"] . $_SERVER["REQUEST_URI"], "/"); ?>" 
data-numposts="<?php if (isset($numposts) && !empty($numposts)) echo $numposts; else echo '5';?>" 
data-colorscheme="<?php if (isset($href) && !empty($href)) echo $href; else echo 'light';?>" 
data-mobile="<?php if (isset($mobile) && !empty($mobile)) echo $mobile;?>" 
data-order-by="<?php if (isset($order_by) && !empty($order_by)) echo $order_by; else echo 'social';?>" 
data-width="<?php if (isset($width) && !empty($width)) echo $width; else echo '100%';?>" 
></div>
</div>
