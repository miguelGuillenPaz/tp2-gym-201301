<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Entidad.Proveedor>>" %>

<% foreach (var item in Model) { %>
<tr>
    <td>
        <input type="checkbox" name="check" class="check" />
        <input type="hidden" name="codProv" value="<%: item.codProv %>" />
    </td>
    <td>
        <%: item.numero %>
    </td>
    <td>
        <%: item.razsocPro %>
    </td>
    <td>
        <%: item.rucPro %>
    </td>
    <td>
        <%: item.emailProTServ %>
    </td>
    <td>
        <%: item.contactoProTServ %>
    </td>
</tr>
<% } %>