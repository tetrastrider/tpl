<?php

class registrom extends Modelo
{
  public function __construct() { parent::__construct(); }

  public function usuarios(){ $this->modo('obj')->select('*','usuarios')->orden('usuario','ASC'); return $this->cons(); }

	public function verbasededatos(){ $this->verdb(); return $this->query(); }

	public function tablas($bd){$this->vertabla($bd); return $this->query(PDO::FETCH_NUM); }

  public function creatabla($tabla,$comando){ $sql ="CREATE table $tabla($comando);"; $this->conexion->exec($sql); echo "TABLA $tabla SE CREO CON EXITO.\n"; }
  
  public function borrartabla($tabla){ $sql ="DROP TABLE $tabla;" ; $this->conexion->exec($sql); echo "TABLA $tabla SE BORRO CON EXITO.\n"; }

  public function comandosql($comando){ $this->conexion->exec($comando); }

	public function categorias(){$this->modo('obj')->select('*','categoria'); return $this->cons(); }

	public function borracat($id){$this->tabla('categoria')->attr(["id"=>$id])->borrar('id',':id'); }

  public function estado($est){$this->select('*','usuarios')->where('id_usuario=',$est);
    	$estado = $this->query();
    	if($es=$estado->fetch()){
   		$activado = $es['activo'];
   		}

   		if ($activado=='activo') {
   			$shiftactivo='inactivo';
   		}else{
   			$shiftactivo='activo';
   		}
      $this->sql="UPDATE usuarios SET activo='$shiftactivo' WHERE id_usuario=$est";
   		$this->query()->execute();
    }

}

?>
