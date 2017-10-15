<!--cols:<?php if (isset($grid_cols) && $grid_cols) echo $grid_cols + $grid_offset;else echo 12;?>   -->
<?php
global $_type, $_button_cart, $_per_column, $_per_row;
$_button_cart = $button_cart;
$_type = $type;?>
<div class="offcanvas">
<div class="navbar yamm col-lg-8 col-md-8 col-sm-6 <?php if (isset($hide_on_mobile) && $hide_on_mobile == 'true') {?> hide_on_mobile<?php }?>">

  <div class="navbar-header">
	<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".offcanvas.menu">
	  <span class="sr-only">Toggle navigation</span>
	  <span class="icon-bar"></span>
	  <span class="icon-bar"></span>
	  <span class="icon-bar"></span>
	</button>
	<?php if (isset($mobile_text) && $mobile_text) {?><a href="#" class="navbar-brand visible-xs"><?php echo $mobile_text;?></a><?php }?>
  </div>
  


	<?php 
	if (isset($this->registry)) $registry = $this->registry;
	$session =  $registry->get('session');
	$current_lang = $session->data['language'];
	if (is_object($current_lang)) $current_lang = $current_lang->get('code');
	include_once('nico_product.tpl');
	$_per_column = (isset($children_per_column) && !empty($children_per_column))?$children_per_column:5;
	$_per_row = (isset($categories_per_row) && !empty($categories_per_row))?$categories_per_row:3;
	
	if (!function_exists('_opencart_menu_offcanvas'))
	{
		function _opencart_menu_offcanvas(&$categories, $level = false, $i)
		{
				global $current_lang;
				$level++;
				foreach($categories as $category)
				{
					$i++;
				?>
				
				<a href="<?php if ((isset($category['children']) && !empty($category['children']))) echo '#p' . $i; else if(isset($category['url'])) echo $category['url'];?>" class="list-group-item" <?php if ((isset($category['children']) && !empty($category['children'])) || $category['menu_type'] != 'text' ) {?>data-toggle="collapse"<?php }?>>
					<?php echo $category['name'];?>
					<?php if ($level == 1){ if (isset($category['children'])) {?><b class="fa fa-chevron-down"></b><?php } }?>				
				</a>
				
				<?php if (isset($category['children']) && !empty($category['children'])) {?> 
					<div class="collapse" id="<?php echo 'p' . $i;?>">
					<?php _opencart_menu_offcanvas($category['children'], $i);?> 
					</div>
				<?php } ?>
				<?php
				}
		 }
	 }?>	  
	 <!-- outside -->
	 <div class="offcanvas menu <?php if ($type == 'offcanvas_right') echo 'right';?>">
	 <div class="navbar-collapse collapse">
		 <button data-target=".offcanvas.menu" data-toggle="collapse" class="navbar-toggle" type="button">
		  
		 </button>
		 
		<div class="nav navbar-nav">
			<div class="list-group panel">
			<!-- li><a href="<?php //echo $home; ?>"><span class="home">&#8962;</span></a></li -->
			<?php	
			global $__this;
			$__this = $_this;
			
			if (!function_exists('generate_menu_offcanvas'))
			{
			function generate_menu_offcanvas(&$categories, &$current_lang, &$opencart_categories, $level)
			{
				global $__this, $_type, $_per_column, $_per_row;
			?>	 
			<?php 
			$level++;
			$i=0;
			if (isset($categories))
			foreach($categories as $category)
			{
				//if (isset($category['categories'])) _opencart_menu_offcanvas($opencart_categories, $level); else 
				{
				$i++;
			?>
			<a href="<?php if ((isset($category['children']) && !empty($category['children'])) || $category['menu_type'] != 'text' ) echo '#p-' . $level . '-'. $i; else if(isset($category['url'])) echo $category['url'];?>" class="list-group-item <?php if ($category['highlight'] == 1) {?>highlight<?php }?>" <?php if ((isset($category['children']) && !empty($category['children'])) || $category['menu_type'] != 'text' ) {?>data-toggle="collapse"<?php }?>>	<?php if (isset($category['font_icon']) && $category['font_icon']) {?><b class="font_icon fa <?php echo $category['font_icon'];?>"></b><?php }?>
				<?php if (isset($current_lang) && isset($category['text'][$current_lang])) echo $category['text'][$current_lang];else if (isset($category['text'][key($category['text'])])) echo $category['text'][key($category['text'])];?> <?php if ((isset($category['children']) && !empty($category['children'])) || $category['menu_type'] != 'text' ) {?><b class="fa fa-chevron-down"></b><?php }?></a>

				<?php if ($category['menu_type'] == 'category') { if ($category['full_width'] == 1) { $no_children= array();?> 
					<div class="collapse" id="<?php echo 'p-' . $level . '-' . $i;?>">
						  <!-- Content container to add padding -->
						  <div class="yamm-content clearfix">
							<div class="row">
								<?php 
								$i=0;$j=0;
								$categs = $__this->get_categories($category['category']);
								$no_children = array();
								
								foreach ($categs as $cat) { if (is_array($cat['children']) && count($cat['children'])) {$i++;?>
								  <ul class="col-sm-<?php echo $_per_row;?> list-unstyled">
									<li>
									  <p><a href="<?php echo $cat['url'];?>"><strong><?php echo $cat['name'];?></strong></a><?php if ($cat['thumb']) {?><img class="cat_thumb" src="<?php echo $cat['thumb'];?>" alt=""><?php }?></p>
									</li>
									<?php $j=0; $len = count($cat['children']);if ($len > 0)foreach ($cat['children'] as $child) { $cat_name = $cat['name']; $j++;?>
									<li><a href="<?php echo $child['url'];?>"><?php echo $child['name'];?></a></li>
									<?php /*echo '<li>' . $i  .' - '. ($i % 4) . '</li>';*/
										if (($j % $_per_column == 0) && ($j < $len)) 
										{
											echo '</ul>';
											if (($i % (12 /$_per_row)) == 0) { echo '</div><div class="row">';};
											echo '<ul class="col-sm-' . $_per_row . ' list-unstyled">';
											if ((($i % (12 /$_per_row)) == 0) && $cat_name != $cat['name']) 
											{
												echo '<li><p><a href="'. $cat['url'] . '"><strong>'. $cat['name'] . '</strong></a></p></li>';
											} else 
											{
												echo '<li><p><strong>&nbsp;</strong></p></li>';
											}
											$i++;
										} 
									} ?>
								  </ul>
								<?php if (($i % (12 /$_per_row)) == 0) echo '</div><div class="row">'; } else { if ($cat) $no_children[] = $cat;}; if ($i % (12 / $_per_row) == 0) echo '</div><div class="row">';}?>
								<?php if (isset($no_children) && !empty($no_children)) {?>
								<ul class="col-sm-<?php echo $_per_row;?> list-unstyled">
								<li>&nbsp;</li>	
								<?php $j=1;$len = count($no_children);foreach ($no_children as $child) { $j++;
									/*if ($j % 4 == 0 && $j < $len) 
									{
										echo '</ul><ul class="col-sm-<?php echo $_per_row;?> list-unstyled">';
										$i++;  
									}*/?>
									<li><a href="<?php echo $child['url'];?>"><strong><?php echo $child['name'];?></strong></a></li>
								<?php }?>
								</ul>
								<?php }?>
						  </div>
						 </div>
						 </div>
				<?php } else { ?>
					<div class="collapse" id="<?php echo 'p-' . $level . '-' . $i;?>">
					<?php $i=0;$categs = $__this->get_categories($category['category']);
						foreach ($categs as $cat) { $i++;
							$has_children = (is_array($cat['children']) && count($cat['children']));
							?>
							
							<a href="<?php if (!$has_children) echo $cat['url']; else echo '#c' . $i;?>" class="list-group-item" <?php if ($has_children) {?>data-toggle="collapse"<?php }?>>
							<?php echo $cat['name'];?><?php if ($has_children) {?><b class="fa fa-chevron-down"></b><?php }?> <?php if ($has_children) {?><span class="cat_url" onclick="location.href='<?php echo $cat['url'];?>'"><i class="fa fa-mail-forward"></i></span><?php }?>
							</a>
							<?php if ($has_children) {?>
							<div class="collapse" id="<?php echo 'c' . $i;?>">
								<?php foreach($cat['children'] as $child) {
								$has_grandchildren = (is_array($child['children']) && count($child['children']));?>
								<a href="<?php if (!$has_grandchildren) echo $child['url']; else echo '#gc' . $i;?>" class="list-group-item" <?php if ($has_grandchildren) {?>data-toggle="collapse"<?php }?>><?php echo $child['name'];?><?php if ($has_grandchildren) {?><b class="fa fa-chevron-down"></b><?php }?></a>
								
								<?php if ($has_grandchildren) {?>
									<div class="collapse" id="<?php echo 'gc' . $i;?>">
										<?php foreach($child['children'] as $grandchild) {?>
										<a href="<?php echo $grandchild['url'];?>"  class="list-group-item"><?php echo $grandchild['name'];?></a>
										<?php }?>
									</div>
								<?php }?>
							<?php }?>
							</div>
						<?php }?>
						<?php }?>
					</div>
				<?php } } else if ($category['menu_type'] == 'html') {;?> 
					<div class="collapse" id="<?php echo 'p-' . $level . '-' . $i;?>">
						  <!-- Content container to add padding -->
						  <div class="yamm-content clearfix">
							<?php if (isset($category['html'][$current_lang])) echo $category['html'][$current_lang];?>
						  </div>
					</div>
				<?php } else if ($category['menu_type'] == 'manufacturers') {;?> 
					<div class="collapse" id="<?php echo 'p-' . $level . '-' . $i;?>">
						  <!-- Content container to add padding -->
						  <div class="yamm-content clearfix">
							<div class="row">
								<?php 
								$i=0;$j=0;
								$manufacturers = $__this->get_manufacturers($category);
								if (!empty($manufacturers)) {?>
								<?php $j=0;$len = count($manufacturers);
								foreach ($manufacturers as $child) 
								{ 
									$cat_name = $child['name']; $j++;
									/*if ($j % 4 == 0 && $j < $len) 
									{
										echo '</ul><ul class="col-sm-<?php echo $_per_row;?> list-unstyled">';
										$i++;  
									}*/?>
									<a class="manufacturer_thumb list-group-item"  href="<?php echo $child['url'];?>"><?php if (isset($child['thumb'])) {?><img src="<?php echo $child['thumb'];?>" alt="<?php echo $child['name'];?>"><?php }?> <?php echo $child['name'];?></a>
								<?php }?>
								<?php }?>
						  </div>
						 </div>
					 </div>
				<?php } else if ($category['menu_type'] == 'product') {;?> 
					<div class="collapse" id="<?php echo 'p-' . $level . '-' . $i;?>">
						  <!-- Content container to add padding -->
						  <div class="yamm-content clearfix">
							<div class="row">
							<?php $products = $__this->get_products($category['autocomplete']);
								foreach ($products as $product) {?>
									<div class="col-md-<?php echo 12 / $category['columns'];?>">
									<?php if (function_exists('nico_product')) nico_product($product);?>
									</div>
								<?php } ?>
							</div>
						  </div>
					  </div>
				<?php } else if ($category['menu_type'] == 'category_products') {;?> 
					<div class="collapse" id="<?php echo 'p-' . $level . '-'  . $i;?>">
						  <!-- Content container to add padding -->
						  <div class="yamm-content clearfix">
							<div class="row">
							<?php $products = $__this->get_products_category($category['products_category']);
								foreach ($products as $product) {?>
									<div class="col-md-3">
									<?php if (function_exists('nico_product')) nico_product($product);?>
									</div>
								<?php } ?>
							</div>
						  </div>
					  </div>
				<?php } else if (isset($category['children'])) {;?> 
					 <div class="collapse" id="<?php echo 'p-' . $level . '-' . $i;?>">
					<?php generate_menu_offcanvas($category['children'], $current_lang, $opencart_categories, $level);?> 
					</div>
				<?php } ?>
			<?php } } ?>
			<?php } } 
			if ($content_type == '1') 
			{
				$categories = $__this->get_categories(0);
				_opencart_menu_offcanvas($categories);
			}else
			{
				generate_menu_offcanvas($menu, $current_lang, $categories, 0);
			}?>	  
		</div>
		</div>

		<?php /* echo $language; ?>

		<?php echo $currency; ?>

		<?php echo $cart; ?>

		<form action="/" class="navbar-form navbar-search navbar-right" role="search">
		  <div class="input-group"> 
			
			  <?php if (isset($search)) {?>
			  <input type="text" name="search" class="search-query col-md-2" placeholder="<?php if (isset($text_search)) echo $text_search; ?>" value="<?php if (isset($search)) echo $search; ?>" />
			  <?php } else {?>
				<?php if (isset($filter_name)) { ?>
					<input type="text" name="filter_name" class="search-query col-md-2" value="<?php echo $filter_name; ?>" /> 
				<?php } else { ?>
					<input type="text" id="search_input" class="search-query col-md-2" name="filter_name" value="<?php echo $text_search;?>"/>
				<?php } ?>
			  <?php }?>	

			<button type="submit" class="btn btn-default icon-search"></button> 
		  </div>
		</form>
		 <?php */?>
	  </div><!-- /.navbar-collapse -->
	</div>
	<div class="pusher"></div>
     <!-- end outside -->
</div>
</div>
