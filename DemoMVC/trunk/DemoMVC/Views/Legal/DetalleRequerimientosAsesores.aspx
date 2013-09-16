<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<DemoMVC.Models.LegalRequerimiento>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	DetalleRequerimientosAsesores
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<form id="form1" runat="server">
    <section id="seccionReqLegal">
    <h1>Listado de Requerimientos</h1>
    <br />
    <% using (Html.BeginForm())
       { %>

    <div id="editor-field">
    <table id="Tabla1">
        <tr>
            <th>N de Requerimiento</th>
            <th>Tipo de requerimiento</th>
            <th>Fecha de asignación</th>
            <th>Proyecto</th>
            <th>Estado</th>
        </tr>
        <%
            if (Model != null)
            {
                foreach (var item in Model)
                {%>
                 <tr>
                    <td><%: item.idReqLegal%></td>
                    <td><%: item.cDescripcionReqLegalTipo%></td>
                    <td><%: string.Format("{0:yyyy-MM-dd}", item.cFechaAsignacion)%></td>
                    <td><%: item.nomProyecto%></td>
                    <td><%: item.cDescripcionReqLegalEstado%></td>
                    </tr>          
           
           <% } %>
    <% } %>
    </table>
     </div>
    <% } %>
    </section>
    </form>
</asp:Content>
