<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<List<GYM.SIC.GPC.Models.CategoriaModel>>" %>

    <div class="gpc-separador">
    </div>
    
    <div>
        <strong class="gpc-subtitulo">Partida:</strong>
        <strong id="nompartida"></strong> 
        <strong id="partida" style="display:none;"></strong>
    </div>
    
    <div class="gpc-separador">
    </div>

    <div class="gpc-Categoria-header">
        <div class="gpc-Categoria-nombre-header">Descripción</div>  
        <div class="gpc-Categoria-detalle-header">Detalle</div>       
    </div>

    <% foreach (var categoria in Model)
    { %>
        
    <div class="gpc-Categoria">
        <div class="gpc-Categoria-nombre"><%= categoria.Nombre %></div>  
        <div class="gpc-Categoria-detalle"><a class="gpc-link" onclick="listarItems(<%=categoria.ID%>,'<%= categoria.Nombre %>');">Ver Items</a></div>        
    </div>
            
    <%} %>
