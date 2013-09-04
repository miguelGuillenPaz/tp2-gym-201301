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

        $(function () {

            $('#ActualizarExpediente').ajaxForm({
                type: 'POST',
                beforeSend: function () {
                },
                beforeSubmit: function () {
                },
                success: function (result) {
                    var n = noty({ text: result, type: 'information' });
                }
            });

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

            $(".gpc-registrar").click(function () {
                if (confirm("Usted está a punto de registrar el expediente técnico. ¿Confirmar Cambios?")) {
                    $('#ActualizarExpediente').submit();
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
                Registro de Expediente Técnico</h1>
            <br />
            <h3 class="gpc-subtitulo">
                Datos del Presupuesto</h3>
        </div>
        <div class="gpc-separador">
        </div>
        <div style="width: 100%; float: left; display: block;">
            <div>
                Número de Presupuesto:
                <%=Model.Numero %>
            </div>
            <div>
                Nombre:
                <%=Model.Nombre %>
            </div>
            <div>
                Cliente:
                <%=Model.RazonSocial %>
            </div>
            <div>
                Dirección de la Obra:
                <%=Model.Direccion %>
            </div>
            <div>
                Fecha Inicio:
                <%=Model.FechaInicio %>
            </div>
            <div>
                Fecha Fin:
                <%=Model.FechaFin %>
            </div>
            <div>
                Fecha Cambio de Estado:
                <%=Model.FechaCambioEstado %>
            </div>
            <div>
                Usuario Cambio de Estado:
                <%=Model.UsuarioCambioEstado %>
            </div>
            <div>
                Total Presupuestado:
                <%=Model.TotalPresupuestado %>
            </div>
        </div>
        <div class="gpc-separador">
        </div>
        <form id="ActualizarExpediente" action='<%=ResolveUrl("~/ExpedienteTecnico/ActualizarExpedienteTecnico")%>'
        enctype="multipart/form-data" method="post">
        <input type="hidden" id="IDPresupuesto" name="IDPresupuesto" value="<%=Model.ID%>" />
        <div style="width: 100%; float: left; vertical-align: top;">
            Observación:
            <textarea id="Observacion" name="Observacion" rows="10" cols="50"></textarea>
            Adjuntar Análisis:
            <input type="file" id="Archivo" name="Archivo" />
        </div>
        <div>
            <a href="" class="gpc-registrar">Registrar</a> <a href="javascript:history.back(1)"
                class="gpc-cancelar">Cancelar</a>
        </div>
        </form>
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
</asp:Content>
