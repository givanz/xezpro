<?php 
global $module_name,  $autocomplete_products, $module_row, $module_name, $module_config, $config_size, $section_config, $section_text, $font_awesome_icons, $nico_theme_positions, $opencart_version, $categs, $_modules, $lang_img_path, $_languages;
//$modules = $_modules;
$_languages = $languages;

if ($opencart_version >= 2200) $lang_img_path = 'language/'; else  $lang_img_path = '../image/flags/';

if ($opencart_version > 2000) { include('nicomegamenu2010.tpl');die();}
$categs = $categories;
$module_name = 'nicomegamenu';

$module_config = array(
	'type'=>array('select', 
		    array('horizontal' => 'Horizontal',
			      'vertical' => 'Vertical',
   			      'offcanvas_left' => 'Off canvas left',
   			      'offcanvas_right' => 'Off canvas right',
			      ),
		    'Orientation'
	    ),
	'content_type'=>array('select', 
			array('0' => 'Mega Menu',
				  '1' => 'Opencart Categories'),
			'Menu type'
		),
		
	'align'=>array('select', 
			array('' => 'None',
				  'left' => 'Left',
				  'right' => 'Right'),
			'Menu alignment'
		),
		
	'mobile_text'=>array('multilanguage',null,'Mobile text <span class="help">(text shown near mobile menu button)</span>', 'Categories'),

	'hide_on_mobile'=>array('select', 
					array('false' => 'No',
						  'true' => 'Yes'),
					'Hide on mobile'
				),

	'categories_per_row'=>array('select', 
				array('12' => '1',
					  '6' => '2',
					  '4' => '3',
					  '3' => '4',
					  '2' => '6',
					  '1' => '12',
					  ),
				'Parent categories with children per row', 12
			),
			
	'children_per_column'=>array('input',null,'Children categories per column', 5),

	'section' => array('custom', 'megamenu', 'Mega menu'),
);


