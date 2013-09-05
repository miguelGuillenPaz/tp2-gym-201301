<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<script type="text/javascript">

    $(document).ready(function () {

        var requerimientosSolicitud = $('#agregarSolicitudCotizacion').find('div.requerimientos').find('table.dataTable');
        var proveedoresSolicitud = $('#agregarSolicitudCotizacion').find('div.proveedores').find('table.dataTable');

        $('#agregarSolicitudCotizacion').bind('open', function (e) {
            var codSolCotizacion = parseFloat($('#agregarSolicitudCotizacion').find('input[name=codSolCotizacion]').val());
            if (codSolCotizacion > 0) {
                getData({ url: '<%: Url.Action("ObtenerDeSolicitud", "Proveedor") %>', data: { 'codSolCotizacion': codSolCotizacion }, dataType: 'html' }, function (response) {
                    $(proveedoresSolicitud).find('tbody').html(response);
                });

                getData({ url: '<%: Url.Action("ObtenerDeSolicitud", "Requerimiento") %>', data: { 'codSolCotizacion': codSolCotizacion }, dataType: 'html' }, function (response) {
                    $(requerimientosSolicitud).find('tbody').html(response);
                });
            }
        });

        $(requerimientosSolicitud).on('click', 'input.check', function (e) {
            if ($(this).is(':checked')) {
                $(requerimientosSolicitud).find('input.check').prop('checked', false);
                $(this).prop('checked', true);
            }
        });

        $('#agregarSolicitudCotizacion').find('input[name=salirSolicitud]').click(function () {
            $('#agregarSolicitudCotizacion').data("kendoWindow").close();
        });

        $('#agregarSolicitudCotizacion').find('input[name=grabarSolicitud]').click(function () {
            var fecSolCotizacino = $.trim($('#agregarSolicitudCotizacion').find('input[name=fecSolCotizacino]').val());
            if (fecSolCotizacino.length == 0) {
                msgBox("Debe seleccionar una fecha de registro para la solictud de cotización.", "Información del Sistema");
                return false;
            }

            var fechaVencimiento = $.trim($('#agregarSolicitudCotizacion').find('input[name=fechaVencimiento]').val());
            if (fechaVencimiento.length == 0) {
                msgBox("Debe seleccionar la fecha de vencimiento para la solictud de cotización.", "Información del Sistema");
                return false;
            }

            var dias = obtenerDias(fecSolCotizacino, fechaVencimiento);
            if (dias < 0) {
                msgBox("La fecha de vencimiento debe ser mayor o igual a la fecha de registro.", "Información del Sistema");
                return false;
            }

            var codTServ = parseFloat($('#agregarSolicitudCotizacion').find('select[name=codTServ]').val());
            if (codTServ == 0) {
                msgBox("Debe seleccionar un tipo de servicio.", "Información del Sistema");
                return false;
            }

            var requerimientosSeleccionados = $(requerimientosSolicitud).find('tbody tr:not(.model)').length;
            if (requerimientosSeleccionados == 0) {
                msgBox("Debe adicionar requerimientos para grabar la solictitud de cotización.", "Información del Sistema");
                return false;
            }

            var descSolCotizacion = $.trim($('#agregarSolicitudCotizacion').find('textarea[name=descSolCotizacion]').val());
            var codSolCotizacion = $('#agregarSolicitudCotizacion').find('input[name=codSolCotizacion]').val();
            $('#agregarSolicitudCotizacion').find('input[name=grabarSolicitud]').attr('disabled', true);
            getData({ url: '<%: Url.Action("Grabar", "SolicitudCotizacion") %>', data: { 'codSolCotizacion': codSolCotizacion, 'fecSolCotizacino': fecSolCotizacino, 'codTServ': codTServ, 'descSolCotizacion': descSolCotizacion, 'fechaVencimiento': fechaVencimiento} }, function (response) {
                $('#agregarSolicitudCotizacion').find('input[name=grabarSolicitud]').removeAttr('disabled');
                msgBox(response.mensaje, "Información del Sistema");
                if (!response.error) {
                    $('#agregarSolicitudCotizacion').find('input[name=enviarSolicitud]').removeAttr('disabled');

                    $('#agregarSolicitudCotizacion').find('input[name=codSolCotizacion]').val(response.codSolCotizacion);
                    $('#agregarSolicitudCotizacion').find('input[name=codigoSolicitud]').val(response.codSolCotizacion);
                }
            });
        });

        $('#agregarSolicitudCotizacion').find('div.requerimientos').find('a.eliminar').click(function (e) {
            e.preventDefault();
            var inputSelector = $(requerimientosSolicitud).find('tbody tr:not(.model) input.check:checked');
            if (inputSelector.length == 0) {
                msgBox("Debe seleccionar algún requerimiento.", "Información del Sistema");
                return false;
            } else {
                confirmBox("¿Desea eliminar al requerimiento seleccionado?", "Confirmación", function (response) {
                    if (response == true) {
                        var codReq = parseFloat($(inputSelector).parents('tr').eq(0).find('td.codReq').text());
                        var codcorDetReq = $(inputSelector).parents('tr').eq(0).find('input[name=codcorDetReq]').val()
                        var codPro = $(inputSelector).parents('tr').eq(0).find('input[name=codPro]').val()

                        var codSolCotizacion = $(inputSelector).parents('tr').eq(0).find('input[name=codSolCotizacion]').val()
                        var codSolDet = $(inputSelector).parents('tr').eq(0).find('input[name=codSolDet]').val()
                        getData({ url: '<%: Url.Action("EliminarRequerimiento", "SolicitudCotizacion") %>', data: { 'codReq': codReq, 'codcorDetReq': codcorDetReq, 'codPro': codPro, 'codSolCotizacion': codSolCotizacion, 'codSolDet': codSolDet} }, function (response) {
                            if (!response.error) {
                                $(inputSelector).parents('tr').eq(0).remove();
                                msgBox("El requerimiento ha sido eliminado correctamente.", "Información del Sistema");
                            } else {
                                msgBox(response.mensaje, "Información del Sistema");
                            }
                        });
                    }
                });
            }
        });

        $('#agregarSolicitudCotizacion').find('div.requerimientos').find('a.adicionar').click(function (e) {
            e.preventDefault();
            var codTServ = parseFloat($('#agregarSolicitudCotizacion').find('select[name=codTServ]').val());
            if (codTServ == 0) {
                msgBox("Debe seleccionar un tipo de servicio.", "Información del Sistema");
                return false;
            }

            $('#buscarRequerimientos').find('select[name=codTServ]').val(codTServ);
            $('#buscarRequerimientos').find('select[name=codTServ]').attr('disabled', true);

            $('#buscarRequerimientos').find('input[name=reiniciar]').val('false');
            $('#buscarRequerimientos').data("kendoWindow").open();
        });

        $('#agregarSolicitudCotizacion').find('div.proveedores').find('a.eliminar').click(function (e) {
            e.preventDefault();
            var inputSelector = $(proveedoresSolicitud).find('tbody tr:not(.model) input.check:checked');
            if (inputSelector.length == 0) {
                msgBox("Debe seleccionar el proveedor(es) a eliminar", "Información del Sistema");
            } else {
                confirmBox("¿Desea eliminar al proveedor seleccionado?", "Confirmación", function (response) {
                    if (response == true) {
                        var lista = new Array();
                        $(inputSelector).each(function () {
                            var codProv = $(this).parents('tr').eq(0).find('input[name=codProv]').val();
                            lista.push(codProv);
                        });
                        getData({ url: '<%: Url.Action("EliminarProveedores", "SolicitudCotizacion") %>', data: { 'lista': lista, 'length': lista.length} }, function (response) {
                            if (!response.error) {
                                $(inputSelector).each(function () {
                                    $(this).parents('tr').eq(0).remove();
                                });
                                msgBox("Los proveedor(es) han sido eliminados correctamente.", "Información del Sistema");
                            } else {
                                msgBox(response.mensaje, "Información del Sistema");
                            }
                        });
                    }
                });
            }
        });

        $('#agregarSolicitudCotizacion').find('div.proveedores').find('a.adicionar').click(function (e) {
            e.preventDefault();
            var numRequerimiento = $(requerimientosSolicitud).find('tbody tr:not(.model)').length;
            if (numRequerimiento == 0) {
                msgBox("Debe adicionar requerimientos.", "Información del Sistema");
                return false;
            }

            var codTServ = parseFloat($('#agregarSolicitudCotizacion').find('select[name=codTServ]').val());
            if (codTServ == 0) {
                msgBox("Debe seleccionar un tipo de servicio.", "Información del Sistema");
                return false;
            }

            $('#buscarProveedores').find('input[name=codTServ]').val(codTServ);
            $('#buscarProveedores').find('input[name=codReq]').val(0);
            $('#buscarProveedores').find('input[name=formulario]').val('RegistroSolicitud');
            $('#buscarProveedores').find('input[name=multiSelect]').val('true');
            $('#buscarProveedores').find('a.onload').attr('href', '<%: Url.Action("listaporServicio", "Proveedor") %>');
            $('#buscarProveedores').data("kendoWindow").open();
        });

        // Ordernar tablas de proveedores y requerimientos
        $(proveedoresSolicitud).on('click', 'th a.orderDinamyc', function (e) {
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
            getData({ url: '<%: Url.Action("ObtenerDeSolicitud", "Proveedor") %>', data: { 'order': order, 'orderby': orderby }, dataType: 'html' }, function (response) {
                $('#agregarSolicitudCotizacion div.proveedores').find('table.dataTable tbody').html(response);
            });
        });

        $(requerimientosSolicitud).on('click', 'th a.orderDinamyc', function (e) {
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
            getData({ url: '<%: Url.Action("ObtenerDeSolicitud", "Requerimiento") %>', data: { 'order': order, 'orderby': orderby }, dataType: 'html' }, function (response) {
                $('#agregarSolicitudCotizacion div.requerimientos').find('table.dataTable tbody').html(response);
            });
        });

    });

