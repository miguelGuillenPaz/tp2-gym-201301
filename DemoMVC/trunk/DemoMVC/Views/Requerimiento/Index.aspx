<%@ Page Title="Title" Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<DemoMVC.Models.Requerimiento>>" MasterPageFile="~/Views/Shared/Site.Master" %>

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
                Gestionar Informes de Requerimientos
            </h1>
            <div class="areas-negocios">
                <div class="lista-central">
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Registros:
                                <%= Model.Count() %></span>
                        </div>
                        <div class="texto-noticia">
                            <table id="tblConvocatoria">
                                <thead>
                                    <tr>                                        
                                        <th>
                                            <b>Requerimiento</b>
                                        </th>
                                        <th>
                                            <b>Descripción</b>
                                        </th>
                                        <th>
                                            <b>Proyecto</b>
                                        </th>
                                        <th>
                                            <b>Fecha</b>
                                        </th>
                                         <th>
                                            <b>Tipo Recurso</b>
                                        </th>
                                        <th style="width: 180px; text-align: center;">
                                            <b>Opciones</b>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (Model != null)
                                       {
                                           foreach (var requerimiento in Model)
                                           {
                                    %>
                                    <tr>
                                        <td>
                                            <%= requerimiento.idReq %>
                                        </td>
                                        <td>
                                            <%= requerimiento.descripcion %>
                                        </td>
                                        <td>
                                            <%= requerimiento.desProyecto %>
                                        </td>
                                        <td>
                                            <%= requerimiento.fecha.ToString().Substring(6, 4) + "-" + requerimiento.fecha.ToString().Substring(3, 2) + "-" + requerimiento.fecha.ToString().Substring(0, 2)%>
                                        </td>
                                        <td>
                                            <%= requerimiento.descTipoReq %>
                                        </td>
                                        <td style="text-align: center;">
                                            <%= Html.ActionLink("Editar","Editar", new { id = requerimiento.idReq }, new{@class="button"})%>
                                            | <a class="eliminar button" href="javascript:;">Eliminar</a>
                                        </td>
                                    </tr>
                                    <%
                                           }
                                       } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <br />                    
                    <%= Html.ActionLink("Agregar","Agregar", new { }, new{@class="button"})%>
                    <br />
                    <br />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