function megamenu($module)
{
	global $languages, $module_row, $categs, $_module_row, $opencart_version;
	if ($module !== true)
	{
		$_module_row = $module_row;
	} else
	{
		$_module_row = '__MODULE_ROW__';
	}
	
	?>
	<div class="nico_menu" row="<?php echo $_module_row;?>">
			<?php	
			
			$_nico_generate_menu = function( &$cats, $level, $id ) use ( &$_nico_generate_menu, $module )
			{
				global $languages, $module_name, $module_row, $_module_row, $categs, $opencart_version;
			?>	 
		    <ul>
 			<?php 
 			$i = 0;
 			if (isset($cats) && is_array($cats))
			foreach($cats as $category)
			{
			?>
			<li <?php if (isset($category['categories'])){?> class="categories"<?php }?>>
				<a href="">
				    <?php if (isset($category['text'])) echo current($category['text']); else if (isset($category['categories'])) echo 'Opencart categories'?>
				    <div style="display:none">

					<div style="margin:10px 0px;" class="lang">
					<?php $first=true;foreach ($languages as $language) { ?>
					<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?> &nbsp; 
					<input type="text" _name="text" _code="<?php echo $language['code'];?>" size="10" class="<?php if ($first) {echo 'first';$first=false;}?>"
					 value="<?php if (isset($category['text'][$language['code']])) echo $category['text'][$language['code']]; ?>" />
					<?php }  ?>
					</div>
					
				
					<label>Url</label> <input type="text" _name="url" size="20"
					 value="<?php if (isset($category['url'])) echo $category['url'];?>"/>							 

					Target
					<select _name="target">
					    <option value="_self"  <?php if (isset($category['target']) && $category['target'] =='_self') {?>selected=true<?php } ?>>Same window</option>
					    <option value="_blank"  <?php if (isset($category['target']) && $category['target'] =='_blank') {?>selected=true<?php } ?>>New window</option>
					</select>

					</br>
					
					Full width
					<select _name="full_width">
					    <option value="0" <?php if (isset($category['full_width']) && $category['full_width'] == '0') {?>selected=true<?php } ?>>No</option>
					    <option value="1" <?php if (isset($category['full_width']) && $category['full_width'] == '1') {?>selected=true<?php } ?>>Yes</option>
					</select>

					<span class="columns">
					Columns
					<select _name="columns">
					    <option value="1" <?php if (isset($category['columns']) && $category['columns'] == '1') {?>selected=true<?php } ?>>1</option>
					    <option value="2" <?php if (isset($category['columns']) && $category['columns'] == '2') {?>selected=true<?php } ?>>2</option>
					    <option value="3" <?php if (isset($category['columns']) && $category['columns'] == '3') {?>selected=true<?php } ?>>3</option>
					    <option value="4" <?php if (isset($category['columns']) && $category['columns'] == '4') {?>selected=true<?php } ?>>4</option>
					</select>
					</span>
					
					Highlight
					<select _name="highlight">
					    <option value="0" <?php if (isset($category['highlight']) && $category['highlight'] == '0') {?>selected=true<?php } ?>>No</option>
					    <option value="1" <?php if (isset($category['highlight']) && $category['highlight'] == '1') {?>selected=true<?php } ?>>Yes</option>
					</select>
				
					<label>Font icon</label>
					<input type="text" _name="font_icon" size="20"
					 value="<?php if (isset($category['font_icon'])) echo $category['font_icon'];?>"/>							 
					<br/>

					Type
					<select _name="menu_type" class="menu_type" style="margin:10px 0px;">
					    <option value="text" <?php if (isset($category['menu_type']) && $category['menu_type'] =='text') {?>selected=true<?php } ?>>Text</option>
					    <option value="category_products" <?php if (isset($category['menu_type']) && $category['menu_type'] =='category_products') {?>selected=true<?php } ?>>Products</option>
					    <option value="product" <?php if (isset($category['menu_type']) && $category['menu_type'] =='product') {?>selected=true<?php } ?>>Products autocomplete</option>
					    <option value="category" <?php if (isset($category['menu_type']) && $category['menu_type'] =='category') {?>selected=true<?php } ?>>Category</option>
					    <option value="manufacturers" <?php if (isset($category['menu_type']) && $category['menu_type'] =='manufacturers') {?>selected=true<?php } ?>>Manufacturers</option>
					    <option value="htmltype" <?php if (isset($category['menu_type']) && $category['menu_type'] =='htmltype') {?>selected=true<?php } ?>>Html</option>
					</select>
			
				    <br/>   

					<div class="menu_section text">
					</div>
	
					<div class="menu_section product" <?php if (isset($category['menu_type']) && $category['menu_type'] !='product') {?>style="display:none"<?php }?>>
					<?php if ($opencart_version < 2000) {?>
						<input type="text" _name="product" value="" module="<?php echo $_module_row; ?>" autocomplete="off"/>
						<div class="scrollbox" module="<?php echo $_module_row; ?>">
								<?php $class = 'odd'; ?>
								<?php if(isset($category['autocomplete'])) 
								{ 
								    $products = array_combine(explode(',', $category['autocomplete']), explode(',', $category['autocomplete_names']));
								    
								    foreach ($products as $id => $product) { ?>
								<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
								<div class="<?php echo $module_name;?>-product<?php echo $id; ?> <?php echo $class; ?>">
								  <?php echo urldecode($product); ?> <img src="view/image/delete.png" alt="" />
								  <input type="hidden" value="<?php echo $id; ?>" _label="<?php echo $product; ?>"/>
								</div>
						<?php } }?>
						</div>
						<input type="hidden" _name="autocomplete" 
						value="<?php if (isset($category['autocomplete'])) echo $category['autocomplete'];?>" />
						<input type="hidden" _name="autocomplete_names" 
						value="<?php if (isset($category['autocomplete_names'])) echo $category['autocomplete_names'];?>" />
					<?php } else {?>
						<input type="text" _name="product" value="" 
						module="<?php echo $_module_row; ?>" 
						placeholder="Product" id="input-product" class="form-control" autocomplete="off"/>
						<span class="help-block">(Autocomplete)</span>
						<div id="autocomplete-<?php echo $_module_row; ?>" class="well well-sm" style="height: 150px; overflow: auto;">
						  <?php if(isset($category['autocomplete'])) 
						  {
							  $products = array_combine(explode(',', $category['autocomplete']), explode(',', $category['autocomplete_names']));
							  foreach ($products as $id => $product) { ?>
						  <div id="autocomplete-<?php echo $_module_row; ?>-<?php echo $id;?>"><i class="fa fa-minus-circle"></i> <?php  echo urldecode($product); ?>
							<input type="hidden" value="<?php echo $id; ?>" _label="<?php echo $product; ?>"/>
						  </div>
						  <?php } } ?>
						</div>
						<input type="hidden" _name="autocomplete" 
						value="<?php if (isset($category['autocomplete'])) echo $category['autocomplete'];?>" />
						<input type="hidden" _name="autocomplete_names" 
						value="<?php if (isset($category['autocomplete_names'])) echo $category['autocomplete_names'];?>" />
					<?php } ?>
						
					</div>
					<div class="menu_section category" <?php if (isset($category['menu_type']) && $category['menu_type'] !='category') {?>style="display:none"<?php }?>>
					    Categories
					    <select class="categories" _name="category">
					    <option value="0">All categories</option>
					      <?php foreach($categs as $id => $catname) {?>
						    <option value="<?php echo $id;?>" <?php if (isset($category['category']) && $category['category'] == $id) {?>selected="selected"<?php } ?>>
						    <?php echo $catname;?>
						    </option>
					      <?php }?>
					    </select>
					</div>	  
					
			<div class="menu_section category_products"  <?php if (isset($category['menu_type']) && $category['menu_type'] !='category_products') {?>style="display:none"<?php }?>>
				Sources
				<select class="categories" _name="products_category">
				<optgroup label="Sources">
					<option value="-1" <?php if (isset($module) && isset($category['products_category']) && $category['products_category'] == -1) {?>selected="selected"<?php } ?>>Latest</option>
					<option value="-2" <?php if (isset($module) && isset($category['products_category']) && $category['products_category'] == -2) {?>selected="selected"<?php } ?>>Popular</option>
					<option value="-3" <?php if (isset($module) && isset($category['products_category']) && $category['products_category'] == -3) {?>selected="selected"<?php } ?>>Bestsellers</option>
				</optgroup>
				
				<optgroup label="Categories">
				<option value="0">All categories</option>
				  <?php foreach($categs as $id => $_name) {?>
					<option value="<?php echo $id;?>">
					<?php echo $_name;?>
					</option>
				  <?php }?>
				</select>
				</optgroup>

				Limit
				<input type="text" _name="products_category_limit" 
				value="<?php if (isset($category['products_category_limit'])) echo $category['products_category_limit']; else echo 4;?>" size="3"/>
			</div>		

				<div class="menu_section manufacturers"  <?php if (isset($category['menu_type']) && $category['menu_type'] !='manufacturers') {?>style="display:none"<?php }?>><br/>
					Manufacturer start
					<input type="text" _name="manufacturer_start" 
					value="<?php if (isset($category['manufacturer_start'])) echo $category['manufacturer_start']; else echo 0;?>" size="3" />

					Manufacturer limit
					<input type="text" _name="manufacturer_limit" 
					value="<?php if (isset($category['manufacturer_limit'])) echo $category['manufacturer_limit']; else echo 20;?>" size="3"/>
					<br/>
					Manufacturer sort
					<select class="manufacuter_sort" _name="manufacuter_sort">
					 <option value="sort_order">Sort order</option>
					 <option value="name" <?php if (isset($module) && isset($category['manufacuter_sort']) && $category['manufacuter_sort'] == 'name') {?>selected="selected"<?php } ?>>Name</option>
					</select>

					Manufacturer order
					<select class="manufacuter_order" _name="manufacuter_sort">
					 <option value="ASC">Ascending</option>
					 <option value="DESC" <?php if (isset($module) && isset($category['manufacuter_order']) && $category['manufacuter_order'] == 'DESC') {?>selected="selected"<?php } ?>>Descending</option>
					</select>
					</div>							
					
					
					<div class="menu_section htmltype"  <?php if ( isset($category['menu_type']) && $category['menu_type'] !='htmltype') {?>style="display:none"<?php }?>>
					    <br/>
					    <?php $first=true;foreach ($languages as $language) { ?>
					    <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?> &nbsp; 
					    <textarea cols=80 rows=10 class="html_editor" _code="<?php echo $language['code'];?>"  _name="html" _name="html" id="text_<?php echo rand();?>"><?php if (isset($category['html'][$language['code']])) echo $category['html'][$language['code']]; ?></textarea>
					    <?php } ?>
					</div>					  

					<br/>
					<br/>
					<div href="#" title="Add subcategory" class="add_subcat btn btn-primary" >
						add subcat
					</div>
					<div href="#" title="Remove" class="remove btn btn-primary" >
						remove
					</div>
					</div>
				    </a>
			<?php if (isset($category['children'])) { echo 'recurse';$_nico_generate_menu($category['children'], ++$level, $id . (($level > 1)?'[children]':'') . '[' . $i . ']');} $i++;?>
			</li>
			<?php } ?>
			 </ul>	
			 <?php }; $empty = array('0' => array('text' => array('en' => 'Menu item')));if (isset($module['menu'])) $_nico_generate_menu($module['menu'], 0, '');?>
			</div>
			<a class="btn btn-primary nico_add_menu_item">Add new menu item</a>
		    <input type="hidden" name="nicomegamenu_module[<?php echo $_module_row;?>][menu]">
		    <br/><br/>
		    Note: Click on the folder icon to drag an drop menu items
	<?php
}

