<?php
class vistas{

private $metodo;
private $vista;
private $salida;
private $elem = array();
use etiquetas,sanar;
public function __construct(Request $peticion) { $this->vista = $peticion->vista(); $this->metodo = $peticion->metodo(); }
                 

/*****render*****/


}




?>
