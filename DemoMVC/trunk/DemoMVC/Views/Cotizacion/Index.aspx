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

            $('div.busquedaCotizaciones').find('input[name=fechaInicio]').val('<%: ViewData["fechaInicioMes"] %>');
            $('div.busquedaCotizaciones').find('input[name=fechaFin]').val('<%: ViewData["fechaFinMes"] %>');

            $('div.busquedaCotizaciones').find('input[name=fechaInicio]').attr('fecha', '<%: ViewData["fechaInicioMes"] %>');
            $('div.busquedaCotizaciones').find('input[name=fechaFin]').attr('fecha', '<%: ViewData["fechaFinMes"] %>');

            var tablaCotizaciones = $('div.contenedorCotizaciones').find('div.cotizaciones').find('table.dataTable');

            $('div.busquedaCotizaciones').find('input[name=inicializar]').click(function () {
                var fechaInicio = $('div.busquedaCotizaciones').find('input[name=fechaInicio]').attr('fecha');
                var fechaFin = $('div.busquedaCotizaciones').find('input[name=fechaFin]').attr('fecha');

                $('div.busquedaCotizaciones').find('input[name=fechaInicio]').val(fechaInicio);
                $('div.busquedaCotizaciones').find('input[name=fechaFin]').val(fechaFin);

                $('div.busquedaCotizaciones').find('select[name=tipoFecha]').val($('div.busquedaCotizaciones').find('select[name=tipoFecha] option:first').val());
                $('div.busquedaCotizaciones').find('select[name=estado]').val($('div.busquedaCotizaciones').find('select[name=estado] option:first').val());
                $('div.busquedaCotizaciones').find('select[name=codPro]').val(0);
                $('div.busquedaCotizaciones').find('select[name=codTServ]').val(0);
                $('div.busquedaCotizaciones').find('select[name=codEstado]').val(0);

                $('div.busquedaCotizaciones').find('input[name=fechaInicio]').data("kendoDatePicker").enable(false);
                $('div.busquedaCotizaciones').find('input[name=fechaFin]').data("kendoDatePicker").enable(false);

                $('div.busquedaCotizaciones').find('input[name=codSolCotizacion]').val('');
                $('div.busquedaCotizaciones').find('input[name=codCotizacion]').val('');
                $('div.busquedaCotizaciones').find('input[name=codProv]').val(0);
                $('div.busquedaCotizaciones').find('input[name=razsocPro]').val('');

            });

            $('div.busquedaCotizaciones').find('input[name=buscar]').click(function () {
                var fechaInicio = $('div.busquedaCotizaciones').find('input[name=fechaInicio]').val();
                var fechaFin = $('div.busquedaCotizaciones').find('input[name=fechaFin]').val();

                var tipoFecha = $('div.busquedaCotizaciones').find('select[name=tipoFecha]').val();
                if ((fechaInicio.length == 0 || fechaFin.length == 0) && tipoFecha == 'todos') {
                    msgBox("Debe ingresar las fechas de búsqueda.", "Información del Sistema");
                    return false;
                }

                var codPro = parseFloat($('div.busquedaCotizaciones').find('select[name=codPro]').val());
                var codTServ = parseFloat($('div.busquedaCotizaciones').find('select[name=codTServ]').val());
                var codEstado = $('div.busquedaCotizaciones').find('select[name=codEstado]').val();

                var codSolCotizacion = $('div.busquedaCotizaciones').find('input[name=codSolCotizacion]').val();
                var codCotizacion = $('div.busquedaCotizaciones').find('input[name=codCotizacion]').val();
                var codProv = $('div.busquedaCotizaciones').find('input[name=codProv]').val();

                $(tablaCotizaciones).find('a.onload').attr('data-params', 'tipoFecha:' + tipoFecha + ',fechaInicio:' + fechaInicio + ',fechaFin:' + fechaFin + ',codEstado:' + codEstado + ',codPro:' + codPro + ',codTServ:' + codTServ + ',codSolCotizacion:' + codSolCotizacion + ',codCotizacion:' + codCotizacion + ',codProv:' + codProv);
                $(tablaCotizaciones).dataTable();
            });

            $('div.busquedaCotizaciones').find('input[name=inicializar]').triggerHandler('click');

            $(tablaCotizaciones).on('click', 'a.detalle', function (e) {
                e.preventDefault();
                var tr = $(this).parents('tr').eq(0);
                var obj = $(tr).data('data');

                // cargando datos
                getData({ url: '<%: Url.Action("InicializarValores", "Cotizacion") %>', data: {} }, function (response) {
                    $('#agregarCotizacion').find('input[name=razsocPro]').val(obj.razsocPro);
                    $('#agregarCotizacion').find('input[name=codProv]').val(obj.codProv);

                    $('#agregarCotizacion').find('input[name=descTServ]').val(obj.descTServ);
                    $('#agregarCotizacion').find('input[name=codTServ]').val(obj.codTServ);

                    $('#agregarCotizacion').find('input[name=fechaInicio]').val(obj.fCotizacion);
                    $('#agregarCotizacion').find('input[name=fechaFin]').val(obj.fValidez);

                    $('#agregarCotizacion').find('textarea[name=Comentarios]').val(obj.Comentarios);
                    $('#agregarCotizacion').find('textarea[name=Comentarios]').attr('disabled', true);

                    $('#agregarCotizacion').find('input[name=codSolCotizacion]').val(obj.codSolCotizacion);

                    $('#agregarCotizacion').find('#codMoneda').val(obj.codMoneda);
                    $('#agregarCotizacion').find('#codMoneda').attr('disabled', true);
                    $('#agregarCotizacion').find('#codFormPag').val(obj.codFormPag);
                    $('#agregarCotizacion').find('#codFormPag').attr('disabled', true);

                    $('#agregarCotizacion').find('input[name=codCotizacion]').val(obj.codCotizacion);
                    $('#agregarCotizacion').find('input[name=codigoCotizacion]').val(obj.codCotizacion);
                    $('#agregarCotizacion').find('input[name=estado]').val(obj.estado);

                    $('#agregarCotizacion').find('a.buscarSolicitudCotizacion').hide();
                    if (obj.pdfCotizacion.length == 0) $('#agregarCotizacion').find('a.archivoAdjunto').hide();
                    else {
                        $('#agregarCotizacion').find('a.archivoAdjunto').attr('href', obj.pdfCotizacion);
                        $('#agregarCotizacion').find('a.archivoAdjunto').show();
                    }

                    $('#agregarCotizacion').find('input[name=fechaInicio]').data("kendoDatePicker").enable(false);
                    $('#agregarCotizacion').find('input[name=fechaFin]').data("kendoDatePicker").enable(false);
                    $('#agregarCotizacion').find('.controles').hide();
                    $('#agregarCotizacion').data("kendoWindow").open();
                });
            })

            $(tablaCotizaciones).bind('rowloaded', function (e, p) {
                var tr = p.tr;
                var obj = p.obj;
                if (obj.estado == 'Anulado') $(tr).find('input.check').hide();
            });

            $(tablaCotizaciones).bind('finished', function (e, p) {
                if (p.count > 0) {
                    //$('div.solicitudes').show();
                    $('#imprimirCotizacion').removeAttr('disabled');
                } else {
                    //$('div.solicitudes').hide();
                    msgBox("No existen registros de cotización", "Información del Sistema");
                    $('#imprimirCotizacion').attr('disabled', true);
                }
            });

            $('#nuevoCotizacion').click(function () {
                getData({ url: '<%: Url.Action("InicializarValores", "Cotizacion") %>', data: {} }, function (response) {
                    $('#agregarCotizacion').find('div.detalles').find('table.dataTable tbody').find('tr:not(.model)').remove();
                    $('#agregarCotizacion').find('div.detalles').find('table.dataTable tfoot td.monto').text('');

                    $('#agregarCotizacion').find('input[name=razsocPro]').val('');
                    $('#agregarCotizacion').find('input[name=codProv]').val(0);

                    $('#agregarCotizacion').find('input[name=descTServ]').val('');
                    $('#agregarCotizacion').find('input[name=fechaInicio]').val('');
                    $('#agregarCotizacion').find('input[name=fechaFin]').val('');

                    $('#agregarCotizacion').find('textarea[name=Comentarios]').val('');
                    $('#agregarCotizacion').find('textarea[name=Comentarios]').removeAttr('disabled');

                    $('#agregarCotizacion').find('input[name=codSolCotizacion]').val('');

                    $('#agregarCotizacion').find('#codMoneda').removeAttr('disabled');
                    $('#agregarCotizacion').find('#codFormPag').removeAttr('disabled');

                    $('#agregarCotizacion').find('input[name=codCotizacion]').val(0);
                    $('#agregarCotizacion').find('input[name=codigoCotizacion]').val('');
                    $('#agregarCotizacion').find('input[name=estado]').val('');
                    $('#agregarCotizacion').find('a.buscarSolicitudCotizacion').show();
                    $('#agregarCotizacion').find('a.archivoAdjunto').hide();

                    $('#agregarCotizacion').find('input[name=fechaInicio]').data("kendoDatePicker").enable(true);
                    $('#agregarCotizacion').find('input[name=fechaFin]').data("kendoDatePicker").enable(true);
                    $('#agregarCotizacion').find('.controles').show();
                    $('#agregarCotizacion').find('input[name=adjuntarArchivo]').attr('disabled', true);
                    $('#agregarCotizacion').data("kendoWindow").open();
                });
            });

            $('#modificarCotizacion').click(function () {
                var selector = $(tablaCotizaciones).find('tbody tr:not(.model) input.check:checked');
                if (selector.length == 0) {
                    msgBox("Debe seleccionar una cotización para modificar", "Información del Sistema");
                    return false;
                }

                getData({ url: '<%: Url.Action("InicializarValores", "Cotizacion") %>', data: {} }, function (response) {
                    var obj = $(selector).parents('tr').eq(0).data('data');
                    $('#agregarCotizacion').find('input[name=razsocPro]').val(obj.razsocPro);
                    $('#agregarCotizacion').find('input[name=codProv]').val(obj.codProv);

                    $('#agregarCotizacion').find('input[name=descTServ]').val(obj.descTServ);
                    $('#agregarCotizacion').find('input[name=codTServ]').val(obj.codTServ);

                    $('#agregarCotizacion').find('input[name=fechaInicio]').val(obj.fCotizacion);
                    $('#agregarCotizacion').find('input[name=fechaFin]').val(obj.fValidez);

                    $('#agregarCotizacion').find('textarea[name=Comentarios]').val(obj.Comentarios);
                    $('#agregarCotizacion').find('textarea[name=Comentarios]').removeAttr('disabled');

                    $('#agregarCotizacion').find('input[name=codSolCotizacion]').val(obj.codSolCotizacion);

                    $('#agregarCotizacion').find('#codMoneda').removeAttr('disabled');
                    $('#agregarCotizacion').find('#codMoneda').val(obj.codMoneda);
                    $('#agregarCotizacion').find('#codFormPag').removeAttr('disabled');
                    $('#agregarCotizacion').find('#codFormPag').val(obj.codFormPag);

                    $('#agregarCotizacion').find('input[name=codCotizacion]').val(obj.codCotizacion);
                    $('#agregarCotizacion').find('input[name=codigoCotizacion]').val(obj.codCotizacion);
                    $('#agregarCotizacion').find('input[name=estado]').val(obj.estadoActual);

                    $('#agregarCotizacion').find('a.buscarSolicitudCotizacion').hide();
                    if (obj.pdfCotizacion.length == 0) $('#agregarCotizacion').find('a.archivoAdjunto').hide();
                    else {
                        $('#agregarCotizacion').find('a.archivoAdjunto').attr('href', obj.pdfCotizacion);
                        $('#agregarCotizacion').find('a.archivoAdjunto').show();
                    }

                    $('#agregarCotizacion').find('input[name=fechaInicio]').data("kendoDatePicker").enable(true);
                    $('#agregarCotizacion').find('input[name=fechaFin]').data("kendoDatePicker").enable(true);
                    $('#agregarCotizacion').find('.controles').show();
                    $('#agregarCotizacion').find('input[name=adjuntarArchivo]').removeAttr('disabled');
                    $('#agregarCotizacion').data("kendoWindow").open();
                });

            });

            $('#anularCotizacion').click(function () {
                var selector = $(tablaCotizaciones).find('tbody tr:not(.model) input.check:checked');
                if (selector.length == 0) {
                    msgBox("Debe seleccionar una cotización para anular", "Información del Sistema");
                    return false;
                }

                var obj = $(selector).parents('tr').eq(0).data('data');
                confirmBox("¿Desea anular la Cotización?", "Confirmación", function (response) {
                    if (response == true) {
                        getData({ url: '<%: Url.Action("Anular", "Cotizacion") %>', data: { 'codCotizacion': obj.codCotizacion} }, function (response) {
                            msgBox(response.mensaje, "Información del Sistema");
                            if (!response.error) {
                                $(tablaCotizaciones).dataTable();
                            }
                        })
                    }
                });
            });

            $('#imprimirCotizacion').click(function () {
                var fechaInicio = $('div.busquedaCotizaciones').find('input[name=fechaInicio]').val();
                var fechaFin = $('div.busquedaCotizaciones').find('input[name=fechaFin]').val();

                var tipoFecha = $('div.busquedaCotizaciones').find('select[name=tipoFecha]').val();
                if ((fechaInicio.length == 0 || fechaFin.length == 0) && tipoFecha == 'todos') {
                    msgBox("Debe ingresar las fechas de búsqueda.", "Información del Sistema");
                    return false;
                }

                var codPro = parseFloat($('div.busquedaCotizaciones').find('select[name=codPro]').val());
                var nomPro = $('div.busquedaCotizaciones').find('select[name=codPro] option:selected').text();

                var codTServ = parseFloat($('div.busquedaCotizaciones').find('select[name=codTServ]').val());
                var descTServ = $('div.busquedaCotizaciones').find('select[name=codTServ] option:selected').text()

                var codEstado = $('div.busquedaCotizaciones').find('select[name=codEstado]').val();
                var desEstado = $('div.busquedaCotizaciones').find('select[name=codEstado] option:selected').text();

                var codSolCotizacion = $('div.busquedaCotizaciones').find('input[name=codSolCotizacion]').val();
                var codCotizacion = $('div.busquedaCotizaciones').find('input[name=codCotizacion]').val();

                var codProv = $('div.busquedaCotizaciones').find('input[name=codProv]').val();
                var razsocPro = $('div.busquedaCotizaciones').find('input[name=razsocPro]').val();
                location.href = '<%: Url.Content("~/Cotizacion/ExportarCotizaciones") %>' + '?codCotizacion=' + codCotizacion + '&codSolCotizacion=' + codSolCotizacion + '&codEstado=' + codEstado + '&desEstado=' + desEstado + '&codTServ=' + codTServ + '&descTServ=' + descTServ + '&codPro=' + codPro + '&nomPro=' + nomPro + '&tipoFecha=' + tipoFecha + '&fechaInicio=' + fechaInicio + '&fechaFin=' + fechaFin + '&codProv=' + codProv + '&razsocPro=' + razsocPro;
            });

            $('div.busquedaCotizaciones').find('select[name=tipoFecha]').change(function () {
                if ($(this).val() == 'todos') {
                    $('div.busquedaCotizaciones').find('input[name=fechaInicio]').data("kendoDatePicker").enable(false);
                    $('div.busquedaCotizaciones').find('input[name=fechaFin]').data("kendoDatePicker").enable(false);
                } else {
                    $('div.busquedaCotizaciones').find('input[name=fechaInicio]').data("kendoDatePicker").enable(true);
                    $('div.busquedaCotizaciones').find('input[name=fechaFin]').data("kendoDatePicker").enable(true);
                }
            });

            // Buscar Proveedores para el filtro de Cotizaciones
            $('div.busquedaCotizaciones').find('a.buscarProveedor').click(function (e) {
                e.preventDefault();
                $('#buscarProveedores').find('a.onload').attr('href', '<%: Url.Action("listar", "Proveedor") %>');
                $('#buscarProveedores').find('input[name=codTServ]').val(0);
                $('#buscarProveedores').find('input[name=codReq]').val(0);
                $('#buscarProveedores').find('input[name=formulario]').val('BusquedaCotizacion');
                $('#buscarProveedores').find('input[name=multiSelect]').val('false');
                $('#buscarProveedores').find('.calificacion').hide();
                $('#buscarProveedores').data("kendoWindow").open();
            });

        });
    </script>
    <div class="contenido-top">
        <div>
            <div class="areas-negocios">
                <div class="lista-central">
                    <div class="busquedaCotizaciones">
                        <fieldset>
                            <legend>Filtros</legend>
                            <div style="display: inline-block; margin-right: 20px;">
                                <table>
                                    <tr>
                                        <td>
                                            Proyecto:
                                        </td>
                                        <td colspan="3">
                                            <%: Html.DropDownList("IdProyecto", new SelectList(GYM.SIG.Business.ProyectoCN.Instancia.listartodos(true), "codPro", "nomPro")) %>
                                        </td>
                                        <td>
                                            Situación:
                                        </td>
                                        <td>
                                            <%: Html.DropDownList("IdEstado", new SelectList(GYM.SIG.Business.EstadoCN.Instancia.listartodos("C", true), "codEstado", "desEstado"))%>
                                        </td>
                                        <td>
                                            Tipo de Fecha:
                                        </td>
                                        <td>
                                            <select name="tipoFecha">
                                                <option value="todos">- Todos -</option>
                                                <option value="fechaCotizacion">Fecha de Cotización</option>
                                                <option value="fechaVencimiento">Fecha de Validez</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Proveedor:
                                        </td>
                                        <td colspan="3">
                                            <div class="input-prepend">
                                                <input type="text" name="razsocPro" style="width: 220px;" readonly />
                                                <input type="hidden" name="codProv" value="0" />
                                                <a href="#" class="buscarProveedor"><span class="add-on"><i class="icon-search"></i>
                                                </span></a>
                                            </div>
                                        </td>
                                        <td>
                                            Tipo de Servicio:
                                        </td>
                                        <td>
                                            <%: Html.DropDownList("IdTipoServicio", new SelectList(GYM.SIG.Business.TipoServicioCN.Instancia.listartodos(true), "codTServ", "descTServ"))%>
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
                                            Nro Coti.:
                                        </td>
                                        <td>
                                            <input type="text" name="codCotizacion" class="digits" style="width: 80px;" maxlength="5" />
                                        </td>
                                        <td>
                                            Nro Sol. Coti.:
                                        </td>
                                        <td>
                                            <input type="text" name="codSolCotizacion" class="digits" style="width: 80px;" maxlength="5" />
                                        </td>
                                        <td colspan="2">
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
                    <div class="contenedorCotizaciones" style="margin-top: 15px; margin-bottom: 10px;">
                        <div class="cotizaciones">
                            <div style="display: inline-block; width: 48%;">
                                <label>
                                    <b>Cotizaciones</b></label></div>
                            <div style="display: inline-block; width: 50%; margin-bottom: 5px;" align="right">
                                <input type="button" id="nuevoCotizacion" name="nuevo" value="Nuevo" />&nbsp;&nbsp;
                                <input type="button" id="modificarCotizacion" name="modificar" value="Modificar" />&nbsp;&nbsp;
                                <input type="button" id="anularCotizacion" name="anular" value="Anular" />&nbsp;&nbsp;
                                <input type="button" id="imprimirCotizacion" name="imprimir" value="Ver Reporte"
                                    disabled="true" />
                            </div>
                            <table class="dataTable table table-bordered" shownumberrows="true">
                                <thead>
                                    <tr>
                                        <th class="model">
                                            <a href="<%: Url.Action("BuscarCotizaciones", "Cotizacion") %>" class="onload" root="data"
                                                data-params=""></a>
                                        </th>
                                        <th>
                                            Sel
                                        </th>
                                        <th>
                                            Detalle
                                        </th>
                                        <th>
                                            <a href="" class="order" data-orderby="codSolCotizacion">Nro Sol.</a>
                                        </th>
                                        <th>
                                            <a href="" class="order" data-orderby="fechaInicio">Fecha Cotización</a>
                                        </th>
                                        <th>
                                            <a href="" class="order" data-orderby="descTServ">Tipo Servicio</a>
                                        </th>
                                        <th>
                                            <a href="" class="order" data-orderby="codCotizacion">Nro Sol Cot.</a>
                                        </th>
                                        <th>
                                            <a href="" class="order" data-orderby="razsocPro">Proveedor</a>
                                        </th>
                                        <th>
                                            <a href="" class="order" data-orderby="fechaFin">Fecha Validez</a>
                                        </th>
                                        <th>
                                            <a href="" class="order" data-orderby="abrvMon">Moneda</a>
                                        </th>
                                        <th>
                                            <a href="" class="order" data-orderby="monto">Importe</a>
                                        </th>
                                        <th>
                                            <a href="" class="order" data-orderby="estado">Situación</a>
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
                                            <a href="#" class="detalle">Ver Detalle</a>
                                        </td>
                                        <td class="codSolCotizacion">
                                        </td>
                                        <td class="fCotizacion">
                                        </td>
                                        <td class="descTServ">
                                        </td>
                                        <td class="codCotizacion">
                                        </td>
                                        <td class="razsocPro">
                                        </td>
                                        <td class="fValidez">
                                        </td>
                                        <td class="abrvMon">
                                        </td>
                                        <td class="monto">
                                        </td>
                                        <td class="estado">
                                        </td>
                                    </tr>
                                    <tr style="height: 32px;">
                                        <td style="text-align: center;">
                                        </td>
                                        <td>
                                        </td>
                                        <td class="codSolCotizacion">
                                        </td>
                                        <td class="fCotizacion">
                                        </td>
                                        <td class="descTServ">
                                        </td>
                                        <td class="codCotizacion">
                                        </td>
                                        <td class="razsocPro">
                                        </td>
                                        <td class="fValidez">
                                        </td>
                                        <td class="abrvMon">
                                        </td>
                                        <td class="monto">
                                        </td>
                                        <td class="estado">
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
    <% Html.RenderPartial("AgregarCotizacion"); %>
    <% Html.RenderPartial("../Proveedor/BuscarProveedor"); %>
</asp:Content>