ob_start();
?>
<div class="nico_new_menu_item_template" style="display:none">
     <div>
	    <div style="margin:10px 0px;" class="lang">
	    <?php $first = true;foreach ($languages as $language) { ?>
	    <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?> &nbsp; 
	    <input type="text" _name="text" _code="<?php echo $language['code'];?>" size="10" class="<?php if ($first) {echo 'first';$first=false;}?>"
	     value="Menu item" />
	    <?php }  ?>
	    </div>
	    
	    <label>url</label> <input type="text" _name="url" size="20"
	     value="<?php if (isset($category['url'])) echo $category['url'];?>"/>							 

		<label>Font icon</label>
		<input type="text" _name="font_icon" size="20"
		 value="<?php if (isset($category['font_icon'])) echo $category['font_icon'];?>"/>							 

	    Target
	    <select _name="target">
		<option value="_self">Same window</option>
		<option value="_blank">New window</option>
	    </select>
	    <br/>

	    Full width
	    <select _name="full_width">
		<option value="0">No</option>
		<option value="1">Yes</option>
	    </select>

		<span class="columns">
		Columns
		<select _name="columns">
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
		</select>
		</span>

	    Highlight
	    <select _name="highlight">
		<option value="0">No</option>
		<option value="1">Yes</option>
	    </select>
	    

	    Type
	    <select _name="menu_type" class="menu_type" style="margin:10px 0px;">
		<option value="text">Text</option>
		<option value="category_products">Products</option>
		<option value="product">Product autocomplete</option>
		<option value="category">Category</option>
		<option value="manufacturers">Manufacturers</option>
		<option value="htmltype">Html</option>
	    </select>

	    <br/>   
					
	    <div class="menu_section text">
	    </div>
	    <div class="menu_section product" style="display:none">
			
			
		<?php if ($opencart_version < 2000) {?>
				<input type="text" _name="product" value="" module="<?php echo isset($module_row_section)?$module_row_section:''; ?>">
				<div id="<?php echo $module_name;?>-product-autocomplete-<?php echo isset($module_row_section)?$module_row_section:''; ?>" class="scrollbox" module="<?php echo isset($module_row_section)?$module_row_section:''; ?>">
					
					
				</div>
				<input type="hidden" _name="autocomplete" 
				value="<?php if (isset($category['autocomplete'])) echo $category['autocomplete'];?>" />
	
			<?php } else {?>
				<input type="text" _name="product" value="" 
				module="<?php echo isset($module_row_section)?$module_row_section:''; ?>"
				placeholder="Product" id="input-product" class="form-control" autocomplete="off"/>
				<span class="help-block">(Autocomplete)</span>
				<div id="autocomplete-<?php echo $_module_row; ?>" class="well well-sm" style="height: 150px; overflow: auto;">

				</div>
				<input type="hidden" _name="autocomplete" 
				value="<?php if (isset($category['autocomplete'])) echo $category['autocomplete'];?>" />
				<input type="hidden" _name="autocomplete_names" 
				value="<?php if (isset($category['autocomplete_names'])) echo $category['autocomplete_names'];?>" />
			<?php } ?>			
	    </div>
	    <div class="menu_section category" style="display:none">
		Category
		<select class="categories" _name="category">
		 <option value="0">All categories</option>
		  <?php if(isset($categs) && is_array($categs)) foreach($categs as $id => $catname) {?>
			<option value="<?php echo $id;?>" <?php if (isset($module) && isset($category['category']) && $category['category'] == $id) {?>selected="selected"<?php } ?>>
			<?php echo $catname;?>
			</option>
		  <?php }?>
		</select>
	    </div>	
	    

			<div class="menu_section category_products" style="display:none">
				Sources
				<select class="categories" _name="products_category">
				<optgroup label="Sources">
					<option value="-1">Latest</option>
					<option value="-2">Popular</option>
					<option value="-3">Bestsellers</option>
				</optgroup>
				
				<optgroup label="Categories">
				<option value="0">All categories</option>
				  <?php foreach($categs as $id => $_name) {?>
					<option value="<?php echo $id;?>">
					<?php echo $_name;?>
					</option>
				  <?php }?>
				</select>
				</optgroup>


				Limit
				<input type="text" _name="products_category_limit" 
				value="4" size="3"/>
				<br/>
			</div>	  
		  
		<div class="menu_section manufacturers" style="display:none"><br/>
		Manufacturer start
		<input type="text" _name="manufacturer_start" 
		value="<?php if (isset($category['manufacturer_start'])) echo $category['manufacturer_start']; else echo 0;?>" size="3" />

		Manufacturer limit
		<input type="text" _name="manufacturer_limit" 
		value="<?php if (isset($category['manufacturer_limit'])) echo $category['manufacturer_limit']; else echo 20;?>" size="3"/>
		<br/>
		Manufacturer sort
		<select class="manufacuter_sort" _name="manufacuter_sort">
		 <option value="sort_order">Sort order</option>
		 <option value="name" <?php if (isset($module) && isset($category['manufacuter_sort']) && $category['manufacuter_sort'] == 'name') {?>selected="selected"<?php } ?>>Name</option>
		</select>

		Manufacturer order
		<select class="manufacuter_order" _name="manufacuter_sort">
		 <option value="ASC">Ascending</option>
		 <option value="DESC" <?php if (isset($module) && isset($category['manufacuter_order']) && $category['manufacuter_order'] == 'DESC') {?>selected="selected"<?php } ?>>Descending</option>
		</select>

		</div>		
	    
	      
	    <div class="menu_section htmltype"  style="display:none">
		<?php $first=true;foreach ($languages as $language) { ?>
		<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?> &nbsp; 
		<textarea cols=80 rows=10 class="html_editor" _code="<?php echo $language['code'];?>"  _name="html" _name="html" id="text_<?php echo rand();?>"><?php if (isset($category['html'][$language['code']])) echo $category['html'][$language['code']]; ?></textarea>
		<?php } ?>
	    </div>					  


	    <br/>
	    <br/>
	    <div href="#" title="Add subcategory" class="add_subcat btn btn-primary" >
		    add subcat
	    </div>
	    <div href="#" title="Remove" class="remove btn btn-primary" >
		    remove
	    </div>
    </div>    
