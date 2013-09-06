<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<DemoMVC.Models.Actividad>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	IngresoActividades
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Planificación de Proyectos > Nuevo Plan de Proyecto (Actividades)</h2>
    <p>
        Cree un nuevo Cronograma para el Plan de Proyecto en base a Actividades - PROY<%: ViewData["codProy"]%>:
    </p>
    <% using (Html.BeginForm()) { %>
    <input type="hidden" id="txtCodPro" name="txtCodPro" value="<%: ViewData["codProy"]%>" />
    <input type="hidden" id="txtCodPlaPro" name="txtCodPlaPro" value="<%: ViewData["codPlanProy"]%>" />
    <input type="hidden" id="txtFecIniPro" name="txtFecIniPro" value="<%: ViewData["fechIniProy"]%>" />
    <input type="hidden" id="txtFecFinPro" name="txtFecFinPro" value="<%: ViewData["fechIniFin"]%>" />
    <input type="hidden" id="txtAccion" name="txtAccion" value="<%: ViewData["accion"]%>" />
    <input type="hidden" id="txtTotReg" name="txtTotReg" value="<%: ViewData["totReg"]%>" />
            <fieldset>
                <div class="editor-label">
		    <table border="0">
			<tr>
			   <td border="0" width="200px" >Fecha Inicio Proyecto:</td><td border=0><%: ViewData["fechIniProy"]%></td>
			</tr>
			<tr>
			   <td border="0" width="200px" >Fecha Fin Proyecto:</td><td border=0><%: ViewData["fechIniFin"]%></td>
			</tr>
			<tr>
			   <td border="0" width="200px" >Duración Proyectada Proyecto:</td><td border=0>6 meses</td>
			</tr>
			<tr>
			   <td border="0" width="200px" >Duración Calculada:</td><td border=0>18 días</td>
			</tr>
		     </table>
                </div>
		<br>
		<h3>Asignar Actividades:</h3>
                <div class="editor-field">
			<table id='Tabla1' >
			  <tr>
                <th>Eliminar</th>
			    <th>ID</th>
			    <th>Entregable</th>
			    <th>Actividad</th>
			    <th>Comienzo</th>
			    <th>Fin</th>
			    <th>Predecesores</th>	
    		  </tr>
              <% 
                  if (Model != null) { 
                  foreach (var item in Model) { %>
			      <tr>
                    <td><input type="checkbox" id='chk_eli<%: item.corAct %>' name='chk_eli<%: item.corAct %>' /></td>
			        <td><%: item.corAct %></td>
			        <td><input type="hidden" name='txt_Ent<%: item.corAct %>' id='txt_Ent<%: item.corAct %>' value='<%: item.codEnt %>' />
                    <select name='sel_Ent<%: item.corAct %>' id='sel_Ent<%: item.corAct %>'>
                        <option value='1' <%: ViewData["entSel1"]%>>Entregable 01</option>
                        <option value='2' <%: ViewData["entSel2"]%>>Entregable 02</option>
                        <option value='3' <%: ViewData["entSel3"]%>>Entregable 03</option>
                    </select>                    
                    </td>
			        <td><input type="text" name="txt_nomAct_<%: item.corAct %>" id="txt_nomAct_<%: item.corAct %>" value="<%: item.desAct %>" /></td>
                    <td><input id="txt_fecIni<%: item.corAct %>" name="txt_fecIni<%: item.corAct %>" value='<%: item.feciniAct %>'  size='10' /></td>
                    <td><input id="txt_fecFin<%: item.corAct %>" name="txt_fecFin<%: item.corAct %>" value='<%: item.fecfinAct %>' size='10' /></td>
                    <td><input type="text" id="txt_Pred<%: item.corAct %>" name="txt_Pred<%: item.corAct %>"  value='<%: item.preAct %>' size='10' /></td>
    		      </tr>
                  <% } %>
              <% } %>
           </table>
	</div>
    <br>
            </fieldset>
            <center><b><%: ViewData["Message"] %></b></center>
    <br>
    <input type="button" value="Adicionar Actividad" onclick="javascript:fAccion(1)" />&nbsp;&nbsp;
    <input type="button" value="Guardar Cambios" onclick="javascript:fAccion(2)" />&nbsp;&nbsp;
    <input type="button" value="Crear Plan" onclick="javascript:fAccion(4)" />&nbsp;&nbsp;
    <input type="button" value="Exportar a Excel" />&nbsp;&nbsp;
    <% } %>	    
    <script type='text/javascript'>

        function fAccion(nroAccion) {
            if (nroAccion == 1) {
                insertaActividad();
            }
            if (nroAccion == 2) { 
                if (document.getElementById('txtTotReg').value == '0') {
                    alert("Por favor, ingrese al menos una actividad para ser guardada");
                }
                else{
                    document.getElementById("txtAccion").value = nroAccion;
                    document.forms[0].submit();
                }            
            }
            if (nroAccion == 4) { 
               if (document.getElementById('txtTotReg').value == '0') {
                    alert("Por favor, ingrese al menos una actividad para que el plan sea creado");
                }
                else {
                    document.getElementById("txtAccion").value = nroAccion;
                    document.forms[0].submit();
                }                           
            }
            if (nroAccion == 5) {
                if (nroAccion == 5 && document.getElementById('txtTotReg').value == '0') {
                    alert("En estos momentos no se puede exportar a Excel pues no hay actividades a ingresar al archivo");
                }
                else {
                    alert("Coming soon");
                    //document.getElementById("txtAccion").value = nroAccion;
                    //document.forms[0].submit();                
                }
            }
            
        };

        //Funcion que permite validar que se inserten nuevos valores a la tabla
        function insertaActividad() {
            var table = document.getElementById("Tabla1");
            var totReg = 0;
            totReg = document.getElementById('txtTotReg').value;
            var totRegID = parseInt(totReg) + 1;
            var row;
            if (totReg == 0) {
                row = table.insertRow(1);
            }
            else {
                row = table.insertRow(totRegID);
            }            
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);
            var cell7 = row.insertCell(6);

            totReg = parseInt(totReg) + 1;
            cell1.innerHTML = "<input type='checkbox' id='chk_eli" + totReg + "' name='chk_eli" + totReg + "' />";
            cell2.innerHTML = "" + totRegID;
            cell3.innerHTML = "<select name='sel_Ent" + totReg + "' id='sel_Ent" + totReg + "'><option value='1'>Entregable 01</option><option value='2'>Entregable 02</option><option value='3'>Entregable 03</option></select>";
            cell4.innerHTML = "<input type='text' name='txt_nomAct_" + totReg + "' id='txt_nomAct_" + totReg + "' />";
            cell5.innerHTML = "<input type='text' id='txt_fecIni" + totReg + "' name='txt_fecIni" + totReg + "' size='10' value='dd/mm/aaaa' />";
            cell6.innerHTML = "<input type='text' id='txt_fecFin" + totReg + "' name='txt_fecFin" + totReg + "' size='10' value='dd/mm/aaaa' />";
            cell7.innerHTML = "<input type='text' id='txt_Pred" + totReg + "' name='txt_Pred" + totReg + "' size='10' value=' ' />";
            document.getElementById("txtTotReg").value = totReg;
        };

    </script>
</asp:Content>
