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
		
		
		<div class="row">
			<div class="col-md-12">
			 <div class="box padding">
				 
			  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
				<p><?php echo $text_email; ?></p>
				<h2><?php echo $text_your_email; ?></h2>
				<div class="content">
				  <table class="form">
					<tr>
					  <td><?php echo $entry_email; ?>&nbsp;</td>
					  <td><input type="text" name="email" value="" class="form-control" size="50"/></td>
					</tr>
				  </table>
				</div>
				<div class="buttons">
				  <div class="left"><a href="<?php echo $back; ?>" class="button"><?php echo $button_back; ?></a></div>
				  <div class="right">
					<input type="submit" value="<?php echo $button_continue; ?>" class="button btn btn-primary" />
				  </div>
				</div>
			  </form>
				 
			 
			 </div>
		  </div>
	</div>
</div>
<?php echo $footer; ?>