</div>

<link rel="stylesheet" href="view/javascript/jquery/jstree3/themes/default/style.min.css" type="text/css" />
<script>
var nico_mega_menu_template = '<br/><div style="display:none">' +  jQuery(".nico_new_menu_item_template").clone().removeClass('nico_new_menu_item_template').html() + '</div>';
</script>
<script src="view/javascript/jquery/jstree3/jstree.js"></script>
<script>
    

$('.nico_menu').delegate('select.menu_type', 'change', function() 
{
    var parent =  this.parentNode;
    jQuery(".menu_section", parent).hide();
    jQuery(".menu_section." + jQuery(this).val(), parent).show();   
    <?php if ($opencart_version < 2000) {?>
    if (jQuery(this).val() == 'htmltype')
    jQuery('> div .html_editor', parent)
     .ckeditor({
	    filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	    filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	    filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	    filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	    filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	    filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
    }).resize( '100%', '250' );
    <?php } ?>
});


$('.nico_menu').delegate('.lang > input.first', 'keyup', function()     
{
    text = this.value;
    first = true;
    jQuery("> a.jstree-anchor", jQuery(this).parents(".jstree-node:first")).contents().filter(function() 
    {
		//Node.TEXT_NODE === 3
		if (this.nodeType === 3 && first == true)
		{
			first = false;
			return true;
		}
		return false;
    }).each(function () 
    {
		this.nodeValue = text;
    });
    /*first = true;
    jQuery('.jstree-anchor', jQuery(this).closest('li')).contents().filter(function() 
    {
	//Node.TEXT_NODE === 3
	if (this.nodeType === 3 && first == true)
	{
	    first = false;
	    return true;
	}
	return true;
    }).each(function () 
    {
		this.nodeValue = text;
    });*/
    return true;
});
    
