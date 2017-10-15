<?php 
define('DEMO', true);
if (DEMO) die('Import is disabled on demo store');

header('Content-Type: text/html; charset=utf-8');

// All streams should be uncached
header('Cache-Control: no-cache, no-store, max-age=0, must-revalidate');
header('Pragma: no-cache');
header('Expires: Fri, 01 Jan 1990 00:00:00 GMT');

// Of course the official chunked header
//header('Transfer-Encoding: chunked');

// Again a magic tweak for browsers, otherwise they won't stream...
//header('X-Content-Type-Options: nosniff');

// Protect our streams from xss attacks
//header('X-XSS-Protection: 1; mode=block');

header( 'Content-Encoding: none; ' );

ini_set('zlib.output_compression', 0);
ini_set('implicit_flush', 1);

flush();

ob_implicit_flush(1);

function sendChunk($chunk)
{
    //echo sprintf("%x\r\n", strlen($chunk));
    echo $chunk;
    echo "\r\n";
    echo "</br>";

    @flush();
    @ob_flush();
}


if (file_exists('../../../../../config.php')) {
	require_once('../../../../../config.php');
}  

// Startup
require_once(DIR_SYSTEM . 'startup.php');

// Application Classes
require_once(DIR_SYSTEM . 'library/currency.php');
require_once(DIR_SYSTEM . 'library/user.php');
require_once(DIR_SYSTEM . 'library/weight.php');
require_once(DIR_SYSTEM . 'library/length.php');


// Registry
$registry = new Registry();

// Loader
$loader = new Loader($registry);
$registry->set('load', $loader);

// Config
$config = new Config();
$registry->set('config', $config);

//$opencart2 = ((int)substr(VERSION,0,1) == 2);
$opencart2 = isset($_GET['opencart2']);

global $db;
// Database
$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
$registry->set('db', $db);


function grab_image($url,$saveto){
	//error_log($url . "\n\n", 3, '/home/store/logs/opencart.log');
    $ch = curl_init ($url);
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_BINARYTRANSFER,1);
    if (!$raw=curl_exec($ch)) return false;
    curl_close ($ch);
    if(file_exists($saveto)){
        unlink($saveto);
    }
    
    if (!file_exists(dirname($saveto))) mkdir(dirname($saveto));
    
    if (!$fp = fopen($saveto,'x')) return false;
    fwrite($fp, $raw);
    fclose($fp);
    return true;
}

function disable_module($module_name)
{
    global $db;
	if (substr($module_name, 0, 4) == 'nico') 
	{
//		echo 'DELETE  FROM ' . DB_PREFIX . 'extension WHERE `code` = \'' . $module_name . '\'';
		$query = $db->query('DELETE  FROM ' . DB_PREFIX . 'extension WHERE `code` = \'' . $module_name . '\''); 
	}
    return $query = $db->query('DELETE  FROM ' . DB_PREFIX . 'setting WHERE `group` = \'' . $module_name . '\'');
}


function install_module($module_name, $config)
{
    global $db;
    disable_module($module_name);
    $query = $db->query('SELECT extension_id FROM `'. DB_PREFIX . 'extension`  WHERE `type` = \'module\' AND code = \'' . $module_name . '\'');
    if ($query->num_rows == 0)
    {
		$query = $db->query('INSERT INTO `'. DB_PREFIX . 'extension`  (`type`, `code`)  VALUES(\'module\', \'' . $module_name . '\')');
    }
    //echo 'INSERT INTO `'. DB_PREFIX . 'setting`  (`group`, `key`, `value`)  VALUES( \'' . $module_name . '\', \'' . $module_name . '_module\', \'' . $config . '\')  ON DUPLICATE KEY UPDATE `value` = \'' . $config . '\'';
    //if ($module_name == 'nicomegamenu') error_log($config  . ' ----------------- '  . $db->escape($config) . "\n\n", 3, '/home/store/logs/opencart.log'); 
    $query = $db->query('INSERT INTO `'. DB_PREFIX . 'setting`  (`group`, `key`, `value`, `serialized`)  VALUES( \'' . $module_name . '\', \'' . $module_name . '_module\', \'' . $db->escape($config) . '\', 1)  ON DUPLICATE KEY UPDATE `value` = \'' . $db->escape($config)  . '\'');
}

$key = trim($_GET['purchase_key']);
$store_path = $_GET['store'];

$ch = curl_init('http://' . $store_path . '/import.php');

$data = array('store' => $store_path, 'purchase_key' => $key);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

