<?php

class iniciom extends Modelo{
  public function __construct() { parent::__construct(); }

  public function ultimas(){ $this->select('*','noticias')->orden('id','DESC')->limit(5); return $this->query(); }

  public function antigua(){ $this->select('*','noticias')->orden('id','ASC')->limit(5); return $this->query(); }

}

?>
