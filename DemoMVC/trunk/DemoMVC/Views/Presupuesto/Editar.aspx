<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<DemoMVC.Models.PMP_PptoMtoPreventivo>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script src="/Scripts/Presupuesto/refresh.js" type="text/javascript"></script>
    <script src="/Scripts/Presupuesto/editar.js" type="text/javascript"></script>
    <div class="contenido-top">
        <div>
            <h1>
                Editar Presupuesto</h1>
                <%= Html.HiddenFor(m=> m.idPptoMtoPreventivo) %>
            <div class="areas-negocios">
                <div class="noticia">
                    <table class="table100">
                        <tr>
                            <td>
                                <label>
                                    Año:</label>
                            </td>
                            <td>                                
                                <%= Html.TextBoxFor(m => m.ano, new{@Type = "number"}) %>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>
                                    Descripción:</label>
                            </td>
                            <td>                                
                                <%= Html.TextBoxFor(m => m.descripcion) %>
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
                            <table id="tblListadoEquipos" class="table100">
                                <thead>
                                    <tr>
                                        <th>
                                            <b>Id</b>
                                        </th>
                                        <th style="width: 150px; text-align: center;">
                                            <b>Modelo</b>
                                        </th>
                                        <th>
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
                                        <th>
                                            <b>IdDetalle</b>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (Model != null)
                                       {                                           
                                           foreach (var pre in Model.PMP_DetallePptoMtoPreventivo)
                                           {
                                    %>
                                    <tr>
                                        <td>
                                            <%=pre.idMaquinariaEquipo %>
                                        </td>
                                        <td style="text-align: center;">
                                            <%=pre.PMP_MaquinariaEquipo.modelo%>
                                        </td>
                                        <td>
                                            <%=pre.PMP_MaquinariaEquipo.descripcion%>
                                        </td>
                                        <td style="text-align: right;">
                                            <%=pre.PMP_MaquinariaEquipo.costoMantenimiento%>
                                        </td>
                                        <td style="text-align: right;">                                                                                        
                                             <input class="cantidad" type="number" value="<%=pre.cantidadMantenimiento %>" min="0" />
                                        </td>
                                        <td style="text-align: right;">
                                            <%=pre.montoAprobado %>
                                        </td>
                                        <td>
                                            <%=pre.idDetallePptoMtoPreventivo %>
                                        </td>
                                    </tr>
                                    <%}
                                       } %>

                                </tbody>
                                <tfoot style="border-top:1px dashed gray">
                                    <tr>
                                        <td style="width: 150px; text-align: right"></td>
                                        <td></td>
                                        <td></td>
                                        <td style="width: 150px; text-align: right"><b id="costoTotalFijo"><%= Model!=null? Model.montoEstimado + string.Empty:"0.0000"%></b></td>
                                        <td style="width: 150px; text-align: right"><b id="cantidad"><%= Model!=null? Model.cantidadMantencion + string.Empty:"0.0000"%></b></td>
                                        <td style="width: 150px; text-align: right"><b id="costoTotalFinal"><%= Model!=null? Model.montoFinal + string.Empty:"0.0000"%></b></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                    <a id="btnGrabar" href="javascript:;">Enviar</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
