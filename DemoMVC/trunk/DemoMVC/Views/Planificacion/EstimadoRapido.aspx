<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<DemoMVC.Models.EstimadoRapidoForm>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	EstimadoRapido
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
    <h2>Planificación de Proyectos > Estimación Rápida</h2>
     <p>
       Por favor, seleccione un tipo de consulta (Planes de Proyecto Histórico) para la estimación: PROY<b><%: ViewData["codProy"]%></b>
    </p>
     <% using (Html.BeginForm()) { %>
       <input type="hidden" id="txtCodProyAct" name="txtCodProyAct" value='<%: ViewData["codProy"]%>' />
       <input type="hidden" id="txtAccion"  name="txtAccion" value='<%: ViewData["accion"]%>' />
            <fieldset>
                <div class="editor-label">
		    <table border="0">
			<tr>
			   <td border="0" width="200px" >Por Duración de Proyecto:</td>
               <td><input id="cantDuracion" name="cantDuracion" size="10" onkeypress="return isNumberKey(event)"></td>
               <td border="0"><input type="radio" name="duracion" id="duracion" checked value="d"> Días</td>
               <td border="0"><input type="radio" name="duracion" id="duracion" value="m"> Meses</td>
               <td border="0"><input type="radio" name="duracion" id="duracion" value="y"> Años</td>
			</tr>
            <tr>
			   <td border="0" width="200px" >Por Tipo de Proyecto:</td>
               <td border="0" colspan="4"><select id='tipo' name='tipo'>
               <option value=''>-- Escoja un tipo de proyecto --</option>
               <% if (Model.ListadoTipoProyecto != null) {
                      foreach (DemoMVC.Models.TipoProyecto item in Model.ListadoTipoProyecto)  { %>
                        <option value='<%= item.codTipPro %>'><%= item.nomTipPro %></option>
               <% }%>
            <% }%>
                    </select></td>
			</tr>
            <tr>
			   <td border="0" width="200px" >Por Prioridad:</td>
               <td border="0" colspan="4">
                    <select id='prioridad' name='prioridad'>
                        <option value=''>-- Escoja prioridad de proyecto --</option>
                        <option value="1">Alta</option>
                        <option value="2">Media</option>
                        <option value="3">Baja</option>
                    </select></td>
			</tr>
            <tr>
			   <td width="200px" >Por Rango de Presupuesto:</td>
               <td colspan="4">
               <select id='presupuesto' name='presupuesto'>
                    <option value=''>-- Escoja presupuesto de proyecto --</option>
                    <option value='1'>Menos de S/. 50,000.00</option> 
                    <option value='2'>S/. 50,001.00 - S/. 100,000.00</option> 
                    <option value='3'>S/. 100,001.00 - S/. 800,000.00</option>
                    <option value='4'>S/. 800,001.00 a más</option>
               </select></td>
			</tr>			
            <tr>
			   <td border="0" width="200px" >Por Ubigeo:</td>
               <td border="0">
               <select name='departamento'>
               <% if (Model.ListadoUbigeoDep != null) {
                      foreach (DemoMVC.Models.Ubigeo item in Model.ListadoUbigeoDep)  { %>
                        <option value='<%= item.codUbiDep %>' <%= item.selected %> ><%= item.nomUbiDep %></option>
                  <% }%>
               <% }%>
               </select></td>
               <td border="0">
               <select name='provincia'>
               <% if (Model.ListadoUbigeoProv != null) {
                      foreach (DemoMVC.Models.Ubigeo item in Model.ListadoUbigeoProv)  { %>
                        <option value='<%= item.codUbiProv %>' <%= item.selected %> ><%= item.nomUbiProv %></option>
                  <% }%>
               <% }%>
               </select></td>
               <td border="0">
               <select name='distrito'>
               <% if (Model.ListadoUbigeoDist != null) {
                      foreach (DemoMVC.Models.Ubigeo item in Model.ListadoUbigeoDist)  { %>
                        <option value='<%= item.codUbiDist %>' <%= item.selected %> ><%= item.nomUbiDist %></option>
                  <% }%>
               <% }%>
               </select></td>
			</tr>
		     </table>
             <br/>
             <center><input type="submit" value="Buscar" /></center>
             <br/>        
             Resultados de la búsqueda: <%: ViewData["totReg"] %>
                <div class="editor-field">
			<table id='Tabla1' >
			  <tr>
			    <th>Código Proyecto</th>
			    <th>Nombre Proyecto</th>
			    <th>tipo Proyecto</th>
                <th>Fecha Inicio</th>
			    <th>Fecha Fin</th>
			    <th>Presupuesto</th>
		        <th>Ver Detalle</th>		
    		  </tr>
              <% 
                  if (Model.ListadoProyectoHist != null) { 
                  foreach (DemoMVC.Models.ProyectoHist item in Model.ListadoProyectoHist) { %>
			      <tr>
			        <td align="center">PROY<%: item.codPro %></td>
			        <td><%: item.nomPro %></td>
			        <td><%: item.tipoProyecto%></td>
			        <td><%: item.feciniplaPro %></td>	
			        <td><%: item.fecfinplaPro %></td>
			        <td><%: item.monfacPro %> <%: item.presupuesto %></td>
			        <td align="center">
                    <%: Html.ActionLink("Crear", "DetallePlanHistorico", "Planificacion", new { codProyAct = ViewData["codProy"], codProyHist = item.codPro }, null)%></td>
    		      </tr>
                  <% } %>
              <% } %>
              </table>
                </div>
                <center><h2><%: ViewData["msgErr"] %></h2></center>
           </fieldset>
      <% } %>	    
      </div>

    <SCRIPT language=Javascript>
        //Funcion que permite validar que solo se ingresen numeros
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        };

    </SCRIPT>

</asp:Content>
