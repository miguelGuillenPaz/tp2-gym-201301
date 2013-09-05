<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<List<GD_Documento>>" %>
<%@ Import Namespace="DemoMVC.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Contenidos
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link href="../../Content/SiteGD.css" rel="stylesheet" type="text/css" />

<div class="contenido-top">
        <div>
            <h1>
                BUSCAR DOCUMENTO
            </h1>
    <fieldset>
        <legend>Criterios de Búsqueda</legend><br />
        
        <%using (Html.BeginForm("Buscar", "Contenidos", new { r = ViewData["reference"] }, FormMethod.Post))
          {%>
          
          <table cellpadding="0" cellspacing="0" border="0" class="tabla-gestion">
          <tr>
              <td><div class="editor-label"><label for="codigo">Código Documento</label></div></td>
              <td><div class="editor-field"><%:Html.TextBox("codigo") %></div></td>
              <td><div class="editor-label">Creado entre</div></td>
              <td><div class="editor-field"><%:Html.TextBox("txtCreadoFrom")%></div></td>
              <td>o</td>
              <td><div class="editor-field"><%:Html.TextBox("txtCreadoUntil")%></div></td>
          </tr>
          <tr>
              <td><div class="editor-label"><label for="tags">Palabra Clave</label></div></td>
              <td><div class="editor-field"><%:Html.TextBox("tags") %></div></td>
              <td><div class="editor-label">Registrado entre</div></td>
              <td><div class="editor-field"><%:Html.TextBox("txtRegistradoFrom")%></div></td>
              <td>o</td>
              <td><div class="editor-field"><%:Html.TextBox("txtRegistradoUntil")%></div></td>
          </tr>
          <tr>
              <td><div class="editor-label"><label for="area">Area</label></div></td>
              <td><div class="editor-field"><%: Html.DropDownList("area",new SelectList((IEnumerable<GRH_Area>)ViewData["Area"], "Codigo","Nombre"),"-- Seleccionar --")%></div></td>
              <td><div class="editor-label"><label for="tipoDocumento">Tipo Documento</label></div></td>
              <td><div class="editor-field"><%: Html.DropDownList("tipoDocumento", new SelectList((IEnumerable<GD_TipoDocumento>)ViewData["TipoDocumento"], "IdTipoDocumento", "Nombre"), "-- Seleccionar --")%></div></td>
              <td></td>
              <td></td>
          </tr>
          <tr>
              <td><div class="editor-label"><label for="proyectoCodigo">Proyecto</label></div></td>
              <td><div class="editor-field"><%: Html.DropDownList("proyectoCodigo", new SelectList((IEnumerable<GPP_Proyecto>)ViewData["Proyecto"], "IdProyecto", "Nombre"), "-- Seleccionar --")%></div></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
          </tr>
          <tr>
          <td colspan="3" style="text-align:right; padding-right:10px;"><input type="submit" value="Buscar" /></td>
          <td colspan="3" style="text-align:left; padding-left:10px;"><input id="btnLimpiar" type="button" value="Limpiar" /></td>
          </tr>
          </table><br />

         <%}%>
    </fieldset>
    <br />
    <div>
        <table border=0 width="90%" >
            <tr><th>&nbsp;</th><th>Código</th><th>Nombre del documento</th><th>Descripción</th><th>Fecha Documento</th><th>Fecha Registro</th></tr>
            <% if (Model != null)
               {
                   foreach (var d in Model)
                   { %>
                <tr><th><%:Html.ActionLink("Seleccionar", ViewData["reference"].ToString(), "Contenidos", new { id = d.IdDocumento},null)%></th><td><%= d.IdDocumento%></td><td><%=d.Nombre%></td><td><%= d.Descripcion %></td><td><%= d.FechaDocumento == null ? string.Empty : d.FechaDocumento.Value.ToString("dd/MM/yyyy") %></td><td><%= d.FechaRegistro == null ? string.Empty : d.FechaRegistro.ToString("dd/MM/yyyy") %></td></tr>
               <% }
               } %>
        </table>
    </div>
    
    <script language="javascript" type="text/javascript">
        $(function () {
            $("#btnLimpiar").click(function () {
                $("input[type=text]").val("");
                $("select").val("0");
            });
            $('#txtCreadoFrom, #txtCreadoUntil').datepicker({ showOn: "both", beforeShow: customRange, dateFormat: "dd/mm/yy" });
            $('#txtRegistradoFrom, #txtRegistradoUntil').datepicker({ showOn: "both", beforeShow: customRange, dateFormat: "dd/mm/yy" });
        });

        function customRange(input) {
            var fec, minDate;
            if (input.id == 'txtCreadoUntil') {
                fec = $("#txtCreadoFrom").val().split("/");
                minDate = new Date(parseInt(fec[2]),parseInt(fec[1])-1,parseInt(fec[0]));
                minDate.setDate(minDate.getDate() + 1);
                return {minDate: minDate};
            }
            if (input.id == 'txtRegistradoUntil') {
                fec = $("#txtRegistradoFrom").val().split("/");
                minDate = new Date(parseInt(fec[2]), parseInt(fec[1]) - 1, parseInt(fec[0]));
                minDate.setDate(minDate.getDate() + 1);
                return { minDate: minDate };
            }
        }
        
    </script>

    </div>
</div>
</asp:Content>



