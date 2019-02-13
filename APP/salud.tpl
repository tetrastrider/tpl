<?php
//***    Universal prevent xss  ***
//   place this in top of script to prevent xss on your site
$_GET=array_map("strip_tags",$_GET);
$_POST=array_map("strip_tags",$_POST);
?>