<?php
class administradorc  extends controlador
{

public function __construct(){
	parent::__construct();
	
}

public function index(){


       	$this->vista->eti('tpub',$this->modelo->pub());
        $this->vista->eti('pxu',$this->modelo->pxu($_SESSION['user']));
        $this->vista->eti('tvisitas',$this->modelo->tvi());
        $this->vista->eti('tcoment',$this->modelo->tco());
        $this->vista->eti('mcoment',$this->modelo->uco($_SESSION['user']));
        $this->vista->eti('mvisitas',$this->modelo->uvi($_SESSION['user']));
        $this->vista->eachset('categoria',$this->modelo->cat());
        $this->vista->eachset('singuion',$this->jsfiles());
 		     $this->vista->eachset('conguion',$this->jsfiles());
        $this->vista->eachset('paginasdd',$this->vistastpl());
        $this->vista->eachset('paginas',$this->vistastpl());

$this->vista->eti('user',$_SESSION['user']);
$this->vista->ver();
 }

 public function cpagina()
    {
        $npagina= filter_var(trim($_POST['npagina']),FILTER_SANITIZE_STRING, FILTER_FLAG_STRIP_LOW | FILTER_FLAG_STRIP_HIGH);

        if(!empty($_POST['dispo'])){

        $dispo=filter_var(trim($_POST['dispo']),FILTER_SANITIZE_STRING, FILTER_FLAG_STRIP_LOW | FILTER_FLAG_STRIP_HIGH);

    }else{ $dispo='index'; }

        if(!empty($_POST['script'])){

        $script=filter_var(trim($_POST['script']),FILTER_SANITIZE_STRING, FILTER_FLAG_STRIP_LOW | FILTER_FLAG_STRIP_HIGH);

		}else{ $script='index'; }
        /****************************************/
        if (!file_exists('vistas/'.$npagina)) {
        mkdir('vistas/'.$npagina,0777,true);
        }
        if(!is_readable("vistas/".$npagina."/index".EXT)){
        $pag = fopen("vistas/".$npagina."/index".EXT, "w") or die("no se pudo abrir el archibo!");
        $txt = file_get_contents('plantillas/vistas/'.$dispo.EXT);
        fwrite($pag,$txt);
        fclose($pag);
      }

      /********************************/
     if(!is_readable("control/".$npagina."c/index".EXT)){
      mkdir("control/".$npagina."c", 0700);
        $fichero=(string)"control/".$npagina."c/index".EXT;
        /**********************************/
        $control = '<?php 
         class '.$npagina.'c extends controlador{
         
	          public function __construct() { 
	             parent::__construct();
	              } 
              public function index(){ 
                
                 $this->vista->ver();';
        $control.=' }
                 }
                 ?>';

        file_put_contents($fichero,$control, FILE_APPEND | LOCK_EX);
    }
    /*****************************/
       if(!is_readable("modelo/".$npagina."m/index".EXT)){
        mkdir("modelo/".$npagina."m", 0700);
        $fi="modelo/".$npagina."m/index".EXT;
        $contr = "<?php \n class ".$npagina."m extends Modelo \n { \n public function __construct() { \n parent::__construct(); \n } \n } \n ?>";


        file_put_contents($fi,$contr, FILE_APPEND | LOCK_EX);
    }
    /*******************************************************/
    if(!is_readable("dom/".$npagina."/index.js")){
      mkdir('dom/'.$npagina,0777,true);
        $fij="dom/".$npagina."/index.js";
        $contrj = file_get_contents('plantillas/js/'.$script.'.js');

        file_put_contents($fij,$contrj, FILE_APPEND | LOCK_EX);
    }
  
      header('location:/'.$npagina);
    
	}

  public function creacat()
  {
    $categoria= filter_var(trim($_POST['cnombre']),FILTER_SANITIZE_STRING, FILTER_FLAG_STRIP_LOW | FILTER_FLAG_STRIP_HIGH);
    $this->modelo->icat($categoria);
    header('location:/administrador');
  }


   public function publicar()
    {

      if(isset($_POST["titulo"])&&!empty($_POST["titulo"])&&isset($_POST["categoria"])&&!empty($_POST["categoria"])){

          $titulo=filter_var(trim($_POST["titulo"]),FILTER_SANITIZE_STRING, FILTER_FLAG_STRIP_LOW | FILTER_FLAG_STRIP_HIGH);
      $categoria=filter_var(trim($_POST["categoria"]),FILTER_SANITIZE_STRING, FILTER_FLAG_STRIP_LOW | FILTER_FLAG_STRIP_HIGH);
      $user=filter_var(trim($_POST["user"]),FILTER_SANITIZE_STRING, FILTER_FLAG_STRIP_LOW | FILTER_FLAG_STRIP_HIGH);
      $contenido=filter_var(trim($_POST["contenido"]),FILTER_SANITIZE_STRING, FILTER_FLAG_STRIP_LOW | FILTER_FLAG_STRIP_HIGH);
      if(!empty($_FILES["foto"]['name']))
          {
            opendir("imagenes");
              $file_name = $_FILES['foto']['name'];
              $file_tmp = $_FILES['foto']['tmp_name'];
              copy($file_tmp,"imagenes/".$file_name);
              $foto="imagenes/".$file_name;   
              }else{ $foto =''; }

  $this->modelo->inoticia($titulo,$foto,$contenido,$user,$categoria);
    }
    header("location:/administrador");
  }

   public function jsfiles()
    {
      $DirPath="plantillas/js";
      if($dir = opendir($DirPath)){
           while(($file = readdir($dir))!== false){
                  if(!is_dir($DirPath.$file))
                  {
                      $js= pathinfo($file, PATHINFO_FILENAME );
                      $guiones[] = array('guion' => $js); 
                  }
           }
      }
      return $guiones;
    }


    public function vistastpl()
    {
    	 
      $DirPath="plantillas/vistas";
      if($dir = opendir($DirPath)){
           while(($file = readdir($dir))!== false){

                  if(!is_dir($DirPath.$file))
                  {                  		
                  	
                   $arr=pathinfo($file, PATHINFO_FILENAME );
                    $paginas[] = array('pagina' => $arr); 
                     

                  }


           }

         
      }
   
     return $paginas;
    }

/*****************************************************/
    public function salir(){ Acceso::destruir(); }

} 

?>