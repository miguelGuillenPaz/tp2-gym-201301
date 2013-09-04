<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<List<GYM.SIC.GPC.Models.PresupuestoModel>>" %>

<div class="gpc-tabla" style="width: 932px">
    <div class="gpc-tr">
        <div class="gpc-th" style="width: 100px;">
            Num. Presupuesto</div>
        <div class="gpc-th" style="width: 200px;">
            Nombre del Proyecto</div>
        <div class="gpc-th" style="width: 150px;">
            Cliente</div>
        <div class="gpc-th" style="width: 200px;">
            Dirección de la Obra</div>
        <div class="gpc-th" style="width: 80px;">
            Fecha Estado</div>
        <div class="gpc-th" style="width: 130px;">
            Usuario Estado</div>
        <div class="gpc-th" style="width: 65px;">
            Evaluar</div>
    </div>
    <% foreach (var presupuesto in Model)
       { %>
    <div class="gpc-tr">
        <div class="gpc-td" style="width: 100px;">
            <%=presupuesto.Numero %>
        </div>
        <div class="gpc-td" style="width: 200px;">
            <%=presupuesto.Nombre %>
        </div>
        <div class="gpc-td" style="width: 150px;">
            <%=presupuesto.RazonSocial %>
        </div>
        <div class="gpc-td" style="width: 200px;">
            <%=presupuesto.Direccion %>
        </div>
        <div class="gpc-td-center" style="width: 80px;">
            <%=presupuesto.FechaCambioEstado != null? presupuesto.FechaCambioEstado.ToString().Substring(1, 10) : null%>
        </div>
        <div class="gpc-td-center" style="width: 130px;">
            <%=presupuesto.UsuarioCambioEstado%>
        </div>
        <div class="gpc-td-center" style="width: 65px;">
            <a href="ListarDetalle?PresupuestoID=<%=presupuesto.IDPresupuestoObra%>">Evaluar</a>
        </div>
    </div>
    <% }%>
</div>
