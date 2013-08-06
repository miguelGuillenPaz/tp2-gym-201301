<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<DemoMVC.Models.PMP_DetalleProgramacionPreventiva>>" %>

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
                Programacion Maquinarias y Equipo </h1>

            <table id="datos">
                <tr>
                    <td>
                        Código
                    </td>
                    <td>
                        :
                    </td>
                    <td>
                        <%: ViewData[""] %>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>

            <table id="tblListadoProgramacion">
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
