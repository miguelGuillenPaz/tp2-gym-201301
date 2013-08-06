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
            <div class="editor-label">
                <table>
                    <tr>
                        <td>
                            <label for="txtAno">
                                Año:</label>
                        </td>
                        <td>
                            <input id="txtAno" name="txtAno" type="text" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="txtDescripcion">
                                Descripción:</label>
                        </td>
                        <td>
                            <input id="txtDescripcion" name="txtDescripcion" type="text" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="ddlEstado">
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
                <p>
                    Filtros [Año:
                    <%=ViewData["ano"]  %>
                    ]</p>
                <p>
                    Descripción: [<%=ViewData["descripcion"]%>
                    Estado:
                    <%=ViewData["estado"] %>]</p>
                <p>
                    Nro. de Registros: [<%=ViewData["nregistros"] %>]
                </p>
            </div>
            <hr>
            <% } %>
            <div class="areas-negocios">
                <div class="lista-central">
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Lista de Presupuestos</span>
                        </div>
                        <table id="tblListadoPresupuesto" class="table100">
                            <thead>
                                <tr>
                                    <th style="display: none;">
                                        <b>Id</b>
                                    </th>
                                    <th>
                                        <b>Año</b>
                                    </th>
                                    <th>
                                        <b>Descripción</b>
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
                                    <td style="display: none;">
                                        <%=pre.idPptoMtoPreventivo %>
                                    </td>
                                    <td style="text-align: center;">
                                        <%=pre.ano%>
                                    </td>
                                    <td>
                                        <%=pre.descripcion %>
                                    </td>
                                    <td style="text-align: right;">
                                        <%=pre.montoEstimado%>
                                    </td>
                                    <td style="text-align: right;">
                                        <%=pre.montoFinal %>
                                    </td>
                                    <td style="text-align: right;">
                                        <%=pre.cantidadMantencion %>
                                    </td>
                                    <td style="text-align: center;">
                                        <%=pre.estado %>
                                    </td>
                                    <td>
                                        <a class="enviar" href="javascript:;">Enviar</a>
                                    </td>
                                    <td>
                                        <a class="editar" href="/Presupuesto/Editar/<%= pre.idPptoMtoPreventivo %>">Editar</a>
                                    </td>
                                    <td>
                                        <a class="eliminar" href="javascript:;">Eliminar</a>
                                    </td>
                                    <td>
                                        <a class="detalle" href="/Presupuesto/Detalle/<%=pre.idPptoMtoPreventivo.ToString()%>">
                                            Detalle</a>
                                    </td>
                                </tr>
                                <%}
                       } %>
                            </tbody>
                        </table>
                    </div>
                </div>
                <a id="addPresupuesto" href="/Presupuesto/Crear">Crear</a>
            </div>
        </div>
    </div>
    </div>
</asp:Content>
