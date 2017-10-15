<?php ob_start();
if (isset($price_min_limit) && !empty($price_min_limit)) {
	?>
	<span class="list-group-item group"><?php if (!empty($price_text)) echo $price_text; else {?>Price range<?php }?></span>
    <span class="list-group-item priceslider">
    
     <input id="price-slider" type="text" class="span2" value="" data-slider-enabled="<?php echo (bool)($price_min_limit != $price_max_limit);?>" data-slider-tooltip="<?php if ($price_min_limit == $price_max_limit) echo 'hide'; else echo 'always';?>" data-slider-min="<?php echo $price_min_limit; ?>" data-slider-max="<?php echo $price_max_limit; ?>" data-slider-step="5" data-slider-value="[<?php echo $price_min; ?>,<?php echo $price_max; ?>]" style="display:none"/>
	
    </span>
<?php } $_output[$sort_order['price']] = ob_get_contents();ob_end_clean();?>


<?php ob_start();
if (isset($tag) && !empty($tag)) {?>
	<span class="list-group-item group"><?php if (!empty($tag_text)) echo $tag_text; else {?>Tags<?php }?></span>
    <span class="list-group-item">
    
     <input type="text" name="filter_tag" class="form-control">
    
    </span>
<?php } $_output[$sort_order['tag']] = ob_get_contents();ob_end_clean();?>


<?php ob_start();
if (isset($name) && !empty($name)) {?>

	<span class="list-group-item group"><?php if (!empty($name_text)) echo $name_text; else {?>Search (product name)<?php }?></span>
    <span class="list-group-item">
    
     <input type="text" name="filter_name" class="form-control">
    
    </span>
<?php } $_output[$sort_order['name']] = ob_get_contents();ob_end_clean();?>

<?php ob_start();
if (isset($availability) && !empty($availability)) {?>
    <span class="list-group-item group"><?php if (!empty($availability_text)) echo $availability_text; else {?>Availability<?php }?></span>
    <div class="list-group-item">
      <div id="availability-group">
         <?php foreach ($availability as $id => $text) { ?>
        <?php if (in_array($id, $availability_category)) { ?>
        <label class="checkbox checked">
          <input name="filter_availability[]" type="checkbox" value="<?php echo $id ?>" checked="checked" />
          <?php echo $text; ?></label>
        <?php } else { ?>
        <label class="checkbox">
          <input name="filter_availability[]" type="checkbox" value="<?php echo $id; ?>" />
          <?php echo $text; ?></label>
        <?php } ?>
        <?php } ?>
      </div>
    </div>
<?php } $_output[$sort_order['availability']] = ob_get_contents();ob_end_clean();?>


<?php 
ob_start();
if (isset($options) && !empty($options)) 
{
	foreach ($options as $name => $option_group) { ?>
    <span class="list-group-item group"><?php echo $name; ?></span>
    <div class="list-group-item">
      <div id="option-group<?php echo $name; ?>">
        <?php foreach ($option_group as $option) { 
		$checked = (isset($option_category) && 
		((is_array($option_category) && in_array($option['option_value_id'], $option_category) 
		|| $option['option_value_id'] == $option_category)));
		?>
			
        <label class="checkbox<?php if ($option['type'] == 'image') {?> image<?php } if ($checked) {?> checked<?php }?>">
          <input name="filter_option[]" type="checkbox" value="<?php echo $option['option_value_id']; ?>" <?php if ($checked) { ?>checked="checked"<?php }?> />
          <?php if ($option['type'] == 'image') {?><img src="<?php echo $option['image']; ?>" alt=""><?php }?>
          <span><?php echo $option['name']; if (isset($option['prod_count'])) echo  ' <strong>(' . $option['prod_count'] . ')</strong>'?></span></label>
        <?php } ?>
      </div>
    </div>
    <?php } 
} $_output[$sort_order['options']] = ob_get_contents();ob_end_clean();?>

<?php 
ob_start();
if (isset($categories) && !empty($manufacturers)) {?>
    <span class="list-group-item group"><?php if (!empty($manufacturers_text)) echo $manufacturers_text; else {?>Manufacturer<?php }?></span>
    <div class="list-group-item">
      <div id="manufacturer-group">
         <?php foreach ($manufacturers as $manufacturer) { 
        $checked = (in_array($manufacturer['manufacturer_id'], $manufacturer_category)); ?>

        <label class="checkbox image<?php if ($checked) {?> checked<?php }?>">
          <input name="filter_manufacturer[]" type="checkbox" value="<?php echo $manufacturer['manufacturer_id']; ?>" <?php if ($checked) { ?>checked="checked"<?php }?> />
          <?php if (isset($manufacturer['thumb']) && $manufacturer['thumb'] && $manufacturers_images != 0) {?><img src="<?php echo $manufacturer['thumb']; ?>" alt=""><?php }?>
          <?php if ($manufacturers_names != 0) {?><span><?php echo $manufacturer['name']; if (isset($manufacturer['prod_count'])) echo  ' <strong>(' . $manufacturer['prod_count'] . ')</strong>';?></span><?php }?></label>
        <?php } ?>
      </div>
    </div>
<?php } $_output[$sort_order['manufacturers']] = ob_get_contents();ob_end_clean();?>

