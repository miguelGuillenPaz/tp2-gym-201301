<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="TituloPlan" ContentPlaceHolderID="TitleContent" runat="server">
	ListadoProyPlan
</asp:Content>

<asp:Content ID="ContentPlan" ContentPlaceHolderID="MainContent" runat="server">

        <h2>Planificación de Proyectos > Listado de Proyectos Pre Aprobados</h2>
    <p>
        Por favor, seleccione un proyecto pre aprobado para la planificación del mismo:
    </p>
    <% using (Html.BeginForm()) { %>
            <fieldset>
		<hr>
                <div class="editor-label">
                    <label for="UserName">Código del Proyecto:</label>&nbsp;&nbsp;<input id="UserName" name="UserName" type="text" value="" />
		    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	            <input type="submit" value="Buscar" />
                </div>
		<hr><br><br>
		Resultados de la búsqueda: 5
                <div class="editor-field">
			<table id='Tabla1' >
			  <tr>
			    <th>Código Proyecto</th>
			    <th>Nombre Proyecto</th>
			    <th>tipo Proyecto</th>
			    <th>Fecha de Inicio</th>
			    <th>Fecha de Fin</th>
		            <th>Presupuesto</th>
			    <th>Crear Plan</th>				
    			  </tr>
			  <tr>
			    <td align="center">PROYXXXXXXX1</td>
			    <td>Proyecto 01</td>
			    <td>Oficina</td>
			    <td>01/06/2013</td>	
			    <td>05/06/2014</td>
			    <td>S/. 7'500,000.00</td>
			    <td align="center"><%: Html.ActionLink("Crear", "CrearPlan", "Planificacion")%></td>
    			  </tr>
			  <tr>
			    <td align="center">PROYXXXXXXX2</td><td>Proyecto 02</td>
			    <td>Oficina</td>
			    <td>01/06/2013</td>	
			    <td>05/06/2014</td>
			    <td>S/. 7'500,000.00</td>
			    <td align="center"><%: Html.ActionLink("Crear", "CrearPlan", "Planificacion")%></td>
    			  </tr>
			  <tr>
			    <td align="center">PROYXXXXXXX3</td><td>Proyecto 03</td>
			    <td>Oficina</td>
			    <td>01/06/2013</td>	
			    <td>05/06/2014</td>
			    <td>S/. 7'500,000.00</td>
			    <td align="center"><%: Html.ActionLink("Crear", "CrearPlan", "Planificacion")%></td>
    			  </tr>
			  <tr>
			    <td align="center">PROYXXXXXXX4</td><td>Proyecto 04</td>
			    <td>Oficina</td>
			    <td>01/06/2013</td>	
			    <td>05/06/2014</td>
			    <td>S/. 7'500,000.00</td>
			    <td align="center"><%: Html.ActionLink("Crear", "CrearPlan", "Planificacion")%></td>
    			  </tr>
			  <tr>
			    <td align="center">PROYXXXXXXX5</td><td>Proyecto 05</td>
			    <td>Oficina</td>
			    <td>01/06/2013</td>	
			    <td>05/06/2014</td>
			    <td>S/. 7'500,000.00</td>
			    <td align="center"><%: Html.ActionLink("Crear", "CrearPlan", "Planificacion")%></td>
    			  </tr>
			</table>
		</div>

            </fieldset>
    <% } %>	    

</asp:Content>