$import = curl_exec($ch);
curl_close($ch);

//$import = file_get_contents('http://x-shop.nicolette.ro/import.php');
$data = unserialize($import);
?>
<style>
body {
    font-family: Sans-serif;
    font-size: 12px;
}
</style>
<?php
if (isset($data['error'])) die($data['error']);
if (isset($data['message'])) sendChunk($data['message']);

foreach ($data['disable_modules'] as $module_name)  
{
    sendChunk('Configuring ' . $module_name);
    disable_module($module_name);
}    

//error_log(print_r($data,1) . "\n\n", 3, '/home/store/logs/opencart.log'); 
$modules_count = 0;
foreach ($data['modules'] as $module_name => $config)  
{
    sendChunk('Installing ' . $module_name);
    //if ($module_name == 'nicomegamenu') error_log($config  . ' ----------------- '  . base64_decode($config) . "\n\n", 3, '/home/store/logs/opencart.log'); 
    $config = base64_decode($config);
    //if ($module_name  == 'nicocustomproducts')  error_log($config, 3, '/home/store/logs/opencart.log');
    if ($opencart2)
    {
		$config = preg_replace_callback('@s:(\d+):"(data/[^"]*)@', function($matches) 
		{
			$return =  str_replace(array($matches[1], 'data/'),array($matches[1] + 3, 'catalog/'),$matches[0]);
			return $return;
		}, $config);
	} else
	{
		$config = preg_replace_callback('@s:(\d+):"(catalog/[^"]*)@', function($matches) 
		{
			return str_replace(array($matches[1], 'catalog'),array($matches[1] - 3, 'data/'),$matches[0]);
		}, $config);
    }
    
    $permission_modules[] = 'module/' . $module_name;
    $modules_count++;
    
    install_module($module_name, $config);
}


sendChunk('Set modules permission');

$query = $db->query('SELECT permission FROM `'. DB_PREFIX . 'user_group`  WHERE `user_group_id` = 1 LIMIT 1');

if (isset($query->rows[0][0]) && $query->rows[0][0] !== NULL) $permission = $query->rows[0][0];
else if (isset($query->rows[0]['permission']) && $query->rows[0]['permission'] !== NULL) $permission = $query->rows[0]['permission'];

$permission = unserialize($permission);

if (is_array($permission) && is_array($permission_modules))
{
	$access_ok = false;
	$modify_ok = false;

	$access = array_unique(array_merge($permission['access'], $permission_modules));
	
	if (is_array($access) && count($access) > $modules_count)
	{
		$permission['access'] = $access;
		$access_ok = true;
	}
	
	$modify = array_unique(array_merge($permission['modify'], $permission_modules));

	if (is_array($modify)  && count($access) > $modules_count)
	{
		$permission['modify'] = $modify;
		$modify_ok = true;
	}
	
	if ($modify_ok && $access_ok)
	{
		$query = $db->query('UPDATE `'. DB_PREFIX . 'user_group` SET permission = \''.  $db->escape(serialize($permission))  .'\' WHERE `user_group_id` = 1');
	}
}


foreach($data['images'] as $image)
{
    sendChunk('Downloading ' . $image);

    if ($opencart2)
    {
	$image_path = str_replace('data/', 'catalog/', $image);
    } else
    {
	$image_path = str_replace('catalog/', 'data/', $image);
    }

    
    //echo 'http://' . $_GET['store'] . '/image/' . $image . ' - ' . DIR_IMAGE . '/'. $image_path;
    grab_image('http://' . $_GET['store'] . '/image/' . $image, DIR_IMAGE . $image_path);
}

foreach($data['setting'] as $key => $value)
{
    if ($opencart2)
    {
	$value = str_replace('data/', 'catalog/', $value);
    } else
    {
	$value = str_replace('catalog/', 'data/', $value);
    }
    
    $query = $db->query('UPDATE `'. DB_PREFIX . 'setting` SET `value` = \'' . $value . '\' WHERE `key` = \'' . $key . '\'');
}

//import images

foreach($data['products'] as $id => $product)
{
    if ($opencart2)
    {
	$image_path = str_replace('data/', 'catalog/', $product['image']);
    } else
    {
	$image_path = str_replace('catalog/', 'data/', $product['image']);
    }
    
    sendChunk('Product image ' . $id);
    $query = $db->query("UPDATE `" . DB_PREFIX . "product` SET image='" . $db->escape($image_path) . "' WHERE product_id = $id");
}

sendChunk('<strong>Import complete</strong>');
