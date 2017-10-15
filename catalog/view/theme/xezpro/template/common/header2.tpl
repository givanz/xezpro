<div id="header">
  <div class="">
	<div class="row">
	  <div class="col-sm-3 col-xs-5">
		<div id="logo">
		  <?php if ($logo) { ?>
		  <a href="<?php echo $home; ?>">
			<img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /><span><?php echo $name; ?></span>
		  </a>
		  <?php } else { ?>
		  <h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
		  <?php } ?>
		</div>
	  </div>
	  <div class="col-sm-6 col-xs-1">
		  <?php if (isset($search) && !empty($search)) echo $search; else {?>
				<form action="/" class="navbar-form navbar-search navbar-right search2" role="search">
				  <div class="input-group"> 

					  <button type="submit" class="btn btn-default icon-search"></button> 
					
					  <?php if (isset($search)) {?>
					  <input type="text" name="search" class="search-query col-xs-8" placeholder="<?php if (isset($text_search)) echo $text_search; ?>" value="<?php if (isset($search)) echo $search; ?>" />
					  <?php } else {?>
						<?php if (isset($filter_name)) { ?>
							<input type="text" name="filter_name" class="search-query col-xs-8" value="<?php echo $filter_name; ?>" /> 
						<?php } else { ?>
							<input type="text" id="search_input" class="search-query col-xs-4" name="filter_name" value="<?php echo $text_search;?>"/>
						<?php } ?>
					  <?php }?>	

				  </div>
				  </form>				  
		  <?php } ?>
		  <?php $head = nico_get_modules('header');if($head) foreach ($head as $module) echo $module;?></div>
			<div class="col-sm-3 col-xs-6 search-col">
	
		  <?php echo $cart; ?>
	<!--	  
	  </div>
	  <div class="col-sm-3"> --></div>
	</div>
  </div>
</div>
