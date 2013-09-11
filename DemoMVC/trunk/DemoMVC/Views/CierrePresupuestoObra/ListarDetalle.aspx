<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GYM.SIC.GPC.Models.PresupuestoModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	ListarDetalle
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
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
                url: config.contextPath + 'CierrePresupuestoObra/CambiarEstado?PresupuestoID=' + $("#IDPresupuesto").val() + '&Estado=' + IdEstado + '&Observacion=' + Observacion,
                type: 'POST',
                //data: jsonData,
                datatype: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (result) {

                    var mText = "";
                    if (IdEstado == 11) { // Cerrado por el Supervisor de Presupuesto
                        //mText = "La Aprobación ha sido realizada.";
                        $("#modalCerrar").dialog("close");
                    } else if (IdEstado == 12) { // Presupuesto con Inconsistencias
                        //mText = "Se ha rechazado el presupuesto correctamente.";
                        $("#modalActualizar").dialog("close");
                    } else if (IdEstado == 17) { // En solicitud de Actualización
                        //mText = "Se ha solicitado la anulación del presupuesto.";
                        $("#modalJustificar").dialog("close");
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
                    $('#ListarCronograma').html(data);
                },
                error: function (request, status, err) {
                }
            });

            $(".gpc-cerrar").click(function () {
                $("#tbCerrar").val("");
                $("#modalCerrar").dialog("open");
                return false;
            });
            $(".gpc-actualizar").click(function () {
                if (confirm("Usted está a punto de rechazar el presupuesto asignado. ¿Confirmar Cambios?")) {
                    CambiarEstado(13, "");
                }
                return false;
            });            
            $(".gpc-justificar").click(function () {
                $("#tbJustificar").val("");
                $("#modalJustificar").dialog("open");
                return false;
            });
            $(".gpc-cerrarOK").click(function () {
                if (confirm("Usted está a punto de aprobar el presupuesto asignado. ¿Confirmar Cambios?")) {
                    CambiarEstado(11, $("#tbCerrar").val());
                }
                return false;
            });
            $(".gpc-justificarOK").click(function () {
                if (confirm("Usted está a punto de anular el presupuesto asignado. ¿Confirmar Cambios?")) {
                    CambiarEstado(12, $("#tbJustificar").val());
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

            $("#modalCerrar").dialog({
                modal: true,
                autoOpen: false,
                width: 'auto',
                height: 'auto',
                autoResize: false,
                resizable: false,
                show: 'fade',
                hide: 'fade'
            });
            $("#modalJustificar").dialog({
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
            <h1>
                Aprobación de Presupuestos</h1>
            <br />
            <h3 class="gpc-subtitulo">
                Datos del Presupuesto</h3>
        </div>
        <div class="gpc-separador">
        </div>
        <div style="width: 100%; float: left; display: block;">
            <div style="width: 100%; overflow: hidden;">
                <div style="float: left; padding: .5em;">
                    <input type="hidden" id="IDPresupuesto" value="<%=Model.IDPresupuestoObra%>" />
                    Número de Presupuesto:
                </div>
                <div style="float: left; padding: .5em;">
                    <%=Model.Numero %>
                </div>
                <div style="float: left; padding: .5em;">
                    Nombre:
                </div>
                <div style="float: left; padding: .5em;">
                    <%=Model.Nombre %>
                </div>
                <div style="float: left; padding: .5em;">
                    Cliente:
                </div>
                <div style="float: left; padding: .5em;">
                    <%=Model.RazonSocial %></div>
            </div>
            <div style="width: 100%; overflow: hidden;">
                <div style="float: left; padding: .5em;">
                    Dirección de la Obra:
                </div>
                <div style="float: left; padding: .5em;">
                    <%=Model.Direccion %></div>
            </div>
            <div style="width: 100%; overflow: hidden;">
                <div style="float: left; padding: .5em;">
                    Fecha Inicio:
                </div>
                <div style="float: left; padding: .5em;">
                    <%=Model.FechaInicio %>
                </div>
                <div style="float: left; padding: .5em;">
                    Fecha Fin:
                </div>
                <div style="float: left; padding: .5em;">
                    <%=Model.FechaFin %></div>
            </div>
            <div style="width: 100%; overflow: hidden;">
                <div style="float: left; padding: .5em;">
                    Fecha Cambio de Estado:
                </div>
                <div style="float: left; padding: .5em;">
                    <%=Model.FechaCambioEstado %></div>
                <div style="float: left; padding: .5em;">
                    Usuario Cambio de Estado:
                </div>
                <div style="float: left; padding: .5em;">
                    <%=Model.UsuarioCambioEstado %></div>
            </div>
            <div style="width: 100%; overflow: hidden;">
                <div style="float: left; padding: .5em;">
                    Total Presupuestado:
                </div>
                <div style="float: left; padding: .5em;">
                    <%=Model.TotalPresupuestado %></div>
            </div>
            <div style="width: 100%; overflow: hidden;">
                <div style="float: left; padding: .5em;">
                    Total Ejecutado:
                </div>
                <div style="float: left; padding: .5em;">
                    <%=Model.TotalEjecutado %></div>
            </div>
            <div style="width: 100%; overflow: hidden;">
                <div style="float: left; padding: .5em;">
                    Observaciones:
                </div>
                <div style="float: left; padding: .5em;">
                    <%=Model.Observacion %></div>
            </div>
        </div>
        <div class="gpc-separador">
        </div>
        <div style="width: 100%; float: left;">
            <a href="" class="gpc-cerrar">Cerrar Presupuesto</a>
            <a href="" class="gpc-actualizar">Notificar Actualización </a>
            <a href="" class="gpc-justificar">Notificar Justificación</a>
            <a href="javascript:history.back(1)" class="gpc-cancelar">Cancelar</a>
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
    <div id="modalCerrar" class="gpc-modals" title="Cerrar Presupuesto">
        <div class="gpc-modals-container">
            <div class="gpc-modals-row">
                Usted está a punto de cerrar el presupuesto asignado.
                <br />
                Ingrese el análisis de cierre.
                <br />
                Análisis
            </div>
            <div class="gpc-modals-row">
                <textarea id="tbCerrar" rows="3" cols="60" style="width: 100%;"></textarea>
            </div>
            <div class="gpc-modals-row">
                <a href="" class="gpc-cerrarOK" style="color: #ffffff; float: right;">Confirmar Cierre</a>
            </div>
        </div>
    </div>
    <div id="modalJustificar" class="gpc-modals" title="Notificar Justificación">
        <div class="gpc-modals-container">
            <div class="gpc-modals-row">
                <span class="gpc-indicaciones">Usted está a punto de notificar la justificación de inconsistencias en el presupuesto asignado. 
                    <br />
                    Ingrese las inconsistencias a justificar.
                    <br />
                    Inconsistencias</span>
            </div>
            <div class="gpc-modals-row">
                <textarea id="tbJustificar" rows="3" cols="60" style="width: 100%;"></textarea>
            </div>
            <div class="gpc-modals-row">
                <a href="" class="gpc-justificarOK" style="color: #ffffff; float: right;">Enviar Notificación</a>
            </div>
        </div>
    </div>
</asp:Content>
