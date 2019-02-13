
<div class="comentarios">
<h3>Comentarios</h3>
</comid/>

</div>
<div class="formcom">
<form method="post" action="noticias/com">
<h3>Comentar</h3>
<input type="hidden" name="id" value="[idcom]"/>
<input type="text" name="autor" placeholder="Nombre:"value='&nbsp;&nbsp;[comnombre]'[readonly]/>
<input type="text" name="correo" placeholder="Correo:"value='&nbsp;&nbsp;[comcorreo]'[readonly]/>
<input type="hidden" name="foto" value="imagenes/usuarios/[comfoto]"/>
<input type="hidden" name="categoria" value="[catid]"/>
<textarea placeholder="Deja tu Comentario:" name="comentario"></textarea> 
<p><input type="submit" value="Enviar"/></p>
</form>
</div>
