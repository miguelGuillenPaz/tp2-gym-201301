<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<List<GYM.SIC.GPC.Models.DetallePartidaModel>>" %>

    <div class="gpc-separador">
    </div>

    <div>
        <strong class="gpc-subtitulo">Categoria:</strong>
        <strong id="nomcategoria"></strong> 
    </div>

    <div class="gpc-separador">
    </div>

    <div class="gpc-detallePartida-header">
        <div class="gpc-detallePartida-nombre-header">Recurso</div>  
        <div class="gpc-detallePartida-um-header">Unidad de Medida</div>  
        <div class="gpc-detallePartida-cantidad-header">Cantidad</div>  
        <div class="gpc-detallePartida-precio-header">Precio Unitario</div>            
    </div>

    <% foreach (var detallePartida in Model)
    { %>
        
    <div class="gpc-detallePartida">
        <div class="gpc-detallePartida-nombre"><%= detallePartida.Nombre%></div>  
        <div class="gpc-detallePartida-um"><%= detallePartida.UM%></div>  
        <div class="gpc-detallePartida-cantidad"><%= detallePartida.Cantidad%></div>  
        <div class="gpc-detallePartida-precio"><%= detallePartida.Precio%></div>            
    </div>
            
    <%} %>