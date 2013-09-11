<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<script type="text/javascript" language="javascript">
    $(function () {
        $("#fechaaprobacion").datepicker({
            showOn: "button",
            buttonImage: config.contextPath + 'images/calendar.gif',
            buttonImageOnly: true,
            dateFormat: 'dd/mm/yy'
        });
    });
</script>

<% using (Html.BeginForm()) { %>
<input type='hidden' id='IdDetallePartida' name='IdDetallePartida' value='<%= ViewData["IdDetallePartida"] %>' />
<table border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td>Destinatario</td>
        <td>
            <%: Html.DropDownList("destinatario", (SelectList)ViewData["destinatarios"], new { style = "width: 260px;" })%>
        </td>
    </tr>
    <tr>
        <td>Cantidad</td>
        <td><input type="text" id="cantidad" name="cantidad" value="" style="width: 50px;" /></td>
    </tr>
    <tr>
        <td>Fecha de Ejecución</td>
        <td><input type="text" id="fechaaprobacion" name="fechaaprobacion" disabled="disabled" style="width: 100px;" /></td>
    </tr>
    <tr>
        <td valign="top" style="vertical-align: top;">Observación</td>
        <td><textarea id="observacion" rows="5" cols="5" name="observacion" style="width: 395px; height: 300px;"></textarea></td>
    </tr>
</table>
<% } %>