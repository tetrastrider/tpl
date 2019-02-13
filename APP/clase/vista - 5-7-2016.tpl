<?php
class vistas{

private $locked = PRIVADO;//control acceso
private $metodo;
private $vista;
private $salida;
private $valor = array();
public function __construct(Request $peticion) {
    		$this->vista = $peticion->vista();
    		$this->metodo = $peticion->metodo();
  }

/***************SET MULTIARREGLO SIMPLE**************************************/  
public function incluir($salida,$eti){

		$salida = file_get_contents($salida.EXT);
		$this->valor[$eti] = $salida;

}

/*****************ARREGLOS SIMPLES******************************************/
public function simple($plantilla,$eti,$arreglo=''){

 $unidos = "";
          $tagToReplace = "[key]";
          foreach($arreglo as $key => $value){
                $row = file_get_contents($plantilla.EXT);
               
               $row = str_replace($tagToReplace,$value, $row);

                $unidos .= $row;

                $this->valor[$eti] = $unidos;
        
            }


}
/***************SUBIR UNA VARIABLE A LA VEZ**************************************/
public function set($key, $value) {


            $this->valor[$key] = $value;
        }
/*******************SUBIR MUCHAS VARIABLES A LA VEZ*******************************************/
public function smset($valor){

            foreach ($valor as $llueve) {
              foreach ($llueve as $key => $value) {
               $this->valor[$key] = $value;
              }
              
  
           }

        }

/***************SUBIR MUCHAS VARIABLES A LA VEZ Y ASIGNARLE UNA LLAVE UNICA*USO BASE DE DATOS Y MULTIMATRICES*************************************/        
public function mset($llave,$arreglo){

            foreach ($arreglo as $key => $value) {
$this->valor[$llave][$key] = $value;
        
           }

        }
/******************************************************************/
public function ver(){

  /******************************/
$this->set('TEMA',TEMA);
$this->set('csscontrol','/css/'.TEMA.'/'.$this->vista.'/index.css');
$this->set('titulo',$this->vista);
$this->set('DOMJS','<script type="text/javascript" language="javascript" src="dom/'.$this->vista.'/index.js"></script>');

  /*****************************/

    if(in_array($this->vista,$this->locked)){

  if(!isset($_SESSION['user'])){ header("location:/"); }

  $this->salida = file_get_contents("maqueta/head".EXT);

  }elseif(!in_array($this->vista,$this->locked)){
            
 $this->salida = file_get_contents("maqueta/cabeza".EXT);
            
  }elseif(!isset($_SERVER['HTTP_X_REQUESTED_WITH'])){}

/******/

  if(file_exists('vistas/'.$this->vista.'/'.$this->metodo.''.EXT)){

   if(!isset($_SERVER['HTTP_X_REQUESTED_WITH'])){
      $this->salida .= file_get_contents('vistas/'.$this->vista.'/'.$this->metodo.''.EXT);
    }else{
      $this->salida = file_get_contents('vistas/'.$this->vista.'/'.$this->metodo.''.EXT);
    }

    }else{

   if(file_exists('vistas/'.$this->vista.'/index'.EXT)){
    if(!isset($_SERVER['HTTP_X_REQUESTED_WITH'])){
      $this->salida .= file_get_contents('vistas/'.$this->vista.'/index'.EXT);
    }else{
      $this->salida = file_get_contents('vistas/'.$this->vista.'/index'.EXT);
    }

   }else{
    if(PAGINA_ERROR==true){

    $this->salida .= file_get_contents('vistas/error/index'.EXT);

  }else{
    header("location:/");
  }
  
  
 }
}

/******/

if(in_array($this->vista,$this->locked)){
  $this->salida .=file_get_contents('maqueta/foot'.EXT);

}elseif(!isset($_SERVER['HTTP_X_REQUESTED_WITH'])){ 
  $this->salida .=file_get_contents('maqueta/pie'.EXT);
}
/**************************VARS***********~\{(\w+)\}~************************/

        while(preg_match('/\{(\w+)\}/',$this->salida, $match)){ //print_r($match[1]);
           
            foreach ($this->valor as $key => $value){

        if (!isset($key)) {print_r('llave no existe<br>'); exit;}

        if ($value===''&&$match[1]===$key&&isset($value)) {$value='';/*print_r('valor vacia<br>');*/}


        if ($key===''&&$match[1]===$key) {$value='';print_r('llave vacia<br>');}

         if (isset($key)&&empty($value)&&$match[1]===$key) {$value='';/*print_r('la llave '.$key.' no tiene valor  - ');*/}

              if(!empty($key)&&isset($key)&&$match[1]===$key&&isset($value)){

                
                
             $this->salida = str_replace('{'.$key.'}',$value, $this->salida);



              }
               
            }
            
        }

        
        /**VARS**/
 /********************FOREACH***************************************************************************/
preg_match_all('/{\{each:\s+(\w+)\s*\}}([^\{]*){\{\/each\}}/',$this->salida,$mtodo);
list($dust,$variable, $content) = $mtodo; 

foreach ($variable as $key => $value) {
/************************foreachpreg_match_all************************************/
if(preg_match('/{\{each:\s+'.$value.'\s*\}}([^\{]*){\{\/each\}}/',$this->salida,$meach,PREG_OFFSET_CAPTURE)) {
list($polvo,$tit) = $meach;
$llave=$value;
$this->salida = str_replace($tit, "[[[".$llave."]]]", $this->salida);
$unidos = "";

 foreach($this->valor[$value] as $datos){

    $row = $tit[0];

    foreach ($datos as $key => $value) {
                      $tagToReplace = "[$key]";
                     
                   $row = preg_replace('~\['.$key.']~',$value, $row);
    }
        $unidos .=$row; 
 }
/**endallforeach*/
$this->salida = str_replace("[[[".$llave."]]]",$unidos,$this->salida);
/*********borrar************************/
$this->salida = preg_replace('/{\{each:\s+'.$llave.'\s*\}}/', " ",$this->salida);
  }
/************************foreachpreg_match_all************************************/
}

$this->salida = preg_replace('/{\{\/each\}}/',"", $this->salida);

  /********************END FOREACH**************preg_match_all***********************************************/

echo $this->salida;

  }
/*****render*****/

}




?>
