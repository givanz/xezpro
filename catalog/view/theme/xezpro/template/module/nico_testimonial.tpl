<?php
if (!function_exists("nico_get_config"))
{
	
	$nico_include_path = __DIR__. '/../../';
	//vqmod changes paths and the above path fails, check other paths
	if (!file_exists($nico_include_path . 'nico_theme_editor/common.inc')) 
	{
		$_config =  $this->registry->get('config');
		$nico_include_path = DIR_TEMPLATE . '/' . $_config->get('config_template') . '/';
		
		if (!file_exists($nico_include_path . '/nico_theme_editor/common.inc')) $nico_include_path = dirname(__FILE__) . '/../../';
	}

	if (file_exists($nico_include_path . 'nico_theme_editor/common.inc')) require_once($nico_include_path . 'nico_theme_editor/common.inc');
}
if (!function_exists('nico_testimonial')) 
{
    function nico_testimonial($testimonial)
    {
    ?>
    <div class="testimonial">
	   <div class="image"><img src="<?php echo $testimonial['image'];?>"/></div>
		<div class="body">
		   <div class="user"><h3><?php echo $testimonial['name'];?></h3></div>
		   <div class="date"><p><?php echo $testimonial['date'];?></p></div>
		   <div class="rating">
				  <?php for ($i = 1; $i <= 5; $i++) { ?>
				  <?php if ($testimonial['rating'] < $i) { ?>
				  <span class="fa"><i class="fa fa-star"></i></span>
				  <?php } else { ?>
				  <span class="fa"><i class="fa fa-star star_rating"></i></span>
				  <?php } ?>
				  <?php } ?>
			</div>		   
		</div>		   

	   <div class="tooltip bottom clearfix">
			<div class="tooltip-arrow"></div> 
			<div class="tooltip-inner"><?php echo $testimonial['testimonial'];?></div>
		</div>

    </div>
    <?php
    }
}
