<?php
class Acceso{

	private static $db;

	public function __construct(){ self::$db = new basededatos();}

	public static function login($usuario,$password){ $q=self::$db->prepare("SELECT * FROM usuarios WHERE usuario = :usuario AND password = :password AND activo='activo'"); $q->execute(array(':usuario'=>$usuario,':password'=>$password)); if($datau=$q->fetch()){ Acceso::iniciar('user',$datau['usuario']); Acceso::iniciar('id',$datau['id_usuario']); Acceso::iniciar('role',$datau['role']); Acceso::iniciar('correo',$datau['correo']); Acceso::iniciar('nombre',$datau['nombre']); header('location:/administrador'); }else{ header('location:/log'); } }
 
	public function start(){ SESSION_START(); }

	public static function iniciar($clave,$valor){ if(!empty($clave)){ $_SESSION[$clave] = $valor; } }

	public static function destruir(){ if(isset($_SESSION['user'])){ session_unset(); header("location:/"); }else{header("location:/");} }

	public static function blowall(){session_destroy();header("location:/");}

	public static function getHash($algoritmo, $data, $key){ $hash = hash_init($algoritmo, HASH_HMAC, $key); hash_update($hash, $data); return hash_final($hash); }

	public static function patear(){ if(!isset($_SESSION['user'])){ header("location:/"); exit;} }

	public static function codigo($codigo){ return md5(Acceso::getHash('sha1', $codigo, HASH_KEY)); }
}
$__Acceso = new Acceso;
$__Acceso->start();