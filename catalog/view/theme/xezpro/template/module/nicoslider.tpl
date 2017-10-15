<!--cols:<?php if ($grid_cols) echo $grid_cols + $grid_offset;else echo 12;?>   -->
<?php 
$_config =  $this->registry->get('config');
$theme_name = $_config->get('config_template');

if ($type == 'flexslider')  {?>
		<div class="row">
		    <div class="col-md-12 slideshow">
				<div>
					<ul class="slides">
					<?php foreach ($section as $slide) {?>
					<li>
						<?php if ($slide['url']) { ?>
						<a href="<?php echo $slide['url']; ?>">
							<img src="<?php echo $slide['image']; ?>" alt="<?php echo $slide['title']; ?>" />
							<?php if (isset($slide['text'])) {?><p class="flex-caption"><?php echo $slide['text'];?></p><?php }?>
						</a>
						<?php } else { ?>
							<img src="<?php echo $slide['image']; ?>" alt="<?php echo $slide['title']; ?>" />
							<?php if (isset($slide['text'])) {?><p class="flex-caption"><?php echo $slide['text'];?></p><?php }?>
						<?php } ?>
					</li>
					<?php } ?>
				   </ul>
				</div>
			</div>
		</div>
		
		<link rel="stylesheet" type="text/css" href="catalog/view/theme/<?php echo $theme_name;?>/css/flexslider.css">	
		<script language="javascript" type="text/javascript" src="catalog/view/theme/<?php echo $theme_name;?>/js/jquery.flexslider.js"></script>

		<script>
		$(document).ready( function()
		{	
			$('.slideshow > div').flexslider({
				animation:"slide",
				easing:"",
				direction:"horizontal",
				startAt:0,
				initDelay:0,
				slideshowSpeed:7000,
				animationSpeed:600,
				prevText:"Previous",
				nextText:"Next",
				pauseText:"Pause",
				playText:"Play",
				pausePlay:false,
				controlNav:true,
				slideshow:true,
				animationLoop:true,
				randomize:false,
				smoothHeight:false,
				useCSS:true,
				pauseOnHover:true,
				pauseOnAction:true,
				touch:true,
				video:false,
				mousewheel:false,
				keyboard:false
		});
		});	
		</script>	
<?php 
}
  else if($type == 'camera')
{?>

	<div  id="slideshow<?php echo $module; ?>">
        <div class="camera_wrap camera_emboss camera_white_skin"  style=" height: <?php echo $height; ?>px;" >
			<?php foreach ($section as $slide) {?>
				<div data-thumb="<?php echo $slide['image']; ?>" data-src="<?php echo $slide['image']; ?>" <?php if ($slide['url']) { ?>data-url="<?php echo $slide['url']; ?>"<?php }?>>
				<?php if (isset($slide)) {?><div class="camera-caption fadeIn">
					<h2><?php echo $slide['title'];?></h2>
					<h3><?php echo $slide['description'];?></h3>
					<?php if ($slide['url']) { ?><a href="<?php echo $slide['url'];?>"><?php  
						 if (isset($slide['urlText']))
						 echo $slide['urlText'];?></a><?php }?>
				</div><?php }?>
            </div>
            <?php }?>
        </div>
    </div>
    
	<script>
		$(document).ready( function()
		{	
			jQuery('#slideshow<?php echo $module; ?> > div').camera({
			alignment:"<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['alignment']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['alignment'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Alignment']['default'];
			 /*Alignment center*/
			 ?>",
			autoAdvance:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['autoAdvance']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['autoAdvance'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Auto advance']['default'];
			 /*Auto advance true*/
			 ?>,
			mobileAutoAdvance:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['mobileAutoAdvance']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['mobileAutoAdvance'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Mobile auto advance']['default'];
			 /*Mobile auto advance true*/
			 ?>,
			barDirection:"<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['barDirection']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['barDirection'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Bar direction']['default'];
			 /*Bar direction leftToRight*/
			 ?>",
			barPosition:"<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['barPosition']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['barPosition'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Bar position']['default'];
			 /*Bar position bottom*/
			 ?>",
			cols:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['cols']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['cols'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Columns']['default'];
			 /*Columns 6*/
			 ?>,
			easing:"<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['easing']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['easing'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Easing animation']['default'];
			 /*Easing animation easeInOutExpo*/
			 ?>",
			mobileEasing:"<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['mobileEasing']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['mobileEasing'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Mobile easing animation']['default'];
			 /*Mobile easing animation easeInOutExpo*/
			 ?>",
			fx:"<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['fx']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['fx'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Animation type']['default'];
			 /*Animation type random*/
			 ?>",
			mobileFx:"<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['mobileFx']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['mobileFx'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Mobile animation type']['default'];
			 /*Mobile animation type random*/
			 ?>",
			gridDifference:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['gridDifference']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['gridDifference'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Grid difference']['default'];
			 /*Grid difference 250*/
			 ?>,
			height:"<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['height']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['height'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Height']['default'];
			 /*Height 50%*/
			 ?>",
			hover:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['hover']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['hover'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Pause on hover']['default'];
			 /*Pause on hover true*/
			 ?>,
			loader:"<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['loader']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['loader'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Loader']['default'];
			 /*Loader pie*/
			 ?>",
			loaderColor:"<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['loaderColor']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['loaderColor'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Loader color']['default'];
			 /*Loader color #eeeeee*/
			 ?>",
			loaderBgColor:"<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['loaderBgColor']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['loaderBgColor'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Loader background color']['default'];
			 /*Loader background color #222222*/
			 ?>",
			loaderOpacity:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['loaderOpacity']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['loaderOpacity'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Loader opacity']['default'];
			 /*Loader opacity 0.8*/
			 ?>,
			loaderPadding:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['loaderPadding']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['loaderPadding'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Loader padding']['default'];
			 /*Loader padding 2*/
			 ?>,
			loaderStroke:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['loaderStroke']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['loaderStroke'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Loader stroke']['default'];
			 /*Loader stroke 7*/
			 ?>,
			minHeight:"<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['minHeight']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['minHeight'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Min height']['default'];
			 /*Min height 200px*/
			 ?>",
			navigation:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['navigation']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['navigation'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Navigation']['default'];
			 /*Navigation true*/
			 ?>,
			navigationHover:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['navigationHover']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['navigationHover'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Navigation hover']['default'];
			 /*Navigation hover true*/
			 ?>,
			mobileNavHover:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['mobileNavHover']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['mobileNavHover'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Mobile navigation hover']['default'];
			 /*Mobile navigation hover true*/
			 ?>,
			opacityOnGrid:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['opacityOnGrid']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['opacityOnGrid'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Opacity on grid']['default'];
			 /*Opacity on grid false*/
			 ?>,
			overlayer:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['overlayer']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['overlayer'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Overlayer']['default'];
			 /*Overlayer true*/
			 ?>,
			pagination:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['pagination']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['pagination'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Pagination']['default'];
			 /*Pagination true*/
			 ?>,
			pauseOnClick:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['pauseOnClick']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['pauseOnClick'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Pause on click']['default'];
			 /*Pause on click true*/
			 ?>,
			playPause:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['playPause']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['playPause'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Play pause']['default'];
			 /*Play pause true*/
			 ?>,
			pieDiameter:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['pieDiameter']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['pieDiameter'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Pie diameter']['default'];
			 /*Pie diameter 38*/
			 ?>,
			piePosition:"<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['piePosition']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['piePosition'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Pie position']['default'];
			 /*Pie position rightTop*/
			 ?>",
			portrait:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['portrait']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['portrait'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Portrait']['default'];
			 /*Portrait false*/
			 ?>,
			rows:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['rows']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['rows'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Rows']['default'];
			 /*Rows 4*/
			 ?>,
			slicedCols:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['slicedCols']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['slicedCols'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Sliced cols']['default'];
			 /*Sliced cols 12*/
			 ?>,
			slicedRows:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['slicedRows']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['slicedRows'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Sliced rows']['default'];
			 /*Sliced rows 8*/
			 ?>,
			slideOn:"<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['slideOn']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['slideOn'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Slide on']['default'];
			 /*Slide on random*/
			 ?>",
			thumbnails:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['thumbnails']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['thumbnails'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Thumbnails']['default'];
			 /*Thumbnails false*/
			 ?>,
			time:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['time']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['time'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Time']['default'];
			 /*Time 7000*/
			 ?>,
			transPeriod:<?php
			 if (isset($_nico_settings['sliders']['Homepage']['Camera slider']['transPeriod']))
			 echo $_nico_settings['sliders']['Homepage']['Camera slider']['transPeriod'];
			 else echo $nico_sliders['Homepage']['Camera slider']['Trans period']['default'];
			 /*Trans period 1500*/
			 ?>,				
			 imagePath: '../image/'
		});
	});
	</script>    
<?php } ?>
