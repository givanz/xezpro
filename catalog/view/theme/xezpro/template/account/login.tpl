<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
  <?php } ?>
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <div class="row">
        <div class="col-sm-6">
          <div class="well">
            <h2><?php echo $text_new_customer; ?></h2>
            <p><strong><?php echo $text_register; ?></strong></p>
            <p><?php echo $text_register_account; ?></p>
            <a href="<?php echo $register; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a>
	</div>
			
	<?php 
	if (isset($this->registry)) $registry = $this->registry;
	$_config =  $registry->get('config');
	if (!isset($this->config)) $this->config =  $registry->get('config');
	
	if (!$nicosocialauth = $this->config->get('nicosocialauth')) 
	if ($nicosocialauth = $this->config->get('nicosocialauth_module')) 
	{
		$nicosocialauth = $nicosocialauth[1];
	}
	
	if (!is_array($nicosocialauth)) $nicosocialauth = @json_decode($nicosocialauth, true);
	
	if ($nicosocialauth)
	{ ?>
	 <div class="well">
	<h2><?php if (isset($nicosocialauth['text'])) 
	{
		$session =  $registry->get('session');
		$current_lang = $session->data['language'];
		if (is_object($current_lang)) $current_lang = $current_lang->get('code');
		if (isset($nicosocialauth['text'][$current_lang])) echo $nicosocialauth['text'][$current_lang];
	} else echo 'Login with';?></h2>	
	<?php foreach ($nicosocialauth['section'] as $config) { ?>
	  <a href="<?php echo HTTP_SERVER . '/index.php?route=module/nicosocialauth&provider=' . $config['provider']; ?>">
	  <span class="fa-stack fa-lg">
		  <i class="fa fa-square fa-stack-2x"></i>
		  <i class="fa fa-<?php echo strtolower($config['provider']);?> fa-stack-1x fa-inverse"></i>
		</span>
	  </a>
	<?php } ?>
	   </div>
	<?php } ?>
        </div>
        <div class="col-sm-6">
          <div class="well">
            <h2><?php echo $text_returning_customer; ?></h2>
            <p><strong><?php echo $text_i_am_returning_customer; ?></strong></p>
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
              <div class="form-group">
                <label class="control-label" for="input-email"><?php echo $entry_email; ?></label>
                <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
              </div>
              <div class="form-group">
                <label class="control-label" for="input-password"><?php echo $entry_password; ?></label>
                <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" />
	      </div>
              <div class="form-group">
                <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
	      </div>
              <input type="submit" value="<?php echo $button_login; ?>" class="btn btn-primary" />
              <?php if ($redirect) { ?>
              <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
              <?php } ?>
            </form>
          </div>
        </div>
      </div>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer;
