﻿<%@ Page Title="Title" Language="C#" Inherits="System.Web.Mvc.ViewPage<System.Collections.Generic.List<DemoMVC.Models.GRH_Convocatoria>>" MasterPageFile="~/Views/Shared/Site.Master" %>

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
                Convocatorias Disponibles
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
                                            <b>Inicio - Fin</b>
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
                                        <td style="display:none;">
                                            <%= grhConvocatoria.IdConvocatoria %>
                                        </td>                                        
                                        <td>                                            
                                            <%= grhConvocatoria.FechaInicio.ToString().Substring(6, 4) + "-" + grhConvocatoria.FechaInicio.ToString().Substring(3, 2) + "-" + grhConvocatoria.FechaInicio.ToString().Substring(0, 2) %> - <%= grhConvocatoria.FechaFin.ToString().Substring(6, 4) + "-" + grhConvocatoria.FechaFin.ToString().Substring(3, 2) + "-" + grhConvocatoria.FechaFin.ToString().Substring(0, 2) %>
                                        </td>
                                        <td>
                                            <%= grhConvocatoria.Titulo %>
                                        </td>
                                        <td>
                                            <%= grhConvocatoria.CantidadVacantes %>
                                        </td>
                                        <td style="text-align: center;">                                                                                        
                                            <%= Html.ActionLink("Ver detale","Detalle",new{id = grhConvocatoria.IdConvocatoria},new {@class="eliminar button"}) %>
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
