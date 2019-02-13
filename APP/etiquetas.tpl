<?php 
trait etiquetas{

	/***************INCLUIR APARTE Y ALMACENAR EN EL ARREGLO UN ARCHIVO O VISTA TPL*********IF DESDE ATRAS**************/  
public function incluir($salida,$eti,$arreglo='',$ext=false){ if ($arreglo!='') {
if($ext===false){ $salida = file_get_contents($salida.EXT); }else{ $salida = file_get_contents($salida.$ext);} 
foreach ($arreglo as $arg) { foreach ($arg as $key => $value) { $tagToReplace = "[$key]"; $salida = str_replace($tagToReplace,$value, $salida); } } $this->elem[$eti] = $salida; }else{ if($ext===false){ $salida = file_get_contents($salida.EXT); }else{ $salida = file_get_contents($salida.$ext);} $this->elem[$eti] = $salida; } return $this;}
/*******EACH + INCLUIR + VARIABLE CON CONTENIDO YA COMPILADO********FOREACH DESDE ATRAS************************/
public function unir($ptl,$eti,$datos='',$sub=null,$start=0,$len=500){ $un = "";
  if ($datos!=''){ foreach($datos as $data){ $row = file_get_contents($ptl.EXT); foreach ($data as $key => $value) { if(isset($sub)){ if(is_array($sub)&&in_array($key,$sub)){ $value = $this->substrhtml($this->sanar($value),$start,$len); }elseif(!is_array($sub)&&$key===$sub){ $value = $this->substrhtml($this->sanar($value),$start,$len); } }
 $tagToReplace = "[$key]"; $row = str_replace($tagToReplace,$value, $row); } $un .= $row; $this->elem[$eti] = $un; } }else{ foreach ($ptl as $ptl) {  $row = file_get_contents($ptl.EXT); $un .= $row; $this->elem[$eti] = $un; } } return $this;}
  /**************VARIABLE******************************************************/
  public function eti($key,$value){ $this->elem[$key] = $value; return $this;}
  /*****************ARREGLOS SIMPLES************************************************/
public function fetch($ptl,$eti,$arreglo=''){ $us = ""; foreach($arreglo as $key => $vlu){ $row = file_get_contents($ptl.EXT); $row = str_replace("[key]",$vlu, $row); $us .= $row; $this->elem[$eti] = $us; } return $this;}
  /***************SUBIR MUCHAS VARIABLES A LA VEZ*********************************/
  public function mset($valor){ foreach($valor as $le){ foreach($le as $key => $ve){ $this->elem[$key] = $ve; } } return $this; }
  /*SUBIR MUCHAS VARIABLES A LA VEZ Y ASIGNARLE UNA LLAVE UNICA*USO BASE DE DATOS Y MULTIMATRICES*/        
  public function eachset($llave,$arreglo){ foreach ($arreglo as $key => $value){ $this->elem[$llave][$key] = $value; }  return $this;}
  /*********CSS_LOADER**********************************************************************/ 
  public function css($salida,$eti){$ext='.css'; if(!is_array($salida)){ $salida = trim(file_get_contents($salida.$ext)); $this->elem[$eti] = '<style type="text/css" media="all">'.$salida.'</style>'; return $this; }else{$css='';foreach ($salida as $salida) { $conv = trim(file_get_contents($salida.$ext)); $css .= $conv; } $this->elem[$eti] = '<style type="text/css" media="all">'.$css.'</style>';  return $this;} }
  /*********JS_LOADER**********************************************************************/ 
  public function js($salida,$eti){$ext='.js'; if(!is_array($salida)){ $salida = trim(file_get_contents($salida.$ext)); $this->elem[$eti] = '<script>'.$salida.'</script>';  return $this;}else{$css='';foreach ($salida as $salida) { $conv = trim(file_get_contents($salida.$ext)); $css .= $conv; } $this->elem[$eti] = '<script>'.$css.'</script>';  return $this;} }
  /****************************************************************************************/
  private function href(){ 
      preg_match_all('/href="([^}]+?)"/i',$this->salida,$tge);
      foreach($tge[1] as $tge){ /*$this->salida = str_replace(''.$tge.'','',$this->salida);*/
        /*echo $tge.'<br>';*/ } }
  /****************************************************************************************/
  private function attr(){
      $tipo='id';
      $id='shout_message';

  preg_match('~<(\w+)\(?(\s?[^<>]+?|\s?)'.$tipo.'\s?=\s?["|\']'.$id.'["|\']\(?(\s?[^<>]+?|\s?)/?>~i',$this->salida,$tge);
  //$this->salida = str_replace(''.$tge[0].'','',$this->salida);
        var_dump(htmlspecialchars($tge[0])); }
  /****************************************************************************************/
  private function selectelem(){
      preg_match_all('~<span([^}]+?)>([^}]+?)(?=<\/span>)~i',$this->salida,$tge);
      foreach($tge[0] as $tge){ /*$this->salida = str_replace(''.$tge.'','',$this->salida);*/
        echo strip_tags(urldecode($tge)).'<br>'; } }
  /**************TAGS**************AUTO**COMPILADOR****************************************/
  private function tags(){ preg_match_all('~</(\w+?)/>~',$this->salida,$tge);
   foreach($tge[1] as $tge){ if(isset($this->elem[$tge])){ $this->salida = str_replace('</'.$tge.'/>',$this->elem[$tge],$this->salida); }else{$this->salida = str_replace('</'.$tge.'/>','',$this->salida);} } return $this;}
  /***************INCLUYENDO*******AUTO**COMPILADOR****************************************/
  private function incluyendo(){ preg_match_all('~</incluir:"([^\<>{}]+?)"/>~',$this->salida, $incluir);
    foreach($incluir[1] as $icd){ $incluyendo = file_get_contents($icd.EXT);
    $this->salida=str_replace('</incluir:"'.$icd.'"/>',$incluyendo,$this->salida);} return $this;}
  /********************FOREACH******AUTO**COMPILADOR**************************************/
  private function each(){ preg_match_all('~</each:(\w+)/>([^}]+?)</endeach:/>~',$this->salida,$mtodo);
  list($dust,$variable,$content) = $mtodo; foreach ($variable as $key => $value) {
  if(preg_match('~</each:'.$value.'/>([^}]+?)(?=</endeach:/>|</each:)~',$this->salida,$meach,PREG_OFFSET_CAPTURE)) {
  list($polvo,$tit) = $meach; $llave=$value; $this->salida = str_replace($tit, "[[[".$llave."]]]", $this->salida);
  $unidos = ""; foreach($this->elem[$value] as $datos){ $row = $tit[0]; foreach ($datos as $key => $robot) { $row = str_replace('['.$key.']',$robot, $row); } $unidos .=$row; } $this->salida = str_replace("[[[".$llave."]]]",$unidos,$this->salida); $this->salida = str_replace('</each:'.$llave.'/>', " ",$this->salida); } }
  $this->salida = str_replace('</endeach:/>',"", $this->salida); return $this;}
  /*********IF***********************AUTO**COMPILADOR***********************************/
  private function si(){//IF FILEGETCONTENT CONTENIDO REMOVE ENDSI PUT CONTENT IN IF START TAG MAKE IT GREEDY
  preg_match_all('~</si:\[(\w+?)\]\[([^}]+?)\]\[(\w+?)\]/>([^}]+?)(?=</else:/>|</endsi:/>|</si:)~',$this->salida,$sir);
  foreach($sir[0] as $tu){  $patente='~</si:\[(\w+?)\]\[([^}]+?)\]\[(\w+?)\]/>([^}]+?)(?=</else:/>|</endsi:/>|</si:)~';
    if(preg_match($patente,$this->salida,$cumple)){  list($v9,$vles,$condit,$valores,$contenit) = $cumple;
    /*[variable] [condicion] [valor] [contenido]**/
  foreach ($this->elem as $key => $value){ if($vles==$key){ $dvar=$value; } }
  /***************************/
  switch (trim($condit)){ case 'igual': if($dvar == $valores){ $resp=true; }else{ $resp =false; } break; case '!igual': if($dvar != $valores){ $resp =true; }else{ $resp =false; } break; case 'existe': if(isset($dvar)){ $resp =true; }else{ $resp =false; } break; case 'dobleexiste': if(isset($dvar)&&isset($valores)){ $resp =true; }else{ $resp =false; } break; case 'existe!existe': if(isset($dvar)&&!isset($valores)){ $resp =true; }else{ $resp =false; } break; case '!existe': if(!isset($dvar)){ $resp =true; }else{ $resp =false; } break; case 'doble!existe': if(!isset($dvar)&&!isset($valores)){ $resp =true; }else{ $resp =false; } break; case 'menor': if($dvar<$valores){ $resp=true; }else{ $resp=false; } break; case 'mayor': if($dvar>$valores){ $resp =true; }else{ $resp =false; } break; case 'menoroigual': if($dvar<=$valores){ $resp=true; }else{ $resp=false; } break; case 'mayoroigual': if($dvar>=$valores){ $resp =true; }else{ $resp =false; } break; default: echo ' la condicion no existe =>'.$condit;$resp =false; break; }
  /*******FIN CONDICION**************/
  if($resp===true){ /*****remover etiquetas*****/ $this->salida = str_replace('</si:['.$vles.']['.$condit.']['.$valores.']/>', " ",$this->salida); $this->salida = str_replace('</endsi:/>',"", $this->salida); }else{ $this->salida = preg_replace('~</si:\['.$vles.'\]\['.$condit.'\]\['.$valores.'\]/>([^}]+?)</endsi:/>~',"", $this->salida); } } } /*endfor*/  return $this;}
/*id="activo"*/
public function menu(){ $menu=''; foreach (MENU as $key => $value){  
      if('/'.$value===$_SERVER['REQUEST_URI']){$activo='id="activo"';}else{$activo='';}
     $menu.="<a href='/".$value."' title='".$key."' itemprop='url'><div class='col' itemscope itemtype='".$key."'".$activo.">".$key."</div></a>"; } return trim($menu);
}
/**/
public function ver(){ 
 if(in_array($this->vista,$this->locked)){ define('DEFAULTCSS',ADMINESTILO);



  $this->salida = file_get_contents("maqueta/head".EXT);

  }elseif(!in_array($this->vista,$this->locked)){ define('DEFAULTCSS',NORMALESTILO);
            
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
  } } }
/***pie***/
if(in_array($this->vista,$this->locked)){
  $this->salida .=file_get_contents('maqueta/foot'.EXT);

}elseif(!isset($_SERVER['HTTP_X_REQUESTED_WITH'])){ 
  $this->salida .=file_get_contents('maqueta/pie'.EXT);
}
/********POR DEFECTO********************************************************************************/
$this->css(array('css/'.TEMA.'/'.DEFAULTCSS,'css/'.TEMA.'/'.$this->vista.'/index','css/font-awesome/css/font-awesome'),'csscontrol')->eti('ti',$this->vista)->js(array('js/jq','dom/'.$this->vista.'/index'),'DOMJS')->eti('MENU',$this->menu());
/**********MAQUINA DE CONSIDENCIAS*******************/ 
while(preg_match_all('~</(\w+?)/>~',$this->salida)){$this->si();$this->incluyendo(); $this->each(); $this->tags(); } 
echo trim($this->salida);
  }
/**/ 
}