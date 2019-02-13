<?php

class Modelo
{
    protected $conexion;
    protected $sql;
    protected $attr= array();
    protected $dinamico;
    protected $tabla;
    protected $modo=PDO::FETCH_OBJ;
    
    public function __construct() { $this->conexion = new basededatos();} 

    public function __set($name,$value){ $this->dinamico[$name] = $value; }

    public function __get($name){ return $this->dinamico[$name]; }

    public function __isset($name){ return isset($this->dinamico[$name]); }

    public function __unset($name){ unset($this->dinamico[$name]); }

    public function __toString(){ return $this->dinamico; }
 
    public function select($campo,$tabla=null){ if(!isset($tabla)){$this->sql="SELECT $campo";return $this;}
        $this->sql=null;if(!is_array($campo)){$this->sql="SELECT $campo FROM $tabla";  return $this; }else{ $campo=implode(",",$campo); $this->sql="SELECT $campo FROM $tabla"; return $this; } }

    public function where($campo,$arg=false){ ($arg===false)?$this->sql.=" WHERE $campo":$this->sql.=" WHERE $campo $arg"; return $this; }

    public function like($campo,$arg){return "$campo LIKE '%".$arg."%'";}

    public function limit($limit,$offset=false){ ($offset===false)?$this->sql.=" LIMIT $limit":$this->sql.=" LIMIT $limit,$offset"; return $this; }

    public function attr($attr){$this->attr=null;$this->attr=$attr;return $this;}

    public function tabla($tabla){ $this->tabla=$tabla;return $this;}

    public function borrar($campo,$id){$this->sql="DELETE FROM $this->tabla WHERE $campo= $id";$this->cons(true);return $this;}

    public function vertabla($bd){$this->sql="SHOW TABLES FROM $bd"; return $this;}

    public function verdb(){$this->sql ="SHOW DATABASES"; return $this;}

    public function y($campo,$arg=false){ if($arg===false){$this->sql.=" AND $campo";return $this;}else{$this->sql.=" AND $campo $arg";return $this;}}

    public function o($campo,$arg=false){ if($arg===false){$this->sql.=" OR $campo";return $this;}else{$this->sql.=" OR $campo $arg"; return $this;} }

    public function orden($campo,$orden='ASC'){$this->sql.=" ORDER BY $campo $orden";return $this;}

    public function resumen($campo,$start=1,$end=500){return "SUBSTRING($campo,$start,$end) as $campo";}

    public function cuenta($campo,$arg){return "COUNT($campo) as $arg";}

    public function columnas($tabla){$this->sql="DESCRIBE $tabla"; $q=$this->query(); return $q->fetchAll(PDO::FETCH_COLUMN);}

    public function porid($donde,$id,$campo = "*"){ $this->sql = "SELECT $campo FROM $this->tabla WHERE $donde = '$id'";
        return $this->cons();}

    public function modo($modo){switch($modo){ case 'obj': $this->modo=PDO::FETCH_OBJ;return $this; break; case 'class': $this->modo=PDO::FETCH_CLASS;return $this; break; case 'lazy': $this->modo=PDO::FETCH_LAZY;return $this; break; case 'into': return $this->modo=PDO::FETCH_INTO; break; case 'bound': $this->modo=PDO::FETCH_BOUND;return $this; break; case 'nombre': return $this->modo=PDO::FETCH_NAMED; break; case 'num': $this->modo=PDO::FETCH_NUM;return $this; break; case 'assoc': $this->modo=PDO::FETCH_ASSOC;return $this; break; default: $this->modo=PDO::FETCH_BOTH;return $this; break; } }   

    public function query(){ $query=$this->conexion->query($this->sql)or die('error'.$this->sql); return $query;}

    public function prepare($p){ return $this->conexion->prepare($p); }

    public function prepara(){ $query=$this->prepare($this->sql); $query->execute(); return $query->fetchAll(); }

    public function selectall($a,$b='ASC'){ $this->sql="SELECT * FROM $this->tabla ORDER BY $a $b"; return $this->cons(); }

