<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<DemoMVC.Models.GD_Estado>" %>

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
                Actualización de Estado de Documentos
                <%= Html.HiddenFor(m=> m.IdEstado) %>
            </h1>
            <div class="areas-negocios">
              <% using (Html.BeginForm())
                 { %>
                <div class="lista-central">
                    <div class="noticia">
                        <div class="head-noticia" id="prueba">
                            <span class="titulo-noticia">Registro nuevo</span>
                        </div>
                        <div class="texto-noticia">
                            <table>
                                <tr>
                                    <td>
                                        <%= Html.Label("Nombre")%>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <%= Html.TextBoxFor(m => m.Nombre, new { @required = "required", @Style = "width:50%;" })%>
                                    </td>                                    
                                </tr>
                                                                             
                            </table>                            
                        </div>
                        
                    </div>               
                    <div class="content-button">
                    <input class="button" type="submit" value="Enviar" /> | <a id="btnCancelar" class="button" href="/Estado">Cancelar</a> 
                    </div>
                </div>
                <%} %>
            </div>
        </div>
    </div> 

    </asp:Content>
