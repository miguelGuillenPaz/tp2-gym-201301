<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<DemoMVC.Models.PMP_MaquinariaEquipo>>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script src="/Scripts/Presupuesto/refresh.js" type="text/javascript"></script>
    <script src="/Scripts/Presupuesto/crear.js" type="text/javascript"></script>
    <div class="contenido-top">
        <div>
            <h1>
                Crear Presupuesto</h1>
            <div class="areas-negocios">
                <div class="noticia">
                    <table class="table100">
                        <tr>
                            <td>
                                <label for="txtAno">
                                    Año:</label>
                            </td>
                            <td>
                                <input id="txtAno" type="number" max="9999" min="1900" value="" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="txtDescripcion">
                                    Descripción:</label>
                            </td>
                            <td>
                                <input id="txtDescripcion" type="text" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="areas-negocios">
                <div class="lista-central">
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Lista de Equipos</span>
                        </div>
                        <div class="texto-noticia">
                            <table id="tblListadoEquipos" class="table100 table100b">
                                <thead>
                                    <tr>
                                        <th style="display: none;">
                                            <b>Id</b>
                                        </th>
                                        <th style="width: 150px; text-align: center;">
                                            <b>Modelo</b>
                                        </th>
                                        <th style="text-align: center;">
                                            <b>Descripción</b>
                                        </th>
                                        <th style="width: 150px; text-align: right">
                                            <b>Costo total fijo</b>
                                        </th>
                                        <th style="width: 150px; text-align: right">
                                            <b>Cantidad</b>
                                        </th>
                                        <th style="width: 150px; text-align: right">
                                            <b>Costo total final</b>
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
                                            <%=pre.idMaquinariaEquipo %>
                                        </td>
                                        <td style="text-align: center;">
                                            <%=pre.modelo%>
                                        </td>
                                        <td>
                                            <%=pre.descripcion %>
                                        </td>
                                        <td style="text-align: right;">
                                            <%=pre.costoMantenimiento%>
                                        </td>
                                        <td style="text-align: right;">
                                            <input class="cantidad" type="number" value="1" min="0" />
                                        </td>
                                        <td style="text-align: right;">
                                            <%=pre.costoMantenimiento %>
                                        </td>
                                    </tr>
                                    <%}
                                       } %>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td style="display: none;">
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td style="width: 150px; text-align: right">
                                            <b id="costoTotalFijo">0.0000</b>
                                        </td>
                                        <td style="width: 150px; text-align: right">
                                            <b id="cantidad">0.0000</b>
                                        </td>
                                        <td style="width: 150px; text-align: right">
                                            <b id="costoTotalFinal">0.0000</b>
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                    <a id="btnGrabar" href="javascript:;">Enviar</a> | <a id="btnCancelar" href="/Presupuesto">Cancelar</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
