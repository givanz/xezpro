<?php
ini_set('max_execution_time', 900);//max execution time increased to 15 minutes
global $opencart_version, $ocmods_ignore;
$opencart_version = (int)str_replace('.','',VERSION);


if (!class_exists("User") && file_exists(DIR_SYSTEM . 'library/user.php'))
{
	require_once(DIR_SYSTEM . 'library/user.php'); 
}
else if (!class_exists("Cart\User") && file_exists(DIR_SYSTEM . 'library/cart/user.php'))
{
	require_once(DIR_SYSTEM . 'library/cart/user.php');
}


//table used by social authentication module
define('NICO_CREATE_CUSOMTER_AUTHENTICATION_TABLE_SQL',
'CREATE TABLE IF NOT EXISTS `'. DB_PREFIX . 'customer_authentication` (
  `customer_authentication_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `provider` varchar(100) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `web_site_url` varchar(255) NOT NULL,
  `profile_url` varchar(255) NOT NULL,
  `photo_url` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `language` varchar(255) NOT NULL,
  `age` varchar(255) NOT NULL,
  `birth_day` varchar(255) NOT NULL,
  `birth_month` varchar(255) NOT NULL,
  `birth_year` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `region` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`customer_authentication_id`),
  UNIQUE KEY `identifier` (`identifier`)
);');



class ControllerModuleNicoimport extends Controller
{
	private $group_code = 'group';
	public $db_link = NULL;
	public $images = array();
	
	function grab_image($url,$saveto){
		//add image to queue to prevent sql timeout
		$this->images[$url] = $saveto;
	}
	function _grab_image($url,$saveto){
		//error_log($url . "\n\n", 3, '/home/store/logs/opencart.log');
		$ch = curl_init ($url);
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_BINARYTRANSFER,1);
		if (!$raw=curl_exec($ch)) {$this->sendChunk('<span style="color:red">failed download ' . $url . '</span>');return false;}
		curl_close ($ch);
		if(file_exists($saveto)){
			unlink($saveto);
		}
		
		if (!file_exists(dirname($saveto))) mkdir(dirname($saveto));
		
		if (!$fp = fopen($saveto,'x')) return false;
		fwrite($fp, $raw);
		fclose($fp);
		$this->sendChunk('Downloading ' . basename($url) . ' - ok');
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
		return $query = $db->query('DELETE  FROM ' . DB_PREFIX . 'setting WHERE `' . $this->group_code . '` = \'' . $module_name . '\'');
	}
	
	function disable_module2010($module_name)
	{
		global $db;
		return $query = $db->query('DELETE  FROM ' . DB_PREFIX . 'module WHERE `code` = \'' . $module_name . '\'');
	}

	
	function set_module_layout($module_name, $config)
	{
		global $db;
		//delete old layout configuration
		$query = $db->query('DELETE  FROM ' . DB_PREFIX . 'layout_module WHERE `code` LIKE \'' . $module_name . '.%\''); 
		
		$modules = $config;
		//$modules = unserialize($config);
		$i=0;
		foreach ($modules as $instance) 
		{
			$i++;
			$layout_id = $instance['layout_id'];
			$code = $module_name . '.' . $i;
			$position = $instance['position'];
			$sort_order = isset($instance['sort_order'])?$instance['sort_order']:'0';
			if ($layout_id && $position) $query = $db->query('INSERT INTO `'. DB_PREFIX . 'layout_module`  (`layout_id`, `code`, `position`, `sort_order`)  VALUES( \'' . $layout_id . '\', \'' . $code . '\', \'' . $position . '\', \'' . $sort_order . '\')');		
		}
	}


	function install_module2010($module_name, $config)
	{
		global $db, $opencart_version;
		if (is_array($config))
		foreach ($config as $nr => $module)
		{
			
			$nr++;
	//		$this->disable_module($module_name);
			$module['name'] = isset($module['name'])?$module['name']:$nr;
			if ($opencart_version < 2100)
			{
				$config = serialize($module);
			} else
			{
				$config = json_encode($module);	
			}

			$layout_id = isset($module['layout_id'])?$module['layout_id']:0;
			$module_id = isset($module['module_id'])?$module['module_id']:'DEFAULT';
			$position = isset($module['position'])?$module['position']:'';;
			$sort_order = isset($module['sort_order'])?$module['sort_order']:'0';

			$query = $db->query('SELECT module_id FROM `'. DB_PREFIX . 'module`  WHERE code = \'' . $module_name . '\' AND name =\''. $nr . '\'');
			if ($query->num_rows == 0)
			{
				$query = $db->query('SELECT extension_id FROM `'. DB_PREFIX . 'extension`  WHERE code = \'' . $module_name . '\' AND type =\'module\'');
				if ($query->num_rows == 0)
				{
					$query = $db->query('INSERT INTO `'. DB_PREFIX . 'extension`  (`type`, `code`)  VALUES( \'module\', \'' . $module_name . '\')');
				}				
				
				$query = $db->query('INSERT INTO `'. DB_PREFIX . 'module`  (`module_id`,`name`, `code`, `setting`)  VALUES(' . $module_id . ', \'' . $module['name'] . '\', \'' . $module_name . '\', \'' . $db->escape($config) . '\') ON DUPLICATE KEY UPDATE name = \'' . $module['name'] . '\', code = \'' . $module_name . '\', setting=  \'' . $db->escape($config) . '\'');
				$module_id= $db->getLastId();
			
				$code = $module_name . '.' . $module_id;
				
				$query = $db->query('SELECT layout_id FROM `'. DB_PREFIX . 'layout_module`  WHERE code = \'' . $code . '\' AND layout_id =\'' . $layout_id . '\'');
				if ($query->num_rows == 0)
				{
					$query = $db->query('INSERT INTO `'. DB_PREFIX . 'layout_module`  (`layout_id`, `code`, `position`, `sort_order`)  VALUES( \'' . $layout_id . '\', \'' . $code . '\', \'' . $position . '\', \'' . $sort_order . '\')');		
				}
			} else
			{
				$module_id = $query->rows[0]['module_id'];
				$code = $module_name . '.' . $module_id;
				
				$query = $db->query('UPDATE `'. DB_PREFIX . 'module`  SET setting = \'' . $db->escape($config) . '\' WHERE code = \'' . $module_name . '\' AND name =\''. $nr . '\'');
				$query = $db->query('UPDATE `'. DB_PREFIX . 'layout_module` SET `position` = \'' . $position . '\' , `layout_id` = \'' . $layout_id . '\' WHERE `code` =\''. $code . '\'');
				
			}

		} else $this->sendChunk('Config empty for ' . $module_name);
	}

	function install_module($module_name, $config)
	{
		global $db, $opencart_version;
		
		if ($opencart_version < 2100)
		{
			$config = serialize($config);
		} else
		{
			$config = json_encode($config);	
		}
				
		$this->disable_module($module_name);
		$query = $db->query('SELECT extension_id FROM `'. DB_PREFIX . 'extension`  WHERE `type` = \'module\' AND code = \'' . $module_name . '\'');
		if ($query->num_rows == 0)
		{
			$query = $db->query('INSERT INTO `'. DB_PREFIX . 'extension`  (`type`, `code`)  VALUES(\'module\', \'' . $module_name . '\')');
		}
		//echo 'INSERT INTO `'. DB_PREFIX . 'setting`  (`group`, `key`, `value`)  VALUES( \'' . $module_name . '\', \'' . $module_name . '_module\', \'' . $config . '\')  ON DUPLICATE KEY UPDATE `value` = \'' . $config . '\'';
		//if ($module_name == 'nicomegamenu') error_log($config  . ' ----------------- '  . $db->escape($config) . "\n\n", 3, '/home/store/logs/opencart.log'); 
		$query = $db->query('INSERT INTO `'. DB_PREFIX . 'setting`  (`' . $this->group_code . '`, `key`, `value`, `serialized`)  VALUES( \'' . $module_name . '\', \'' . $module_name . '_status\', \'1\', 0)  ON DUPLICATE KEY UPDATE `value` = \'1\'');
		$query = $db->query('INSERT INTO `'. DB_PREFIX . 'setting`  (`' . $this->group_code . '`, `key`, `value`, `serialized`)  VALUES( \'' . $module_name . '\', \'' . $module_name . '_module\', \'' . $db->escape($config) . '\', 1)  ON DUPLICATE KEY UPDATE `value` = \'' . $db->escape($config)  . '\'');
	}

	function sendChunk($chunk)
	{
		//echo sprintf("%x\r\n", strlen($chunk));
		echo $chunk;
		echo "\r\n";
		echo "</br>";

		@flush();
		//@ob_flush();
	}

	public function index() 
	{
		global $opencart_version;
		header('Content-Type: text/html; charset=utf-8');
/*
		// All streams should be uncached
		header('Cache-Control: no-cache, no-store, max-age=0, must-revalidate');
		header('Pragma: no-cache');
		header('Expires: Fri, 01 Jan 1990 00:00:00 GMT');

		// Of course the official chunked header
		header('Transfer-Encoding: chunked');

		// Again a magic tweak for browsers, otherwise they won't stream...
		header('X-Content-Type-Options: nosniff');

		// Protect our streams from xss attacks
		header('X-XSS-Protection: 1; mode=block');

		header( 'Content-Encoding: none; ' );
*/
		ini_set('zlib.output_compression', 0);
		ini_set('implicit_flush', 1);

		flush();

		ob_implicit_flush(1);
		
		//make sure import is not stopped if it takes longer than 30/limit sec
		if (!set_time_limit(900))
		{
			$this->sendChunk('Notice: Time limit increase failed');
		}

		if ($opencart_version >= 2200)
		{
			$user = new Cart\User($this->registry);

			$theme = $this->config->get('config_theme');
			if ($theme == 'theme_default' || $theme == 'default') {
				$theme = $this->config->get('theme_default_directory');
			} 
		}
		else 
		{
			$user = new User($this->registry);
			$theme = $this->config->get('config_template');
		}

		if (!$user->hasPermission('modify', 'design/layout')) die('Permission denied, first login with admin user in opencart admin.');		

		global $db, $opencart_version;
		$db = $this->registry->get('db', $db);
		// Database
		if (!$db) 
		{
			$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
			//$registry->set('db', $db);
		}
		
		$db_property = false;
		$db_property = function ($db) {
			if (isset($db->db)) return $db->db;
		};

		if (method_exists('Closure', 'bind')) 
		$db_property = @Closure::bind($db_property, null, $db);

		if ($db_property)
		{
			$db_property = $db_property($db);

			if (is_object($db_property) &&  strpos(get_class($db_property), 'MySQL'))
			{
				$db_link = function ($db) {
					return $db->link;
				};

				$db_link = Closure::bind($db_link, null, $db_property);
				$this->db_link = $db_link($db_property);
				if ($this->db_link && method_exists($this->db_link,'ping')) $this->db_link->ping();
			}
		}

		$key = trim($_GET['purchase_key']);
		$store_path = $_GET['store'];

		$ch = curl_init('http://' . $store_path . '/import.php');

		$data = array('store' => $store_path, 'purchase_key' => $key, 'host' => $_SERVER['HTTP_HOST']);
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_VERBOSE, true);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		$verbose = fopen('php://temp', 'rw+');
		curl_setopt($ch, CURLOPT_STDERR, $verbose);

		$import = curl_exec($ch);

		if ($import === FALSE) {
			printf("cUrl error (#%d): %s<br>\n", curl_errno($ch),
				   htmlspecialchars(curl_error($ch)));

			rewind($verbose);
			$verboseLog = stream_get_contents($verbose);

			echo "<pre>", htmlspecialchars($verboseLog), "</pre>\n";
			die();
		}

		curl_close($ch);
		
		$php_version = (int)str_replace('.', '',substr(PHP_VERSION, 0, 5));
		$this->sendChunk('PHP ' . ' - ' .PHP_VERSION);
		if ($php_version < 530) $this->sendChunk('<strong>PHP ' . $php_version . ' is too old, please upgrade to at least PHP 5.3.0+</strong>');
		$this->sendChunk('Opencart ' . $opencart_version);
		
		
		if ($opencart_version > 2000)
		{
			$this->group_code = 'code';
		}
		//$import = file_get_contents('http://x-shop.nicolette.ro/import.php');
		$data = unserialize($import);
		if (isset($_GET['debug']))
		{
			echo '<pre>';
			var_dump($data);
			echo '</pre>';
		}
		?>
		<style>
		body {
			font-family: Sans-serif;
			font-size: 12px;
		}
		</style>
		<?php
		if (isset($data['error'])) die($data['error']);
		if (isset($data['message'])) $this->sendChunk($data['message']);
		
		if (isset($_GET['module_configuration']))
		foreach ($data['disable_modules'] as $module_name)  
		{
			if ($this->db_link && method_exists($this->db_link,'ping')) $this->db_link->ping();
			
			$this->sendChunk('Configuring ' . $module_name);
			if ($opencart_version > 2000 && $module_name != 'nicocontrolpanel')
			{
				$this->disable_module2010($module_name);
			} else
			{
			$this->disable_module($module_name);
			}
		}    

		if ($query = $db->query(NICO_CREATE_CUSOMTER_AUTHENTICATION_TABLE_SQL))
		{		
			$this->sendChunk('Create customer_authentication table OK');
		} else
		{
			$this->sendChunk('Create customer_authentication table FAILED or already created');
		}

		if ($opencart_version > 1564)
		{
			if ($this->db_link && method_exists($this->db_link,'ping')) $this->db_link->ping();
			
			$query = $db->query('SELECT layout_id FROM `'. DB_PREFIX . 'layout`  WHERE `layout_id` = \'99999\'');
			if ($query->num_rows == 0)
			{
				$query = $db->query('INSERT INTO `'. DB_PREFIX . 'layout`  (`layout_id`, `name`)  VALUES(\'99999\', \'All pages\')');
			}
		}
		
		global $ocmods_ignore;
		include(DIR_TEMPLATE . '/'. $theme . '/theme_config.inc');
		
		//error_log(print_r($data,1) . "\n\n", 3, '/home/store/logs/opencart.log'); 
		$permission_modules = array();//'module/nicocontrolpanel';
		$modules_count = 0;
		if ($opencart_version >= 2300) $permission_path = 'extension/module/'; else $permission_path = 'module/';

		if (isset($_GET['module_configuration']))
		{
			foreach ($data['extension'] as $extension => $extension_id)  
			{
				$permission_modules[] = $permission_path . $extension;
				$query = $db->query('SELECT extension_id FROM `'. DB_PREFIX . 'extension`  WHERE `code` = \''. $extension .'\'');
				if ($query->num_rows == 0)
				{
					$query = $db->query('INSERT INTO `'. DB_PREFIX . 'extension`  (`type`, `code`)  VALUES(\'module\', \''. $extension .'\')');
				}
			}
			
			foreach ($data['modules'] as $module_name => $config)  
			{
				$this->sendChunk('Installing <i>' . $module_name . '</i>');
				//if ($module_name == 'nicomegamenu') error_log($config  . ' ----------------- '  . base64_decode($config) . "\n\n", 3, '/home/store/logs/opencart.log'); 
				$config = base64_decode($config);
				//if ($module_name  == 'nicocustomproducts')  error_log($config, 3, '/home/store/logs/opencart.log');
				if ($opencart_version > 1564)
				{
					/*
					$config = preg_replace_callback('@s:(\d+):"(data/[^"]*)@', function($matches) 
					{
						$return =  str_replace(array($matches[1], 'data/'),array($matches[1] + 3, 'catalog/'),$matches[0]);
						return $return;
					}, $config);*/

					$config = str_replace('data/', 'catalog/', $config);
					
					//default language is changed in oc 2200
					if ($opencart_version >= 2200)
					{
						$config = str_replace('s:2:"en"', 's:5:"en-gb"', $config);
						$config = str_replace('&quot;en&quot;', '&quot;en-gb&quot;', $config);

					}
				} else
				{
					$config = str_replace('catalog/', 'data/', $config);
					/*
					$config = preg_replace_callback('@s:(\d+):"(catalog/[^"]*)@', function($matches) 
					{
						return str_replace(array($matches[1], 'catalog/'),array($matches[1] - 3, 'data/'),$matches[0]);
					}, $config);
					*/ 
				}
				
				//recalculate string length
				$config = preg_replace_callback('@s:(\d+):"([^"]*)"@', function($matches) 
				{
					return 's:' . strlen($matches[2]). ':"' . $matches[2] . '"';
					//return str_replace(array($matches[1], 'catalog/'),array($matches[1] - 3, 'data/'),$matches[0]);
				}, $config);

				
				//json
				if ($config)
				{
					
				$config = unserialize($config);
				/*
				foreach($config as $key => &$value)
				{
					if ($opencart_version > 1564)
					{
						$value = str_replace('data/','catalog/', $value);
					} else
					{
						$value = str_replace('catalog/','data/', $value);
					}
				}*/
				
				} else $this->sendChunk('Config empty for ' . $module_name);
				
				$permission_modules[] = $permission_path . $module_name;
				$modules_count++;
				
				if ($this->db_link && method_exists($this->db_link,'ping')) $this->db_link->ping();
				
				if ($opencart_version > 2000 && $module_name != 'nicocontrolpanel')
				{
					$this->install_module2010($module_name, $config);
				} else
				{
					$this->install_module($module_name, $config);
					if ($opencart_version > 1564 && $module_name != 'nicocontrolpanel')
					{
						$this->set_module_layout($module_name, $config);
					}
				}
			}
		}

		$this->sendChunk('Set modules permission');
		if ($this->db_link && method_exists($this->db_link,'ping')) $this->db_link->ping();

		$query = $db->query('SELECT permission FROM `'. DB_PREFIX . 'user_group`  WHERE `user_group_id` = 1 LIMIT 1');

		if (isset($query->rows[0][0]) && $query->rows[0][0] !== NULL) $permission = $query->rows[0][0];
		else if (isset($query->rows[0]['permission']) && $query->rows[0]['permission'] !== NULL) $permission = $query->rows[0]['permission'];


		if ($opencart_version < 2100)
		{
			$permission = unserialize($permission);
		} else
		{
			$permission = json_decode($permission, true);
		}

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
				if ($this->db_link && method_exists($this->db_link,'ping')) $this->db_link->ping();
				//$db->ping();
				
				if ($opencart_version < 2100)
				{
					$permission = serialize($permission);
				} else
				{
					$permission = json_encode($permission);
				}
				
				$query = $db->query('UPDATE `'. DB_PREFIX . 'user_group` SET permission = \''.  $db->escape($permission)  .'\' WHERE `user_group_id` = 1');
			}
		}

		if (isset($_GET['download_images']))
		foreach($data['images'] as $image)
		{
			//$this->sendChunk('Downloading ' . $image);

			if ($opencart_version > 1564)
			{
			$image_path = str_replace('data/', 'catalog/', $image);
			} else
			{
			$image_path = str_replace('catalog/', 'data/', $image);
			}

			
			$this->grab_image('http://' . $_GET['store'] . '/image/' . $image, DIR_IMAGE . $image_path);
		}

		if (isset($_GET['store_configuration']))
		{
			foreach($data['setting'] as $key => $value)
			{
				if ($this->db_link && method_exists($this->db_link,'ping')) $this->db_link->ping();
				$_value = base64_decode($value);
				if ($_value) $value = $_value;
			
				if ($opencart_version > 1564)
				{
				$value = str_replace('data/', 'catalog/', $value);
				} else
				{
				$value = str_replace('catalog/', 'data/', $value);
				}
				//$db->ping();
				$length = strpos($key,'_');
				if ($length) $_config = substr($key, 0, $length);else $_config = $key;
				//$query = $db->query('UPDATE `'. DB_PREFIX . 'setting` SET `value` = \'' .  $db->escape($value) . '\' WHERE `key` = \'' . $key . '\'');
				$serialized = 0;
				if (substr($value, 0, 2) == 'a:') //serialized array
				{
					$serialized = 1;

					if ($opencart_version < 2100)
					{
						//$value = $value;
					} else
					{
						$value = json_encode(unserialize($value));	
					}

					if ($opencart_version >= 2200)
					{
					$value = str_replace('s:2:"en"', 's:5:"en-gb"', $value);
					$value = str_replace('&quot;en&quot;', '&quot;en-gb&quot;', $value);
				}
				}
				
				if (substr($value, 0, 2) == '{"')//json 
				{
					$serialized = 1;

					if ($opencart_version < 2100)
					{
						$value = serialize(json_decode($value, true));
					} else
					{
						//$value = $value;	
					}					
				}
			
				if ($opencart_version >= 2200) $value = str_replace('"en"', '"en-gb"', $value);

				$query = $db->query('DELETE  FROM ' . DB_PREFIX . 'setting WHERE `' . $this->group_code . '` = \''. $key . '\'');
				$query = $db->query('INSERT INTO  ' . DB_PREFIX . 'setting (`' . $this->group_code . '`,`key`,`value`, `serialized`) VALUES (\''.$_config.'\',\''.$key.'\', \'' . $db->escape($value) . '\', '. $serialized .') ON DUPLICATE KEY UPDATE `value`=VALUES(`value`)');			//$query = $db->query('UPDATE `'. DB_PREFIX . 'setting` SET `value` = \'' .  $db->escape($value) . '\' WHERE `key` = \'' . $key . '\'');
			}
		}

		//import images

		if (isset($_GET['product_images']))
		foreach($data['products'] as $id => $product)
		{
			if ($this->db_link && method_exists($this->db_link,'ping')) $this->db_link->ping();
			
			if ($opencart_version > 1564)
			{
			$image_path = str_replace('data/', 'catalog/', $product['image']);
			} else
			{
			$image_path = str_replace('catalog/', 'data/', $product['image']);
			}
			
			$this->sendChunk('Set product image ' . $id);
			//$db->ping();
			$query = $db->query("UPDATE `" . DB_PREFIX . "product` SET image='" . $db->escape($image_path) . "' WHERE product_id = $id");
		}
		
		if (isset($_GET['product_images_additional']))
		foreach($data['product_image'] as $product_id => $images)
		{
			$query = $db->query('DELETE FROM `'. DB_PREFIX . 'product_image`  WHERE  product_id = \'' . $product_id . '\'');
			foreach ($images as $image)
			{
				if ($this->db_link && method_exists($this->db_link,'ping')) $this->db_link->ping();
				
				if ($opencart_version > 1564)
				{
					$image_path = str_replace('data/', 'catalog/', $image);
				} else
				{
					$image_path = str_replace('catalog/', 'data/', $image);
				}
				
				$this->grab_image('http://' . $_GET['store'] . '/image/' . $image, DIR_IMAGE . $image_path);
				
				//$this->sendChunk('Product image ' . $product_id . ' - ' . $image_path);
				//$db->ping();
				
				$query = $db->query('INSERT INTO `'. DB_PREFIX . 'product_image`  (`product_id`, `image`)  VALUES( \'' . $product_id . '\', \'' . $image_path . '\')');
			}
		}
		
		$css_dir = DIR_TEMPLATE . '/'. $theme . '/css/';
		$js_dir = DIR_TEMPLATE . '/'. $theme . '/js/';
		$ocmods_dir = DIR_TEMPLATE . '/'. $theme . '/nico_theme_editor/ocmods/';
		
		if ($opencart_version > 1564 && isset($_GET['ocmods']) && is_dir($ocmods_dir))
		{
				$this->sendChunk('Installing ocmods');
				if ($dh = opendir($ocmods_dir)) 
				{
					while (($file = readdir($dh)) !== false) 
					{
						if ($file[0] == '.') continue;
						
						$this->sendChunk(' - <i>' . str_replace(array('.ocmod.xml', '_'), array('', ' '), $file) . '</i>');
						
						$ocmod = $ocmods_dir . $file;
						
						$xml = file_get_contents($ocmod);

						if ($xml) 
						{
							try 
							{
								$dom = new DOMDocument('1.0', 'UTF-8');
								$dom->loadXml($xml);

								$name = $dom->getElementsByTagName('name')->item(0);

								if ($name) {
									$name = $name->nodeValue;
								} else {
									$name = '';
								}

								$code = $dom->getElementsByTagName('code')->item(0);

								if ($code) {
									$code = $code->nodeValue;

									// Check to see if the modification is already installed or not.
									$query = $db->query("SELECT * FROM " . DB_PREFIX . "modification WHERE code = '" . $this->db->escape($code) . "'");
									$modification_info = $query->row;
									
									if ($modification_info) {
										$this->sendChunk(' &nbsp;^ already installed');
										continue;
									}
								} else {
									$this->sendChunk('ocmod code error');
									continue;
								}

								$author = $dom->getElementsByTagName('author')->item(0);

								if ($author) {
									$author = $author->nodeValue;
								} else {
									$author = '';
								}

								$version = $dom->getElementsByTagName('version')->item(0);

								if ($version) {
									$version = $version->nodeValue;
								} else {
									$version = '';
								}

								$link = $dom->getElementsByTagName('link')->item(0);

								if ($link) {
									$link = $link->nodeValue;
								} else {
									$link = '';
								}

								$modification_data = array(
									'name'    => $name,
									'code'    => $code,
									'author'  => $author,
									'version' => $version,
									'link'    => $link,
									'xml'     => $xml,
									'status'  => (in_array($file, $ocmods_ignore))?0:1
								);

							$db->query("INSERT INTO " . DB_PREFIX . "modification SET code = '" . $this->db->escape($modification_data['code']) . "', name = '" . $this->db->escape($modification_data['name']) . "', author = '" . $this->db->escape($modification_data['author']) . "', version = '" . $this->db->escape($modification_data['version']) . "', link = '" . $this->db->escape($modification_data['link']) . "', xml = '" . $this->db->escape($modification_data['xml']) . "', status = '" . (int)$modification_data['status'] . "', date_added = NOW()");

							
							} catch(Exception $exception) {
								$this->sendChunk('Exception ' . $exception->getCode() . ' ' .  $exception->getMessage() . ' ' .  $exception->getFile() . ' ' .  $exception->getLine());
							}
						}
					}
					
					closedir($dh);
					
					
					if ($this->request->server['HTTPS']) {
						$server = $this->config->get('config_ssl');
					} else {
						$server = $this->config->get('config_url');
					}
		
					$this->sendChunk('Trying to clear ocmod cache');
					sleep(2);

					if (isset($_SESSION['default']['token']))
					{
						$token = $_SESSION['default']['token'];
					} else 
					{
						if (isset($_SESSION['token']))
						{
							$token = $_SESSION['token'];
						} else
						{
							reset($_SESSION);
							$token = $_SESSION[key($_SESSION)]['token'];
						} 
					}

					$this->sendChunk('<iframe width=0 height=0 border=0 src="'. $server . 'admin/index.php?route=extension/modification/refresh&token=' . $token . '"></iframe>');
				}
		}
		
		if (!empty($this->images)) 
		foreach ($this->images as $url => $save_to)
		{
			$this->_grab_image($url, $save_to);
		}
		
		if ($opencart_version > 1564 && isset($_GET['speed_cache']))
		{
			//patch index.php to add page caching
			
			$this->sendChunk('Trying to install speed cache');
			$index_php = file_get_contents(DIR_APPLICATION . '/../index.php');
			
			if ($index_php)
			{
				if (strpos($index_php, 'nico_speed_cache.inc') == false)
				{

					$speed_cache_install_start =
					"include('nico_speed_cache.inc');\nif (NICO_PAGE_CACHE) nico_speed_cache_page_init();\n// Install";

					$index_php = str_replace('// Install', $speed_cache_install_start, $index_php);
					$index_php .= 'if (NICO_PAGE_CACHE) nico_speed_cache_page_save();';

					
					if (file_put_contents(DIR_APPLICATION . '/../index.php', $index_php))
					$this->sendChunk('Speed cache installed');
					else 
					$this->sendChunk('Failed to install speed cache probably because permissions, you need to manually install it, check the docs for howto');
					
				} else $this->sendChunk(' ^ already installed');
			} else $this->sendChunk('Error reading opencart\'s index.php, install failed');
		}
		

		if (!is_writable($css_dir))
		{
			if (!@chmod($css_dir, 0777)) $this->sendChunk('Notice: css folder write permission failed, css concatenation will not work, to enable js concatenation set write permission (0777) for ' . $js_dir);
		} else
		{
			$this->sendChunk('css folder writable - OK');
		}

		if (!is_writable($js_dir))
		{
			if (!@chmod($js_dir, 0777))	$this->sendChunk('Notice: js folder write permission failed, js concatenation will not work, to enable js concatenation set write permission (0777) for ' . $js_dir);
		} else
		{
			$this->sendChunk('js folder writable - OK');
		}

		
			
		$files = glob(DIR_CACHE . 'nico_speed_cache_*');

		if ($files) {
			foreach ($files as $file) {
				if (file_exists($file)) {
					unlink($file);
				}
			}
		}
		
		$this->sendChunk('<strong> Import complete</strong>');
	}
}
