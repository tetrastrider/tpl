<body>
	<div class="todo">

<form class="form-signin" action="/log/login" method="post" name='log'autocomplete="false">
<h6>Inicio de Sesion</h6>
<span><i class="fa fa-user"></i> Usuario</span>
<span><i class="fa fa-lock"></i> Contraseña</span>
<input type="text" placeholder="Usuario" required title="Entra Tu Nombre De Usuario. Minimo 8  Maximo 50 Caracteres Especiales Permitidos @ _ -" pattern="[a-zA-Z0-9-@_-]{8,50}" name="usuario" autocomplete="false"/>

<input type="password" placeholder='contrase&ntilde;a' required title="Contraseña Minimo 8  Maximo 50 Caracteres Especiales Permitidos @ _ -" pattern="[a-zA-Z0-9-@_-]{8,50}" name="password" autocomplete="new-password"/>

<br><button class="btn" type="submit" value='logear'>Entrar</button>
<button class="btn sl" type="reset">Reset</button>
<div class="regisopt">
<a href="#registrarse">Registrarse</a>
<a href="#recuperar">Recuperar Contraseña</a>
</div>
</form>

