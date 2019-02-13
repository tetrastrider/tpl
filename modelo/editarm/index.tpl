<?php 
 class editarm extends Modelo 
 { 
	 public function __construct() { parent::__construct(); }

	  public function pxu($user){ return $this->contar('noticias','user',$user); } 


    public function tpub(){ return $this->contar('noticias'); }


    public function mvisitas($user){ return $this->sumar('visitas','noticias','user',$user); }

    public function tvisitas(){ return $this->sumar('visitas','noticias'); }


    public function tcoment(){ return $this->sumar('comentarios','noticias'); }


    public function mcoment($user){ return $this->sumar('comentarios','noticias','user',$user); }

     public function categoria(){ $this->select('*','categoria')->orden('id','ASC');return $this->query(); }

    public function noticiasxid($id=""){ $this->select('*','noticias')->where('id=',$id); return $this->query(); }

    public function anoticia($titulo,$foto,$contenido,$user,$categoria,$id){
        $query=$this->conexion->query("UPDATE noticias SET titulo='$titulo',foto='$foto',contenido='$contenido',user='$user',categoria='$categoria' WHERE id=$id")or die('error');
        return $query;
    }  
 } 
 ?>