<?php
if(AUTOCARGA===true){
function autoloadCore($class){ if(file_exists(APP_RUTA.strtolower($class).EXT)){ include_once APP_RUTA.ucfirst(strtolower($class)).EXT; } }

function autoloadLibs($class){ 
   if(file_exists(ROOT.'plugin'.DS.strtolower($class).'.php')){ include_once ROOT.'plugin'.DS.strtolower($class).'.php';}
}

spl_autoload_register("autoloadCore");
spl_autoload_register("autoloadLibs");
}