    public function obj(){ $q=$this->prepare($this->sql); $q->setFetchMode(PDO::FETCH_OBJ); $q->execute(); return $q->fetchAll(); }

    public function objeto($o){ $q=$this->prepare($o); $q->execute(); return $q->fetchObject(__CLASS__); }

    protected function cons($insert = false){ $rt = $this->conexion->prepare($this->sql);
    foreach($this->attr as $key => $value){ if(is_int($value)){ $param = PDO::PARAM_INT; }elseif(is_bool($value)){ $param = PDO::PARAM_BOOL; }elseif(is_null($value)){ $param = PDO::PARAM_NULL; }elseif(is_string($value)){ $param = PDO::PARAM_STR; }else{  $param = FALSE; } if($param){ $rt->bindValue(":$key",$value,$param); }
        } $rt->execute(); if($insert==='return'){ return $rt; } if($insert===false){ return $rt->fetchAll($this->modo); }if($insert==='fetch'){ return $rt->fetch($this->modo); } }

    public function vago($v){ $vago = $this->prepare($v); $vago->execute(); return $vago->fetchAll(PDO::FETCH_LAZY); }

    public function ambos($a){ $ambos=$this->prepare($a); $ambos->execute(); return $ambos->fetchAll(PDO::FETCH_BOTH); }
    
    public function clase(){$query=$this->query(); $query->setFetchMode(PDO::FETCH_CLASS,__CLASS__); }

    public function sumar($r,$t,$w=false,$c=false){ $this->sql="SELECT SUM($r) as tot FROM $t"; if($w!==false){ $this->sql.=" WHERE $w ='$c'"; } $q=$this->query(); foreach($q as $q){ $tl=$q['tot'];} return $tl; }

    public function contar($t,$w=false,$c=false){ $this->sql="SELECT COUNT(*) as tot FROM $t"; if($w!==false){ $this->sql.=" WHERE $w ='$c'"; } $q=$this->query(); foreach($q as $q){ $tl=$q['tot'];} return $tl; }

    public function campos($tabla,$id=false){ $columnas; $q=$this->columnas($tabla); foreach($q as $k=>$v){ $columnas[]=$q[$k]; } if($id===false){ $id =array_shift($columnas); } $campos=implode(",",$columnas); return $campos; }

    public function valores($tabla,$id=false){ $columnas; $q=$this->columnas($tabla); foreach($q as $k=>$v){ $columnas[]=' :'.$q[$k]; } if($id===false){ $id =array_shift($columnas); } $campos=implode(",",$columnas); return $campos; }

    public function insertarall($tabla=null,$attr=null){ if(isset($tabla)){$this->tabla($tabla);} if(isset($attr)){$this->attr($attr);}  return $this->sql="INSERT INTO $this->tabla (".$this->campos($this->tabla).") VALUES (".$this->valores($this->tabla).")"; $this->cons(true); }

    public function insertar($tabla=null,$attr=null){ if(isset($tabla)){$this->tabla($tabla);} if(isset($attr)){$this->attr($attr);} foreach($this->attr as $key=>$value) { $keys[] = $key; $insertvalues[] = ':'.$key; } $keys = implode(',', $keys); $insertvalues = implode(',', $insertvalues); echo $this->sql = "INSERT INTO $this->tabla ($keys) VALUES ($insertvalues)"; $this->cons(true); }

    public function update($donde, $id) { foreach($this->attr as $key=>$value) { $sets[] = $key.' = :'.$key;
        } $sets = implode(',', $sets); $this->sql = "UPDATE $this->tabla SET $sets WHERE $donde = '$id'"; $this->cons(true); }

    public function fecha(){ date_default_timezone_set('America/La_Paz'); $dias = array("Domingo","Lunes","Martes","Miercoles","Jueves","Viernes","Sábado"); $meses = array("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"); return $dias[date('w')]." ".date('d')." de ".$meses[date('n')-1]. " del ".date('Y') ; }

    public function hora(){ date_default_timezone_set('America/La_Paz'); return date('H:i.s.A'); }

}

?>


