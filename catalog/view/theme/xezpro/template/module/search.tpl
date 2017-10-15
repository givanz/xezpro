<form action="/" class="navbar-form navbar-search navbar-right search2" role="search">
<div class="input-group"> 
  <button type="submit" class="btn btn-default icon-search"></button>
  
  <?php if (isset($search)) {?>
  <input type="text" name="search" class="search-query col-md-2" autocomplete="off" placeholder="<?php if (isset($text_search)) echo $text_search; ?>" value="<?php if (isset($search)) echo $search; ?>" />
  <?php } else {?>
    <?php if (isset($filter_name)) { ?>
        <input type="text" name="filter_name" autocomplete="off" class="search-query col-md-2" value="<?php echo $filter_name; ?>" /> 
    <?php } else { ?>
        <input type="text" id="search_input" autocomplete="off" class="search-query col-md-2" name="filter_name" value="<?php echo $text_search;?>"/>
    <?php } ?>
  <?php }?>	
</div>
</form>		
