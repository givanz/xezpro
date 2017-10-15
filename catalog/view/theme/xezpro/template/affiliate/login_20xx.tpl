<?php 
echo $header; 
?>


<?php if ($success) { ?>
<div class="success"><?php echo $success; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
<script>
if (notification_hide_timeout > 0) 
{
	var t=setTimeout(function()
	{
		$('.success').fadeOut('slow', function() 
		{
				$(this).remove();
		});
	}, notification_hide_timeout);
}		
</script>
<?php } ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
<script>
if (notification_hide_timeout > 0) 
{
	var t=setTimeout(function()
	{
		$('.warning').fadeOut('slow', function() 
		{
				$(this).remove();
		});
	}, notification_hide_timeout);
}	
</script>
<?php } ?>


<div class="container">
	        
		<div class="row">
		    <div class="col-md-12">
			    <div class="breadcrumbs">
					
						<ul class="breadcrumb">
						<?php foreach ($breadcrumbs as $breadcrumb) { ?>
						<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
						<?php } ?>
						</ul>
				</div>
			</div>
		</div>
		
		<div class="row">
		    <div class="col-md-12">
			    <div class="cat_header">
				    <h2><?php echo $heading_title; ?></h2>
			    </div>

			</div>
		</div>
		
		
			  <div class="row"><?php echo $column_left; ?>
				<?php if ($column_left && $column_right) { ?>
				<?php $class = 'col-sm-6'; ?>
				<?php } elseif ($column_left || $column_right) { ?>
				<?php $class = 'col-sm-9'; ?>
				<?php } else { ?>
				<?php $class = 'col-sm-12'; ?>
				<?php } ?>
				<div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
				<div class="registerbox"><?php echo $text_description; ?></div>

				<div class="row">
					<div class="col-md-6">
							
						
							<form class="loginbox form-horizontal" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
								<h2><?php echo $text_returning_affiliate; ?></h2>
								<p><?php echo $text_i_am_returning_affiliate; ?></p>
								<div class="form-group">
									<label class="control-label col-md-4" for="email"><?php echo $entry_email; ?><span class="required">*</span></label>
									<div class="col-md-8">
										<input type="text" class="form-control" name="email" value="<?php echo $email; ?>">
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-4" for="inputPassword"><?php echo $entry_password; ?><span class="required">*</span></label>
									<div class="col-md-8">
										<input type="password"  class="form-control" name="password" value="<?php echo $password; ?>">
									</div>
								</div>
								<div class="form-group">
									<div class="col-md-12">
										<input class="btn btn-primary" type="submit" value="<?php echo $button_login; ?>"/>
										<a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
									</div>
								</div>

							  <?php if ($redirect) { ?>
							  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
							  <?php } ?>
								
							</form>
					</div>
					
					<div class="col-md-6">
						
						
						 <form class="loginbox form-horizontal" action="<?php echo $register; ?>" method="get">
							<h2><?php echo $text_new_affiliate; ?></h2>
							<div class="content"><?php echo $text_register_account; ?></div>


							  <input type="hidden" name="route" value="affiliate/register" />
							 
							 <!--
							<div class="form-group">
								<label class="control-label col-md-4" for="Username">Username<span class="required">*</span></label>
								<div class="col-md-8">
									<input type="text"  class="form-control" name="Username">
								</div>
							</div> -->

							<div class="form-group">
								<label class="control-label col-md-4" for="email">Email<span class="required">*</span></label>
								<div class="col-md-8">
									<input type="text" id="email" name="email" class="form-control">
								</div>
							</div>

							<div class="form-group">
								<label class="control-label col-md-4" for="password">Password<span class="required">*</span></label>
								<div class="col-md-8">
									<input type="password"  class="form-control" name="password">
								</div>
							</div>
					   
							<div class="form-group">
								<label class="control-label col-md-4" for="confirm">Re-enter password<span class="required">*</span></label>
								<div class="col-md-8">
									<input type="password" id="inputPassword" class="form-control" name="confirm">
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
									<input class="btn btn-primary" type="submit" value="<?php echo $button_continue; ?>"/>
								</div>
							</div>
						</form>					
							   
					</div>
				</div>
		
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>

<script type="text/javascript"><!--
$('#login input').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#login').submit();
	}
});
//--></script> 
<?php echo $footer; ?>
