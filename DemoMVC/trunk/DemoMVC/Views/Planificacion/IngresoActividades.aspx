<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	IngresoActividades
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Planificación de Proyectos > Nuevo Plan de Proyecto (Actividades)</h2>
    <p>
        Cree un nuevo Cronograma para el Plan de Proyecto en base a Actividades - PROYXXXXXXXX01:
    </p>
    <% using (Html.BeginForm()) { %>
            <fieldset>
                <div class="editor-label">
		    <table border="0">
			<tr>
			   <td border="0" width="200px" >Fecha Inicio Proyecto:</td><td border=0>01/06/2013</td>
			</tr>
			<tr>
			   <td border="0" width="200px" >Fecha Fin Proyecto:</td><td border=0>01/06/2014</td>
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
			    <th>Modificar</th>
			    <th>Eliminar</th>
			    <th>ID</th>
			    <th>Entregable</th>
			    <th>Actividad</th>
			    <th>Duración</th>
			    <th>Comienzo</th>
			    <th>Fin</th>
			    <th>Predecesores</th>	
    			  </tr>
			  <tr>
			    <td align="center"><input type="checkbox"></td>
			    <td align="center"><a href="">Eliminar</a></td>
			    <td>1</td>
			    <td>Gestión de Proyecto</td>
			    <td>Actividad 1.1</td>
			    <td>2 días</td>
			    <td>dd/mm/aaaa</td>
			    <td>dd/mm/aaaa</td>
			    <td>&nbsp;</td>
    			  </tr>
			  <tr>
			    <td align="center"><input type="checkbox"></td>
			    <td align="center"><a href="">Eliminar</a></td>
			    <td>2</td>
			    <td>Gestión de Proyecto</td>
			    <td>Actividad 1.2</td>
			    <td>2 días</td>
			    <td>dd/mm/aaaa</td>
			    <td>dd/mm/aaaa</td>
			    <td>1</td>
    			  </tr>
			  <tr>
			    <td align="center"><input type="checkbox"></td>
			    <td align="center"><a href="">Eliminar</a></td>
			    <td>3</td>
			    <td>Gestión de Proyecto</td>
			    <td>Actividad 1.3</td>
			    <td>3 días</td>
			    <td>dd/mm/aaaa</td>
			    <td>dd/mm/aaaa</td>
			    <td>2</td>
    			  </tr>
			  <tr>
			    <td align="center"><input type="checkbox"></td>
			    <td align="center"><a href="">Eliminar</a></td>
			    <td>4</td>
			    <td>Gestión de Proyecto</td>
			    <td>Actividad 1.4</td>
			    <td>4 días</td>
			    <td>dd/mm/aaaa</td>
			    <td>dd/mm/aaaa</td>
			    <td>3</td>
    			  </tr>
			  <tr>
			    <td align="center"><input type="checkbox" checked></td>
			    <td align="center"><a href="">Eliminar</a></td>
			    <td>4</td>
			    <td>
                    <select name='entregable'>
                        <option>Entregable 01</option>
                        <option>Entregable 02</option>
                        <option>Entregable 03</option>
                    </select>
                </td>
			    <td><input type=text value="Actividad 1.5" /></td>
			    <td><input value="n días" disabled size="10" /></td>
			    <td><input value="dd/mm/aaaa" size="10"  /></td>
			    <td><input value="dd/mm/aaaa"  size="10" /></td>
			    <td><input type=text size="20" value="4" /></td>
    		  </tr>
           </table>
	</div>
    <br>
            </fieldset>
            <center><b><%: ViewData["Message"] %></b></center>
    <br>
    <input type="submit" value="Adicionar Actividad" />&nbsp;&nbsp;
    <input type="submit" value="Guardar Cambios" />&nbsp;&nbsp;
    <input type="submit" value="Crear Plan" />&nbsp;&nbsp;
    <input type="submit" value="Exportar a Excel" />&nbsp;&nbsp;
    <% } %>	    

</asp:Content>
