<?php
class contactoc  extends controlador
{

	public function __construct(){
		
		parent::__construct();
	}

	public function index(){

	$this->vista->ver();
	 }

	  public function contactame()
    {
      if($_POST)
  {
    $to_Email     = CORREOLOCAL;
    $subject        = SUBJECT;
    
    
    //check if its an ajax request, exit if not
      if(!isset($_SERVER['HTTP_X_REQUESTED_WITH']) AND strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) != 'xmlhttprequest') {
    
      //exit script outputting json data
      $output = json_encode(
      array(
        'type'=>'error', 
        'text' => 'Request must come from Ajax'
      ));
      
      die($output);
      } 
    
    //check $_POST vars are set, exit if any missing
    if(!isset($_POST["userName"]) || !isset($_POST["userEmail"]) || !isset($_POST["userPhone"]) || !isset($_POST["userMessage"]))
    {
      $output = json_encode(array('type'=>'error', 'text' => 'Input fields are empty!'));
      die($output);
    }

    //Sanitize input data using PHP filter_var().
    $user_Name        = filter_var($_POST["userName"], FILTER_SANITIZE_STRING);
    $user_Email       = filter_var($_POST["userEmail"], FILTER_SANITIZE_EMAIL);
    $user_Phone       = filter_var($_POST["userPhone"], FILTER_SANITIZE_STRING);
    $user_Message     = filter_var($_POST["userMessage"], FILTER_SANITIZE_STRING);
    
    //additional php validation
    if(strlen($user_Name)<4) // If length is less than 4 it will throw an HTTP error.
    {
      $output = json_encode(array('type'=>'error', 'text' => 'Nombre corto o vacio!'));
      die($output);
    }
    if(!filter_var($user_Email, FILTER_VALIDATE_EMAIL)) //email validation
    {
      $output = json_encode(array('type'=>'error', 'text' => 'Entre una direccion de correo valida!'));
      die($output);
    }
    if(!is_numeric($user_Phone)) //check entered data is numbers
    {
      $output = json_encode(array('type'=>'error', 'text' => 'Solo numeros en el campo de telefono'));
      die($output);
    }
    if(strlen($user_Message)<5) //check emtpy message
    {
      $output = json_encode(array('type'=>'error', 'text' => 'Mensaje corto o vacio.'));
      die($output);
    }
    
    $headers = "From: " .$user_Email. "\r\n";
    $headers .= "Reply-To: ".$user_Email. "\r\n";
    $headers .= "CC: susan@example.com\r\n";
    $headers .= 'MIME-Version: 1.0' . "\r\n";
    $headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";
    $message="
    Nombre:".$user_Name."<br>
    Correo:".$user_Email."<br>
    Telefono:".$user_Phone."<br>
    Mensaje:".$user_Message."";
    $sentMail =mail($to_Email,$subject,$message,$headers);
    
    if(!$sentMail)
    {
      $output = json_encode(array('type'=>'error', 'text' => 'No se pudo enviar el correo.'));
      die($output);
    }else{
      $output = json_encode(array('type'=>'message', 'text' => 'Hola '.$user_Name .' Gracias por el correo te responderemos en breve'));
      die($output);
    }
  }
    }


} 

?>