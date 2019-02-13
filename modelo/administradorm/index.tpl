<?php

class administradorm extends Modelo
{
    public function __construct() { parent::__construct(); }

    public function pxu($user){ return $this->contar('noticias','user',$user); } 

    public function pub(){ return $this->contar('noticias'); }
    
    public function uvi($user){ return $this->sumar('visitas','noticias','user',$user); }

    public function tvi(){ return $this->sumar('visitas','noticias'); }

    public function tco(){ return $this->sumar('comentarios','noticias'); }
    	
    public function uco($user){ return $this->sumar('comentarios','noticias','user',$user); }

    public function cat(){$this->tabla('categoria'); return $this->selectall("categoria"); }

    public function inoticia($tit,$fot,$con,$user,$cat){$this->insertar('noticias',['titulo'=>$tit,'foto'=>$fot,'contenido'=>$con,'user'=>$user,'categoria'=>$cat,'publicado'=>$this->fecha().' '.$this->hora()]);}

    public function icat($categoria){ $this->insertar('categoria',['categoria'=>$categoria]); }
    
}

?>
