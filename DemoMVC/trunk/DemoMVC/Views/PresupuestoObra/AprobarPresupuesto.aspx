<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	AprobarPresupuesto
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../../Scripts/kendo/kendo.flat.min.css" rel="stylesheet" type="text/css" />
    <link href="../../Scripts/kendo/kendo.common.min.css" rel="stylesheet" type="text/css" />
    <link href="../../Content/Site.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../Scripts/kendo/kendo.web.min.js"></script>
    <script type="text/javascript">
        //Ajax setup config==================================================================================
        $.ajaxSetup({
            // Disable caching of AJAX responses */
            cache: false
        });
        //Context Route======================================================================================
        var config = {
            contextPath: '<%=ResolveUrl("~")%>'
        };
        //====================================================================================================
        $(function () {
            $.ajax({
                url: config.contextPath + 'PresupuestoObra/ListarPresupuestos',
                type: 'POST',
                datatype: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    $("#ListarPresupuesto").kendoGrid({
                        dataSource: {
                            data: data,
                            pageSize: 10
                        },
                        groupable: false,
                        sortable: false,
                        pageable: true,
                        columns: [{
                            field: "IDPresupuestoObra",
                            width: 46,
                            title: "<center>Numero<br />Presupuesto</center>",
                            attributes: { style: "text-align: right;" }
                        }, {
                            field: "Nombre",
                            width: 110,
                            title: "<center>Nombre del Proyecto</center>",
                            attributes: { style: "text-align: left;" }
                        }, {
                            field: "RazonSocial",
                            width: 110,
                            title: "<center>Cliente</center>",
                            attributes: { style: "text-align: left;" }
                        }, {
                            field: "Direccion",
                            width: 110,
                            title: "<center>Dirección<br />de la Obra</center>",
                            attributes: { style: "text-align: left;" }
                        }, {
                            field: "FechaCambioEstado",
                            width: 50,
                            title: "<center>Fecha<br />Estado</center>",
                            attributes: { style: "text-align: center;" },
                            template: "#= kendo.toString(kendo.parseDate(FechaCambioEstado, 'yyyy-MM-dd'), 'dd/MM/yyyy') #" 
                        }, {
                            field: "UsuarioCambioEstado",
                            width: 60,
                            title: "<center>Usuario<br />Estado</center>",
                            attributes: { style: "text-align: left;" }
                        }, {
                            title: "&nbsp;",
                            width: 40,
                            template: function (dataItem) {
                                return "<input type='button' value='Evaluar' onclick='mostrarEvaluar(" + kendo.htmlEncode(dataItem.IDPresupuestoObra) + ")' style='text-transform:none;-webkit-box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; -moz-box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; background-color:#5B74A8; border:1px solid #29447E; font-family:Tahoma,Verdana,Arial,sans-serif; font-size:12px; font-weight:700; padding:2px 6px; height:28px; color:#fff; border-radius:5px; -moz-border-radius:5px; -webkit-border-radius:5px;' />";
                            }
                        }]
                    }); 
                },
                error: function (request, status, err) {
                }
            });
        });

        function mostrarEvaluar(id) {
            window.location = config.contextPath + 'PresupuestoObra/ListarDetalle?PresupuestoID=' + id;
        }
    </script>


<div class="contenido-top">
    <div class="gpc-page">   
        <div style="width: 100%; float: left; display: block;">
            <h1 style="height: 20px;">Evaluación de Presupuestos</h1>
            <h3 style="height: 20px; color: Black; font-size: 15px; text-decoration: underline;">Presupuestos Pendientes de Evaluación</h3>
            <br />
            <div id="ListarPresupuesto">     
            </div>
        </div>
    </div>            
    <div class="clear"></div>
</div>

</asp:Content>