//$.jstree.defaults.core.themes.dots = false;
$.jstree.defaults.core.expand_selected_onload = true;	
$.jstree.defaults.core.check_callback = true;	


var $treeview = $(".nico_menu").on('select_node.jstree', function (e, data) 
{
<?php if ($opencart_version < 2000) {?>
  CKEDITOR.config.height = 200;    
    
    //jQuery('#' + data.node.id +' > div > div').css("visibility", "hidden");//ckeditor events are broken
    
    if (jQuery('.menu_type',this).val() == 'htmltype')
    jQuery('#' + data.node.id +' > div > div .html_editor')/*.on('instanceReady.ckeditor', function (e) 
    {
	jQuery('#' + data.node.id +' > div > div').css("visibility", "visible");
    })*/
    .ckeditor({
	    filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	    filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	    filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	    filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	    filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	    filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
    }).resize( '100%', '250' );
<?php }?>
});

$treeview.jstree({"plugins" : [ "dnd", "state" ]})


jQuery(".nico_menu").delegate(".remove", "click", function() {
	var node = this.parentNode.parentNode;
	var li = node.parentNode;

	if (confirm("Are you sure you want to remove this menu item and all it's submenus?"))
	{
		<?php if ($opencart_version < 2000) {?>
		var editor = CKEDITOR.instances[jQuery('.html_editor', li).attr('id')];
		if (editor) { editor.destroy(true); }
		<?php }?>
	    var ref = $(this).closest('.nico_menu').jstree(true);
		sel = ref.get_selected();
		if(!sel.length) { return false; }
		sel = sel[0];
			    
		jQuery("> div", node).remove();
		ref.delete_node(sel);
		jQuery(li).remove();
	}
	return false;
});

