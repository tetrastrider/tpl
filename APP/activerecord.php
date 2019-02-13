<?php
abstract class CrudModel
{
	protected $query;
	protected $rows = array();
	private $conexion;
	public function __construct() { $this->conexion = new basededatos(); }

	protected function dynamic_query($values, $insert = false)
	{
		$result = $this->conexion->prepare($this->query);

		foreach($values as $key => $value){
            if(is_int($value)){ 
            	$param = PDO::PARAM_INT; 
            }
            elseif(is_bool($value)){ 
            	$param = PDO::PARAM_BOOL; 
            }
            elseif(is_null($value)){ 
            	$param = PDO::PARAM_NULL; 
            }
            elseif(is_string($value)){ 
            	$param = PDO::PARAM_STR; 
            }
            else{ 
            	$param = FALSE;
            }

            if($param){
            	$result->bindValue(":$key",$value,$param);
            }
        }

        $result->execute();

        if($insert == false){
	        if($result->rowCount() > 1){
	        	$this->rows = $result->fetchAll();
	        }else if($result->rowCount() == 1){
	        	$this->rows = $result->fetch();
	        }
	    }

        $result = null;
	}

	protected function simple_query() 
	{ 
		$result = $this->conexion->prepare($this->query);
        $result->execute();
        $this->rows = $result->fetchAll();
        $result = null;
	}
}
/*
PDO::PARAM_BOOL
PDO::PARAM_NULL
PDO::PARAM_INT
PDO::PARAM_STR
PDO::PARAM_LOB
*/
