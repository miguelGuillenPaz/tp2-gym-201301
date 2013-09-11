<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<DemoMVC.Models.Proyecto>>" %>

<asp:Content ID="ContentPlan" ContentPlaceHolderID="MainContent" runat="server">
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
    <div class="contenido-top">
        <div>
            <h1>
                Planificación de Proyectos > Listado de Proyectos Aprobados
            </h1>
            <div class="areas-negocios">
                <div class="lista-central">
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Por favor, seleccione un proyecto aprobado para la planificación
                                del mismo:</span>
                        </div>
                        <div class="texto-noticia">
                            <% using (Html.BeginForm())
                               { %>
                            <fieldset>
                                <hr>
                                <div class="editor-label">
                                    <label for="UserName">
                                        Código del Proyecto:</label>&nbsp;&nbsp;<input id="txtCodProy" name="txtCodProy"
                                            type="text" value="" />
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="submit" value="Buscar" class="button" />
                                </div>
                                <hr>
                                <br>
                                <br>
                                <% } %>
                                Resultados de la búsqueda:
                                <%: ViewData["totReg"] %>
                                <div class="editor-field">
                                    <table id='Tabla1'>
                                        <tr>
                                            <th>
                                                Código Proyecto
                                            </th>
                                            <th>
                                                Nombre Proyecto
                                            </th>
                                            <th>
                                                tipo Proyecto
                                            </th>
                                            <th>
                                                Fecha de Inicio
                                            </th>
                                            <th>
                                                Fecha de Fin
                                            </th>
                                            <th>
                                                Presupuesto
                                            </th>
                                            <th>
                                                Crear Plan
                                            </th>
                                        </tr>
                                        <% 
                                            if (Model != null)
                                            {
                                                foreach (var item in Model)
                                                { %>
                                        <tr>
                                            <td align="center">
                                                PROY<%: item.codPro %>
                                            </td>
                                            <td>
                                                <%: item.nomPro %>
                                            </td>
                                            <td>
                                                <%: item.tipoProyecto%>
                                            </td>
                                            <td>
                                                <%: item.feciniplaPro %>
                                            </td>
                                            <td>
                                                <%: item.fecfinplaPro %>
                                            </td>
                                            <td>
                                                <%: item.monfacPro %>
                                                <%: item.presupuesto %>
                                            </td>
                                            <td align="center">
                                                <%: Html.ActionLink("Crear", "CrearPlan", "Planificacion", new { codProy = item.codPro },null)%>
                                            </td>
                                        </tr>
                                        <% } %>
                                        <% } %>
                                    </table>
                                </div>
                                <center>
                                    <h2>
                                        <%: ViewData["msgErr"] %></h2>
                                </center>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