<?php ob_start();
if (isset($categories) && !empty($categories)) {?>
    <span class="list-group-item group"><?php if (!empty($categories_text)) echo $categories_text; else {?>Categories<?php }?></span>
    <div class="list-group-item categories">
      <div id="category-group">
         <?php foreach ($categories as $category) { 
 		$checked = (in_array($category['category_id'], $category_category));?>

        <label class="checkbox<?php if ($checked) {?> checked<?php }?>">
          <input name="filter_category[]" type="checkbox" value="<?php echo $category['category_id']; ?>" <?php if ($checked) { ?>checked="checked"<?php }?> />
          <span><?php echo $category['name']; if (isset($category['prod_count'])) echo  ' <strong>(' . $category['prod_count'] . ')</strong>';?></span></label>
        <?php } ?>
      </div>
    </div>
<?php } $_output[$sort_order['categories']] = ob_get_contents();ob_end_clean();?>

<?php ob_start();
if (isset($filters) && !empty($filters)) {?>
    <?php foreach ($filters as $filter_group) { ?>
    <span class="list-group-item group"><?php echo $filter_group['name']; ?></span>
    <div class="list-group-item">
      <div id="filter-group<?php echo $filter_group['filter_group_id']; ?>">
        <?php foreach ($filter_group['filter'] as $filter) { ?>
        <?php if (in_array($filter['filter_id'], $filter_category)) { ?>
        <label class="checkbox checked">
          <input name="filter[]" type="checkbox" value="<?php echo $filter['filter_id']; ?>" checked="checked" />
          <?php echo $filter['name']; ?></label>
        <?php } else { ?>
        <label class="checkbox">
          <input name="filter[]" type="checkbox" value="<?php echo $filter['filter_id']; ?>" />
          <?php echo $filter['name']; ?></label>
        <?php } ?>
        <?php } ?>
      </div>
    </div>
    <?php } 
} $_output[$sort_order['filters']] = ob_get_contents();ob_end_clean();?>


<?php ob_start();
if (isset($attributes) && !empty($attributes)) 
{
	foreach ($attributes as $name => $value) { ?>
    <span class="list-group-item group"><?php echo $name; ?></span>
    <div class="list-group-item">
      <div id="attribute-group<?php echo $name; ?>">
        <?php foreach ($value as $attribute) {
			
		$checked = (isset($attribute_category[$attribute['attribute_id']]) && 
		((is_array($attribute_category[$attribute['attribute_id']]) && in_array($attribute['text'], $attribute_category[$attribute['attribute_id']]) 
		|| $attribute['text'] == $attribute_category[$attribute['attribute_id']])));
         ?>
        <label class="checkbox<?php if ($checked) {?> checked<?php }?>">
          <input name="filter_attribute[<?php echo $attribute['attribute_id'];?>]" type="checkbox" value="<?php echo $attribute['text']; ?>" <?php if ($checked) {?> checked<?php }?>/>
          <?php echo $attribute['text']; if (isset($attribute['prod_count']) && $attribute['prod_count'] > 1) echo  ' <strong>(' . $attribute['prod_count'] . ')</strong>';?>
        </label>
        <?php } ?>
      </div>
    </div>
    <?php } ?>
<?php } $_output[$sort_order['attributes']] = ob_get_contents();ob_end_clean();?>

  <div class="panel panel-default nico_filters">
   <div class="list-group group">
  <!-- div class="panel-heading"><?php echo $heading_title; ?></div -->
	<?php 
		ksort($_output);
		foreach($_output as $buffer) echo $buffer;
	?>

  </div>
  <div class="panel-footer text-right" style="display:none">
    <button type="button" id="button-filter" class="btn btn-primary"><?php echo $button_filter; ?></button>
  </div>
</div>
<script type="text/javascript"><!--
function nico_filter_change()
{
	filters = {};
	filter_text = '';
	action = '<?php echo $action; ?>';
	
	$('.nico_filters input:checked').each(function(element) {
		name = this.name.replace('[]','');
		if (typeof filters[name] == 'undefined') filters[name] = [];
		filters[name].push(this.value);
	});
	
	for(filter_name in filters)
	{
			filter_text += '&' + filter_name + '=';
			first = true;
			for (filter in filters[filter_name])
			{   
				if (!first) filter_text += ',';
				first = false;
				filter_text += filters[filter_name][filter];
			}
	}
	
	price = $("#price-slider").slider('getValue');
	if (price[0] != $("#price-slider").attr('data-slider-min') || price[1] != $("#price-slider").attr('data-slider-max')) filter_text += '&filter_price_min=' + price[0] + '&filter_price_max=' + price[1];
	
	if (filters['filter_category']) action += '&path=' + parseInt(filters['filter_category']);
	
	location = action + filter_text;
}	
	
$('#button-filter').on('click', nico_filter_change);
$("#price-slider").on('slideStop', function() {setTimeout(nico_filter_change, 1500)});

var _filter_timeout;

$('.nico_filters input').on('click', function() 
{
	clearTimeout(_filter_timeout);
	_filter_timeout = setTimeout(function () {
		$('#button-filter').click();
	}, 1500);
});
//--></script> 
