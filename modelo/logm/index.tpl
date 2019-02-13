<?php

class logm extends Modelo
{
    public function __construct() { parent::__construct(); }

    public function login($usuario,$password){ Acceso::login($usuario,$password); }

}

?>
