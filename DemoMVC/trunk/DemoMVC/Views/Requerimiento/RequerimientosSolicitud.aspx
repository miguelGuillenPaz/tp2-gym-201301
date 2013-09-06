<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<GYM.SIG.Entity.DetalleRequerimiento>>" %>

    <% foreach (var item in Model) { %>
    <tr>
        <td>
            <input type="checkbox" name="checkRequerimiento" class="check" />
            <input type="hidden" name="codcorDetReq" value="<%: item.codcorDetReq %>" />
            <input type="hidden" name="codPro" value="<%: item.codPro %>" />

            <input type="hidden" name="codSolCotizacion" value="<%: item.codSolCotizacion %>" />
            <input type="hidden" name="codSolDet" value="<%: item.codSolDet %>" />
        </td>
        <td class="numero">
            <%: item.numero %>
        </td>
        <td class="nomPro">
            <%: item.nomPro %>
        </td>
        <td class="codReq">
            <%: item.codReq %>
        </td>
        <td class="desReq">
            <%: item.desReq %>
        </td>
        <td class="desServicio">
            <%: item.desServicio %>
        </td>
        <td class="descUM">
            <%: item.descUM %>
        </td>
        <td class="canDetReq">
            <%: item.canDetReq %>
        </td>        
    </tr>
    <% } %>