jQuery(".nico_menu").delegate(".add_subcat", "click", function(e) {
    
	var ref = $(this).closest('.nico_menu').jstree(true);
	sel = ref.get_selected();
	if(!sel.length) { return false; }
	sel = sel[0];
	newnode = ref.create_node(sel, "Menu item");
	jQuery('#' + sel + ' .html_editor', this.parentNode).attr("id", ("text_" + Math.random()).replace(/0./,''));
	ref.open_node(sel);
	//ref.activate_node(newnode, e);
	//setTimeout(function () {ref.activate_node(newnode, e);}, 100);
	return true;
});


jQuery(document.body).on("click", "a.nico_add_menu_item",function(e) 
{
	var ref = $('.nico_menu', this.parentNode).jstree(true);
	if (typeof ref._model == 'undefined' || !ref)
	{
	    ref = $(".nico_menu", this.parentNode).jstree({"plugins" : [ "dnd", "state" ]}).jstree(true);
	}
	newnode = ref.create_node("#", "Menu item");
	jQuery('#' + newnode + ' .html_editor', this.parentNode).attr("id", ("text_" + Math.random()).replace(/0./,''));
	ref.open_node(newnode);
});		

jQuery(".nico_menu").delegate("select[_name='full_width']", "change", function(e) {
    
	if (jQuery(this).val() == '1') jQuery("> span.columns", this.parentNode).hide(); else 
	jQuery("> span.columns", this.parentNode).show();
});


