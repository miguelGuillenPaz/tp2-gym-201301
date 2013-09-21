<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<DemoMVC.Models.AsignarRecursoForm>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	AsignarRecursos
</asp:Content>

<asp:Content ID="ContentPlan" ContentPlaceHolderID="MainContent" runat="server">
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
            <h1>
                Listar Actividades
            </h1>
            <% using (Html.BeginForm()) { %>
            <div class="areas-negocios">
                <div class="buscar-proyecto">
                    <input type='hidden' id='codProyIns' name='codProyIns' value='<%: ViewData["codProyIns"] %>'></input>
                    <table border="0">
			            <tr>
			               <td border="0" width="200px" >Proyecto:</td>
                           <td>
                            <select id='selProy' name='selProy'>                                
                                   <% if (Model.ListadoProyecto != null) {
                                          foreach (DemoMVC.Models.Proyecto item in Model.ListadoProyecto)  { %>
                                            <option value='<%= item.codPro %>' ><%= item.nomPro %></option>
                                      <% }%>
                                   <% }%>
                            </select>  
                                                                                  
                           </td>
                          <td>
                          <input type="submit" name="submitButton" value="Buscar" class="button" />
                          </td>
			            </tr>
            </table>                
                </div>
                <div class="lista-central">
                
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Actividades por Proyecto - Resultados de la búsqueda: <%: ViewData["totReg"] %>
                            </span>
                        </div>
                        <div class="texto-noticia">
                            <table id="tblConvocatoria">
                                <thead>
                                    <tr>                                                                               
                                        <th>
                                            <b>ID Actividad</b>
                                        </th>
                                        <th>
                                            <b>Descripción</b>
                                        </th>
                                        <th>
                                            <b>Entregable</b>
                                        </th>
                                        <th>
                                            <b>Duración</b>
                                        </th>
                                        <th>
                                            <b>Fecha Inicio</b>
                                        </th>
                                        <th>
                                            <b>Fecha Fin</b>
                                        </th>
                                         <th>
                                            <b>Estado</b>
                                        </th>
                                        <th style="width: 180px; text-align: center;">
                                            <b>Opción</b>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                  <% 
                                      if (Model.ListadoActividad != null) { 
                                      foreach (DemoMVC.Models.Actividad item in Model.ListadoActividad) { %>
			                          <tr>			                            
			                            <td><%: item.corAct %></td>
                                        <td><%: item.desAct %></td>
                                        <td><%: item.descripcionEntregable %></td>
			                            <td><%: item.duracion %> días</td>
			                            <td><%: item.feciniAct %></td>	
			                            <td><%: item.fecfinAct %></td>
			                            <td><%: item.estado %></td>
                                        <td style="text-align: center;">
                                            <%: Html.ActionLink("Asignar", "DetalleAsignarRecursos", "Planificacion", new { codAct = item.codAct, txtCodigo = ViewData["codProyIns"] }, null)%>
                                        </td>
    		                          </tr>
                                      <% } %>
                                  <% } %>
                                </tbody>
                            </table>
                            <br/><br/>

                             <% 
                                 if (Model.ListadoActividad != null && Model.ListadoActividad.Count > 0) 
                                 { 
                             %>

                             <input type="hidden" name="idProyecto" value="<%: ViewData["idProyecto"] %>" />

                            <center><input type="submit" name="submitButton" value='Exportar a Excel' class="button" /></center> 
                             
                            <% } %>   
                                                    
                        </div>
                    </div>
                    <br />                    
                </div>
            </div>
            <% } %>
        </div>
        <script type='text/javascript'>

            var codProy = document.all.codProyIns.value;
            if (codProy != 0) {
                var sel = document.getElementById("selProy");
                for (var i = 0; i < sel.length; i++) {
                    if (sel.options[i].value == codProy) {
                        sel.options[i].selected = true;
                    }
                }
            }

        </script>
    </div>
</asp:Content>
