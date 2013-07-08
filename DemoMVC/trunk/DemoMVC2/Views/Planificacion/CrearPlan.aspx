<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="PlanTitle" ContentPlaceHolderID="TitleContent" runat="server">
	CrearPlan
</asp:Content>

<asp:Content ID="PlanContent" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Planificación de Proyectos > Crear Plan de Proyecto</h2>
    <p>
        Cree un nuevo Plan de Proyecto - <b>PROYXXXXXXXX01</b>:
    </p>

    <% using (Html.BeginForm()) { %>
        <div>
            <fieldset>
		    <hr>
            <div class="editor-label">
		    <h3>Detalle del Proyecto:</h3>
		    <table border="0">
			<tr>
			   <td border="0" width="200px" >Nombre de Proyecto:</td><td border=0>Proyecto "Casa de Playa del Gerente"</td>
			</tr>
			<tr>
			   <td border="0" width="200px" >Presupuesto:</td><td border=0>S/. 7'755,000.000</td>
			</tr>
			<tr>
			   <td border="0" width="200px" >Fecha Inicio Proyecto:</td><td border=0>01/06/2013</td>
			</tr>
			<tr>
			   <td border="0" width="200px" >Fecha Fin Proyecto:</td><td border=0>01/06/2014</td>
			</tr>
			<tr>
			   <td border="0" width="200px" >Descripción:</td><td border=0>La casa de playa del gerente en Asia</td>
			</tr>
			<tr>
			   <td border="0" width="200px" >Tipo de Proyecto:</td><td border=0>Casa</td>
			</tr>
			<tr>
			   <td border="0" width="200px" >Prioridad:</td><td border=0>Intermedia</td>
			</tr>
			<tr>
			   <td border="0" width="200px" >Ubicación:</td><td border=0>Asia, Lima, Lima</td>
			</tr>
		     </table>
                </div>
		<br><hr><br>
		<h3>Detalle asignación de presupuesto:</h3>
                <div class="editor-field">
			<table id='Tabla1' >
			  <tr>
			    <th>Tipo</th>
			    <th>Presupuesto</th>
			    <th>Porcentaje</th>
    			  </tr>
			  <tr>
			    <td>Equipos</td>
			    <td>S/. 150,000.00</td>
			    <td>20%</td>
    			  </tr>
			  <tr>
			    <td>Materiales</td>
			    <td>S/. 75,000.00</td>
			    <td>10%</td>
    			  </tr>
			  <tr>
			    <td>Artículos</td>
			    <td>S/. 150,000.00</td>
			    <td>15%</td>
    			  </tr>
			  <tr>
			    <td>Personal</td>
			    <td>S/. 225,000.00</td>
			    <td>20%</td>
    			  </tr>
			  <tr>
			    <td>Gastos Administrativos</td>
			    <td>S/. 225,000.00</td>
			    <td>15%</td>
    			  </tr>
			  <tr>
			    <td>Otros Gastos</td>
			    <td>S/. 225,000.00</td>
			    <td>10%</td>
    			  </tr>
			  <tr>
			    <td>Contingencia</td>
			    <td>S/. 750,000.00</td>
			    <td>10%</td>
    			  </tr>
			</table>
		</div>
            <br>
            <input type="submit" value="Importar Plan Existente" />&nbsp;&nbsp;
            <input type="submit" value="Generar Nuevo Plan" />
            </fieldset>
        </div>
    <% } %>

</asp:Content>
