<?php
class noticiasm extends Modelo{
    public function __construct() { parent::__construct();}

    public function pag($limit,$buscar="",$categoria=""){
    $this->select($this->cuenta('*','num'),'noticias');
    if(!empty($buscar)){$this->where($this->like('titulo',$buscar));}
    if(!empty($categoria)){$this->where('categoria= ',":categoria")->attr(['categoria' =>''.$categoria.'']);}
    $this->orden('id','DESC');
    
    $total_results=$this->modo('assoc')->cons('fetch');
    $total_pages=ceil($total_results['num'] / $limit);
    return $total_pages; }

    public function no($limit,$pages,$orden,$buscar="",$categoria="",$id=""){ 
    
    if($orden==2){ $ordenar="DESC"; }else{ $ordenar="ASC"; }
    
    if($id==""){ $this->select(['id','titulo','foto',$this->resumen('contenido',1,99999),'user','categoria','visitas','publicado','comentarios'],'noticias'); }else{ $this->select('*','noticias');}

    if(!empty($buscar)){$this->where($this->like('titulo',$buscar));}
    if(!empty($categoria)){$this->where('categoria=',':categoria')->attr(["categoria" =>$categoria]);}
    if(!empty($id)){$this->where('id=',':id')->attr(["id" =>$id]);}

    if(isset($_SESSION['user'])&&$_SESSION['role']!='administrador'){ if(isset($_SESSION['user'])){ $user = $_SESSION['user']; } if(!empty($user)){$this->where('user=',$user);} }
    $this->orden('id',$ordenar)->limit($pages,$limit); return $this->cons(); }

    public function categorias(){$this->tabla('categoria')->modo('obj'); return $this->selectall("categoria"); }

    public function comentario(){ $this->select(['id','comentario','autor','foto','publicado','correo','categoria','id_contenido'],'comentario')->limit(5); return $this->query(); }

    public function categoriasid($id){ $this->select('*','noticias')->where('id=',':id')->attr(["id" =>$id]); return $this->cons(); }

    public function comxid($id){ $this->attr(["id" =>$id])->select('*','comentario')->where('id_contenido=',':id'); return $this->cons();
     }
    
} ?>
