<?php
/***********DIR CONFIG**********************************/
define('DS', DIRECTORY_SEPARATOR);
define('RAIZ', realpath(dirname(__FILE__)) . DS);
define('APP_RUTA', RAIZ . 'APP' . DS);
/************REQUERIDAS********************************/
require_once APP_RUTA.'salud.tpl';
require_once APP_RUTA.'config.tpl';
require_once APP_RUTA.'auto.tpl';
require_once APP_RUTA.'dev.tpl';
require_once APP_RUTA.'pdo.tpl';
require_once APP_RUTA.'request.tpl';
require_once APP_RUTA.'bootstrap.tpl';
require_once APP_RUTA.'Model.tpl';
require_once APP_RUTA.'acceso.tpl';
require_once APP_RUTA.'etiquetas.tpl';
require_once APP_RUTA.'sanar.tpl';
require_once APP_RUTA.'vistas.tpl';
require_once APP_RUTA.'Controlador.tpl';
/*****************************************************/
try{
    Bootstrap::run(new Request);
}
catch(Exception $e){
    echo $e->getMessage();
}