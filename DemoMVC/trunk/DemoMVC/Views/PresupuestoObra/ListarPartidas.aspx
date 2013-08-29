<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<List<GYM.SIC.GPC.Models.PartidasModel>>" %>

    <div>
        <h3 class="gpc-subtitulo">
            Partidas del Presupuesto</h3>
    </div>
    
    <div class="gpc-separador">
    </div>

    <div class="gpc-Partida-header">
        <div class="gpc-Partida-nombre-header">Descripción</div>  
        <div class="gpc-Partida-detalle-header">Detalle</div>       
    </div>

    <div>
        <% foreach (var partida in Model)
        { %>

        <div class="gpc-Partida">
            <div class="gpc-Partida-nombre"><%= partida.Nombre%></div>  
            <div class="gpc-Partida-detalle"><a class="gpc-link" onclick="listarCategorias(<%=partida.ID%>,'<%=partida.Nombre %>');">Ver Detalle</a></div>       
        </div>

        <%}%>
    </div>
