<!--cols:<?php if (isset($grid_cols) && $grid_cols) echo $grid_cols + $grid_offset;else echo 12;?>   -->
<div class="pull-<?php if (isset($align)) echo $align; else echo 'left'?> <?php if (isset($grid_cols) &&$grid_cols) {?>col-md-<?php echo $grid_cols;}?> <?php if (isset($grid_offset) && $grid_offset) {?>col-md-offset-<?php echo $grid_offset;}?> <?php if (isset($grid_padding) && $grid_padding) {?>no_padding<?php if (isset($grid_padding) && $grid_padding == 2) echo 'left';else if (isset($grid_padding) && $grid_padding == 3) echo 'right'; }?>">
  <div class="dropdown login-box">
    <a data-toggle="dropdown" class="btn btn-link dropdown-toggle" role="button">
	<i class="fa fa-user"></i>
	<span class="hidden-xs hidden-sm hidden-md"><?php if ($logged) echo $text_logged;else echo $button_text;?></span> <i class="fa fa-chevron-down"></i></a>
	
	<div role="menu" class="dropdown-menu">
		<?php if ($logged) { ?>
		<ul>
		<li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
		<li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
		<li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
		<li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
		<li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
		</ul>
		<?php } else { ?>
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
		  <div class="form-group">
			<label class="control-label" for="input-email"><?php echo $entry_email; ?></label>
			<input type="text" name="email" value="" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
		  </div>
		  <div class="form-group">
			<label class="control-label" for="input-password"><?php echo $entry_password; ?></label>
			<input type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" />
		  </div>
			<input type="submit" value="<?php echo $button_login; ?>" class="btn btn-default" />
			<a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
		</form>
		
			<?php 
			if (!isset($this->config)) $this->config =  $this->registry->get('config');
			
			if (!$nicosocialauth = $this->config->get('nicosocialauth')) 
			if ($nicosocialauth = $this->config->get('nicosocialauth_module')) 
			{
				$nicosocialauth = $nicosocialauth[1];
			}
			
			if ($nicosocialauth)
			{?>
			<h3><?php if (isset($nicosocialauth['text'])) 
			{
				$session =  $this->registry->get('session');
				$current_lang = $session->data['language'];
				if (is_object($current_lang)) $current_lang = $current_lang->get('code');
				echo $nicosocialauth['text'][$current_lang]; 
			} else echo 'Login with';?></h3>
			<?php foreach ($nicosocialauth['section'] as $config) { ?>
			  <a href="<?php echo HTTP_SERVER . '/index.php?route=module/nicosocialauth&amp;provider=' . $config['provider']; ?>">
			  <span class="fa-stack fa-lg">
				  <i class="fa fa-square fa-stack-2x"></i>
				  <i class="fa fa-<?php echo strtolower($config['provider']);?> fa-stack-1x fa-inverse"></i>
				</span>
			</a>
			<?php } ?>
			<?php } ?>
			<h3><?php echo $text_new_customer; ?></h3>
			<a href="<?php echo $register; ?>" class="btn btn-default"><?php echo $text_register; ?></a>
		<?php } ?>
	</div>
	
  </div>
</div>
