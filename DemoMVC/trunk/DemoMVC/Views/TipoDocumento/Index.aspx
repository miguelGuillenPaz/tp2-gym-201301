<%@ Page Title="Lorena" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<DemoMVC.Models.GD_TipoDocumento>>" %>



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
    <script src="../../Scripts/tipoDocumento.js" type="text/javascript"></script>
    <div class="contenido-top">
        <div>
            <h1>
                Actualización de Tipo de Documentos
                
            </h1>
            <div class="areas-negocios">
            <% //using (Html.BeginForm())
                // { %>
                <div class="lista-central">
                
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Tipos de Documentos
                                
                            </span>
                        </div>
                        <div class="texto-noticia">
                              <table id="tblTipoDocumento">
                                <thead>
                                    <tr>
                                        <th>
                                            <b>Código</b>
                                        </th>
                                        <th>
                                            <b>Nombre</b>
                                        </th>
                                        <th>
                                            <b>Vigencia</b>
                                        </th>
                                        <th style="text-align: center;"><b>Opciones</b>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (Model != null)
                                       {
                                           foreach (var grhTipoDocumento in Model)
                                           {
                                    %>
                                    <tr>
                                        <td>
                                            <%= grhTipoDocumento.IdTipoDocumento %>
                                        </td>
                                        <td>                                            
                                            <%= grhTipoDocumento.Nombre %>
                                        </td>
                                        <td>
                                            <%= grhTipoDocumento.Vigencia %>
                                        </td>
                                        <td style="text-align: center;">
                                            <%= Html.ActionLink("Editar","Editar", new { id = grhTipoDocumento.IdTipoDocumento}, new{@class="button"})%> |
                                            <a class="eliminar button" href="javascript:;">Eliminar</a>
                                        </td>
                                    </tr>
                                    <%
                                           }
                                       } %>
                                </tbody>
                            </table>
                        </div>
                        <div class="head-noticia">
                            <span class="titulo-noticia">Nro. Registros:
                                <span id="Span1" ><%= Model.Count() %></span>
                            </span>
                        </div>
                    </div>                    
                    <br/>
                    <a class="button" id="btnAgregar" href="/TipoDocumento/Registrar">Agregar</a> 
                    <br/>
                    <br/>
                </div>
                 
            </div>
            
        </div>
        
    </div>
    
</asp:Content>
