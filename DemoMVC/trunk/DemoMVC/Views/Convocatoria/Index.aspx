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
    <script src="../../Scripts/convocatoria.js" type="text/javascript"></script>
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
                              <table id="tblConvocatoria">
                                <thead>
                                    <tr>
                                    <th style="display:none;">Id</th>
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
                                        <th><b>Opciones</b>
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
                                        <td style="display:none;">
                                            <%= grhConvocatoria.IdConvocatoria %>
                                        </td>
                                        <td>                                            
                                            <%= grhConvocatoria.FechaInicio.ToString().Substring(6, 4) + "-" + grhConvocatoria.FechaInicio.ToString().Substring(3, 2) + "-" + grhConvocatoria.FechaInicio.ToString().Substring(0, 2) %>
                                        </td>
                                        <td>                                            
                                            <%= grhConvocatoria.FechaFin.ToString().Substring(6, 4) + "-" + grhConvocatoria.FechaFin.ToString().Substring(3, 2) + "-" + grhConvocatoria.FechaFin.ToString().Substring(0, 2) %>
                                        </td>
                                        <td>
                                            <%= grhConvocatoria.Titulo %>
                                        </td>
                                        <td>
                                            <%= grhConvocatoria.CantidadVacantes %>
                                        </td>
                                        <td style="text-align: center;">
                                            <%= Html.ActionLink("Editar","Editar", new { id = grhConvocatoria.IdConvocatoria })%> |
                                            <a class="eliminar" href="javascript:;">Eliminar</a>
                                        </td>
                                    </tr>
                                    <%
                                           }
                                       } %>
                                </tbody>
                            </table>
                        </div>
                        
                    </div>                    
                    <br/>
                    <a class="button" id="btnAgregar" href="/Convocatoria/Crear">Agregar</a> 
                    <br/>
                    <br/>
                </div>
                 
            </div>
            
        </div>
        
    </div>
    
</asp:Content>
