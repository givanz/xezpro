<?php
global $_config, $nico_include_path;
if(!isset($_config)) $_config =  $this->registry->get('config');

if (!isset($nico_include_path))
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
?>
<div class="screen_<?php echo $screen_position;?>">
	<div>
		<div>
			<div>
			<?php if (isset($section) && is_array($section)) foreach ($section as $slide) {?>
			<div class="sideblock" style="width:<?php echo $slide['content_width'] + 35;?>px">
				<div class="body" style="width:<?php echo $slide['content_width'];?>px;left:<?php echo $slide['width'];?>px;height:<?php echo $slide['content_height'];?>px;">
			<?php
			switch ($slide['section_type'])
			{
				/* ------------------------------ youtube ----------------------*/
				case 'youtube':
			?>  
				<iframe width="<?php echo $slide['content_width'];?>" height="<?php echo $slide['content_height'];?>" src="//www.youtube.com/embed/<?php echo $slide['youtube_id'];?>" allowfullscreen></iframe>
			<?php
				break;
				
				/* ------------------------------ vimeo ----------------------*/
				case 'vimeo':
			?>
				<iframe src="//player.vimeo.com/video/<?php echo $slide['vimeo_id'];?>"  width="<?php echo $slide['content_width'];?>" height="<?php echo $slide['content_height'];?>" allowfullscreen></iframe>
			<?php
				break;
				
				/* ------------------------------ facebook ----------------------*/
				case 'facebook':
			?>
				<div id="fb-root" class="fb-root-sideblock"></div>
<?php				
$_facebook_js = <<<FJS
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (!d.getElementById(id))
  {
	  js = d.createElement(s); js.id = id;
	  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.4";
	  fjs.parentNode.insertBefore(js, fjs);
  }
  
  jQuery(".fb-root-sideblock iframe").ready(function() 
  {
	  var interval = setInterval(function ()
	  {
	    width = jQuery(".fb-root-sideblock iframe").width();
	    if (width > 0)
	    {
			jQuery(".fb-root-sideblock").width(width - 2);
			clearInterval(interval);
		}
	  }, 1000);
  });
}(document, 'script', 'facebook-jssdk'))
FJS;
nico_add_js($_facebook_js);?>

				<div class="fb-like-box" data-href="https://www.facebook.com/<?php echo $slide['facebook_id'];?>" data-width="<?php echo $slide['content_width'];?>"  data-height="<?php echo $slide['content_height'];?>" data-colorscheme="light" data-show-faces="true" data-header="true" data-stream="false" data-show-border="false"></div>	
			<?php
				break;

				/* ------------------------------ twitter ----------------------*/
				case 'twitter':
			?>

				<a class="twitter-timeline" href="https://twitter.com/twitterapi" data-widget-id="<?php echo $slide['twitter_id'];?>"></a>
				<?php 
					nico_add_js('!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs")');
				break;
				
				/* ------------------------------ text ----------------------*/
				case 'text':
			?>
				<?php echo html_entity_decode($slide['text']);?>
			<?php
				break;
			}	
			?>	
				</div>
				<div class="head" style="background:<?php echo $slide['background'];?>;color:<?php echo $slide['color'];?>;width:35px;height:<?php echo $slide['height'];?>px;">
					<div class="icon fa fa-<?php echo $slide['icon'];?>"></div>
					<div class="title"><?php echo $slide['icon_text'];?></div>
				</div>
			</div>
			<?php }?>
			</div>
		</div>
	</div>
</div>
