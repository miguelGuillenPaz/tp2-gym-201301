<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<DemoMVC.Models.PMP_PptoMtoPreventivo>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script src="/Scripts/Presupuesto/refresh_.js" type="text/javascript"></script>
    <script src="/Scripts/Presupuesto/buscar.js" type="text/javascript"></script>
    <div class="contenido-top">
        <div>
            <h1>
                Detalle de Presupuesto</h1>
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
                                <%= Html.DisplayTextFor(m=>m.ano) %>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>
                                    Descripción de Presupuesto:</label>
                            </td>
                            <td>                                
                                <%= Html.DisplayTextFor(m => m.descripcion)%>
                            </td>
                        </tr>          
                        <tr>
                            <td>
                                <label>
                                    Tipo:</label>
                            </td>
                            <td>                                
                                <select id="ddlTipo">
                                    <option value="">TODOS</option>
                                    <option value="MAQUINARIA">MAQUINARIA</option>
                                    <option value="EQUIPO">EQUIPO</option>
                                </select>
                            </td>
                        </tr>               
                        <tr>
                            <td>
                                <label>
                                    Descripción de Equipo:</label>
                            </td>
                            <td>                                
                                <input id="txtParametro" type="text" value=""/>
                            </td>
                        </tr>                        
                        <tr>
                            <td>
                            </td>
                            <td>                                
                                <a id="btnBuscar" href="javascript:;">Consultar</a>
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
                            <table id="tblListadoEquipos" class="table100  table100b">
                                <thead>
                                    <tr>
                                        <th style="display: none;">
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
                                        <th style="display: none;">
                                            <b>IdDetalle</b>
                                        </th>
                                        <th style="text-align: center;">
                                            <b>Tipo</b>
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
                                        <td style="display: none;">
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
                                              <%=pre.cantidadMantenimiento %>
                                        </td>
                                        <td style="text-align: right;">
                                            <%=pre.montoAprobado %>
                                        </td>
                                        <td style="display: none;">
                                            <%=pre.idDetallePptoMtoPreventivo %>
                                        </td>
                                        <td style="text-align: center;">
                                            <%=pre.PMP_MaquinariaEquipo.tipo %>
                                        </td>
                                    </tr>
                                    <%}
                                       } %>

                                </tbody>
                                <tfoot style="border-top:1px dashed gray">
                                    <tr>
                                        <td  style="display: none;"></td>
                                        <td style="width: 150px; text-align: right"></td>                                        
                                        <td></td>
                                        <td style="width: 150px; text-align: right"><b id="costoTotalFijo"><%= Model!=null? Model.montoEstimado + string.Empty:"0.0000"%></b></td>
                                        <td style="width: 150px; text-align: right"><b id="cantidad"><%= Model!=null? Model.cantidadMantencion + string.Empty:"0.0000"%></b></td>
                                        <td style="width: 150px; text-align: right"><b id="costoTotalFinal"><%= Model!=null? Model.montoFinal + string.Empty:"0.0000"%></b></td>
                                        <td style="display: none;"></td>
                                        <td></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                    <%--<a id="btnCancelar" href="/Presupuesto">Regresar</a>--%>
                    <%= Html.ActionLink("Regresar","Index") %>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
