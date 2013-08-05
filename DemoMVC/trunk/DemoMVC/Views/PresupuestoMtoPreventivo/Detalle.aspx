<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<DemoMVC.Models.PMP_PptoMtoPreventivo>>" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            try {
                var textoNoticia = $('.head-noticia').next();
                if (textoNoticia.hasClass('texto-noticia')) {
                    if (textoNoticia.css('display') == 'none') {
                        textoNoticia.slideDown();
                    }
                    else {
                        textoNoticia.slideUp();
                    }
                }
            } catch (ex) {
            }
        });
    </script>
    <script src="../../Scripts/Presupuesto/presupuesto.js" type="text/javascript"></script>
    <div class="contenido-top">
        <div>
            <h1>
                Presupuesto de Mantenimiento Preventivo</h1>

            <% using (Html.BeginForm())
               { %>
            <hr>
            <div class="editor-label">
                <table>
                    <tr>
                        <td>
                            <label for="Ano">
                                Año:</label>
                        </td>
                        <td>
                            <input id="txtAno" name="txtAno" type="text" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="Descripcion">
                                Descripción:</label>
                        </td>
                        <td>
                            <input id="txtDescripcion" name="txtDescripcion" type="text" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="Estado">
                                Estado:</label>
                        </td>
                        <td>
                            <select id="ddlEstado" name="ddlEstado">
                                <option>TODOS</option>
                                <option>CREADO</option>
                                <option>PENDIENTE DE APROBACIÓN</option>
                                <option>APROBADO</option>
                                <option>RECHAZADO</option>
                            </select>
                        </td>
                    </tr>
                </table>
                <input type="submit" value="Consultar" />
                <P>
                Filtros [Año: <%=ViewData["ano"]  %>  Descripción: <%=ViewData["descripcion"]%> Estado: <%=ViewData["estado"] %>]<br />
                Nro. de Registros: <%=ViewData["nregistros"] %>
                </P>
            </div>
            <hr>
            <% } %>
            <table id="tblListadoPresupuesto">
                <thead>
                    <tr>
                        <th>
                            <b>Id</b>
                        </th>
                        <th>
                            <b>Año Presupuesto</b>
                        </th>
                        <th>
                            <b>Descripción Presupuesto</b>
                        </th>
                        <th>
                            <b>Costo total fijo</b>
                        </th>
                        <th>
                            <b>Costo total final</b>
                        </th>
                        <th>
                            <b>Cantidad</b>
                        </th>
                        <th>
                            <b>Estado</b>
                        </th>
                        <th>
                            <b>Enviar</b>
                        </th>
                        <th>
                            <b>Editar</b>
                        </th>
                        <th>
                            <b>Eliminar</b>
                        </th>
                        <th>
                            <b>Detalle</b>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <% if (Model != null)
                       {
                           foreach (var pre in Model)
                           {
                    %>
                    <tr>
                        <td>
                            <%=pre.idPptoMtoPreventivo %>
                        </td>
                        <td>
                            <%=pre.ano%>
                        </td>
                        <td>
                            <%=pre.descripcion %>
                        </td>
                        <td>
                            <%=pre.montoEstimado%>
                        </td>
                        <td>
                            <%=pre.montoFinal %>
                        </td>
                        <td>
                            <%=pre.cantidadMantencion %>
                        </td>
                        <td>
                            <%=pre.estado %>
                        </td>
                        <td>
                            <a class="enviar" href="javascript:;">Enviar</a>
                        </td>
                        <td>
                            <a class="editar" href="javascript:;">Editar</a>
                        </td>
                        <td>
                            <a class="eliminar" href="javascript:;">Eliminar</a>
                        </td>
                        <td>
                            <a class="detalle" href="/PresupuestoMtoPreventivo/Detalle/<%=pre.idPptoMtoPreventivo%>>">Detalle</a>
                        </td>
                    </tr>
                    <%}
                       } %>
                </tbody>
            </table>
            <a id="addPresupuesto" href="javascript:;">Crear</a>
        </div>
    </div>
    <div id="dialogPresupuesto" title="" style="display: none; z-index: 1000;">
        <input type="hidden" id="hdnPresupuesto" />
        <input type="hidden" id="hdnAccionPresupuesto" />
        <table>
            <tr>
                <td>
                    Código Presupuesto
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.FirstOrDefault().idPptoMtoPreventivo, new { @id = "txtIdPptoMtoPreventivo", @class = "required" })%>
                </td>
            </tr>
            <tr>
                <td>
                    Año Presupuesto
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.FirstOrDefault().ano, new { @id = "txtAno", @class = "required" })%>
                </td>
            </tr>

            <tr>
                <td>
                    Descripción Presupuesto
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.FirstOrDefault().descripcion, new { @id = "txtDescripcion", @class = "required" })%>
                </td>
            </tr>

             <tr>
                <td>
                    Costo total fijo
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.FirstOrDefault().montoEstimado, new { @id = "txtCostoTotalFijo", @class = "required" })%>
                </td>
            </tr>

             <tr>
                <td>
                    Costo total final
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.FirstOrDefault().montoFinal, new { @id = "txtCostoTotalFinal", @class = "required" })%>
                </td>
            </tr>

             <tr>
                <td>
                    Cantidad
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.FirstOrDefault().cantidadMantencion, new { @id = "txtCantidad", @class = "required" })%>
                </td>
            </tr>

             <tr>
                <td>
                   Estado
                </td>
                <td>
                    :
                </td>
                <td>
                     <%= Html.DropDownListFor(m => m.FirstOrDefault().estado, (IEnumerable<SelectListItem>)ViewData["TipoEstado"], new { @id = "ddlEstado", @class = "required" })%>
                </td>
            </tr>

        </table>
    </div>
</asp:Content>
