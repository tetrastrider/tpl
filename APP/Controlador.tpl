<?php

abstract class controlador extends vistas
{
    protected $vista;
    protected $pedir;
    protected $control;
    protected $modelo;
    private $locked = PRIVADO;//control acceso
    public function __construct(){
        $this->vista = new vistas(new Request);
        $this->pedir = new Request();
        $this->modelo=$this->modelo($this->pedir->vista());
         if(in_array($this->pedir->vista(),$this->locked)){ Acceso::patear(); }
    }

    abstract public function index();

    protected function modelo($modelo)
    {
        $modelo = $modelo.'m';
        $rutaModelo = MODELO.$modelo.DS.'index'.EXT;
        
        if(is_readable($rutaModelo)){
            require_once $rutaModelo;
            $modelo = new $modelo;
            return $modelo;
        }
        else {
            throw new Exception('<h1>no se encontro el modelo '.$rutaModelo.'<h1>');
        }
    }

    protected function plugin($libreria){ $rutaLibreria = PLUGIN.$libreria.'.php';
        
        if(is_readable($rutaLibreria)){ require_once $rutaLibreria; }else{ throw new Exception('Error de libreria'); }
    }

    protected function getpost($clave){ if(isset($_POST[$clave])){ return $_POST[$clave]; } }

    protected function getint($clave){ if(isset($_POST[$clave]) && !empty($_POST[$clave])){ $_POST[$clave] = filter_input(INPUT_POST, $clave,FILTER_VALIDATE_INT); return $_POST[$clave]; } return 0; }

    protected function numero($int){ $int = (int) $int; if(is_int($int)){ return $int; }else{ return 0; } }

    public function correo($email){ if(!filter_var($email,FILTER_VALIDATE_EMAIL)){ return false; } return true; }

    public function substrhtml($str,$start,$len){ $str_clean = substr(strip_tags($str),$start,$len); $pos = strrpos($str_clean, " "); if($pos === false) { $str_clean = substr(strip_tags($str),$start,$len); }else $str_clean = substr(strip_tags($str),$start,$pos); if(preg_match_all('/\<[^>]+>/is',$str,$matches,PREG_OFFSET_CAPTURE)){ for($i=0;$i<count($matches[0]);$i++){ if($matches[0][$i][1] < $len){ $str_clean=substr($str_clean,0,$matches[0][$i][1]) . $matches[0][$i][0] . substr($str_clean,$matches[0][$i][1]); }else if(preg_match('/\<[^>]+>$/is',$matches[0][$i][0])){ $str_clean = substr($str_clean,0,$matches[0][$i][1]) . $matches[0][$i][0] . substr($str_clean,$matches[0][$i][1]); break; } } return $str_clean; }else{ $string = substr($str,$start,$len); $pos = strrpos($string, " "); if($pos === false) { return substr($str,$start,$len); } return substr($str,$start,$pos); } }

    public function sub($datos,$sub,$start=0,$len=500){ $i=0;$arr=array(); foreach ($datos as $datos) { foreach ($datos as $ky => $ve) { if(is_array($sub)){if(in_array($ky,$sub)){$ve=$this->substrhtml($ve,$start,$len);}} if($ky===$sub){$ve=$this->substrhtml($ve,$start,$len);} $arr[$i][$ky]=$ve; } $i++; } return $arr; }

}

?>
