<!--cols:<?php if (isset($grid_cols) && $grid_cols) echo $grid_cols + $grid_offset;else echo 12;?>   -->
<div class="<?php if (isset($grid_cols) &&$grid_cols) {?>col-md-<?php echo $grid_cols;}?> <?php if (isset($grid_offset) && $grid_offset) {?>col-md-offset-<?php echo $grid_offset;}?> <?php if (isset($grid_padding) && $grid_padding) {?>no_padding<?php if (isset($grid_padding) && $grid_padding == 2) echo 'left';else if (isset($grid_padding) && $grid_padding == 3) echo 'right'; }?>">
<?php
global $_config;
?>
		<div class="newsletter clearfix">

			<!-- Begin MailChimp Signup Form -->
				<form action="<?php if ($type == 1) {?>/index.php?route=account/newsletter<?php } else { ?>http://<?php echo $mailchimp_key;} ?>"
					class="validate" id="mc-embedded-subscribe-form" method="post" name="mc-embedded-subscribe-form"  novalidate="" target="_blank">

						<div class="text">
							<h3><?php if (!empty($newsletter_text)) echo $newsletter_text; else echo 'Newsletter';?></h3>
							<?php if (!empty($additional_text)) {?><div><?php echo $additional_text;?></div><?php }?>
						</div>
						<div class="inputs">
							<input class="email" id="mce-EMAIL" name="EMAIL" placeholder="<?php if (!empty($email_text)) echo $email_text; else echo 'Email address';?>" required="" type="email" value=""> 
							<input class="button btn btn-primary" name="subscribe" type="submit" value="<?php if (!empty($subscribe_text)) echo $subscribe_text; else echo 'Subscribe';?>">&nbsp;
							<input type="hidden" value="1" name="newsletter">
						</div>
				</form>
			<!--End mc_embed_signup-->
		</div>
</div>
