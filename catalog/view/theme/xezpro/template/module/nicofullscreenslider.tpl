<?php
$_config =  $this->registry->get('config');
$theme_name = $_config->get('config_template');
?>
<script type="text/javascript" src="catalog/view/theme/<?php echo $theme_name;?>/js/jquery.backstretch.min.js"></script>
<script>
$.backstretch([
<?php
foreach ($section as $sec)
{
	echo '"' . $sec['image'] . '",';
}
?>
], {
    fade: <?php echo $fade;?>,
    duration: <?php echo $duration;?>
});
</script>
<style>
.backstretch img
{
<?php 
switch ($effect)
{
    /* ------------------------------ grid ----------------------*/
    case 'grayscale':
?>
  -webkit-filter: grayscale(100%);
  -moz-filter: grayscale(100%);
  -ms-filter: grayscale(100%);
  -o-filter: grayscale(100%);
  filter: grayscale(100%);
  filter: url(catalog/view/theme/<?php echo $theme_name;?>/css/grayscale.svg#greyscale); /* Firefox 4+ */
  filter: gray; /* IE 6-9 */
<?php    
    break;
    case 'blur':
?>
  filter: blur(10px); 
  -webkit-filter: blur(10px); 
  -moz-filter: blur(10px);
  -o-filter: blur(10px); 
  -ms-filter: blur(10px);
  filter: url(catalog/view/theme/<?php echo $theme_name;?>/css/blur.svg#blur);   
  filter: blur; /* IE 6-9 */
<?php    
    break;
}
?>
}
</style>
