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
            <div style="width: 100%; overflow: hidden;">
                <input type="hidden" id="Hidden1" value="<%=Model.IDPresupuestoObra%>" />
                <div style="float: left; padding: .3em; font-weight: bold;">
                    Número de Presupuesto:
                </div>
                <div style="float: left; padding: .3em;">
                    <%=Model.Numero %></div>
                <div style="float: left; padding: .3em; font-weight: bold;">
                    Nombre:</div>
                <div style="float: left; padding: .3em;">
                    <%=Model.Nombre %></div>
                <div style="float: left; padding: .3em; font-weight: bold;">
                    Cliente:</div>
                <div style="float: left; padding: .3em;">
                    <%=Model.RazonSocial %></div>
            </div>
            <div style="width: 100%; overflow: hidden;">
                <div style="float: left; padding: .3em; font-weight: bold;">
                    Dirección de la Obra:</div>
                <div style="float: left; padding: .3em;">
                    <%=Model.Direccion %></div>
            </div>
            <div style="width: 100%; overflow: hidden;">
                <div style="float: left; padding: .3em; font-weight: bold;">
                    Fecha Inicio:</div>
                <div style="float: left; padding: .3em;">
                    <%=Model.FechaInicio %></div>
                <div style="float: left; padding: .3em; font-weight: bold;">
                    Fecha Fin:</div>
                <div style="float: left; padding: .3em;">
                    <%=Model.FechaFin %></div>
            </div>
            <div style="width: 100%; overflow: hidden;">
                <div style="float: left; padding: .3em; font-weight: bold;">
                    Fecha Cambio de Estado:</div>
                <div style="float: left; padding: .3em;">
                    <%=Model.FechaCambioEstado %></div>
                <div style="float: left; padding: .3em; font-weight: bold;">
                    Usuario Cambio de Estado:</div>
                <div style="float: left; padding: .3em;">
                    <%=Model.UsuarioCambioEstado %></div>
            </div>
            <div style="width: 100%; overflow: hidden;">
                <div style="float: left; padding: .3em; font-weight: bold;">
                    Total Presupuestado:</div>
                <div style="float: left; padding: .3em;">
                    <%=Model.TotalPresupuestado %></div>
            </div>
        </div>
        <div class="gpc-separador">
        </div>
        <form id="ActualizarExpediente" action='<%=ResolveUrl("~/ExpedienteTecnico/ActualizarExpedienteTecnico")%>'
        enctype="multipart/form-data" method="post">
        <input type="hidden" id="IDPresupuesto" name="IDPresupuesto" value="<%=Model.IDPresupuestoObra%>" />
        <table style="width:900px;">
            <tr>
                <td>
                    Observación: 
                </td>
                <td><textarea id="Observacion" name="Observacion" rows="10" cols="1" style="width:700px"></textarea></td>
            </tr>
            <tr>
                 <td>Adjuntar Análisis:  </td>
                 <td><input type="file" id="Archivo" name="Archivo" /></td>
            </tr>
        </table>
        <div class="gpc-separador">
        </div>
        <div style="width: 100%; float: left;">
            <a href="" class="gpc-registrar" style='width: 70px; text-decoration: none; text-transform: none;
                -webkit-box-shadow: rgba(0,0,0,0.0.1) 0 1px 0 0; -moz-box-shadow: rgba(0,0,0,0.0.1) 0 1px 0 0;
                box-shadow: rgba(0,0,0,0.0.1) 0 1px 0 0; background-color: #5B74A8; border: 1px solid #29447E;
                font-family: Tahoma,Verdana,Arial,sans-serif; font-size: 12px; font-weight: 700;
                padding: 2px 6px; height: 22px; color: #fff; border-radius: 5px; -moz-border-radius: 5px;
                -webkit-border-radius: 5px;'>Registrar</a> <a href="javascript:history.back(1)" class="gpc-cancelar"
                    style='width: 70px; text-decoration: none; text-transform: none; -webkit-box-shadow: rgba(0,0,0,0.0.1) 0 1px 0 0;
                    -moz-box-shadow: rgba(0,0,0,0.0.1) 0 1px 0 0; box-shadow: rgba(0,0,0,0.0.1) 0 1px 0 0;
                    background-color: #5B74A8; border: 1px solid #29447E; font-family: Tahoma,Verdana,Arial,sans-serif;
                    font-size: 12px; font-weight: 700; padding: 2px 6px; height: 22px; color: #fff;
                    border-radius: 5px; -moz-border-radius: 5px; -webkit-border-radius: 5px;'>Cancelar</a>
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
