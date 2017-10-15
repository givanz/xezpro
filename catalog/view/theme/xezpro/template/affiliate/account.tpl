<?php 
echo $header; 
?>
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
		
    				<?php if (isset($text_description)) {?><div class="registerbox"><?php echo $text_description; ?></div><?php }?>
				 <h2><?php echo $text_my_account; ?></h2>
			
				  <div class="content box padding">
				  <ul>
					  <li><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
					  <li><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
					  <li><a href="<?php echo $payment; ?>"><?php echo $text_payment; ?></a></li>
					</ul>
				  </div>
				  
				  <h2><?php echo $text_my_tracking; ?></h2>
				  <div class="content box padding">
					<ul>
					  <li><a href="<?php echo $tracking; ?>"><?php echo $text_tracking; ?></a></li>
					</ul>
				  </div>
				  <h2><?php echo $text_my_transactions; ?></h2>
				  <div class="content box padding">
					<ul>
					  <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
					</ul>
				  </div>
								  
			</div>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?>
	</div>
<?php echo $footer; ?>
