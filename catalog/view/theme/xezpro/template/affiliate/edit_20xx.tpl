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
    <?php $class = 'col-md-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-md-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-md-12'; ?>
    <?php } ?>
    <div class="<?php echo $class?>">
    			<div class="content box padding">

			 <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data"  class="form-horizontal">
				<h2><?php echo $text_your_details; ?></h2>
				
				<div class="registerbox">
				
						<div class="form-group">
							<?php if ($error_firstname) { ?>
							<div class="row">
								<span class="error col-md-12"><?php echo $error_firstname; ?></span>
							</div>
							<?php } ?>
							<label class="control-label col-md-4" for="email"><?php echo $entry_firstname; ?><span class="required">*</span></label>

							<div class="col-md-8">
								<input type="text" class="form-control" name="firstname" value="<?php echo $firstname; ?>">
							</div>
						</div>

						<div class="form-group">
							<?php if ($error_lastname) { ?>
							<div class="row">
								<span class="error col-md-12"><?php echo $error_lastname; ?></span>
							</div>
							<?php } ?>

							<label class="control-label col-md-4" for="lastname"><?php echo $entry_lastname; ?><span class="required">*</span></label>

							<div class="col-md-8">
								<input type="text" class="form-control" name="lastname" value="<?php echo $lastname; ?>">
							</div>
						</div>


						<div class="form-group">
							<?php if ($error_email) { ?>
							<div class="row">
								<span class="error col-md-12"><?php echo $error_email; ?></span>
							</div>
							<?php } ?>

							<label class="control-label col-md-4" for="email"><?php echo $entry_email; ?><span class="required">*</span></label>

							<div class="col-md-8">
								<input type="text" class="form-control" name="email" value="<?php echo $email; ?>">
							</div>
						</div>
					
						<div class="form-group">
							<?php if ($error_telephone) { ?>
							<div class="row">
								<span class="error col-md-12"><?php echo $error_telephone; ?></span>
							</div>
							<?php } ?>

							<label class="control-label col-md-4" for="telephone"><?php echo $entry_telephone; ?><span class="required">*</span></label>

							<div class="col-md-8">
								<input type="text" class="form-control" name="telephone" value="<?php echo $telephone; ?>">
							</div>
						</div>
						
						<div class="form-group">
							<label class="control-label col-md-4" for="fax"><?php echo $entry_fax; ?></label>
							<div class="col-md-8">
								<input type="text" class="form-control" name="fax" value="<?php echo $fax; ?>">
							</div>
						</div>
				

				<h2><?php echo $text_your_address; ?></h2>

						
						<div class="form-group">
							<label class="control-label col-md-4" for="company"><?php echo $entry_company; ?></label>
							<div class="col-md-8">
								<input type="text" class="form-control" name="company" value="<?php echo $company; ?>">
							</div>
						</div>


						<div class="form-group">
							<label class="control-label col-md-4" for="company"><?php echo $entry_website; ?></label>
							<div class="col-md-8">
								<input type="text" class="form-control" name="website" value="<?php echo $website; ?>">
							</div>
						</div>						
						

						<div class="form-group">
							<?php if ($error_address_1) { ?>
							<div class="row">
								<span class="error col-md-12"><?php echo $error_address_1; ?></span>
							</div>
							<?php } ?>

							<label class="control-label col-md-4" for="address_1"><?php if (isset($entry_address_1)) echo $entry_address_1; ?><span class="required">*</span></label>

							<div class="col-md-8">
								<input type="text" class="form-control" name="address_1" value="<?php echo $address_1; ?>">
							</div>
						</div>

						<div class="form-group">
							<label class="control-label col-md-4" for="address_2"><?php if (isset($entry_address_2)) echo $entry_address_2; ?></label>
							<div class="col-md-8">
								<input type="text" class="form-control" name="address_2" value="<?php echo $address_2; ?>">
							</div>
						</div>
						
						<div class="form-group">
							<?php if ($error_city) { ?>
							<div class="row">
								<span class="error col-md-12"><?php echo $error_city; ?></span>
							</div>
							<?php } ?>

							<label class="control-label col-md-4" for="city"><?php if (isset($entry_city)) echo $entry_city; ?><span class="required">*</span></label>

							<div class="col-md-8">
								<input type="text" class="form-control" name="city" value="<?php echo $city; ?>">
							</div>
						</div>
						
						<div class="form-group">
							<?php if ($error_postcode) { ?>
							<div class="row">
								<span class="error col-md-12"><?php echo $error_postcode; ?></span>
							</div>
							<?php } ?>
							<label class="control-label col-md-4" for="postcode"><?php if (isset($entry_postcode)) echo $entry_postcode; ?><span class="required">*</span></label>

							<div class="col-md-8">
								<input type="text" class="form-control" name="postcode" value="<?php echo $postcode; ?>">
							</div>
						</div>
						
						<div class="form-group">
							<?php if ($error_country) { ?>
							<div class="row">
								<span class="error col-md-12"><?php echo $error_country; ?></span>
							</div>
							<?php } ?>
							<label class="control-label col-md-4" for="country_id"><?php if (isset($entry_country)) echo $entry_country; ?><span class="required">*</span></label>

							<div class="col-md-8">
								<select name="country_id"  name="country_id">
								  <option value=""><?php echo $text_select; ?></option>
								  <?php foreach ($countries as $country) { ?>
								  <?php if ($country['country_id'] == $country_id) { ?>
								  <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
								  <?php } else { ?>
								  <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
								  <?php } ?>
								  <?php } ?>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<?php if ($error_zone) { ?>
							<div class="row">
								<span class="error col-md-12"><?php echo $error_zone; ?></span>
							</div>
							<?php } ?>

							<label class="control-label col-md-4" for="zone_id"><?php if (isset($entry_zone)) echo $entry_zone; ?><span class="required">*</span></label>

							<div class="col-md-8">
								<select name="zone_id">
								</select>
								<?php if ($error_zone) { ?>
								<span class="error"><?php echo $error_zone; ?></span>
								<?php } ?>
							</div>
						</div>
								
								
						<div class="buttons">
						  <div class="left"><a href="<?php echo $back; ?>" class="button"><?php echo $button_back; ?></a></div>
						  <div class="right">
							<input type="submit" value="<?php echo $button_continue; ?>" class="button btn btn-primary" />
						  </div>
						</div>
					</div>


			  </form>
			</div>
		  
		  </div>
	<?php echo $column_right; ?>
	
	</div>
</div>
<?php echo $footer; ?>
