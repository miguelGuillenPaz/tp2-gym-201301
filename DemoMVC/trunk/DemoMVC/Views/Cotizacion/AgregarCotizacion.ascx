<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<script type="text/javascript">

    $(document).ready(function () {

        var detallesCotizacion = $('#agregarCotizacion').find('div.detalles').find('table.dataTable');

        $('#agregarCotizacion').bind('open', function (e) {
            var codCotizacion = parseFloat($('#agregarCotizacion').find('input[name=codCotizacion]').val());
            if (codCotizacion > 0) {
                getData({ url: '<%: Url.Action("DetallesCotizacion", "Cotizacion") %>', data: { 'codSolCotizacion': 0, 'codCotizacion': codCotizacion, 'tomarSession': false }, dataType: 'html' }, function (response) {
                    $(detallesCotizacion).find('tbody').html(response);

                    var monto = 0;
                    $(detallesCotizacion).find('tbody tr:not(.numRegistros)').each(function () {
                        monto += parseFloat($(this).find('td.importe').text());
                    });
                    $(detallesCotizacion).find('tfoot td.monto').text(monto);
                });
            }
        });

        $('#agregarCotizacion').find('input[name=grabarCotizacion]').click(function () {
            var editando = $('#agregarCotizacion').find('input[name=editando]').val();
            if (editando == 'true') {
                msgBox("Debe finalizar la edición de precios de los detalles de cotización.", "Información del Sistema");
                return false;
            }

            var fechaInicio = $.trim($('#agregarCotizacion').find('input[name=fechaInicio]').val());
            if (fechaInicio.length == 0) {
                msgBox("Debe seleccionar una fecha de registro para la cotización.", "Información del Sistema");
                return false;
            }

            var fechaValidez = $.trim($('#agregarCotizacion').find('input[name=fechaFin]').val());
            if (fechaValidez.length == 0) {
                msgBox("Debe seleccionar la fecha de validez para la cotización.", "Información del Sistema");
                return false;
            }

            var dias = obtenerDias(fechaInicio, fechaValidez);
            if (dias < 0) {
                msgBox("La fecha de validez debe ser mayor o igual a la fecha de registro.", "Información del Sistema");
                return false;
            }

            var codSolCotizacion = $('#agregarCotizacion').find('input[name=codSolCotizacion]').val();
            if (codSolCotizacion.length == 0) {
                msgBox("Debe seleccionar un tipo de servicio.", "Información del Sistema");
                return false;
            }

            var detallesAdicionados = $(detallesCotizacion).find('tbody tr:not(.model)').length;
            if (detallesAdicionados == 0) {
                msgBox("Debe adicionar los detalles a la cotización.", "Información del Sistema");
                return false;
            }

            var Comentarios = $.trim($('#agregarCotizacion').find('textarea[name=Comentarios]').val());
            var codProv = $('#agregarCotizacion').find('input[name=codProv]').val();
            var codTServ = $('#agregarCotizacion').find('input[name=codTServ]').val();
            var codFormPag = $('#agregarCotizacion').find('select[name=codFormPag]').val();
            var codMoneda = $('#agregarCotizacion').find('select[name=codMoneda]').val();

            var codCotizacion = $('#agregarCotizacion').find('input[name=codCotizacion]').val();
            $('#agregarCotizacion').find('input[name=grabarCotizacion]').attr('disabled', true);
            getData({ url: '<%: Url.Action("Grabar", "Cotizacion") %>', data: { 'codCotizacion': codCotizacion, 'codSolCotizacion': codSolCotizacion, 'fechaInicio': fechaInicio, 'codProv': codProv, 'codFormPag': codFormPag, 'codMoneda': codMoneda, 'codTServ': codTServ, 'Comentarios': Comentarios, 'fechaValidez': fechaValidez} }, function (response) {
                $('#agregarCotizacion').find('input[name=grabarCotizacion]').removeAttr('disabled');
                msgBox(response.mensaje, "Información del Sistema");
                if (!response.error) {
                    $('#agregarCotizacion').find('input[name=codigoCotizacion]').val(response.codCotizacion);
                    $('#agregarCotizacion').find('input[name=codCotizacion]').val(response.codCotizacion);
                    $('#agregarCotizacion').find('input[name=adjuntarArchivo]').removeAttr('disabled');

                    $('div.contenedorCotizaciones').find('div.cotizaciones').find('table.dataTable').dataTable();
                }
            });
        });

        $('#agregarCotizacion').find('a.buscarSolicitudCotizacion').click(function (e) {
            e.preventDefault();
            $('#buscarSolicitudes').data("kendoWindow").open();
        });

        // Editar precios y cantidades de detalles de cotizacion
        $('#agregarCotizacion').find('a.actualizar').click(function (e) {
            e.preventDefault();
            $('#agregarCotizacion').find('input[name=editando]').val('true');
            $(detallesCotizacion).find('tbody tr:not(.model)').each(function () {
                var input = document.createElement("input");
                $(input).numeric({ negative: false }, function () { alert("No negative values"); this.value = ""; this.focus(); });
                //$(input).mask("99.99", { placeholder: " " });
                $(input).css('width', '70px');
                $(input).css('text-align', 'right');
                $(input).attr('maxlength', '12');
                $(input).attr('type', 'text');
                $(input).val($(this).find('td.precio').text());
                $(input).attr('precio', $(this).find('td.precio').text());
                $(this).find('td.precio').html(input);
            });
            $(detallesCotizacion).find('input[type=text]').eq(0).focus();
        });

        // Grabar precios y cantidades editados de detalles de cotizacion
        $('#agregarCotizacion').find('a.guardar').click(function (e) {
            e.preventDefault();
            var editando = $('#agregarCotizacion').find('input[name=editando]').val();
            if (editando == 'true') {
                var lista = new Array();
                var monto = 0, mensaje = '';
                $(detallesCotizacion).find('tbody tr:not(.numRegistros)').each(function () {
                    var precio = $(this).find('td.precio input').val();
                    if (precio != undefined) {
                        if (precio.split('.')[1] != undefined && $.trim(precio.split('.')[1]).length > 2) {
                            mensaje = 'El precio del detalle Nº ' + $.trim($(this).find('td.numero').text()) + ' sobrepasa los 2 decimales.';
                            return false;
                        }
                    } else {
                        precio = $(this).find('td.precio').text();
                    }

                    precio = parseFloat(precio);
                    var cantidad = parseFloat($(this).find('td.cantidad').text());
                    var importe = cantidad * precio;
                    $(this).find('td.precio').html(precio.toFixed(2));
                    $(this).find('td.importe').html(importe.toFixed(2));

                    var codSolCotizacion = $(this).find('input.codSolCotizacion').val();
                    var codSolDet = $(this).find('input.codSolDet').val();
                    lista.push({ 'codSolCotizacion': codSolCotizacion, 'codSolDet': codSolDet, 'precio': precio });
                    monto += importe;
                });

                if (mensaje.length > 0) {
                    msgBox(mensaje, "Información del Sistema");
                } else {
                    $('#agregarCotizacion').find('input[name=editando]').val('false');
                    getData({ url: '<%: Url.Action("ActualizarDetalles", "Cotizacion") %>', data: { 'lista': lista, 'length': lista.length} }, function (response) {
                        if (!response.error) {
                            $(detallesCotizacion).find('tfoot td.monto').text(monto.toFixed(2));
                        } else {
                            msgBox("No se pudo actualizar los precios de la cotización.", "Información del Sistema");
                        }
                    });
                }
            }
        });

        $('#agregarCotizacion').find('a.eliminar').click(function (e) {
            e.preventDefault();

            var detalleSeleccionado = $(detallesCotizacion).find('tbody tr:not(.model) input.check:checked');
            if (detalleSeleccionado.length > 0) {
                confirmBox("¿Desea eliminar el detalle seleccionado?", "Confirmación", function (response) {
                    if (response == true) {
                        var tr = $(detalleSeleccionado).parents('tr').eq(0);
                        var codSolCotizacion = $(tr).find('input.codSolCotizacion').val();
                        var codSolDet = $(tr).find('input.codSolDet').val();
                        getData({ url: '<%: Url.Action("EliminarDetalle", "Cotizacion") %>', data: { 'codSolCotizacion': codSolCotizacion, 'codSolDet': codSolDet} }, function (response) {
                            msgBox(response.mensaje, "Información del Sistema");
                            if (!response.error) {
                                getData({ url: '<%: Url.Action("DetallesCotizacion", "Cotizacion") %>', data: { 'codSolCotizacion': 0, 'tomarSession': true }, dataType: 'html' }, function (response) {
                                    $(detallesCotizacion).find('tbody').html(response);

                                    var monto = 0;
                                    $(detallesCotizacion).find('tbody tr:not(.numRegistros)').each(function () {
                                        monto += parseFloat($(this).find('td.importe').text());
                                    });
                                    $(detallesCotizacion).find('tfoot td.monto').text(monto.toFixed(2));
                                });
                            }
                        });
                    }
                });
            } else {
                msgBox("No ha seleccionado ningún elemento", "Información del Sistema");
            }
        });

        $('#agregarCotizacion').find('a.cancelar').click(function (e) {
            e.preventDefault();
            var editando = $('#agregarCotizacion').find('input[name=editando]').val();
            if (editando == 'true') {
                $('#agregarCotizacion').find('input[name=editando]').val('false');

                $(detallesCotizacion).find('tbody tr:not(.numRegistros)').each(function () {
                    var cantidad = parseFloat($(this).find('td.cantidad').text());
                    var precio = parseFloat($(this).find('td.precio input').attr('precio'));
                    var importe = cantidad * precio;
                    $(this).find('td.precio').html(precio.toFixed(2));
                    $(this).find('td.importe').html(importe.toFixed(2));
                });
            }
        });

        $('#agregarCotizacion').find('input[name=salirCotizacion]').click(function () {
            $('#agregarCotizacion').data("kendoWindow").close();
        });

        $('#agregarCotizacion').find('input[name=adjuntarArchivo]').click(function () {
            var codCotizacion = $('#agregarCotizacion').find('input[name=codCotizacion]').val();
            if (codCotizacion == 0) {
                msgBox("Debe registrar la cotización.", "Información del Sistema");
                return false;
            }

            var codSolCotizacion = $('#agregarCotizacion').find('input[name=codSolCotizacion]').val();
            $('#adjuntarArchivo').find('input[name=codSolCotizacion]').val(codSolCotizacion);
            $('#adjuntarArchivo').find('input[name=codCotizacion]').val(codCotizacion);
            $('#adjuntarArchivo').data("kendoWindow").open();
        });

        $(detallesCotizacion).on('click', 'input.check', function (e) {
            if ($(this).is(':checked')) {
                $(detallesCotizacion).find('input.check').prop('checked', false);
                $(this).prop('checked', true);
            }
        });

        // Ordernar tablas de proveedores y requerimientos
        $(detallesCotizacion).on('click', 'th a.orderDinamyc', function (e) {
            e.preventDefault();
            var table = $(this).parents("table.dataTable").eq(0);
            var orderby = $(this).attr("data-orderby")
            var order = $(this).attr("data-order") || undefined;
            $(table).find("thead th a.order").removeAttr("data-order");
            if (order == undefined) order = 'asc';
            else if (order == 'asc') order = 'desc';
            else if (order == 'desc') order = undefined;
            if (order == undefined) $(this).removeAttr("data-order");
            else $(this).attr("data-order", order);

            // ordenar tabla
            getData({ url: '<%: Url.Action("DetallesCotizacion", "Cotizacion") %>', data: { 'codSolCotizacion': 0, 'tomarSession': true, 'order': order, 'orderby': orderby }, dataType: 'html' }, function (response) {
                $('#agregarCotizacion').find('div.detalles table.dataTable tbody').html(response);
            });
        });

    });

