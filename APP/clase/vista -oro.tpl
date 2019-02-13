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

/***************INCLUIR APARTE Y ALMACENAR EN EL ARREGLO UN ARCHIVO O VISTA TPL**************************************/  
public function incluir($salida,$eti,$arreglo=''){
  if ($arreglo!='') {
    

  $salida = file_get_contents($salida.EXT);

            foreach ($arreglo as $arg) {

        
                foreach ($arg as $key => $value) {
                     
                $tagToReplace = "[$key]";
               $salida = str_replace($tagToReplace,$value, $salida);
                }
      

            }
            $this->valor[$eti] = $salida;

  }else{

    $salida = file_get_contents($salida.EXT);
    $this->valor[$eti] = $salida;

  }
}
/*******EACH + INCLUIR*********************************************************************/
public function requerir($plantilla,$eti,$datos=''){
          $unidos = "";
          if ($datos!='') {
          
          foreach($datos as $data){
                $row = file_get_contents($plantilla.EXT);
                
                foreach ($data as $key => $value) {

                    $tagToReplace = "[$key]";
               $row = str_replace($tagToReplace,$value, $row);


                }
                $unidos .= $row;

                $this->valor[$eti] = $unidos;
        
            }

          }else{

            foreach ($plantillas as $plantilla) { 
              $row = file_get_contents($plantilla.EXT);

               $unidos .= $row;
               $this->valor[$eti] = $unidos;
            }

          }
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

/*SUBIR MUCHAS VARIABLES A LA VEZ Y ASIGNARLE UNA LLAVE UNICA*USO BASE DE DATOS Y MULTIMATRICES*/        
public function mset($llave,$arreglo){

            foreach ($arreglo as $key => $value) {
$this->valor[$llave][$key] = $value;
        
           }

        }
/***************INCLUYENDO**************************************************/
public function incluyendo(){
    if(preg_match('/{\{\s?incluir:\s?\"([^\{]*)\"\s?\}}/',$this->salida, $includir)){

      $incluyendo = file_get_contents($includir[1].EXT);
     $vartoreplace = str_replace('/','\/', $includir[1]);
  $this->salida=preg_replace('/{\{\s?incluir:\s?\"'.$vartoreplace.'\"\s?\}}/',$incluyendo,$this->salida);
     }
}
/***************VARIABLES***************************************************/

public function variables(){
preg_match_all('/\{(\w+)\}/',$this->salida,$varrrr);

foreach($varrrr[0] as $varo=>$orav){ 
// echo $orav;
    if(preg_match('/\{(\w+)\}/',$this->salida, $match)){ //print_r($match[1]);'/\{(\w+)\}/'
             
              foreach ($this->valor as $key => $value){

          if (!isset($key)) {print_r('llave no existe<br>'); exit;}

          if ($value===''&&$match[1]===$key&&isset($value)) {$value='';}


          if ($key===''&&$match[1]===$key) {$value='';print_r('llave vacia<br>');}

           if (isset($key)&&empty($value)&&$match[1]===$key) {$value='';}

                if(!empty($key)&&isset($key)&&$match[1]===$key&&isset($value)){

                  
                  
               $this->salida = str_replace('{'.$key.'}',$value, $this->salida);



                }
                 
              }
              
          }

               }
    var_dump($this->valor['titulo']);          
}
/********************FOREACH***************************************************************************/
public function each(){
preg_match_all('/{\{each:\s?(\w+)\s?\}}([^\{]*){\{\/each\}}/',$this->salida,$mtodo);
list($dust,$variable, $content) = $mtodo; 

foreach ($variable as $key => $value) {

if(preg_match('/{\{each:\s?'.$value.'\s?\}}([^\{]*){\{\/each\}}/',$this->salida,$meach,PREG_OFFSET_CAPTURE)) {
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

$this->salida = str_replace("[[[".$llave."]]]",$unidos,$this->salida);

$this->salida = preg_replace('/{\{each:\s+'.$llave.'\s*\}}/', " ",$this->salida);
  }

}

$this->salida = preg_replace('/{\{\/each\}}/',"", $this->salida);


}
/*********IF************************************************************************************/
public function si(){
preg_match_all('/{\{\s?if:\s?\[(\w*)\]\s?\[([^}]+)\]\s?\[(\w*)\]\s?\}\}\s*([^?]*?)\s*\{\{\/if}\}/',$this->salida,$tututu);
foreach($tututu[0] as $tu){

$patente='/{\{\s?if:\s?\[(\w*)\]\s?\[([^}]+)\]\s?\[(\w*)\]\s?\}\}\s*([^?]*?)\s*\{\{\/if}\}/';
  if(preg_match($patente,$this->salida,$cumple)){ 
  list($v9,$vles,$condit,$valores,$contenit) = $cumple;
  /*[variable] [condicion] [valor] [contenido]**/

foreach ($this->valor as $key => $value){

           if($vles==$key){ $dvar=$value; }
     }
/***************************/
switch (trim($condit)){
  case 'igual':

  if($dvar == $valores){ $resp=true; }else{ $resp =false; }

    break;

    case '!igual':

  if($dvar != $valores){ $resp =true; }else{ $resp =false; }
  
    break;

    case 'existe':

  if(isset($dvar)){ $resp =true; }else{ $resp =false; }
  
    break;

    case '!existe':

   if(!isset($dvar)){ $resp =true; }else{ $resp =false; }
  
    break;

    case 'menor':

  if($dvar<$valores){ $resp =true; }else{ $resp =false; }

    break;

    case 'mayor':

  if($dvar>$valores){ $resp =true; }else{ $resp =false; }
  
    break;

    case 'menorigual':

  if($dvar<=$valores){ $resp =true; }else{ $resp =false; }
  
    break;

    case 'mayorigual':

  if($dvar>=$valores){  $resp =true; }else{ $resp =false; }
  
    break;
  
  default:
    echo ' la condicion no existe';
    break;
} 

/*******FIN CONDICION**************/
if($resp===true){
/*****remover etiquetas*****/
$this->salida = preg_replace('/{\{\s*if:\s+\['.$vles.'\]\s*\['.$condit.'\]\s*\['.$valores.'\]\s*\}\}/', " ",$this->salida);

$this->salida = preg_replace('/\{\{\/if}\}/',"", $this->salida);

  }else{

 $this->salida = str_replace($v9,"", $this->salida);   
  }


  }
      }
}
public function id($id){
  preg_match_all('~<div\s?id=(\'|")'.$id.'(\'|")\>([^\{]*)\<\/div\>~',$this->salida,$idm);
  foreach($idm[0] as $varc){
  $this->salida = preg_replace('~<div\s?id=(\'|")'.$id.'(\'|")\>([^\{]*)\<\/div\>~',"",$this->salida);
}

}
/********************************************************************/                  
public function ver(){

  

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

/***pie***/

if(in_array($this->vista,$this->locked)){
  $this->salida .=file_get_contents('maqueta/foot'.EXT);

}elseif(!isset($_SERVER['HTTP_X_REQUESTED_WITH'])){ 
  $this->salida .=file_get_contents('maqueta/pie'.EXT);
}
/****************************************************************************************/
$this->set('TEMA',TEMA);
$this->set('csscontrol','/css/'.TEMA.'/'.$this->vista.'/index.css');
$this->set('titulo',$this->vista);
$this->set('DOMJS','<script type="text/javascript" language="javascript" src="dom/'.$this->vista.'/index.js"></script>');
/*****************************/
$this->si();
$this->incluyendo();
$this->variables();
$this->each();
$this->variables();
echo trim($this->salida);
  }
/*****render*****/

}




?>
