<?php 
 class editarc extends controlador{
 
  public function __construct() { parent::__construct(); } 
  
  public function index(){ 

    if(isset($_GET['i'])&&!empty($_GET['i'])){
    $this->vista->eachset('thegod',$this->modelo->noticiasxid($_GET['i'])); }
    $this->vista->eti('tpub',$this->modelo->tpub());
    $this->vista->eti('pxu',$this->modelo->pxu($_SESSION['user']));
    $this->vista->eti('tvisitas',$this->modelo->tvisitas());
    $this->vista->eti('tcoment',$this->modelo->tcoment());
    $this->vista->eti('mcoment',$this->modelo->mcoment($_SESSION['user']));
    $this->vista->eti('mvisitas',$this->modelo->mvisitas($_SESSION['user']));
    $this->vista->eti('user',$_SESSION['user']);
    $this->vista->unir('vistas/editar/cat','cat',$this->modelo->categoria());
     $this->vista->ver();
      }

      public function actualizar(){

     $titulo=filter_var(trim($_POST["titulo"]),FILTER_SANITIZE_STRING, FILTER_FLAG_STRIP_LOW | FILTER_FLAG_STRIP_HIGH);
     $categoria=filter_var(trim($_POST["categoria"]),FILTER_SANITIZE_STRING, FILTER_FLAG_STRIP_LOW | FILTER_FLAG_STRIP_HIGH);
     $user=filter_var(trim($_POST["user"]),FILTER_SANITIZE_STRING, FILTER_FLAG_STRIP_LOW | FILTER_FLAG_STRIP_HIGH);
     $contenido=filter_var(trim($_POST["contenido"]),FILTER_SANITIZE_STRING, FILTER_FLAG_STRIP_LOW | FILTER_FLAG_STRIP_HIGH);
     $id=filter_var(trim($_POST["id"]),FILTER_SANITIZE_STRING, FILTER_FLAG_STRIP_LOW | FILTER_FLAG_STRIP_HIGH);

     if(!empty($_FILES["foto"]['name']))
     {
        opendir("imagenes");
        $file_name = $_FILES['foto']['name'];
        $file_tmp = $_FILES['foto']['tmp_name'];
        copy($file_tmp,"imagenes/".$file_name);
        $foto="imagenes/".$file_name;   
        }else{$foto=$_POST["ofoto"];}

        $this->modelo->anoticia($titulo,$foto,$contenido,$user,$categoria,$id);
        header("location:/publicaciones");
    }

} ?>