</script>
<div class="dialog" title="Cotización de Servicios" id="agregarCotizacion">
    <div style="padding: 6px;">
        <div>
            <table>
                <tr>
                    <td>
                        Nro Cot.:
                    </td>
                    <td>
                        <input type="text" name="codigoCotizacion" style="width: 70px;" readonly value="" />
                    </td>
                    <td>
                        Nro Sol. Cot.:
                    </td>
                    <td>
                        <div class="input-prepend">
                            <input type="text" name="codSolCotizacion" style="width: 70px;" readonly value="" />
                            <a href="#" class="buscarSolicitudCotizacion"><span class="add-on"><i class="icon-search">
                            </i></span></a>
                        </div>
                    </td>
                    <td>
                        Fecha Cot.:
                    </td>
                    <td>
                        <input type="text" name="fechaInicio" class="datepicker" style="width: 110px;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Tipo de Servicio:
                    </td>
                    <td>
                        <input type="text" name="descTServ" readonly />
                        <input type="hidden" name="codTServ" value="0" />
                    </td>
                    <td>
                        Proveedor:
                    </td>
                    <td colspan="3">
                        <input type="text" name="razsocPro" readonly style="width: 310px;" />
                        <input type="hidden" name="codProv" value="0" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Moneda:
                    </td>
                    <td>
                        <%: Html.DropDownList("IdMoneda", new SelectList(GYM.SIG.Business.MonedaCN.Instancia.listartodos(), "codMoneda", "descMon"))%>
                    </td>
                    <td>
                        Forma de Pago:
                    </td>
                    <td>
                        <%: Html.DropDownList("IdFormaPago", new SelectList(GYM.SIG.Business.FormaPagoCN.Instancia.listartodos(), "codFormPag", "desFormPag"))%>
                    </td>
                    <td>
                        Fecha Validez:
                    </td>
                    <td>
                        <input type="text" name="fechaFin" class="datepicker" style="width: 110px;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Comentario:
                    </td>
                    <td colspan="3">
                        <textarea tabindex="0" name="Comentarios" class="firstelement" placeholder="Ingrese un comentario a la cotización"
                            maxlength="300" rows="" cols="" style="width: 460px; height: 60px;"></textarea>
                    </td>
                    <td>
                        Situación:
                    </td>
                    <td>
                        <input type="text" name="estado" style="width: 100px;" readonly />
                    </td>
                </tr>
            </table>
        </div>
        <hr style="margin: 10px 0 !important;" />
        <div class="detalles" style="margin-top: 15px;">
            <div style="display: inline-block">
                <label>
                    <b>Detalle de Cotización</b></label>
                <table class="dataTable table table-bordered">
                    <thead>
                        <tr>
                            <th>
                                Sel
                            </th>
                            <th>
                                Nº
                            </th>
                            <th>
                                <a href="" class="orderDinamyc" data-orderby="nomPro">Proyecto</a>
                            </th>
                            <th>
                                <a href="" class="orderDinamyc" data-orderby="codReq">Nº Req</a>
                            </th>
                            <th>
                                Sec Req
                            </th>
                            <th>
                                Descripción
                            </th>
                            <th>
                                <a href="" class="orderDinamyc" data-orderby="descUM">Unidad Medida</a>
                            </th>
                            <th>
                                <a href="" class="orderDinamyc" data-orderby="cantidad">Cantidad</a>
                            </th>
                            <th>
                                <a href="" class="orderDinamyc" data-orderby="precio">Precio Unit</a>
                            </th>
                            <th>
                                <a href="" class="orderDinamyc" data-orderby="importe">Importe</a>
                            </th>
                        </tr>
                    </thead>
                    <tfoot>
                        <tr>
                            <td colspan="9" style="text-align: right; font-weight: bold;">
                                Total
                            </td>
                            <td class="monto" style="text-align: right; font-weight: bold;">
                            </td>
                        </tr>
                    </tfoot>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div class="controles" style="display: inline-block; vertical-align: top; margin-left: 10px;
                margin-top: 20px;">
                <a href="" title="Actualizar precios de los detalles" class="actualizar"><i class="icon-pencil">
                </i></a>
                <br />
                <a href="" title="Eliminar item" class="eliminar"><i class="icon-trash"></i></a>
                <br />
                <a href="" title="Guardar cambios en precios" class="guardar">
                    <img src="../../Img/save.png" style="width: 16px; height: 16px;" alt="" /></a><br />
                <a href="" title="Cancelar cambios hechos" class="cancelar"><i class="icon-ban-circle">
                </i></a>
            </div>
        </div>
        <div style="margin-top: 5px;">
            <div style="display: inline-block; width: 40%">
                <input type="button" class="controles" name="adjuntarArchivo" value="Adjuntar" title="Adjuntar archivo" />&nbsp;&nbsp;
                <input type="button" class="controles" name="grabarCotizacion" value="Grabar" title="Grabar cotización" />&nbsp;&nbsp;
                <input type="button" name="salirCotizacion" value="Salir" title="Salir del formulario" />
                <input type="hidden" name="codCotizacion" value="0" />
                <input type="hidden" name="editando" value="false" />
            </div>
            <div style="display: inline-block; width: 20%; text-align: right;">
                <a class="archivoAdjunto" target="_blank" title="Descargar archivo pdf de cotización"
                    href=""><i class="icon-file"></i>&nbsp;Ver Archivo</a></div>
        </div>
        <div align="center" style="margin-top: 8px; display: none;" class="enviandoSolicitud">
            <div style="display: inline-block; vertical-align: middle;">
                Registrado cotización&nbsp;</div>
            <div style="display: inline-block; vertical-align: middle;">
                <img alt="" src="../../Img/loading.gif" /></div>
        </div>
    </div>
</div>
<% Html.RenderPartial("../Cotizacion/BuscarSolicitud"); %>
<% Html.RenderPartial("../Cotizacion/AdjuntarArchivo"); %>