<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<List<GYM.SIC.GPC.Models.PartidasModel>>" %>

<div>
    <h3 class="gpc-subtitulo">
        Items del Presupuesto</h3>
</div>
<div>
    <% foreach (var partida in Model)
    { %>
    <div class="gpc-separador">
    </div>
    <div class="gpc-partida">
        <%=partida.Nombre %>
    </div>
    <div>
        <% foreach (var categoria in partida.CategoriasModel)
        { %>
        <div class="gpc-categoria">
            <%= categoria.Nombre %>
        </div>
        <div class="gpc-tabla">
            <div class="gpc-tr">
                <div class="gpc-th" style="width: 425px;">
                    Recurso</div>
                <div class="gpc-th" style="width: 100px;">
                    Unidad de Medida</div>
                <div class="gpc-th" style="width: 200px;">
                    Cantidad</div>
                <div class="gpc-th" style="width: 200px;">
                    Precio Unitario</div>
            </div>
            <% foreach (var detallePartida in categoria.DetallePartidasModel)
                { %>
            <div class="gpc-tr">
                <div class="gpc-td" style="width: 425px;">
                    <%=detallePartida.Nombre%>
                </div>
                <div class="gpc-td" style="width: 100px;">
                    <%=detallePartida.UM%>
                </div>
                <div class="gpc-td" style="width: 200px;">
                    <%=detallePartida.Cantidad%>
                </div>
                <div class="gpc-td" style="width: 200px;">
                    <%=detallePartida.PrecioUnitarioReal%>
                </div>
            </div>
            <%}%>
        </div>
        <%}%>
    </div>
    <%}%>
</div>
