<%@ Page Title="Title" Language="C#" Inherits="System.Web.Mvc.ViewPage<DemoMVC.Models.GRH_Convocatoria>" MasterPageFile="~/Views/Shared/Site.Master" %>

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
                <%= Model.Titulo %>
            </h1>
            <div class="areas-negocios">
                <div class="lista-central">
                    <div class="noticia">
                        <div class="head-noticia">
                           Detalle
                        </div>
                        <div class="texto-noticia">
                              <table id="tblConvocatoria">
                                <tr><td>Fecha Inicio</td><td>:</td><td><%= Model.FechaInicio %></td></tr>
                                <tr><td>Fecha Fin</td><td>:</td><td><%= Model.FechaFin %></td></tr>
                                <tr><td>Descripción</td><td>:</td><td><%= Model.Detalle.Replace("\n","<br/>") %></td></tr>
                                <tr><td>Vacantes</td><td>:</td><td><%= Model.CantidadVacantes %></td></tr>
                            </table>
                        </div>
                        
                    </div>                    
                    <div class="content-button">
                        <%= Html.ActionLink("Participar","Participar",null,new{@class="button"}) %>
                    </div>
                </div>
                 
            </div>
            
        </div>
        
    </div>
    
</asp:Content>



