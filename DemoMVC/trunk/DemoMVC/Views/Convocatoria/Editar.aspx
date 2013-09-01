<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<DemoMVC.Models.GRH_Convocatoria>" %>

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
                Editar
                <%= Html.HiddenFor(m=> m.IdConvocatoria) %>
            </h1>
            <div class="areas-negocios">
              <% using (Html.BeginForm())
                 { %>
                <div class="lista-central">
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Convocatoria</span>
                        </div>
                        <div class="texto-noticia">
                            <table>
                                <tr>
                                    <td>
                                        <%= Html.Label("Título")%>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <%= Html.TextBoxFor(m => m.Titulo, new { @required = "required", @Style = "width:600px;" })%>
                                    </td>
                                    <td>
                                    </td>                                    
                                </tr>
                                <tr>
                                    <td>
                                        <%= Html.Label("Detalle")%>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td colspan="2">
                                        <%= Html.TextAreaFor(m => m.Detalle, new { @required = "required", @rows = "10", @Style = "width:600px;" })%>
                                    </td>                                    
                                </tr>
                                <tr>
                                    <td>
                                        <%= Html.Label("Fecha de Inicio")%>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                         <% var fechaInicio = string.Empty;
                                            if (Model.FechaInicio != null)
                                            {
                                                fechaInicio = Model.FechaInicio.ToString().Substring(6, 4) + "-" + Model.FechaInicio.ToString().Substring(3, 2) + "-" + Model.FechaInicio.ToString().Substring(0, 2);
                                            } %>
                                        <input id="FechaInicio" name="FechaInicio" type="date" value="<%= fechaInicio %>" required="required" />
                                    </td>
                                    <td>
                                    </td>                                    
                                </tr>
                                <tr>
                                    <td>
                                        <%= Html.Label("Fecha de Fin")%>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                         <% var fechaFin = string.Empty;
                                            if (Model.FechaFin != null)
                                            {
                                                fechaFin = Model.FechaFin.ToString().Substring(6, 4) + "-" + Model.FechaFin.ToString().Substring(3, 2) + "-" + Model.FechaFin.ToString().Substring(0, 2);
                                            } %>
                                        <input id="FechaFin" name="FechaFin" type="date" value="<%= fechaFin %>" required="required"  />
                                    </td>
                                    <td>
                                    </td>                                    
                                </tr>
                                <tr>
                                    <td>                                        
                                        <%= Html.Label("Cantidad de Vacantes")%>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <%= Html.TextBoxFor(m => m.CantidadVacantes, new { @type = "number", @required = "required", @Style = "width:50px;", @min = "1" })%>
                                    </td>
                                    <td>
                                    </td>                                    
                                </tr>      
                                 <tr>
                                    <td>
                                        <%= Html.Label("Perfil")%>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>                                        
                                        <%= Html.DropDownListFor(m => m.IdPerfil, (IEnumerable<SelectListItem>)ViewData["Perfil"], new { @required = "required" })%>
                                    </td>                                                                        
                                </tr>                                                      
                            </table>                            
                        </div>
                    </div>               
                    
                    <input class="button" type="submit" value="Enviar" /> | <a id="btnCancelar" class="button" href="/Convocatoria">Cancelar</a> 
                </div>
                <%} %>
            </div>
        </div>
    </div> 
</asp:Content>
