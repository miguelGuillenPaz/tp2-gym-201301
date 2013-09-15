<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GYM.SIC.GPC.Models.PresupuestoModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    ListarDetalle
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

        function CambiarEstado(IdEstado, Observacion) {
            $.ajax({
                url: config.contextPath + 'PresupuestoObra/CambiarEstado?PresupuestoID=' + $("#IDPresupuesto").val() + '&Estado=' + IdEstado + '&Observacion=' + Observacion,
                type: 'POST',
                //data: jsonData,
                datatype: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (result) {

                    var mText = "";
                    if (IdEstado == 6) { // aprobar
                        //mText = "La Aprobación ha sido realizada.";
                        $("#modalAprobar").dialog("close");
                    } else if (IdEstado == 3) { // rechazar
                        //mText = "Se ha rechazado el presupuesto correctamente.";
                        $("#modalRechazar").dialog("close");
                    } else if (IdEstado == 4) { // anular
                        //mText = "Se ha solicitado la anulación del presupuesto.";
                        $("#modalAnular").dialog("close");
                    }

                    /*
                    Alert  
                    Success  
                    Error
                    Warning  
                    Information  
                    Confirm 
                    */
                    var n = noty({ text: result, type: 'Success' });

                },
                error: function (request, status, err) {
                }
            });
        };

        $(function () {
            $.ajax({
                url: config.contextPath + 'PresupuestoObra/Listarpartidas?PresupuestoID=' + $("#IDPresupuesto").val(),
                type: 'POST',
                datatype: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    $('#ListarPartidas').html(data);
                },
                error: function (request, status, err) {
                }
            });

            $.ajax({
                url: config.contextPath + 'PresupuestoObra/ListarCronograma?PresupuestoID=' + $("#IDPresupuesto").val(),
                type: 'POST',
                datatype: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    $("#ListarCronograma").kendoGrid({
                        dataSource: {
                            data: data,
                            pageSize: 10
                        },
                        groupable: false,
                        sortable: false,
                        pageable: true,
                        columns: [{
                            field: "Fecha",
                            width: 50,
                            title: "<center>Fecha</center>",
                            attributes: { style: "text-align: center;" },
                            template: "#= kendo.toString(kendo.parseDate(Fecha, 'yyyy-MM-dd'), 'dd/MM/yyyy') #"
                        }, {
                            field: "Hito",
                            width: 70,
                            title: "<center>Hito</center>",
                            attributes: { style: "text-align: left;" }
                        }, {
                            field: "Nombre",
                            width: 100,
                            title: "<center>Nombre</center>",
                            attributes: { style: "text-align: left;" }
                        }, {
                            field: "Responsable",
                            width: 70,
                            title: "<center>Responsable</center>",
                            attributes: { style: "text-align: left;" }
                        }]
                    });
                    //$('#ListarCronograma').html(data);
                },
                error: function (request, status, err) {
                }
            });

            $(".gpc-aprobar").click(function () {
                $("#tbAprobar").val("");
                $("#modalAprobar").dialog("open");
                return false;
            });
            $(".gpc-rechazar").click(function () {
                $("#tbRechazar").val("");
                $("#modalRechazar").dialog("open");
                return false;
            });
            $(".gpc-anular").click(function () {
                $("#tbAnular").val("");
                $("#modalAnular").dialog("open");
                return false;
            });
            $(".gpc-aprobarOK").click(function () {
                if (confirm("Usted está a punto de aprobar el presupuesto asignado. ¿Confirmar Cambios?")) {
                    CambiarEstado(6, $("#tbAprobar").val());
                }
                return false;
            });
            $(".gpc-rechazarOK").click(function () {
                if (confirm("Usted está a punto de rechazar el presupuesto asignado. ¿Confirmar Cambios?")) {
                    CambiarEstado(3, $("#tbRechazar").val());
                }
                return false;
            });
            $(".gpc-anularOK").click(function () {
                if (confirm("Usted está a punto de anular el presupuesto asignado. ¿Confirmar Cambios?")) {
                    CambiarEstado(4, $("#tbAnular").val());
                }
                return false;
            });
        });

        $(document).ready(function () {

            $.noty.defaults = {
                layout: 'top',
                theme: 'defaultTheme',
                type: 'alert',
                text: '',
                dismissQueue: true, // If you want to use queue feature set this true
                template: '<div class="noty_message"><span class="noty_text"></span><div class="noty_close"></div></div>',
                animation: {
                    open: { height: 'toggle' },
                    close: { height: 'toggle' },
                    easing: 'swing',
                    speed: 500 // opening & closing animation speed
                },
                timeout: 2000, // delay for closing event. Set false for sticky notifications
                force: false, // adds notification to the beginning of queue when set to true
                modal: false,
                maxVisible: 1, // you can set max visible notification for dismissQueue true option
                closeWith: ['click'], // ['click', 'button', 'hover']
                callback: {
                    onShow: function () { },
                    afterShow: function () { },
                    onClose: function () { },
                    afterClose: function () { }
                },
                buttons: false // an array of buttons
            };

            $("#modalAprobar").dialog({
                modal: true,
                autoOpen: false,
                width: 'auto',
                height: 'auto',
                autoResize: false,
                resizable: false,
                show: 'fade',
                hide: 'fade'
            });
            $("#modalRechazar").dialog({
                modal: true,
                autoOpen: false,
                width: 'auto',
                height: 'auto',
                autoResize: false,
                resizable: false,
                show: 'fade',
                hide: 'fade'
            });
            $("#modalAnular").dialog({
                modal: true,
                autoOpen: false,
                width: 'auto',
                height: 'auto',
                autoResize: false,
                resizable: false,
                show: 'fade',
                hide: 'fade'
            });
            $("#modalPartida").dialog({
                modal: true,
                autoOpen: false,
                width: 'auto',
                height: 'auto',
                autoResize: false,
                resizable: false,
                show: 'fade',
                hide: 'fade'
            });

            $("#modalCategoria").dialog({
                modal: true,
                autoOpen: false,
                width: 'auto',
                height: 'auto',
                autoResize: false,
                resizable: false,
                show: 'fade',
                hide: 'fade'
            });
        });

        function listarCategorias(PartidaID, nomPartida) {
            $.ajax({
                url: config.contextPath + 'PresupuestoObra/ListarCategorias?PartidaID=' + PartidaID,
                type: 'POST',
                datatype: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    $('#ListarCategoria').html(data);
                    $('#nompartida').text(nomPartida);
                    $('#partida').text(PartidaID);
                    $("#modalPartida").dialog("open");
                },
                error: function (request, status, err) {
                }
            });
        }

        function listarItems(CategoriaID, nomCategoria) {
            var PartidaID = $('#partida').text();
            $.ajax({
                url: config.contextPath + 'PresupuestoObra/ListarItems?PartidaID=' + PartidaID + '&CategoriaID=' + CategoriaID,
                type: 'POST',
                datatype: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    $('#ListarItem').html(data);
                    $('#nomcategoria').text(nomCategoria);
                    $("#modalCategoria").dialog("open");
                },
                error: function (request, status, err) {
                }
            });
        }

    </script>
    <div class="contenido-top">
        <div style="width: 100%; float: left; display: block;">
            <h1 style="height: 20px;">Aprobación de Presupuestos</h1>
            <h3 style="height: 20px; font-size: 15px; text-decoration: underline;">Datos del Presupuesto</h3>
        </div>
        <div class="gpc-separador">
        </div>
        <div style="width: 100%; float: left; display: block;">
            <div style="width: 100%; overflow: hidden;">
                <input type="hidden" id="IDPresupuesto" value="<%=Model.IDPresupuestoObra%>" />
                <div style="float: left; padding: .3em; font-weight: bold;">Número de Presupuesto: </div>
                <div style="float: left; padding: .3em;"><%=Model.Numero %></div>
                <div style="float: left; padding: .3em; font-weight: bold;">Nombre:</div>
                <div style="float: left; padding: .3em;"><%=Model.Nombre %></div>
                <div style="float: left; padding: .3em; font-weight: bold;">Cliente:</div>
                <div style="float: left; padding: .3em;"><%=Model.RazonSocial %></div>
            </div>
            <div style="width: 100%; overflow: hidden;">
                <div style="float: left; padding: .3em; font-weight: bold;">Dirección de la Obra:</div>
                <div style="float: left; padding: .3em;"><%=Model.Direccion %></div>
            </div>
            <div style="width: 100%; overflow: hidden;">
                <div style="float: left; padding: .3em; font-weight: bold;">Fecha Inicio:</div>
                <div style="float: left; padding: .3em;"><%=Model.FechaInicio %></div>
                <div style="float: left; padding: .3em; font-weight: bold;">Fecha Fin:</div>
                <div style="float: left; padding: .3em;"><%=Model.FechaFin %></div>
            </div>
            <div style="width: 100%; overflow: hidden;">
                <div style="float: left; padding: .3em; font-weight: bold;">Fecha Cambio de Estado:</div>
                <div style="float: left; padding: .3em;"><%=Model.FechaCambioEstado %></div>
                <div style="float: left; padding: .3em; font-weight: bold;">Usuario Cambio de Estado:</div>
                <div style="float: left; padding: .3em;"><%=Model.UsuarioCambioEstado %></div>
            </div>
            <div style="width: 100%; overflow: hidden;">
                <div style="float: left; padding: .3em; font-weight: bold;">Total Presupuestado:</div>
                <div style="float: left; padding: .3em;"><%=Model.TotalPresupuestado %></div>
            </div>
        </div>
        <div class="gpc-separador">
        </div>
        <div style="width: 100%; float: left;">
            <a href="" class="gpc-aprobar" style='width:70px;text-decoration: none;text-transform:none;-webkit-box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; -moz-box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; background-color:#5B74A8; border:1px solid #29447E; font-family:Tahoma,Verdana,Arial,sans-serif; font-size:12px; font-weight:700; padding:2px 6px; height:22px; color:#fff; border-radius:5px; -moz-border-radius:5px; -webkit-border-radius:5px;'>Aprobar</a> 
            <a href="" class="gpc-rechazar" style='width:70px;text-decoration: none;text-transform:none;-webkit-box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; -moz-box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; background-color:#5B74A8; border:1px solid #29447E; font-family:Tahoma,Verdana,Arial,sans-serif; font-size:12px; font-weight:700; padding:2px 6px; height:22px; color:#fff; border-radius:5px; -moz-border-radius:5px; -webkit-border-radius:5px;'>Rechazar</a>
            <a href="" class="gpc-anular" style='width:70px;text-decoration: none;text-transform:none;-webkit-box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; -moz-box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; background-color:#5B74A8; border:1px solid #29447E; font-family:Tahoma,Verdana,Arial,sans-serif; font-size:12px; font-weight:700; padding:2px 6px; height:22px; color:#fff; border-radius:5px; -moz-border-radius:5px; -webkit-border-radius:5px;'>Anular </a>
            <a href="javascript:history.back(1)" class="gpc-cancelar" style='width:70px;text-decoration: none;text-transform:none;-webkit-box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; -moz-box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; background-color:#5B74A8; border:1px solid #29447E; font-family:Tahoma,Verdana,Arial,sans-serif; font-size:12px; font-weight:700; padding:2px 6px; height:22px; color:#fff; border-radius:5px; -moz-border-radius:5px; -webkit-border-radius:5px;'>Cancelar</a>
        </div>
        <div class="gpc-separador">
        </div>
        <div id="ListarPartidas" class="gpc-listas">
        </div>
        <div class="gpc-separador">
        </div>
        <div id="ListarCronograma" class="gpc-listas">
        </div>
        <div class="clear">
        </div>
    </div>
    <div id="modalPartida" class="gpc-modals" title="Lista de Categorias">
        <div id="ListarCategoria" class="gpc-lista-Categoria">
        </div>
    </div>
    <div id="modalCategoria" class="gpc-modals" title="Lista de Items">
        <div id="ListarItem" class="gpc-lista-detallePartida">
        </div>
    </div>
    <div id="modalAprobar" class="gpc-modals" title="Aprobar Presupuesto">
        <div class="gpc-modals-container">
            <div class="gpc-modals-row">
                Usted está a punto de aprobar el presupuesto asignado.
                <br />
                Observaciones
            </div>
            <div class="gpc-modals-row">
                <textarea id="tbAprobar" rows="3" cols="60" style="width: 98%;"></textarea>
            </div>
            <div class="gpc-modals-row">
                <br />
                <a href="" class="gpc-aprobarOK" style="color: #ffffff; float: right;width:140px;height:22px;text-decoration: none;text-transform:none;-webkit-box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; -moz-box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; background-color:#5B74A8; border:1px solid #29447E; font-family:Tahoma,Verdana,Arial,sans-serif; font-size:12px; font-weight:700; padding:2px 6px; color:#fff; border-radius:5px; -moz-border-radius:5px; -webkit-border-radius:5px;">Confirmar Cambios</a>
            </div>
        </div>
    </div>
    <div id="modalRechazar" class="gpc-modals" title="Rechazar Presupuesto">
        <div class="gpc-modals-container">
            <div class="gpc-modals-row">
                <span class="gpc-indicaciones">Usted está a punto de rechazar el presupuesto asignado.
                    <br />
                    Ingrese las indicaciones de cambios a realizar para tener su conformidad.
                    <br />
                    Observaciones </span>
            </div>
            <div class="gpc-modals-row">
                <textarea id="tbRechazar" rows="3" cols="60" style="width: 98%;"></textarea>
            </div>
            <div class="gpc-modals-row">
                <br />
                <a href="" class="gpc-rechazarOK" style="color: #ffffff; float: right;width:140px;height:22px;text-decoration: none;text-transform:none;-webkit-box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; -moz-box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; background-color:#5B74A8; border:1px solid #29447E; font-family:Tahoma,Verdana,Arial,sans-serif; font-size:12px; font-weight:700; padding:2px 6px; color:#fff; border-radius:5px; -moz-border-radius:5px; -webkit-border-radius:5px;">Confirmar Cambios</a>
            </div>
        </div>
    </div>
    <div id="modalAnular" class="gpc-modals" title="Anular Presupuesto">
        <div class="gpc-modals-container">
            <div class="gpc-modals-row">
                <span class="gpc-indicaciones">Usted está a punto de solicitar la anulación del presupuesto
                    asignado.
                    <br />
                    Ingrese la justificación de cambios a realizar para tener su conformidad.
                    <br />
                    Justificación </span>
            </div>
            <div class="gpc-modals-row">
                <textarea id="tbAnular" rows="3" cols="60" style="width: 98%;"></textarea>
            </div>
            <div class="gpc-modals-row">
                <br />
                <a href="" class="gpc-anularOK" style="color: #ffffff; float: right; width:140px;height:22px;text-decoration: none;text-transform:none;-webkit-box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; -moz-box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; background-color:#5B74A8; border:1px solid #29447E; font-family:Tahoma,Verdana,Arial,sans-serif; font-size:12px; font-weight:700; padding:2px 6px; color:#fff; border-radius:5px; -moz-border-radius:5px; -webkit-border-radius:5px;">Confirmar Anulación</a>
            </div>
        </div>
    </div>
</asp:Content>
