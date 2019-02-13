<?php

class publicacionesm extends Modelo{
    public function __construct() { parent::__construct(); }

    public function pag($limit,$buscar="",$categoria=""){

    $this->select($this->cuenta('*','num'),'noticias');
    if(!empty($buscar)){$this->where($this->like('titulo',$buscar));}
    if(!empty($categoria)){$this->sql.=" WHERE categoria='$categoria'";}
    $this->orden('id','DESC');
    $query=$this->query();
    $total_results=$query->fetch();
    $total_pages=ceil($total_results['num'] / $limit);
    return $total_pages;
    }

    public function no($limit,$pagina,$orden,$buscar="",$categoria="",$id=""){ 
        $pages=(($pagina * $limit)- $limit);

    if($orden==2){ $ordenar="DESC"; }else{ $ordenar="ASC"; }
    
    $this->sql="SELECT id,titulo,foto,";
    if($id==""){ $this->sql.="SUBSTRING(contenido,1,99999) as contenido"; }else{ $this->sql.="contenido"; }
    
    $this->sql.=",user,categoria,visitas,publicado,comentarios FROM noticias ";
    if(!empty($buscar)){$this->where($this->like('titulo',$buscar));}
    if(!empty($categoria)){$this->where('categoria=',':categoria')->attr(["categoria" =>$categoria]);}
    if(!empty($id)){$this->where('id=',':id')->attr(["id" =>$id]);}

    if(isset($_SESSION['user'])&&$_SESSION['role']!='administrador'){

    if(isset($_SESSION['user'])){ $user = $_SESSION['user']; }

    if(!empty($user)){$this->where('user=',$user);}

    }
    $this->orden('id',$ordenar)->limit($pages,$limit);

    return $this->cons(); }

     public function categorias(){$this->tabla('categoria'); return $this->selectall("categoria"); }

     public function eliminar($id){$this->tabla('noticias')->attr(['id'=>':id'])->borrar('id',$id);}

} ?>
