<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<DemoMVC.Models.AsignarRecursoForm>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	DetalleAsignarRecursos
</asp:Content>

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
            <h1>
                Asignar Recursos 
            </h1>
            <% using (Html.BeginForm()) { %>
             <div class="areas-negocios">
                <div class="buscar-proyecto">
                  <input type='hidden' id='codProyIns' name='codProyIns' value='<%: ViewData["codProyIns"] %>'></input>

                  <input type='hidden' id='codAct' name='codAct' value='<%: ViewData["codAct"] %>'></input>


                  <table width="800" border="0" cellspacing="2" cellpadding="2">
                     <% 
                     if (Model.ListadoActividad != null) { 
                     foreach (DemoMVC.Models.Actividad item in Model.ListadoActividad) { %>
			          <tr>
			                <td colspan="2">Actividad <%: item.corAct%> - <%: item.desAct%></td>
                            <td width="19">&nbsp;</td>
                            <td width="46">Fecha Inicio</td>
                            <td width="144"><input id='fecha_inicio' name="fecha_inicio" type="text" value='<%: item.feciniAct %>' disabled /></td>
                            <td width="23">&nbsp;</td>
                            <td width="72">Cantidad</td>
                            <td width="144"><input name="cantidad" type="text" required /></td>
                            <td width="18">&nbsp;</td>
                            <td width="44">Unidad</td>
                            <td width="71">
                                <select id='sel_tipUnidad' name='sel_tipUnidad' disabled>
                                    <option value='1' selected>Horas</option>
                                    <option value='2'>Toneladas</option>
                                </select>
                             </td>
    		            </tr>
                      <tr>
                        <td width="50">Tipo Recurso</td>
                        <td width="101">
                            <select id='selTipRec' name='selTipRec' onchange='javascript:cambiarTipoRecurso();'>
                                <option value='3'>Empleados</option>
                                <option value='2'>Materiales</option>
                                <option value='1'>Maquinarias</option>
                            </select>
                        </td>
                        <td>&nbsp;</td>
                        <td>Fecha Fin</td>
                        <td><input name="fecha_fin" type="text" id="fecha_fin" value='<%: item.fecfinAct %>' disabled /></td>
                        <td>&nbsp;</td>
                        <td>Descripción</td>
                        <td id='tbl_recurso'>
                            <select id='selRecCargo' name='selRecCargo'>
                               <% if (Model.ListadoCargo != null) {
                                      foreach (DemoMVC.Models.Recurso item2 in Model.ListadoEmpleados)
                                      { %>
                                        <option value='<%= item2.IdRecurso %>'><%= item2.Descripcion%></option>
                               <% }%>
                            <% }%>
                            </select>
                            <select id='selRecEquipo' name='selRecEquipo' disabled>
                               <% if (Model.ListadoEquipos != null) {
                                      foreach (DemoMVC.Models.Recurso item3 in Model.ListadoEquipos)  { %>
                                        <option value='<%= item3.IdRecurso %>'><%= item3.Descripcion %></option>
                               <% }%>
                            <% }%>
                            </select> 
                            <select id='selRecMaterial' name='selRecMaterial' disabled>
                               <% if (Model.ListadoMateriales != null) {
                                      foreach (DemoMVC.Models.Recurso item4 in Model.ListadoMateriales)  { %>
                                        <option value='<%= item4.IdRecurso %>'><%= item4.Descripcion %></option>
                               <% }%>
                            <% }%>
                            </select>                                                                                                                                   
                        </td>
                        <td>&nbsp;</td>
                        <td colspan="2"><input type="submit" name="submitButton" value="Agregar"/></td>
                      </tr>
                         <% } %>
                      <% } %>
                  </table>
                  <p>&nbsp;</p>
                </div>
            <div class="areas-negocios">
                <div class="lista-central">
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Listado de Actividades</span>
                        </div>
                        <div class="texto-noticia">
                            <table width="800" id="tblConvocatoria">
                                <thead>
                                    <tr>                                        
                                        <th width="93">
                                            <b>Actividad</b>
                                        </th>
                                        <th width="124">
                                            <b>Tipo Recurso</b>
                                        </th>
                                        <th width="113">
                                            <b>Descripción</b>
                                        </th>
                                        <th width="80"><b>Cantidad</b></th>                                       
                                        <th width="180" style="width: 180px; text-align: center;">
                                            <b>Opción</b>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                  <% 
                                      if (Model.ListadoRecursoActividad != null) { 
                                      foreach (DemoMVC.Models.PlanRecursosActividad item6 in Model.ListadoRecursoActividad) { %>
			                          <tr>			                            
			                            <td><%: item6.IdActividad %> - <%: item6.Descripcion %></td>
                                        <td><%: item6.tipoRecurso %></td>
                                        <td><%: item6.DescRec %></td>
			                            <td><%: item6.Cantidad %></td>
			                            <td style="text-align: center;">                                            
                                            <%: Html.ActionLink("Eliminar", "EliminarPlanRecurso", new { idActividad = item6.IdActividad, idProyecto = ViewData["codProyIns"], idRecurso = item6.IdRecurso }, null)%>
                                        </td>
    		                          </tr>
                                      <% } %>
                                  <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <center>
                    
                    <!--                    
                    Html.ActionLink("Grabar", "GrabarPlanRecursoActividad", new { idActividad = ViewData["codAct"], idProyecto = ViewData["codProyIns"] }, new { @class = "button" })%>
                    -->

                    
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <center><%= Html.ActionLink("Regresar", "AsignarRecursos", "Planificacion")%>&nbsp;&nbsp;<input type="submit" name="submitButton" value="Grabar" /></center>
                </div>
            </div>
        </div>
        <% } %>
        <script type='text/javascript'>

            function cambiarTipoRecurso() {

                if (document.all.selTipRec.value == 3){
                    document.all.selRecCargo.disabled = false;
                    document.all.selRecEquipo.disabled = true;
                    document.all.selRecMaterial.disabled = true;
                    document.all.sel_tipUnidad.options[0].selected = true;
                }
                if (document.all.selTipRec.value == 2) {
                    document.all.selRecCargo.disabled = true;
                    document.all.selRecEquipo.disabled = true;
                    document.all.selRecMaterial.disabled = false;
                    document.all.sel_tipUnidad.options[1].selected = true;
                }
                if (document.all.selTipRec.value == 1) {
                    document.all.selRecCargo.disabled = true;
                    document.all.selRecEquipo.disabled = false;
                    document.all.selRecMaterial.disabled = true;
                    document.all.sel_tipUnidad.options[0].selected = true;
                }

            }

        </script>
    </div>
</asp:Content>
