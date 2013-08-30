<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<DemoMVC.Models.GRH_Convocatoria>>" %>

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
                Convocatorias
            </h1>
            <div class="areas-negocios">
                <div class="lista-central">
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Registros:
                                <%= Model.Count() %></span>
                        </div>
                        <div class="texto-noticia">
                              <table class="table100 table100b">
                                <thead>
                                    <tr>
                                        <th>
                                            <b>Inicio</b>
                                        </th>
                                        <th>
                                            <b>Fin</b>
                                        </th>
                                        <th>
                                            <b>Titulo</b>
                                        </th>
                                        <th>
                                            <b>Vacantes</b>
                                        </th>
                                        <th>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (Model != null)
                                       {
                                           foreach (var grhConvocatoria in Model)
                                           {
                                    %>
                                    <tr>
                                        <td>
                                            <%= grhConvocatoria.fechaInicio %>
                                        </td>
                                        <td>
                                            <%= grhConvocatoria.fechaFin %>
                                        </td>
                                        <td>
                                            <%= grhConvocatoria.titulo %>
                                        </td>
                                        <td>
                                            <%= grhConvocatoria.cantidadVacantes %>
                                        </td>
                                        <td style="text-align: center;">
                                            <%= Html.ActionLink("Editar","Editar", new { id = grhConvocatoria.idConvocatoria })%> |
                                            <%= Html.ActionLink("Eliminar", "Eliminar", new { id = grhConvocatoria.idConvocatoria })%>
                                        </td>
                                    </tr>
                                    <%
                                           }
                                       } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
