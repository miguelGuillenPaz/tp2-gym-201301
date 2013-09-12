<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<script type="text/javascript">

    $(document).ready(function () {

        var tablaSolicitudes = $('#buscarSolicitudes').find('table.dataTable');

        $('#buscarSolicitudes').bind('open', function () {
            $(tablaSolicitudes).find('tbody tr:not(.model)').remove();
            var filaBlanco = $(tablaSolicitudes).find('tbody tr.model').clone();
            $(filaBlanco).removeClass('model');
            $(filaBlanco).css('height', '32px');
            $(filaBlanco).find('a, input').remove();
            $(tablaSolicitudes).find('tbody').append(filaBlanco);
            $(tablaSolicitudes).find('tfoot').empty();
        });

        $(tablaSolicitudes).bind('finished', function (e, p) {
            if (p.count > 0) {
                $('#buscarSolicitudes').find('input[name=aceptar]').show();
            } else {
                $('#buscarSolicitudes').find('input[name=aceptar]').hide();
                msgBox("No existen registros de solicitudes de cotización", "Información del Sistema");
            }
        });

        $(tablaSolicitudes).on('click', 'input.check', function (e) {
            if ($(this).is(':checked')) {
                $(tablaSolicitudes).find('input.check').prop('checked', false);
                $(this).prop('checked', true);
            }
        });
                
        $('#buscarSolicitudes').find('input[name=salir]').click(function () {
            $('#buscarSolicitudes').data("kendoWindow").close();
        });

        $('#buscarSolicitudes').find('input[name=aceptar]').click(function () {
            var filaSeleccionada = $(tablaSolicitudes).find('tbody tr:not(.model) input.check:checked');
            
            if (filaSeleccionada.length > 0) {
                var obj = $(filaSeleccionada).parents('tr').eq(0).data('data');
                getData({ url: '<%: Url.Action("DetallesCotizacion", "Cotizacion") %>', data: { 'codSolCotizacion': obj.codSolCotizacion, 'tomarSession':false }, dataType: 'html' }, function (response) {
                    $('#agregarCotizacion').find('div.detalles table.dataTable tbody').html(response);
                    $('#agregarCotizacion').find('div.detalles table.dataTable tfoot td.monto').text('0');

                    $('#agregarCotizacion').find('input[name=codSolCotizacion]').val(obj.codSolCotizacion);
                    $('#agregarCotizacion').find('input[name=descTServ]').val(obj.descTServ);
                    $('#agregarCotizacion').find('input[name=IdTipoServicio]').val(obj.codTServ);
                    $('#agregarCotizacion').find('input[name=razsocPro]').val(obj.razsocPro);
                    $('#agregarCotizacion').find('input[name=codProv]').val(obj.codProv);
                    $('#buscarSolicitudes').data("kendoWindow").close();
                });
            } else {
                msgBox("Debe seleccionar una solicitud de cotización", "Información del Sistema");
            }
        });

        $('#buscarSolicitudes').find('input[name=buscar]').click(function () {
            var codTServ = parseFloat($('#buscarSolicitudes').find('select[name=IdTipoServicio] option:selected').val());
            var codProv = $('#buscarSolicitudes').find('input[name=codProv]').val();

            var codSolCotizacion = $('#buscarSolicitudes').find('input[name=codSolCotizacion]').val();
            $(tablaSolicitudes).find('a.onload').attr('data-params', 'codProv:' + codProv + ',codTServ:' + codTServ + ',codSolCotizacion:' + codSolCotizacion);
            $(tablaSolicitudes).dataTable();
        });

        $('#buscarSolicitudes').find('input[name=inicializar]').click(function () {
            $('#buscarSolicitudes').find('select[name=codPro]').val(0);
            $('#buscarSolicitudes').find('select[name=IdTipoServicio]').val(0);
            $('#buscarSolicitudes').find('input[name=codSolCotizacion]').val('');
        });

        $('#buscarSolicitudes').find('a.buscarProveedor').click(function (e) {
            e.preventDefault();
            $('#buscarProveedores').find('a.onload').attr('href', '<%: Url.Action("listar", "Proveedor") %>');
            $('#buscarProveedores').find('input[name=IdTipoServicio]').val(0);
            $('#buscarProveedores').find('input[name=codReq]').val(0);
            $('#buscarProveedores').find('input[name=formulario]').val('BusquedaSolicitud');
            $('#buscarProveedores').find('input[name=multiSelect]').val('false');
            $('#buscarProveedores').find('.calificacion').hide();
            $('#buscarProveedores').data("kendoWindow").open();
        });

    });

