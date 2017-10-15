<?php
global $opencart_version;
?>
<div id="header"> 
  <div class="">
	<div class="row">
	  <div class="logo-col">
		<div id="logo">
		  <?php if ($logo) { ?>
		  <a href="<?php echo $home; ?>" id="image-logo">
			<img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" />
		  </a>
		  <?php } ?>
		  <h1 id="text-logo"><a href="<?php echo $home; ?>">
		  <span>
		  <?php 
			$logo_first_word_length = (int)nico_get_config('logo_first_word_length');
			echo substr_replace($name, '</span>', $logo_first_word_length, 0);
		  ?></a></h1>
		  <span id="text_under_logo"><?php 
		  $text_under_logo = nico_get_config('text_under_logo');
		  $_text_under_logo = '';
		  if (isset($text_under_logo[$_config->get('config_language')])) $_text_under_logo = $text_under_logo[$_config->get('config_language')];
		  elseif (isset($text_under_logo['en'])) $_text_under_logo = $text_under_logo['en'];
		  echo $_text_under_logo;
			?></span>
		</div>
		
	  </div>
	  
	  
	  <div class="search-col">
      <div class="header-phone"><span>
	  <?php	  
      	  $call_us_text = nico_get_config('call_us_text');
      	  $phone_number = nico_get_config('phone_number');
		  $_call_us_text = '';
		  if (isset($call_us_text[$_config->get('config_language')])) $_call_us_text = $call_us_text[$_config->get('config_language')];
		  elseif (isset($call_us_text['en'])) $_call_us_text = $call_us_text['en'];
		  echo $_call_us_text; ?>
		</span><?php echo $phone_number;?></div>
		  
	  <?php if ($opencart_version > 1564) echo $search; else {?>
				<form action="/" class="navbar-form navbar-search" role="search">
				  <div class="input-group"> 

					  <button type="submit" class="btn btn-default icon-search"></button> 
					  <?php if (isset($search)) {?>
					  <input type="text" name="search" class="search-query col-sm-4" autocomplete="off" placeholder="<?php if (isset($text_search)) echo $text_search; ?>" value="<?php if (isset($search)) echo $search; ?>" />
					  <?php } else {?>
						<?php if (isset($filter_name)) { ?>
							<input type="text" name="filter_name" autocomplete="off" class="search-query col-sm-8" value="<?php echo $filter_name; ?>" /> 
						<?php } else { ?>
							<input type="text" id="search_input" autocomplete="off" class="search-query col-sm-4" name="filter_name" value="<?php echo $text_search;?>"/>
						<?php } ?>
					  <?php }?>	

					  <div class="select">
					  <select name="category_id">
						<option value="0">All categories</option>
						<?php $category_id = isset($_GET['category_id'])?$_GET['category_id']:isset($_GET['path'])?$_GET['path']:0;$nico_categories = nico_get_categories();foreach ($nico_categories as $category_1) { ?>
						<?php if ($category_1['category_id'] == $category_id) { ?>
						<option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
						<?php } else { ?>
						<option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
						<?php } ?>
						<?php foreach ($category_1['children'] as $category_2) { ?>
						<?php if ($category_2['category_id'] == $category_id) { ?>
						<option value="<?php echo $category_2['category_id']; ?>" selected="selected">&emsp;<?php echo $category_2['name']; ?></option>
						<?php } else { ?>
						<option value="<?php echo $category_2['category_id']; ?>">&emsp;<?php echo $category_2['name']; ?></option>
						<?php } ?>
						<?php foreach ($category_2['children'] as $category_3) { ?>
						<?php if ($category_3['category_id'] == $category_id) { ?>
						<option value="<?php echo $category_3['category_id']; ?>" selected="selected">&emsp;&emsp;<?php echo $category_3['name']; ?></option>
						<?php } else { ?>
						<option value="<?php echo $category_3['category_id']; ?>">&emsp;&emsp;<?php echo $category_3['name']; ?></option>
						<?php } ?>
						<?php } ?>
						<?php } ?>
						<?php } ?>
					  </select>
					  </div>
				  </div>
				  </form>			
			  <?php } ?>	  

		 


		  <?php echo $cart; ?>
		</div>
	</div>
  </div>
</div>