<?php if ($opencart_version >= 2000) {?>
$(document).on("keyup.autocomplete", 'input[_name=\'product\']', function()
{ 
	var module = jQuery(this).attr('module');
	var input = jQuery(this);
	var autocomplete_container = this.parentNode;

	$(this).autocomplete({
		'source': function(request, response) {
	if (typeof request != "string" && request.term) request = request.term;
	
			$.ajax({
				url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
				dataType: 'json',			
				success: function(json) {
					response($.map(json, function(item) {
						return {
							label: item['name'],
							value: item['product_id'],
						}
					}));
				}
			});
		},
		'select': function(item) {
			
			//console.log('#autocomplete-' + module + '-' + section);
			//console.log($('#autocomplete-' + module + '-' + section));
			//console.log(item);
			
			$('#autocomplete-' + module + '-' + item['value'], autocomplete_container).remove();
			
			$('div.well', autocomplete_container).append('<div id="autocomplete-' + module +'-' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" value="' + item['value'] + '"  _label="' + item['label'] + '"/></div>');	
		
			data = $.map($('div > input', autocomplete_container), function(element){
				return $(element).attr('value');
			});

			data_label = $.map($('div > input', autocomplete_container), function(element){
				return $(element).attr('_label');
			});		
								
			$(jQuery('input[_name="autocomplete"]', autocomplete_container)).attr('value', data.join());
			$(jQuery('input[_name="autocomplete_names"]', autocomplete_container)).attr('value', data_label.join());
		}	
	});
});

$('.well').on('click', '.fa-minus-circle', function() {
	var autocomplete_container = this.parentNode.parentNode.parentNode;
	$(this.parentNode).remove();

	data = $.map($('.well input', autocomplete_container), function(element){
		return $(element).attr('value');
	});
	
	data_label = $.map($('.well input', autocomplete_container), function(element){
		return $(element).attr('_label');
	});		
					
	$(jQuery('input[_name="autocomplete"]', autocomplete_container)).attr('value', data.join());
	$(jQuery('input[_name="autocomplete_names"]', autocomplete_container)).attr('value', data_label.join());
});

<?php } else {?>
$(document).on("keyup.autocomplete", 'input[_name=\'product\']', function()
{ 
	
var module = jQuery(this).attr('module');
var input = jQuery(this);
var autocomplete_container = this.parentNode;
	
$(this).autocomplete({
	delay: 500,
	source: function(request, response) 
	{
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {		
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.product_id
					}
				}));
			}
		});
	}, 
	select: function(event, ui) 
	{
		scrollbox = jQuery('.scrollbox', autocomplete_container);
		node_id = scrollbox.closest('li').attr('id');
		module = scrollbox.attr('module');
		
		$('.<?php echo $module_name;?>-product' + ui.item.value, scrollbox).remove();
		
		scrollbox.append('<div node_id="' + node_id + '" module="' + module + '" class="<?php echo $module_name;?>-product' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" value="' + ui.item.value + '" _label="' + escape(ui.item.label) +'"/></div>');

		$(' div:odd', scrollbox).addClass('odd').removeClass('even');
		$(' div:even', scrollbox).addClass('even').removeClass('odd');
		
		data = $.map($('input', scrollbox), function(element){
			return $(element).attr('value');
		});
		
		data_label = $.map($('input', scrollbox), function(element){
			return $(element).attr('_label');
		});

		$(jQuery('input[_name="autocomplete"]', this.parentNode)).attr('value', data.join());
		$(jQuery('input[_name="autocomplete_names"]', this.parentNode)).attr('value', data_label.join());
					
		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});
});

$('.scrollbox div').on('click', 'img', function() {
	var scrollbox = this.parentNode.parentNode;
	$(this.parentNode).remove();
	
	$('div:odd', scrollbox).attr('class', 'odd');
	$('div:even', scrollbox).attr('class', 'even');

	data = $.map($('input', scrollbox), function(element){
		return $(element).attr('value');
	});

	data_label = $.map($('input', scrollbox), function(element){
		return $(element).attr('_label');
	});
	
	$('input[_name="autocomplete"]', scrollbox.parentNode).attr('value', data.join());
	$(jQuery('input[_name="autocomplete_names"]', scrollbox.parentNode)).attr('value', data_label.join());
});
<?php } ?>


