<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<GYM.SIG.Entity.DetalleSolicitudRequerimiento>>" %>

<% foreach (var item in Model) { %>
<tr>
    <td>
        <input type="checkbox" name="checkDetalle" class="check" />
        <input type="hidden" name="codSolCotizacion" class="codSolCotizacion" value="<%: item.codSolCotizacion %>" />
        <input type="hidden" name="codSolDet" class="codSolDet" value="<%: item.codSolDet %>" />
    </td>
    <td class="numero">
        <%: item.numero %>
    </td>
    <td>
        <%: item.nomPro %>
    </td>
    <td>
        <%: item.codReq %>
    </td>
    <td>
        <%: item.codcorDetReq %>
    </td>
    <td>
        <%: item.desServicio %>
    </td>
    <td>
        <%: item.descUM %>
    </td>
    <td class="cantidad" style="text-align:right;">
        <%: String.Format("{0:F}", item.canDetReq) %>
    </td>
    <td class="precio" style="text-align:right;">
        <%: String.Format("{0:F}", item.precio) %>
    </td>
    <td class="importe" style="text-align:right;">
        <%: String.Format("{0:F}", item.importe) %>
    </td>    
</tr>
<% } %>
<tr class="numRegistros">
    <td style="text-align: left; color: rgb(0, 115, 234);" colspan="10">Total Registros: <span><%: Model.Count() %></span></td>
</tr>