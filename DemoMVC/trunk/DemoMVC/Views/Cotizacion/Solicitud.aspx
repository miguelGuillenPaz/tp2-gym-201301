<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../../Scripts/kendo/kendo.flat.min.css" rel="stylesheet" type="text/css" />
    <link href="../../Scripts/kendo/kendo.common.min.css" rel="stylesheet" type="text/css" />
    <link href="../../Content/Site.css" rel="stylesheet" type="text/css" />
    <link href="../../Scripts/jquery-ui/jquery-ui-1.10.3.custom.min.css" rel="stylesheet"
        type="text/css" />
    <script type="text/javascript" src="../../Scripts/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="../../Scripts/jquery-ui/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript" src="../../Scripts/js/jquery.maskedinput-1.3.1.min.js"></script>
    <script type="text/javascript" src="../../Scripts/js/jquery.numeric.js"></script>
    <script type="text/javascript" src="../../Scripts/js/jquery.validationEngine-es.js"></script>
    <script type="text/javascript" src="../../Scripts/js/jquery.validationEngine.js"></script>
    <script type="text/javascript" src="../../Scripts/libs/main.js"></script>
    <script type="text/javascript" src="../../Scripts/libs/dialog.js"></script>
    <script type="text/javascript" src="../../Scripts/libs/ajax.js"></script>
    <script type="text/javascript" src="../../Scripts/libs/form.js"></script>
    <script type="text/javascript" src="../../Scripts/libs/simpledataTable.js"></script>
    <script type="text/javascript" src="../../Scripts/kendo/kendo.web.min.js"></script>
    <script type="text/javascript" src="../../Content/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            $('div.busquedaSolicitudes').find('input[name=fechaInicio]').val('<%: ViewData["fechaInicioMes"] %>');
            $('div.busquedaSolicitudes').find('input[name=fechaFin]').val('<%: ViewData["fechaFinMes"] %>');

            $('div.busquedaSolicitudes').find('input[name=fechaInicio]').attr('fecha', '<%: ViewData["fechaInicioMes"] %>');
            $('div.busquedaSolicitudes').find('input[name=fechaFin]').attr('fecha', '<%: ViewData["fechaFinMes"] %>');

            var tablaRequerimientos = $('div.contenedorSolicitudes').find('div.requerimientos').find('table.dataTable');
            var tablaSolicitudes = $('div.contenedorSolicitudes').find('div.solicitudes').find('table.dataTable');

            $('div.busquedaSolicitudes').find('input[name=inicializar]').click(function () {
                var fechaInicio = $('div.busquedaSolicitudes').find('input[name=fechaInicio]').attr('fecha');
                var fechaFin = $('div.busquedaSolicitudes').find('input[name=fechaFin]').attr('fecha');

                $('div.busquedaSolicitudes').find('input[name=fechaInicio]').val(fechaInicio);
                $('div.busquedaSolicitudes').find('input[name=fechaFin]').val(fechaFin);

                $('div.busquedaSolicitudes').find('select[name=tipoFecha]').val($('div.busquedaSolicitudes').find('select[name=tipoFecha] option:first').val());
                $('div.busquedaSolicitudes').find('select[name=desEstado]').val(0);
                $('div.busquedaSolicitudes').find('select[name=codPro]').val(0);
                $('div.busquedaSolicitudes').find('select[name=codTServ]').val(0);

                $('div.busquedaSolicitudes').find('input[name=fechaInicio]').data("kendoDatePicker").enable(false);
                $('div.busquedaSolicitudes').find('input[name=fechaFin]').data("kendoDatePicker").enable(false);

                $('div.busquedaSolicitudes').find('input[name=codSolCotizacion]').val('');
                $('div.busquedaSolicitudes').find('input[name=codReq]').val('');
            });

            $('div.busquedaSolicitudes').find('input[name=buscar]').click(function () {
                var fechaInicio = $('div.busquedaSolicitudes').find('input[name=fechaInicio]').val();
                var fechaFin = $('div.busquedaSolicitudes').find('input[name=fechaFin]').val();

                var tipoFecha = $('div.busquedaSolicitudes').find('select[name=tipoFecha]').val();
                if ((fechaInicio.length == 0 || fechaFin.length == 0) && tipoFecha == 'todos') {
                    msgBox("Debe ingresar las fechas de búsqueda.", "Información del Sistema");
                    return false;
                }

                var codPro = parseFloat($('div.busquedaSolicitudes').find('select[name=codPro]').val());
                var codTServ = parseFloat($('div.busquedaSolicitudes').find('select[name=codTServ]').val());

                var codEstado = $('div.busquedaSolicitudes').find('select[name=codEstado]').val();
                var codSolCotizacion = $('div.busquedaSolicitudes').find('input[name=codSolCotizacion]').val();
                var codReq = $('div.busquedaSolicitudes').find('input[name=codReq]').val();

                $(tablaSolicitudes).find('a.onload').attr('data-params', 'tipoFecha:' + tipoFecha + ',fechaInicio:' + fechaInicio + ',fechaFin:' + fechaFin + ',codEstado:' + codEstado + ',codPro:' + codPro + ',codTServ:' + codTServ + ',codSolCotizacion:' + codSolCotizacion + ',codReq:' + codReq);
                $(tablaSolicitudes).dataTable();
            });

            $('div.busquedaSolicitudes').find('input[name=inicializar]').triggerHandler('click');

            $(tablaSolicitudes).on('click', 'a.detalle', function (e) {
                e.preventDefault();
                var tr = $(this).parents('tr').eq(0);
                var obj = $(tr).data('data');
                $(tablaRequerimientos).find('a.onload').attr('data-params', 'codSolCotizacion:' + obj.codSolCotizacion);
                $(tablaRequerimientos).dataTable();
            })

            $(tablaSolicitudes).bind('rowloaded', function (e, p) {
                var tr = p.tr;
                var obj = p.obj;
                if (obj.desEstado == 'Anulado') $(tr).find('input.check').hide();
            });

            $(tablaSolicitudes).bind('finished', function (e, p) {
                $('div.contenedorSolicitudes').find('div.requerimientos').hide();
                if (p.count > 0) {
                    //$('div.solicitudes').show();
                    $('#imprimirSolicitudCotizacion').removeAttr('disabled');
                } else {
                    msgBox("No existen registros de solicitudes de cotización", "Información del Sistema");
                    $('#imprimirSolicitudCotizacion').attr('disabled', true);
                    //$('div.solicitudes').hide();
                }
            });

            $(tablaRequerimientos).bind('finished', function (e, p) {
                if (p.count > 0) {
                    $('div.contenedorSolicitudes').find('div.requerimientos').show();
                } else {
                    $('div.contenedorSolicitudes').find('div.requerimientos').hide();
                    msgBox("No existen registros de requerimientos", "Información del Sistema");
                }
            });

            $('#nuevoSolicitudCotizacion').click(function () {
                getData({ url: '<%: Url.Action("InicializarValores", "SolicitudCotizacion") %>', data: {} }, function (response) {
                    $('#agregarSolicitudCotizacion').find('div.requerimientos table.dataTable tbody').find('tr:not(.model)').remove();
                    $('#agregarSolicitudCotizacion').find('div.proveedores table.dataTable tbody').find('tr:not(.model)').remove();
                    $('#agregarSolicitudCotizacion').find('select[name=codPro]').val(0);
                    $('#agregarSolicitudCotizacion').find('select[name=codTServ]').val(0);
                    $('#agregarSolicitudCotizacion').find('input[name=fecSolCotizacino]').val('');
                    $('#agregarSolicitudCotizacion').find('input[name=fechaVencimiento]').val('');
                    $('#agregarSolicitudCotizacion').find('textarea[name=descSolCotizacion]').val('');
                    $('#agregarSolicitudCotizacion').find('input[name=codSolCotizacion]').val(0);
                    $('#agregarSolicitudCotizacion').find('input[name=codigoSolicitud]').val('');

                    $('#agregarSolicitudCotizacion').data("kendoWindow").open();
                });
            });

            $('#modificarSolicitudCotizacion').click(function () {
                var selector = $(tablaSolicitudes).find('tbody tr:not(.model) input.check:checked');
                if (selector.length == 0) {
                    msgBox("Debe seleccionar una solicitud para modificar", "Información del Sistema");
                    return false;
                }

                getData({ url: '<%: Url.Action("InicializarValores", "SolicitudCotizacion") %>', data: {} }, function (response) {
                    var obj = $(selector).parents('tr').eq(0).data('data');
                    $('#agregarSolicitudCotizacion').find('select[name=codPro]').val(obj.codPro);
                    $('#agregarSolicitudCotizacion').find('select[name=codTServ]').val(obj.codTServ);
                    $('#agregarSolicitudCotizacion').find('input[name=fecSolCotizacino]').val(obj.fechaSolicitud);
                    $('#agregarSolicitudCotizacion').find('input[name=fechaVencimiento]').val(obj.fVencimiento);
                    $('#agregarSolicitudCotizacion').find('textarea[name=descSolCotizacion]').val(obj.descSolCotizacion);
                    $('#agregarSolicitudCotizacion').find('input[name=codSolCotizacion]').val(obj.codSolCotizacion);
                    $('#agregarSolicitudCotizacion').find('input[name=codigoSolicitud]').val(obj.codSolCotizacion);

                    $('#agregarSolicitudCotizacion').data("kendoWindow").open();
                });

            });

            $('#anularSolicitudCotizacion').click(function () {
                var selector = $(tablaSolicitudes).find('tbody tr:not(.model) input.check:checked');
                if (selector.length == 0) {
                    msgBox("Debe seleccionar una solicitud para anular", "Información del Sistema");
                    return false;
                }

                var obj = $(selector).parents('tr').eq(0).data('data');
                confirmBox("¿Desea anular la solicitud de cotización?", "Confirmación", function (response) {
                    if (response == true) {
                        getData({ url: '<%: Url.Action("Anular", "SolicitudCotizacion") %>', data: { 'codSolCotizacion': obj.codSolCotizacion} }, function (response) {
                            msgBox(response.mensaje, "Información del Sistema");
                            if (!response.error) {
                                $(tablaSolicitudes).dataTable();
                            }
                        })
                    }
                });
            });

            $('#enviarSolicitudCotizacion').click(function () {
                var selector = $(tablaSolicitudes).find('tbody tr:not(.model) input.check:checked');
                if (selector.length == 0) {
                    msgBox("Debe seleccionar una solicitud para enviar", "Información del Sistema");
                    return false;
                }

                var obj = $(selector).parents('tr').eq(0).data('data');
                $('#enviarSolicitudCotizacion').attr('disabled', true);
                $('div.contenedorSolicitudes').find('div.esperarProceso').show();
                getData({ url: '<%: Url.Action("EnviarSolicitudToProveedores", "Cotizacion") %>', data: { 'codSolCotizacion': obj.codSolCotizacion} }, function (response) {
                    $('div.contenedorSolicitudes').find('div.esperarProceso').hide();
                    $('#enviarSolicitudCotizacion').removeAttr('disabled');
                    msgBox(response.mensaje, "Información del Sistema");
                    if (!response.error) {

                    }
                });
            });

            $('#imprimirSolicitudCotizacion').click(function () {
                //window.print();
                var fechaInicio = $('div.busquedaSolicitudes').find('input[name=fechaInicio]').val();
                var fechaFin = $('div.busquedaSolicitudes').find('input[name=fechaFin]').val();

                var tipoFecha = $('div.busquedaSolicitudes').find('select[name=tipoFecha]').val();
                if ((fechaInicio.length == 0 || fechaFin.length == 0) && tipoFecha == 'todos') {
                    msgBox("Debe ingresar las fechas de búsqueda.", "Información del Sistema");
                    return false;
                }

                var codPro = parseFloat($('div.busquedaSolicitudes').find('select[name=codPro]').val());
                var nomPro = $('div.busquedaSolicitudes').find('select[name=codPro] option:selected').text();
                var codTServ = parseFloat($('div.busquedaSolicitudes').find('select[name=codTServ]').val());
                var descTServ = $('div.busquedaSolicitudes').find('select[name=codTServ] option:selected').text();

                var codEstado = $('div.busquedaSolicitudes').find('select[name=codEstado]').val();
                var desEstado = $('div.busquedaSolicitudes').find('select[name=codEstado] option:selected').text();
                var codSolCotizacion = $('div.busquedaSolicitudes').find('input[name=codSolCotizacion]').val();
                var codReq = $('div.busquedaSolicitudes').find('input[name=codReq]').val();

                location.href = '<%: Url.Content("~/SolicitudCotizacion/ExportarSolicitudes") %>' + '?codReq=' + codReq + '&codSolCotizacion=' + codSolCotizacion + '&codEstado=' + codEstado + '&desEstado=' + desEstado + '&codTServ=' + codTServ + '&descTServ=' + descTServ + '&codPro=' + codPro + '&nomPro=' + nomPro + '&tipoFecha=' + tipoFecha + '&fechaInicio=' + fechaInicio + '&fechaFin=' + fechaFin;
            });

            $('div.busquedaSolicitudes').find('select[name=tipoFecha]').change(function () {
                if ($(this).val() == 'todos') {
                    $('div.busquedaSolicitudes').find('input[name=fechaInicio]').data("kendoDatePicker").enable(false);
                    $('div.busquedaSolicitudes').find('input[name=fechaFin]').data("kendoDatePicker").enable(false);
                } else {
                    $('div.busquedaSolicitudes').find('input[name=fechaInicio]').data("kendoDatePicker").enable(true);
                    $('div.busquedaSolicitudes').find('input[name=fechaFin]').data("kendoDatePicker").enable(true);
                }
            });

        });
    </script>
    <div class="contenido-top">
        <div>
            <div class="areas-negocios">
                <div class="lista-central">
                    <div class="busquedaSolicitudes">
                        <fieldset>
                            <legend>Filtros</legend>
                            <div style="display: inline-block; margin-right: 20px;">
                                <table>
                                    <tr>
                                        <td>
                                            Proyecto:
                                        </td>
                                        <td colspan="3">
                                            <%: Html.DropDownList("codPro", new SelectList(GYM.SIG.Business.ProyectoCN.Instancia.listartodos(true), "codPro", "nomPro")) %>
                                        </td>
                                        <td>
                                            Tipo de Fecha:
                                        </td>
                                        <td>
                                            <select name="tipoFecha">
                                                <option value="todos">- Todos -</option>
                                                <option value="fechaCotizacion">Fecha de Cotización</option>
                                                <option value="fechaVencimiento">Fecha de Vencimiento</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Tipo de Servicio:
                                        </td>
                                        <td>
                                            <%: Html.DropDownList("codTServ", new SelectList(GYM.SIG.Business.TipoServicioCN.Instancia.listartodos(true), "codTServ", "descTServ"))%>
                                        </td>
                                        <td>
                                            Nro Sol. Coti.:
                                        </td>
                                        <td>
                                            <input type="text" name="codSolCotizacion" class="digits" style="width: 80px;" maxlength="5" />
                                        </td>
                                        <td>
                                            Fecha Inicio:
                                        </td>
                                        <td>
                                            <input type="text" name="fechaInicio" value="" class="datepicker" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Situación:
                                        </td>
                                        <td>
                                            <%: Html.DropDownList("codEstado", new SelectList(GYM.SIG.Business.EstadoCN.Instancia.listartodos("S", true), "codEstado", "desEstado"))%>
                                        </td>
                                        <td>
                                            Nro Req:
                                        </td>
                                        <td>
                                            <input type="text" name="codReq" class="digits" style="width: 80px;" maxlength="5" />
                                        </td>
                                        <td>
                                            Fecha Fin:
                                        </td>
                                        <td>
                                            <input type="text" name="fechaFin" value="" class="datepicker" maxlength="10" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div style="display: inline-block; vertical-align: top; text-align: center;">
                                <input type="button" name="buscar" value="Buscar" style="margin-top: 5px;" /><br />
                                <input type="button" name="inicializar" value="Inicializar" style="margin-top: 10px;" />
                            </div>
                        </fieldset>
                    </div>
                    <div class="contenedorSolicitudes" style="margin-top: 15px; margin-bottom: 10px;">
                        <div align="center" style="margin-top: 8px; display: none;" class="esperarProceso">
                            <div style="display: inline-block; vertical-align: middle;">
                                Enviando solicitud&nbsp;</div>
                            <div style="display: inline-block; vertical-align: middle;">
                                <img alt="" src="../../Img/loading.gif" /></div>
                        </div>
                        <div class="solicitudes">
                            <div style="display: inline-block; width: 48%;">
                                <label>
                                    <b>Solicitudes</b></label></div>
                            <div style="display: inline-block; width: 50%; margin-bottom: 5px;" align="right">
                                <input type="button" id="nuevoSolicitudCotizacion" name="nuevo" value="Nuevo" />&nbsp;&nbsp;
                                <input type="button" id="modificarSolicitudCotizacion" name="modificar" value="Modificar" />&nbsp;&nbsp;
                                <input type="button" id="anularSolicitudCotizacion" name="anular" value="Anular" />&nbsp;&nbsp;
                                <input type="button" id="imprimirSolicitudCotizacion" name="imprimir" value="Ver Reporte"
                                    disabled="true" />&nbsp;&nbsp;
                                <input type="button" id="enviarSolicitudCotizacion" name="enviar" value="Enviar Sol. Cot." />
                            </div>
                            <table class="dataTable table table-bordered" shownumberrows="true">
                                <thead>
                                    <tr>
                                        <th class="model">
                                            <a href="<%: Url.Action("BuscarSolicitudes", "Cotizacion") %>" class="onload" root="data"
                                                data-params=""></a>
                                        </th>
                                        <th>
                                            Sel
                                        </th>
                                        <th>
                                            Detalle
                                        </th>
                                        <th>
                                            <a href="" class="order" data-orderby="codSolCotizacion">Nro Sol. Cot.</a>
                                        </th>
                                        <th>
                                            <a href="" class="order" data-orderby="fechaSolicitud">Fecha de Registro</a>
                                        </th>
                                        <th>
                                            <a href="" class="order" data-orderby="descTServ">Tipo Servicio</a>
                                        </th>
                                        <th>
                                            <a href="" class="order" data-orderby="descSolCotizacion">Comentario</a>
                                        </th>
                                        <th>
                                            <a href="" class="order" data-orderby="desEstado">Situación</a>
                                        </th>
                                    </tr>
                                </thead>
                                <tfoot>
                                </tfoot>
                                <tbody>
                                    <tr class="model">
                                        <td style="text-align: center;">
                                            <input type="radio" name="check" class="check" />
                                        </td>
                                        <td>
                                            <a href="#" title="Ver detalle de la solicitud" class="detalle">Ver Detalle</a>
                                        </td>
                                        <td class="codSolCotizacion">
                                        </td>
                                        <td class="fechaSolicitud">
                                        </td>
                                        <td class="descTServ">
                                        </td>
                                        <td class="descSolCotizacion">
                                        </td>
                                        <td class="desEstado">
                                        </td>
                                    </tr>
                                    <tr style="height: 32px;">
                                        <td style="text-align: center;">
                                        </td>
                                        <td>
                                        </td>
                                        <td class="codSolCotizacion">
                                        </td>
                                        <td class="fechaSolicitud">
                                        </td>
                                        <td class="descTServ">
                                        </td>
                                        <td class="descSolCotizacion">
                                        </td>
                                        <td class="desEstado">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <br />
                        <div class="requerimientos" style="display: none;">
                            <label>
                                <b>Detalle de Solicitud</b></label>
                            <table class="dataTable table table-bordered" shownumberrows="true">
                                <thead>
                                    <tr>
                                        <th class="model">
                                            <a href="<%: Url.Action("listarporSolicitud", "Requerimiento") %>" class="onload"
                                                data-params="" root="data"></a>
                                        </th>
                                        <th>
                                            N°
                                        </th>
                                        <th>
                                            <a href="" class="order" data-orderby="nomPro">Proyecto</a>
                                        </th>
                                        <th>
                                            <a href="" class="order" data-orderby="codReq">Nº Req.</a>
                                        </th>
                                        <th>
                                            <a href="" class="order" data-orderby="desReq">Descripción</a>
                                        </th>
                                        <th>
                                            <a href="" class="order" data-orderby="desServicio">Detalle</a>
                                        </th>
                                        <th>
                                            <a href="" class="order" data-orderby="descUM">Unidad Medida</a>
                                        </th>
                                        <th>
                                            <a href="" class="order" data-orderby="canDetReq">Cantidad</a>
                                        </th>
                                    </tr>
                                </thead>
                                <tfoot>
                                </tfoot>
                                <tbody>
                                    <tr class="model">
                                        <td class="numero">
                                        </td>
                                        <td class="nomPro">
                                        </td>
                                        <td class="codReq">
                                        </td>
                                        <td class="desReq">
                                        </td>
                                        <td class="desServicio">
                                        </td>
                                        <td class="descUM">
                                        </td>
                                        <td class="canDetReq">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <% Html.RenderPartial("AgregarSolicitudCotizacion"); %>
</asp:Content>
