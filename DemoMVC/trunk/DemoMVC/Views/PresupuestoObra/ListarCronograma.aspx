<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<GYM.SIC.GPC.Models.CronogramaModel>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ListarCronograma</title>
</head>
<body>
    <div>
        <h3 class="gpc-subtitulo">Datos del Cronograma</h3>
    </div>
    <div class="gpc-separador"></div>
    <div>
        Nombre:
        <%= Model.Nombre %>
    </div>
    <div>
        Fecha:
        <%= Model.Fecha %>
    </div>
    <div>
        Responsable:
        <%= Model.Responsable%>
    </div>
    <div class="gpc-separador"></div>
    <div>
        <div class="gpc-tabla" style="width: 929px">
            <div class="gpc-tr">
                <div class="gpc-th" style="width: 80px;">Fecha</div>
                <div class="gpc-th" style="width:200px;">Hito</div>
                <div class="gpc-th" style="width:345px;">Nombre</div>
                <div class="gpc-th" style="width:300px;">Responsable</div>
            </div>
            <% foreach (var actividad in Model.ActividadesModel)
            { %>
            <div class="gpc-tr">
                <div class="gpc-td-center" style="width: 80px;">
                    <%= actividad.Fecha%>
                </div>
                <div class="gpc-td" style="width: 200px;">
                    <%= actividad.Hito%>
                </div>
                <div class="gpc-td" style="width: 345px;">
                    <%= actividad.Nombre%>
                </div>
                <div class="gpc-td" style="width: 300px;">
                    <%= actividad.Responsable%>
                </div>
            </div>  
            <%} %>
        </div>
    </div>
</body>
</html>
