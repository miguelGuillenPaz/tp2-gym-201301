<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<DemoMVC.Models.PMP_MaquinariaEquipo>>" %>

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
    <div class="contenido-top">
        <div>
            <h1>
                Crear Presupuesto</h1>
            <div class="editor-label">
                <table>
                    <tr>
                        <td>
                            <label for="txtAno">
                                Año:</label>
                        </td>
                        <td>
                            <input id="txtAno" type="number" max="9999" min="1900" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="txtDescripcion">
                                Descripción:</label>
                        </td>
                        <td>
                            <input id="txtDescripcion" type="text" />
                        </td>
                    </tr>
                </table>
            </div>
            <div class="areas-negocios">
                <div class="lista-central">
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Información Personal</span>
                        </div>
                        <div class="texto-noticia">
                            <table id="tblListadoEquipos">
                                <thead>
                                    <tr>
                                        <th>
                                            <b>Id</b>
                                        </th>
                                        <th style="width: 150px; text-align: center;">
                                            <b>Modelo</b>
                                        </th>
                                        <th>
                                            <b>Descripción</b>
                                        </th>
                                        <th style="width: 150px; text-align: right">
                                            <b>Costo total fijo</b>
                                        </th>
                                        <th style="width: 150px; text-align: right">
                                            <b>Cantidad</b>
                                        </th>
                                        <th style="width: 150px; text-align: right">
                                            <b>Costo total final</b>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (Model != null)
                                       {
                                           foreach (var pre in Model)
                                           {
                                    %>
                                    <tr>
                                        <td>
                                            <%=pre.idMaquinariaEquipo %>
                                        </td>
                                        <td style="text-align: center;">
                                            <%=pre.modelo%>
                                        </td>
                                        <td>
                                            <%=pre.descripcion %>
                                        </td>
                                        <td style="text-align: right;">
                                            <%=pre.costoMantenimiento%>
                                        </td>
                                        <td style="text-align: right;">
                                            <input class=".cantidad" type="number" value="1" />
                                        </td>
                                        <td style="text-align: right;">
                                            <%=pre.costoMantenimiento %>
                                        </td>
                                    </tr>
                                    <%}
                           } %>
                                </tbody>
                            </table>
                        </div>                        
                    </div>
                    <a id="addPresupuesto" href="javascript:;">Crear</a>
                </div>
            </div>
    </div> </div>
</asp:Content>