</script>

<div class="dialog" title="Registro de Solicitud de Cotización" id="agregarSolicitudCotizacion">
    <div style="padding:6px;">
        <div>
            <table>
                <tr>
                    <td>Nro Sol. Cot.:</td>
                    <td><input type="text" name="codigoSolicitud" style="width:70px;" readonly="true" value="" /></td>
                    <td>Fecha Registro:</td>
                    <td><input type="text" name="fecSolCotizacino" class="datepicker" style="width:110px;" /></td>                    
                </tr>
                <tr>
                    <td>Tipo de Servicio:</td>
                    <td><%: Html.DropDownList("codTServ", new SelectList(GYM.SIG.Business.TipoServicioCN.Instancia.listartodos(true), "codTServ", "descTServ"))%></td>
                    <td>Fecha Vencimiento:</td>
                    <td><input type="text" name="fechaVencimiento" class="datepicker" style="width:110px;" /></td>
                </tr>
                <tr>
                    <td>Comentario:</td>
                    <td colspan="3"><textarea tabindex="0" placeholder="Ingrese un comentario a la solicitud" name="descSolCotizacion" maxlength="200" rows="" cols="" style="width:370px; height:60px;"></textarea></td>
                </tr>
            </table>
        </div>
        <hr style="margin:10px 0 !important;" />
        <div class="requerimientos" style="margin-top:15px;">
            <div style="display:inline-block">
                <label><b>Requerimientos</b></label>
                <table class="dataTable table table-bordered">
                    <thead>
                        <tr>
                            <th>Sel</th>
                            <th>Nº</th>
                            <th><a href="" class="orderDinamyc" data-orderby="nomPro">Proyecto</a></th>
                            <th><a href="" class="orderDinamyc" data-orderby="codReq">Nº Req</a></th>
                            <th><a href="" class="orderDinamyc" data-orderby="desReq">Descripción Req.</a></th>
                            <th><a href="" class="orderDinamyc" data-orderby="desServicio">Detalle</a></th>
                            <th><a href="" class="orderDinamyc" data-orderby="descUM">Unidad Medida</a></th>
                            <th><a href="" class="orderDinamyc" data-orderby="canDetReq">Cantidad</a></th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div style="display:inline-block; vertical-align:top; margin-left:10px; margin-top:20px;">
                <a href="" title="Adicionar requerimiento" class="adicionar"><i class="icon-plus"></i></a><br />
                <a href="" title="Eliminar requerimiento" class="eliminar"><i class="icon-trash"></i></a>
            </div>
        </div>
        <div class="proveedores" style="margin-top:15px;">
            <div style="display:inline-block">
                <label><b>Proveedores</b></label>
                <table class="dataTable table table-bordered">
                    <thead>
                        <tr>
                            <th>Sel</th>
                            <th>Nº</th>
                            <th><a href="#" class="orderDinamyc" data-orderby="razsocPro">Proveedor</a></th>
                            <th><a href="#" class="orderDinamyc" data-orderby="rucPro">RUC</a></th>
                            <th><a href="#" class="orderDinamyc" data-orderby="emailProTServ">Email</a></th>
                            <th><a href="#" class="orderDinamyc" data-orderby="contactoProTServ">Contacto</a></th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div style="display:inline-block; vertical-align:top; margin-left:10px; margin-top:20px;">
                <a href="" title="Adicionar proveedor" class="adicionar"><i class="icon-plus"></i></a><br />
                <a href="" title="Eliminar proveedor" class="eliminar"><i class="icon-trash"></i></a>
            </div>
        </div>

        <div style="margin-top:10px;">            
            <input type="button" name="grabarSolicitud" value="Grabar" title="Grabar Solicitud de Cotización" />&nbsp;&nbsp;
            <input type="button" name="salirSolicitud" value="Salir" title="Salir del formulario" />
            <input type="hidden" name="codSolCotizacion" value="0" />
        </div>
        <div align="center" style="margin-top:8px; display:none;" class="enviandoSolicitud">
            <div style="display:inline-block; vertical-align:middle;">Enviando solicitud&nbsp;</div>
            <div style="display:inline-block; vertical-align:middle;"><img alt="" src="../../Img/loading.gif" /></div>
        </div>
    </div>
</div>
<% Html.RenderPartial("../Requerimiento/BuscarRequerimiento"); %>
<% Html.RenderPartial("../Proveedor/BuscarProveedor"); %>