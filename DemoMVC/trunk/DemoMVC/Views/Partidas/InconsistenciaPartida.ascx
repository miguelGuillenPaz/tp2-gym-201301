<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<% using (Html.BeginForm()) { %>
<input type='hidden' id='IdInconsistenciaAvancePartida' name='IdInconsistenciaAvancePartida' value='<%= ViewData["IdInconsistenciaAvancePartida"] %>' />
<input type='hidden' id='IdAvancePartida' name='IdAvancePartida' value='<%= ViewData["IdAvancePartida"] %>' />
<p>Registre alguna observación que se incluirá en el requerimiento de inconsistencia de avance por Partida</p>
<textarea id="observacion" rows="5" cols="5" name="observacion" style="width: 550px; height: 300px;"><%= ViewData["Justificacion"]%></textarea>
<% } %>