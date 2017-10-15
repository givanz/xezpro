<?php 
if (isset($_GET['route']) && $_GET['route'] == 'module/cart') $_GET['ajax'] = true;
global $_config;

$nico_include_path = __DIR__. '/../../';
//vqmod changes paths and the above path fails, check other paths
if (!file_exists($nico_include_path . 'nico_theme_editor/common.inc')) 
{
	$_config =  $this->registry->get('config');
	$nico_include_path = DIR_TEMPLATE . '/' . $_config->get('config_template') . '/';
	
	if (!file_exists($nico_include_path . '/nico_theme_editor/common.inc')) $nico_include_path = dirname(__FILE__) . '/../../';
}

if (file_exists($nico_include_path . 'nico_theme_editor/common.inc')) require_once($nico_include_path . 'nico_theme_editor/common.inc');

//$_config =  $this->registry->get('config');
?>
	<div class="nav navbar-right cart pull-right">
		<a id="cart" href="<?php echo $cart;?>" class="dropdown-toggle" data-toggle="dropdown" role="button">
			<span><b><?php echo substr($text_items, 0, strpos($text_items, ' '));?></b>
			<span><?php echo str_replace(' - ', '<br/>', substr($text_items, strpos($text_items, ' ')));?></span>
			</span>
		</a>
			<div class="cart-info dropdown-menu pull-right" role="menu">
				<?php if ($products || $vouchers) { ?>
				<table class="table">
				<?php foreach ($products as $product) { ?>
				<tr>
				  <td class="text-center"><?php if ($product['thumb']) { ?>
					<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail" /></a>
					<?php } ?></td>
				  <td class="text-left"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
					<?php if ($product['option']) { ?>
					<?php foreach ($product['option'] as $option) { ?>
					<br />
					- <small><?php echo $option['name']; ?> <?php echo $option['value']; ?></small>
					<?php } ?>
					<?php } ?>
					<?php if (isset($product['recurring']) && $product['recurring']) { ?>
					<br />
					- <small><?php echo $text_profile; ?> <?php echo $product['recurring']; ?></small>
					<?php } ?></td>
				  <td class="text-right">x <?php echo $product['quantity']; ?></td>
				  <td class="text-right"><?php echo $product['total']; ?></td>
				  <td class="text-center"><button type="button" 
				  <?php /*  onclick="cart.remove('<?php echo $product['key']; ?>');" */?>
				  onclick="(getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') ? location = 'index.php?route=checkout/cart&remove=<?php echo $product['key']; ?>' : $('#cart').load('index.php?route=module/cart&remove=<?php echo $product['key']; ?>' + ' #cart > *');"
				  title="<?php echo $button_remove; ?>" class="btn btn-danger btn-xs"><i class="fa fa-times"></i></button></td>
				</tr>
				<?php } ?>
				<?php foreach ($vouchers as $voucher) { ?>
				<tr>
				  <td class="text-center"></td>
				  <td class="text-left"><?php echo $voucher['description']; ?></td>
				  <td class="text-right">x&nbsp;1</td>
				  <td class="text-right"><?php echo $voucher['amount']; ?></td>
				  <td class="text-center text-danger"><button type="button"
				   <?php /*</button>onclick="voucher.remove('<?php echo $voucher['key']; ?>');" */?>
				   onclick="(getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') ? location = 'index.php?route=checkout/cart&remove=<?php echo $voucher['key']; ?>' : $('#cart').load('index.php?route=module/cart&remove=<?php echo $voucher['key']; ?>' + ' #cart > *');" 
				   title="<?php echo $button_remove; ?>" class="btn btn-danger btn-xs"><i class="fa fa-times"></i></button></td>
				</tr>
				<?php } ?>
			  </table>
				<div class="cart-total pull-right">
					<table class="table">
					  <?php foreach ($totals as $total) { ?>
					  <tr>
						<td class="text-right"><strong><?php echo $total['title']; ?></strong></td>
						<td class="text-right"><?php echo $total['text']; ?></td>
					  </tr>
					  <?php } ?>
					</table>
					<p class="text-right"><a href="<?php echo $cart; ?>"><i class="fa fa-shopping-cart"></i> <?php echo $text_cart; ?></a>&nbsp;&nbsp;&nbsp;
					<a href="<?php if (nico_get_config('checkout')  == '1') echo str_replace('/checkout', '/nicocheckout', $checkout); else echo $checkout; ?>"><i class="fa fa-share"></i> <?php echo $text_checkout; ?></a>&nbsp;&nbsp;</p>
				</div>
				<?php } else { ?>
				<div class="empty"><?php echo $text_empty; ?></div>
				<?php } ?>
				
			</div> 
	 </div>
