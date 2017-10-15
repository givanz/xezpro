<?php
$opencart_version = (int)str_replace('.','',VERSION);
if ($opencart_version >= 2300) include('layout_form23.tpl'); else if ($opencart_version >= 2000) include('layout_form2.tpl'); else  include('layout_form1.tpl');
