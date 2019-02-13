<?php
class noticiasc  extends controlador
{
private $pagina=null;
private $limit=5;
private $orden=2;
private $id=null;
private $buscar="";
private $categoria='';
private $h5='',$h10='',$h15='',$h20='',$h25='',$h30='';
public function __construct(){ parent::__construct(); }

public function index(){ /*MODELO*/$M=$this->modelo; /*VISTA*/$V=$this->vista;
// if(isset($_GET["i"])){if(!empty($_GET["i"])){(int)$this->id=(int)$_GET["i"];$V->eti("idnoti",$this->id);}}
if (preg_match('~url\s?=\s?(\d)~',$_SERVER['QUERY_STRING'])) { $i=$_SERVER['QUERY_STRING']; $i = explode('=', $i); $this->id=(int)$i[1];$V->eti("idnoti",$this->id); }
/************************************if ($_SERVER['REQUEST_METHOD'] == 'POST')***************/
if(!empty($_GET["b"])){$this->buscar=$_GET["b"];} if(!empty($_GET['c'])){$this->categoria=$_GET['c'];}
/**/
if(isset($_GET['p'])&&is_numeric($_GET['p'])){ $this->pagina=(int)$_GET['p']; $V->eti("pagina", $this->pagina);
        }else{ $this->pagina=1; $V->eti("pagina", $this->pagina); }
/**/
if(!isset($_GET['lt'])||!is_numeric($_GET['lt'])){ $V->eti("limite", $this->limit); }else{ $this->limit=$_GET['lt']; $V->eti("limite",$this->limit); } $from=(($this->pagina * $this->limit)- $this->limit);
/**/
 $total=$M->pag($this->limit,$this->buscar,$this->categoria); $V->eti('total',$total);
/**/
if(!isset($_GET["co"])){ $check2='selected';$check1=''; }elseif($_GET["co"]==1){ $this->orden=$_GET["co"]; $check1='selected';$check2=''; }else{ $check2='selected';$check1='';}
/**/
if($this->limit==5){ $this->h5='selected'; }elseif($this->limit==10){ $this->h10='selected'; }elseif($this->limit==15){ $this->h15='selected'; }elseif($this->limit==20){ $this->h20='selected'; }elseif($this->limit==25){ $this->h25='selected'; }elseif($this->limit==30){ $this->h30='selected'; }else{ $this->h5='selected'; } /***/ $god =[['orden'=>$this->orden],['check2'=>$check2,'check1'=>$check1],['hasta5'=>$this->h5,'hasta10'=>$this->h10,'hasta15'=>$this->h15,'hasta20'=>$this->h20,'hasta25'=>$this->h25,'hasta30'=>$this->h30]]; $V->mset($god);
/**/
$no=$M->no($this->limit,$from,$this->orden,$this->buscar,$this->categoria,$this->id);
/**/
if ($this->id){ $V->incluir("vistas/noticias/contenido2",'contenido',$no); }else{ if($total>=1){ $V->unir("vistas/noticias/contenido",'contenido',$no,'contenido',0,2000); }else{ $V->eti('contenido',''); } }
/**/ 
$categoria=$M->categorias(); $V->eachset('categorias',$categoria); 
/**/
 $ultimos=$M->comentario(); $V->eachset('ultimos',$this->sub($ultimos,['comentario','autor'],0,485));
/**/
 if($total>=1){$V->eti("noresult",'');}else{$V->eti("noresult",'<center><h2>no se encontraron resultados</h2></center>'); }
/**/
 if ($this->id) { $catxid=$M->categoriasid($this->id); foreach($catxid as $catid){ $catidc = $catid->categoria; $idcom=$catid->id; }
/***/ 
if (isset($_SESSION['user'])) { $varcomet=[['readonly'=>'readonly','comfoto'=>$_SESSION['user'].'.gif','comnombre'=>$_SESSION['user'],'comcorreo'=>$_SESSION['correo'],'catid'=>$catidc,'idcom'=>$idcom]]; }else{ $varcomet=[['readonly'=>'required','comfoto'=>'anonimo.png','comnombre'=>'','comcorreo'=>'','catid'=>$catidc,'idcom'=>$idcom]]; } $V->incluir('vistas/noticias/comentar','comentar',$varcomet);
/**/ 
 $comexid=$M->comxid($this->id); if(count($comexid)!==0){ $V->eti('tcxi',1);$V->unir('vistas/noticias/comid','comid',$comexid); }else{ $V->eti('comid','<style>.comentarios{display:none}</style>'); } }else{ $V->eti('comentar',''); }
/**/
if (!isset($this->id)&&$total>1){ $V->eti("siguiente",$this->pagina+1); $V->eti("anterior",$this->pagina-1); if($total>=1){ if($this->pagina==1){ $V->eti("inicio1",'style="display:none"'); }else{$V->eti("inicio1",'');} if($this->pagina<=2){ $V->eti("inicio2",'style="display:none"'); }else{$V->eti("inicio2",'');} if($this->pagina==$total){ $V->eti("inicio3",'style="display:none"'); }else{$V->eti("inicio3",'');} if($this->pagina==$total){ $V->eti("fin",'style="display:none"'); }else{$V->eti("fin",'');} } $V->incluir('vistas/noticias/paginacion','paginacion'); }else{ $V->eti('paginacion',''); } $V->ver();
 }
/*FIN INDEX*/ } ?>