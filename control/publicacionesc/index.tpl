<?php
class publicacionesc  extends controlador {

public function __construct(){ parent::__construct(); }

public function index(){
/***************************************************/
if(isset($_SESSION['user'])){$this->vista->eti('user',$_SESSION['user']);}
/***************************************************/
if(empty($_GET["b"])){$buscar="";}else{$buscar=$_GET["b"];}
if(empty($_GET['c'])){$categoria="";}else{$categoria=$_GET['c'];}
if(isset($_GET["i"])){if(!empty($_GET["i"])){(int)$id=$_GET["i"];}}else{$id="";}
/******************************************************/
if(isset($_GET['p'])&&is_numeric($_GET['p'])){ $pagina=(int)$_GET['p']; $this->vista->eti("pagina", $pagina);
        }else{ $pagina=1; $this->vista->eti("pagina", $pagina); }
/****************************************************/
if(!isset($_GET['lt'])||!is_numeric($_GET['lt'])){ $limit=10; $this->vista->eti("limite", $limit); }else{ $limit=$_GET['lt']; $this->vista->eti("limite",$limit); }
/***************************************************/
 $total=$this->modelo->pag($limit,$buscar,$categoria); $this->vista->eti('total',$total);
/***************************************************/
if(!isset($_GET["co"])){ $orden=2; $check2='selected'; $check1='';//Publicaciones Nuevas
}elseif($_GET["co"]==1){ $orden=$_GET["co"]; $check1='selected';$check2=''; }else{ $orden=2; $check2='selected';$check1='';/*Publicaciones Nuevas*/ }
/****************************************************/
$hasta5='';$hasta10='';$hasta15='';$hasta20='';$hasta25='';$hasta30='';
if($limit==5){ $hasta5='selected'; }elseif($limit==10){ $hasta10='selected'; }elseif($limit==15){ $hasta15='selected';
}elseif($limit==20){ $hasta20='selected'; }elseif($limit==25){ $hasta25='selected'; }elseif($limit==30){ $hasta30='selected'; }else{ $hasta5='selected'; }
/***/
$god =array(array('orden'=>$orden),array('check2'=>$check2,'check1'=>$check1),array('hasta5'=>$hasta5,'hasta10'=>$hasta10,'hasta15'=>$hasta15,'hasta20'=>$hasta20,'hasta25'=>$hasta25,'hasta30'=>$hasta30));
$this->vista->mset($god);
/***************************************************/
if($total>=1){ $no=$this->modelo->no($limit,$pagina,$orden,$buscar,$categoria,$id);	
$this->vista->unir("vistas/publicaciones/contenido",'contenido',$no); }else{
$this->vista->eti("contenido",'<center><h2>no se encontraron resultados</h2></center>'); }
/*************************************************/
$categoria=$this->modelo->categorias();
$this->vista->eachset('categorias',$categoria);
// /**************************************************/
if($total>=1){ $this->vista->eti("siguiente",$pagina+1); $this->vista->eti("anterior",$pagina-1);
if($pagina==1){ $this->vista->eti("inicio1",'style="display:none"'); }else{$this->vista->eti("inicio1",'');}
if($pagina<=2){ $this->vista->eti("inicio2",'style="display:none"'); }else{$this->vista->eti("inicio2",'');}
if($pagina==$total){ $this->vista->eti("inicio3",'style="display:none"'); }else{$this->vista->eti("inicio3",'');}
if($pagina==$total){ $this->vista->eti("fin",'style="display:none"'); }else{$this->vista->eti("fin",'');}
$this->vista->incluir("vistas/publicaciones/paginacion",'paginacion'); }else{ $this->vista->eti("paginacion",''); }

$this->vista->ver();
}//FIN INDEX
public function eliminar(){ if(isset($_GET["i"])){if(!empty($_GET["i"])){(int)$id=$_GET["i"];}}
	$this->modelo->eliminar($id);header('location:publicaciones');}

} ?>