</script>

<div class="dialog" id="buscarSolicitudes" title="Búsqueda de Solicitudes de Cotización de Servicios">
    <div style="padding:6px;">
        <fieldset>
            <legend>Filtros</legend>
            <div>
                <div style="display:inline-block; margin-right:10px;">
                    <table>
                        <tr>
                            <td>Proveedor:</td>
                            <td colspan="3">
                                <div class="input-prepend">
                                    <input type="text" name="razsocPro" style="width:220px;" readonly />
                                    <input type="hidden" name="codProv" value="0" />
                                    <a href="#" class="buscarProveedor"><span class="add-on"><i class="icon-search"></i></span></a>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Tipo Servicio:</td>
                            <td><%: Html.DropDownList("IdTipoServicio", new SelectList(GYM.SIG.Business.TipoServicioCN.Instancia.listartodos(true), "codTServ", "descTServ"))%></td>
                            <td>Nro Sol. Cot.:</td>
                            <td><input type="text" name="codSolCotizacion" value="" style="width:80px;" class="digits" maxlength="5" /></td>
                        </tr>
                    </table>
                </div>
                <div style="display:inline-block; vertical-align:top; text-align:center;">
                    <input type="button" name="buscar" value="Buscar" title="Buscar registros de solicitudes de cotización" style="margin-top:5px" /><br />
                    <input type="button" name="inicializar" value="Inicializar" title="Inicializar filtro de busqueda" style="margin-top:5px;" />
                </div>
            </div>
        </fieldset>
        <div style="margin-top:5px;">
            <label><b>Solicitudes</b></label>
            <table class="dataTable table table-bordered" showNumberRows="true" data-limit="6">
                <thead>
                    <tr>
                        <th class="model"><a href="<%: Url.Action("BuscarSolicitudProveedores", "SolicitudCotizacion") %>" class="onload" root="data" data-params=""></a></th>
                        <th></th>
                        <th><a href="" class="order" data-orderby="codSolCotizacion">Nro Sol. Cot.</a></th>
                        <th><a href="" class="order" data-orderby="fechaSolicitud">Fecha de Sol. Cot.</a></th>
                        <th><a href="" class="order" data-orderby="descTServ">Tipo Servicio</a></th>
                        <th><a href="" class="order" data-orderby="razsocPro">Proveedor</a></th>
                    </tr>
                </thead>
                <tfoot></tfoot>
                <tbody>
                    <tr class="model">
                        <td><input type="checkbox" class="check" name="solicitudCheck" /></td>
                        <td class="codSolCotizacion"></td>
                        <td class="fechaSolicitud"></td>
                        <td class="descTServ"></td>
                        <td class="razsocPro"></td>
                    </tr>
                    <tr style="height:32px;">
                        <td></td>
                        <td class="codSolCotizacion"></td>
                        <td class="fechaSolicitud"></td>
                        <td class="descTServ"></td>
                        <td class="razsocPro"></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div style="text-align:right; margin-top:5px;">
            <input type="button" name="aceptar" value="Aceptar" title="Aceptar solicitud de cotización seleccionada" />&nbsp;&nbsp;
            <input type="button" name="salir" value="Salir" title="Salir de formulario" />
            <input type="hidden" name="reiniciar" value="true" />
        </div>
    </div>
</div>