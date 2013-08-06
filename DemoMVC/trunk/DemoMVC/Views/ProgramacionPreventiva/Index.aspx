<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<DemoMVC.Models.PMP_ProgramacionPreventiva>>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            try {
                var textoNoticia = $('.head-noticia').next();
                if (textoNoticia.hasClass('texto-noticia')) {
                    if (textoNoticia.css('display') == 'none') {
                        textoNoticia.slideDown();
                    }
                    else {
                        textoNoticia.slideUp();
                    }
                }
            } catch (ex) {
            }
        });
    </script>
    <script src="../../Scripts/Presupuesto/presupuesto.js" type="text/javascript"></script>
    <div class="contenido-top">
        <div>
            <h1>
                Programacion Preventiva de Maquinarias y Equipos </h1>
                <br/>
                <br/>
                  <% using (Html.BeginForm())
               { %>
                <%= Html.DropDownList("ddlPresupuestosAprobados", (IEnumerable<SelectListItem>)ViewData["PresupuestosAprobados"])%>
                <br/>
                <input type="submit" value="Cargar" />
                 <% } %>
            <table id="tblListadoProgramacion" class="table100 table100b">
                <thead>
                    <tr>
                        <th>
                            <b>Código</b>
                        </th>
                        <th>
                            <b>Descripción</b>
                        </th>
                        <th>
                            <b>Mtos.</b>
                        </th>
                        <th>
                            <b>Fecha Máx.</b>
                        </th>
                        <th>
                            <b>Máx.</b>
                        </th>
                        <th>
                            <b>Estado Actual del Equipo</b>
                        </th>
                        <th>
                            <b>Detalle</b>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <% if (Model != null)
                       {
                           foreach (var item in Model)
                           {
                    %>
                    <tr>
                        <td>
                            <%=item.idMaquinariaEquipo%>
                        </td>
                        <td>
                            <%=item.PMP_MaquinariaEquipo.descripcion%>
                        </td>
                        <td>
                            <%=item.cantidadMantenimientos %>
                        </td>
                        <td>
                            <%=item.fechaMaxima%>
                        </td>
                        <td>
                            <%=item.maximaCantidadMantenimientos %>
                        </td>
                        <td>
                            <%=item.estadoActualEquipo %>
                        </td>
                        <td>
                            <a class="detalle" href="/ProgramacionPreventiva/Detalle/<%=item.idProgramacionPreventiva%>">Detalle</a>
                        </td>
                    </tr>
                    <%}
                       } %>
                </tbody>
            </table>          
        </div>
    </div>
   
</asp:Content>
