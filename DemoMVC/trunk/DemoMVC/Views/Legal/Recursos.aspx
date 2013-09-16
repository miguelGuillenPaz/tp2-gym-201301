<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<DemoMVC.Models.AsesorLegal>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Recursos
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form runat="server">
    <section id="seccionReqLegal">
    <h1>Detalle del Requerimiento</h1>
    <% using (Html.BeginForm())
       { %>
       <div class="fila">
            <div class="col2 paddingTop">
                Requerimiento Legal: 
            </div>
            <div class="col4">
                <input id="txtCodSolicitud" name="txtCodSolicitud" type="text" 
                value="<%: ViewData["idReq"] %> " readonly="readonly" class="text3"/>
            </div>
       </div>
       <div class ="fila">
            <div class="col2 paddingTop">
                Proyecto: 
            </div>
            <div class="col4">    
                <input id="txtProyecto" name="txtProyecto" type="text" 
                value="<%: ViewData["Proyecto"] %>" readonly="readonly" class="text2"/>
            </div>
       </div>
       <div class="fila">
            <div class="col2 paddingTop">
                Fecha de Solicitud: 
            </div>
            <div class="col4">
              <input id="Text2" name="txtEstado" type="text" 
                value="<%: ViewData["Fecha"] %>" readonly="readonly" class="text2" disabled="disabled"/>
            </div>
       </div>
       <div class="fila">
        <div class="col2 paddingTop">
            <label for="Username">Prioridad:</label>
        </div>
        <div class="col6">
            <input id="Text1" name="txtPrioridad" type="text" value=""/>
        </div>
        </div>
       <div id="editor-field">
    <table id="Tabla1">
        <tr>
            <th>Asesor</th>
            <th>Casos asignados</th>
            <th>Seleccione</th>
        </tr>
        <%
            if (Model != null)
            {
                foreach (var item in Model)
                {%>
                 <tr>
                    <td><%: item.Nombre + " " + item.Apellido%></td>
                    <td align="center"><%: Html.ActionLink(Convert.ToString(item.CasosAsignados), "DetalleRequerimientosAsesores", "Legal", new { idAsesorLegal = item.IdAsesorLegal }, null)%></td>
                    <td><%: Html.RadioButton("checked:" + item.IdAsesorLegal.ToString(), "",false)  %></td>
                 </tr>
           <% } %>
    <% } %>
    </table>
    <div class="fila">
     <p><input type="submit" value="Asignar"/></p>
    </div>
     </div>
    <% } %>
</section>
    </form>
</asp:Content>
