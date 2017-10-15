<?php
$opencart_version = (int)str_replace('.','',VERSION);
if (!defined('NICO_THEME_NAME')) define('NICO_THEME_NAME', 'Nico');


// Heading
$_['heading_title']       = '<span class="fa-stack fa-lg" style="color:#104da1"><i class="fa fa-square fa-stack-2x"></i><i class="fa fa-hand-o-up fa-stack-1x fa-inverse"></i></span> ' .  NICO_THEME_NAME . '&nbsp; Parallax';

// Text
$_['text_module']         = 'Modules';
$_['text_success']        = 'Success: You have modified module nicoparallax!';
$_['entry_name']       = 'Module Name';

if ($opencart_version > 1564)
$_['text_edit']         = 'Edit '. NICO_THEME_NAME.' Parallax';
else
$_['text_edit']         = 'Edit';

// Error 
$_['error_permission']    = 'Warning: You do not have permission to modify module nicoparallax!';
$_['error_image']         = 'Image width &amp; height dimensions required!';

$_['entry_status']      = 'Status';
$_['entry_heading']     = 'Heading Title';
$_['entry_description'] = 'Content';
?>
