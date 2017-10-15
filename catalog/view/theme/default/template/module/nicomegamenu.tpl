<!--cols:<?php if (isset($grid_cols) && $grid_cols) echo $grid_cols + $grid_offset;else echo 12;?>   -->
<?php
global $_type, $_button_cart, $_per_column, $_per_row;
$_button_cart = $button_cart;
$_type = $type;
if ($type == 'offcanvas_left' || $type == 'offcanvas_right') { include('nicomegamenu_offcanvas.tpl'); return; }
if ($type == 'vertical') {?><div class="sidebar-nav"><?php }?>
<div class="navbar yamm <?php if (isset($grid_cols) &&$grid_cols) {?>col-md-<?php echo $grid_cols;}?> <?php if (isset($grid_offset) && $grid_offset) {?>col-md-offset-<?php echo $grid_offset;}?> <?php if (isset($grid_padding) && $grid_padding) {?>no_padding<?php if (isset($grid_padding) && $grid_padding == 2) echo 'left';else if (isset($grid_padding) && $grid_padding == 3) echo 'right'; }?>">

  <div class="navbar-header">
	<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
	  <span class="sr-only">Toggle navigation</span>
	  <span class="icon-bar"></span>
	  <span class="icon-bar"></span>
	  <span class="icon-bar"></span>
	</button>
	<?php if (isset($mobile_text) && $mobile_text) {?><a href="#" class="navbar-brand visible-xs"><?php echo $mobile_text;?></a><?php }?>
  </div>
  
	<?php 
	$session =  $this->registry->get('session');
	$current_lang = $session->data['language'];
	if (is_object($current_lang)) $current_lang = $current_lang->get('code');
	include_once('nico_product.tpl');
	$_per_column = (isset($children_per_column) && !empty($children_per_column))?$children_per_column:5;
	$_per_row = (isset($categories_per_row) && !empty($categories_per_row))?$categories_per_row:3;
	
	if (!function_exists('_opencart_menu'))
	{
		function _opencart_menu(&$categories, $level = false)
		{
				global $current_lang;
				$level++;
				foreach($categories as $category)
				{
				?>
				<li <?php if (isset($category['children']) && !empty($category['children'])) {?>class="dropdown<?php if ($level == 2){?>-menu<?php } else if ($level > 2) {?>-submenu<?php }?>"<?php }?>>
					<a href="<?php if(isset($category['url'])) echo $category['url'];?>">
					<?php echo $category['name'];?>
					
					<?php if ($level == 1){ if (isset($category['children'])) {?><b class="fa fa-chevron-down"></b><?php } }?>
					</a>
					<?php if (isset($category['children']) && !empty($category['children'])) {?> 
						<ul class="dropdown-menu">
						<?php _opencart_menu($category['children']);?> 
						</ul>
					<?php } ?>
				</li>
				<?php
				}
		 }
	 }?>	  
	 
	 <div class="navbar-collapse collapse">
		<ul class="nav navbar-nav">
			<!-- li><a href="<?php //echo $home; ?>"><span class="home">&#8962;</span></a></li -->
			<?php	
			global $__this;
			$__this = $_this;
			
			if (!function_exists('generate_menu'))
			{
			function generate_menu(&$categories, &$current_lang, &$opencart_categories, $level)
			{
				global $__this, $_type, $_per_column, $_per_row;
			?>	 
			<?php 
			$level++;
			if (isset($categories))
			foreach($categories as $category)
			{
				//if (isset($category['categories'])) _opencart_menu($opencart_categories, $level); else 
				{
			?>
			<li class="<?php if ($category['menu_type'] != 'text' && $category['full_width'] == 1) {?>mega<?php }?>
						<?php if ($category['full_width'] == 1) {?>yamm-fw <?php }?>
						<?php if ($category['highlight'] == 1) {?>highlight <?php }?>
						<?php if ((isset($category['children']) && !empty($category['children'])) || $category['menu_type'] != 'text' ) {?> dropdown <?php if ($level == 0){?>dropdown-menu<?php } else if ($level > 1) {?>dropdown-submenu<?php } }?>"
				>
				<a href="<?php if(isset($category['url'])) echo htmlentities($category['url']);?>" 
				<?php if(isset($category['target']) && $category['target'] == "_blank") {?>target="<?php echo $category['target'];?>"<?php } else { if(isset($category['url']) && !empty($category['url'])) {?> onclick="if (!isMobile()) location.href='<?php echo htmlentities($category['url']);?>'"<?php } }?>  
					<?php if (isset($category['children']) || $category['menu_type'] != 'text') {?>data-toggle="dropdown" class="dropdown-toggle"<?php }?>>
				<?php if (isset($category['font_icon']) && $category['font_icon']) {?><b class="font_icon fa <?php echo $category['font_icon'];?>"></b><?php }?>
				<?php if (isset($current_lang) && isset($category['text'][$current_lang])) echo $category['text'][$current_lang];else if (isset($category['text'][key($category['text'])])) echo $category['text'][key($category['text'])];?>
				
				<?php if ($level == 1){  if ((isset($category['children']) || $category['menu_type'] == 'category') && $_type != 'vertical') {?><b class="fa fa-chevron-down"></b><?php } }?>
				</a>
				
				
				<?php if ($category['menu_type'] == 'category') { if ($category['full_width'] == 1) { $no_children= array();?> 
					<ul class="dropdown-menu <?php if (isset($category['column']) && $category['column'] && $category['column'] > 1) { echo 'multi-' . $category['column'] . '-columns'; }?>">
						<li>
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
						</li>
					</ul>
				<?php } else { ?>
					<ul class="dropdown-menu <?php if (isset($category['column']) && $category['column'] && $category['column'] > 1) { echo 'multi-' . $category['column'] . '-columns'; }?>">
					<?php $i=0;$categs = $__this->get_categories($category['category']);
						foreach ($categs as $cat) { 
							$has_children = (is_array($cat['children']) && count($cat['children']));
							?>
						  <li <?php if ($has_children) {?>class="dropdown dropdown-submenu"<?php }?>>
							  <a href="<?php echo $cat['url'];?>" onclick="if (!isMobile()) location.href='<?php echo $cat['url'];?>'" <?php if ($has_children) { ?>class="dropdown-toggle"  data-toggle="dropdown"<?php }?>><?php echo $cat['name'];?></a>
								<?php if ($has_children) {?>
								<ul class="dropdown-menu <?php if (isset($cat['column']) && $cat['column'] && $cat['column'] > 1) { echo 'multi-' . $cat['column'] . '-columns'; }?>">
								<?php foreach($cat['children'] as $child) {
									$has_grandchildren = (is_array($child['children']) && count($child['children']));	
								?>
								<li <?php if ($has_grandchildren) {?>class="dropdown dropdown-submenu"<?php }?>><a href="<?php echo $child['url'];?>"><?php echo $child['name'];?></a>
									<?php if ($has_grandchildren) {?>
									<ul class="dropdown-menu <?php if (isset($cat['column']) && $cat['column'] && $cat['column'] > 1) { echo 'multi-' . $cat['column'] . '-columns'; }?>">
									<?php foreach($child['children'] as $grandchild) {
									?>
									<li><a href="<?php echo $grandchild['url'];?>"><?php echo $grandchild['name'];?></a></li>
									<?php }?>
									</ul>
									<?php }?>
								</li>
								<?php }?>
								</ul>
								<?php }?>
						</li>
						<?php }?>
					</ul>
				<?php } } else if ($category['menu_type'] == 'html') {;?> 
					<ul class="dropdown-menu <?php if (isset($category['column']) && $category['column'] && $category['column'] > 1) { echo 'multi-' . $category['column'] . '-columns'; }?>">
						<li>
						  <!-- Content container to add padding -->
						  <div class="yamm-content clearfix">
							<?php if (isset($category['html'][$current_lang])) echo $category['html'][$current_lang];?>
						  </div>
						</li>
					</ul>
				<?php } else if ($category['menu_type'] == 'manufacturers') {;?> 
					<ul class="dropdown-menu <?php if (isset($category['column']) && $category['column'] && $category['column'] > 1) { echo 'multi-' . $category['column'] . '-columns'; }?>">
						<li>
						  <!-- Content container to add padding -->
						  <div class="yamm-content clearfix">
							<div class="row">
								<?php 
								$i=0;$j=0;
								$manufacturers = $__this->get_manufacturers($category);
								if (!empty($manufacturers)) {?>
								<ul class="col-sm-<?php echo $_per_row;?> list-unstyled">
								<?php $j=0;$len = count($manufacturers);
								foreach ($manufacturers as $child) 
								{ 
									$cat_name = $child['name']; $j++;
									/*if ($j % 4 == 0 && $j < $len) 
									{
										echo '</ul><ul class="col-sm-<?php echo $_per_row;?> list-unstyled">';
										$i++;  
									}*/?>
									<li class="manufacturer_thumb"><a href="<?php echo $child['url'];?>"><?php echo $child['name'];?> <?php if (isset($child['thumb'])) {?><img src="<?php echo $child['thumb'];?>" alt="<?php echo $child['name'];?>"><?php }?></a></li>
										<?php /*echo '<li>' . $i  .' - '. ($i % 4) . '</li>';*/
										if (($j % $_per_column == 0) && ($j < $len)) 
										{
											echo '</ul><ul class="col-sm-' . $_per_row. ' list-unstyled">';
										} 
									?>									
								<?php }?>
								</ul>
								<?php }?>
						  </div>
						 </div>
						</li>
					</ul>
				<?php } else if ($category['menu_type'] == 'product') {;?> 
					<ul class="dropdown-menu <?php if (isset($category['column']) && $category['column'] && $category['column'] > 1) { echo 'multi-' . $category['column'] . '-columns'; }?>">
						<li>
						  <!-- Content container to add padding -->
						  <div class="yamm-content clearfix">
							<div class="row">
							<?php $products = $__this->get_products($category['autocomplete']);
								foreach ($products as $product) {?>
									<div class="col-md-3">
									<?php if (function_exists('nico_product')) nico_product($product);?>
									</div>
								<?php } ?>
							</div>
						  </div>
						</li>
					</ul>
				<?php } else if ($category['menu_type'] == 'category_products') {;?> 
					<ul class="dropdown-menu <?php if (isset($category['column']) && $category['column'] && $category['column'] > 1) { echo 'multi-' . $category['column'] . '-columns'; }?>">
						<li>
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
						</li>
					</ul>
				<?php } else if (isset($category['children'])) {;?> 
					<ul class="dropdown-menu <?php if (isset($category['columns']) && $category['columns'] && $category['columns'] > 1) { echo 'columns' . $category['columns']; }?>">
					<?php generate_menu($category['children'], $current_lang, $opencart_categories, $level);?> 
					</ul>
				<?php } ?>
			</li>
			<?php } } ?>
			<?php } } 
			if ($content_type == '1') 
			{
				$categories = $__this->get_categories(0);
				_opencart_menu($categories);
			}else
			{
				generate_menu($menu, $current_lang, $categories, 0);
			}?>	  
		</ul>


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
<?php if ($type == 'vertical') {?></div><?php }