function before_save()
{
    
	var _nico_changes = {};
	$treeview.jstree('open_all');
//	$.jstree.core.open_all($(".nico_menu"));
	
	var mega_menu = {};
	function processOneLi(node) {       
		var retVal = {};
		jQuery(" > div input, > div select, > div textarea", node).each(function() 
		{
		    var $this = jQuery(this);
		    var name = $this.attr("_name");
		    var val = $this.val();
		    if (name == 'text') 
		    {
			if (!retVal['text']) retVal['text'] = {};
			if (val != '') retVal['text'][$this.attr("_code")] = val;
		    } else
		    if (name == 'html') 
		    {
			if (!retVal['html']) retVal['html'] = {};
			if (val != '') retVal['html'][$this.attr("_code")] = val;
		    } else if (typeof name != 'undefined'  && val != null && val != '' ) retVal[name] = val.isArray?JSON.stringify(val):val;
		});
		
		//$treeview.jstree('open_node', node);
		node.find("> ul > li").each(function() 
		{
		    if (!retVal.hasOwnProperty("children")) 
		    {
			    retVal.children = [];
		    }
		    retVal.children.push(processOneLi($(this)));
		});
		return retVal;
	}
	$(".nico_menu").each(function() 
	{
	    row = jQuery(this).attr("row");
	    mega_menu = [];
	    $("> ul.jstree-container-ul > li.jstree-node", this).each(function() 
	    {
		    mega_menu.push(processOneLi($(this)));
	    });
	    //console.dir(mega_menu);
	    //console.log(JSON.stringify(mega_menu));
	    jQuery('[name="nicomegamenu_module[' + row + '][menu]"]').val(JSON.stringify(mega_menu));
	});
	
//	$('#form').submit(menu, function () {});
	//$('#form').submit();
	//_nico_changes['nicomegamenu_module'] = mega_menu;
	//console.log(JSON.stringify(_nico_changes));
	
	//console.log($.param(_nico_changes));
	
	//console.log(unescape($('#form').serialize()));
	$('#form').submit();
	return false;
	
	$.ajax({
	  type:"POST",
	  url: $('#form').attr("action"),
	  data:$.param(_nico_changes) + $('#form').serialize(),
	  context: document.body
	}).done(function() { 
		//console.dir(_nico_changes);
	});
	
	
	
	return false;
}	
</script>		
<style>
div.inline
{
	display:inline-block;
	padding:5px;
}

.jstree-clicked > div, .jstree-clicked + div, .jstree-clicked + br + div
{
	display:inline-block !important;
}


.jstree-default li div.menu_section
{
    margin:10px 0px 0px;
    vertical-align:middle;
    display:inline;
}

.jstree-default li div .btn, .btn {
    -moz-user-select: none;
    background-image: none;
    border: 1px solid rgba(0, 0, 0, 0);
    border-radius: 4px;
    cursor: pointer;
    display: inline-block;
    font-size: 14px;
    font-weight: normal;
    line-height: 1.42857;
    margin-bottom: 0;
    padding: 6px 12px;
    text-align: center;
    vertical-align: middle;
    border: medium none;
    border-radius: 4px;
    font-size: 12px;
    text-decoration:none;
}    

.jstree-default li div .btn-primary,.btn-primary  
{
    background-color: #7ABCE7;
    border-bottom: 1px solid #3498DB;
    text-shadow: 0 -1px #3498DB;
    color: #FFFFFF;
}

.menu_section select, .menu_section textarea
{
    vertical-align:middle;
}

.jstree-anchor > span {
  padding: 10px 10px 10px 0px;
}

.scrollbox
{
  white-space:normal;
  background: none repeat scroll 0 0 #FFFFFF;
  border: 1px solid #CCCCCC;
  height: 100px;
  overflow-y: scroll;
  width: 350px;
}

.scrollbox div.even {
    background: none repeat scroll 0 0 #FFFFFF;
}
.scrollbox div {
    padding: 3px;
}


.scrollbox div.odd {
    background: none repeat scroll 0 0 #E4EEF7;
}

.scrollbox img {
  cursor: pointer;
  float: right;
}

.jstree-default li div .scrollbox img
{
	padding:5px 0px;
}

</style>    
<?php
$module_js = ob_get_contents();
ob_end_clean();

if ($opencart_version >= 2010) 
{
	require('nicomodule2010.tpl');
} else
if ($opencart_version >= 2000) 
{
	require('nicomodule2.tpl');
} else
{
	require('nicomodule.tpl');
}
