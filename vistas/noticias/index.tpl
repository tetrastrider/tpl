<!--oncontextmenu="return false"onkeydown='return false'-->
<body>
  <div class="todo">
    <header>
      <a href="inicio"><div class="imglogo"></div></a>
<nav itemprop="breadcrumb">
  </MENU/>
  <div class="buscar">

<form name="buscador" action="noticias"><input type="text" name="b" placeholder="Buscar:"/><button type="submit" class="buscardor"title="buscar"/></button></form>
</div>

</nav>
    </header>

<div class="cuerpo">
<div class="limite">
</si:[idnoti][!existe][0]/>
<form  name="orden" method="get">
<input type="hidden" name="p" value="</pagina/>"/>
<label class="m custom-select">

<select name="lt" onchange='this.form.submit()' title='Cambiar numero de entradas a mostrar'>
<option </hasta5/> value=5 title='5'>5</option>
<option </hasta10/> value=10 title='10'>10</option>
<option </hasta15/> value=15 title='15'>15</option>
<option </hasta20/> value=20 title='20'>20</option>
<option </hasta25/> value=25 title='25'>25</option>
<option </hasta30/> value=30 title='30'>30</option>
</select>
</label>

<label class="n custom-select">
<select name="co" onchange='this.form.submit()' title='Orden de las plublicaciones'>
<option </check2/> value=2>Publicaciones Nuevas</option>
<option </check1/> value=1>Publicaciones Anteriores</option>
</select>

</label>
<noscript><input type="submit" value="Submit"></noscript>
 </form>
</endsi:/>
</div>
<div class="servicios">
<div class='noticias'>

<div id="noticia"> 
</contenido/>
</noresult/>
</comentar/>
</paginacion/>
<!--paginacion-->
</div>
<aside>
<h3>Categorias</h3>
<div class="cat">

 </each:categorias/>
<a href="javascript:void(0);" onclick="window.location.assign('/?c=[categoria]')" rel="tag" title="[categoria]"><p><i class="fa fa-tags"></i> [categoria] </p></a>
</endeach:/>

<a href="/" title='todas'><p><i class="fa fa-tags"></i> todas </p></a>
</div>
<h3>Ultimos Comentarios</h3>
<div class="combello">
 </each:ultimos/>
<a href="javascript:void(0);" onclick="window.location.assign('/[id_contenido]')"><div class="comecont">
<img src="/[foto]" class="fotocom"/>
<h6>Escrito por:&nbsp;<i class="fa fa-user" itemprop="author"></i> &nbsp; [autor]</h6>
<p itemprop="comment" itemscope>[comentario]</p>
<p><small><i class="fa fa-calendar"></i>&nbsp;[publicado]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-tags"></i>&nbsp;[categoria]</small></p>
</div></a>
</endeach:/>
</div>
<h3>Chat</h3>
<!--chatbox-->
<div class="shout_caja">
  <div class="toggle_chat">
  <div class="message_box">
    </div>
    <div class="user_info">
     
      <input type='hidden' id='shout_username' name='shout_username' value='[user]'/>
    
   <input name="shout_message" id="shout_message" type="text" placeholder="Escribe un mensaje y Pulsa Enter" maxlength="100" />
    
    </div>
    </div>
</div>
<!--chatbox-->

</aside>

</div></div>

</div>
