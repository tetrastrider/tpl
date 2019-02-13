<body><div class="todo">
    <header>
    <nav>
  <a href="/"><div class="col">Sitio Web</div></a>
  <a href="/Administrador"><div class="col">Publicar</div></a>
  <a href="/publicaciones"><div class="col"  id="activo">Publicaciones</div></a>
  <a href="/registro"><div class="col">Control</div></a>
  <a href="/administrador/salir"><div class="col">Salir</div></a>
  <div class="buscar">
<form name="buscador" action="Publicaciones"><input type="text" name="b" placeholder="Buscar:"/><button type="submit" class="buscardor"title="buscar"/></button></form>
</div>
</nav>
    </header>

<div class="cuerpo">
<div class="limite">
<!---->
<form  name="orden" method="get">
<input type="hidden" name="p" value="</pagina/>"/>
<label class="m custom-select">

<select name="lt" onchange='this.form.submit()'>
<option </hasta5/> value=5>5</option>
<option </hasta10/> value=10>10</option>
<option </hasta15/> value=15>15</option>
<option </hasta20/> value=20>20</option>
<option </hasta25/> value=25>25</option>
<option </hasta30/> value=30>30</option>
</select>
</label>

<label class="n custom-select">
<select name="co" onchange='this.form.submit()'>
<option </check2/> value=2>Publicaciones Nuevas</option>
<option </check1/> value=1>Publicaciones Anteriores</option>
</select>

</label>
<noscript><input type="submit" value="Submit"></noscript>
 </form>
</div>
<div class="servicios">
<div class='noticias'>
<div id="noticia">
  </contenido/>
</paginacion/>
</div>
<aside>
  <!---adminbaner---->
  <div class='envase admin'>
   <center><h3></user/></h3></center>
  </div>
  <!---adminbaner---->
  <!--cat-->
  <h6>Categorias</h6>
<div class="cat">
</each:categorias/>
<a href="/publicaciones?c=[categoria]"><p><i class="fa fa-tags"></i> [categoria] </p></a>
</endeach:/>
<a href="/publicaciones"><p><i class="fa fa-tags"></i> todas </p></a>
</div>
  <!--cat-->
 <hr>
<!--chatbox-->
</aside>
</div>
</div>