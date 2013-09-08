<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<DemoMVC.Models.GRH_Persona>>" %>

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
                Seleccionar Persona
            </h1>
            <div class="areas-negocios">
                <div class="lista-central">
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Empleados Aprobados: <%= Model.Count() %></span>
                        </div>
                        <div class="texto-noticia">
                            <table>
                                <thead>
                                    <tr>
                                        <th>
                                            <b>Nombres</b>
                                        </th>
                                        <th>
                                            <b>Apellido Paterno</b>
                                        </th>
                                        <th>
                                            <b>Apellido Materno</b>
                                        </th>
                                        <th>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (Model != null)
                                       {
                                           foreach (var grhPersona in Model)
                                           {
                                    %>
                                    <tr>
                                        <td>
                                            <%= grhPersona.Nombre %>
                                        </td>
                                        <td>
                                            <%= grhPersona.ApellidoPaterno %>
                                        </td>
                                        <td>
                                            <%= grhPersona.ApellidoMaterno %>
                                        </td>
                                        <td style="text-align: center;">
                                            <%= Html.ActionLink("Agregar", "DatosAdicionales", new { id = grhPersona.IdPersona },new{@class="button"})%>
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
