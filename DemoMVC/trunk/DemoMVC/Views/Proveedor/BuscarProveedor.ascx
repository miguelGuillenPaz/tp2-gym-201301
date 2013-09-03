<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<script type="text/javascript">

    $(document).ready(function () {
        var tablaProveedores = $('#buscarProveedores').find('table.dataTable');

        $('#buscarProveedores').find('input[name=buscar]').click(function () {
            var codTServ = $('#buscarProveedores').find('input[name=codTServ]').val();
            var codReq = $('#buscarProveedores').find('input[name=codReq]').val();
            var tipoBusqueda = $('#buscarProveedores').find('input[name=criterio]:checked').val();
            var expresion = $('#buscarProveedores').find('input[name=expresion]').val();
            $(tablaProveedores).find('a.onload').attr('data-params', 'tipoBusqueda:' + tipoBusqueda + ', expresion:' + expresion + ',codTServ:' + codTServ + ',codReq:' + codReq);
            $(tablaProveedores).dataTable();
        });

        $('#buscarProveedores').find('input[name=inicializar]').click(function () {
            $('#buscarProveedores').find('input[name=expresion]').val('');
            $('#buscarProveedores').find('input[name=criterio]').removeAttr('checked');
            $('#buscarProveedores').find('input[name=criterio]:first').click();
        });

        $('#buscarProveedores').bind('open', function () {
            $(tablaProveedores).find('tbody tr:not(.model)').remove();
            var filaBlanco = $(tablaProveedores).find('tbody tr.model').clone();
            $(filaBlanco).removeClass('model');
            $(filaBlanco).css('height', '32px');
            $(filaBlanco).find('a, input').remove();
            $(tablaProveedores).find('tbody').append(filaBlanco);
            $(tablaProveedores).find('tfoot').empty();
            $('#buscarProveedores').find('input[name=inicializar]').triggerHandler('click');
        });

        $(tablaProveedores).on('click', 'input.check', function (e) {
            var multiSelect = $('#buscarProveedores').find('input[name=multiSelect]').val();
            if (multiSelect == 'false') {
                if ($(this).is(':checked')) {
                    $(tablaProveedores).find('input.check').prop('checked', false);
                    $(this).prop('checked', true);
                }
            }
        });

        $(tablaProveedores).bind('finished', function (e, p) {
            if (p.count > 0) {
                $(tablaProveedores).show();
                $('#buscarProveedores').find('input[name=aceptar]').show();
            } else {
                $(tablaProveedores).hide();
                $('#buscarProveedores').find('input[name=aceptar]').hide();
                msgBox("No existen registros de proveedores", "Información del Sistema");
            }
        });

        $('#buscarProveedores').find('input[name=salir]').click(function () {
            $('#buscarProveedores').data("kendoWindow").close();
        });

        $('#buscarProveedores').find('input[name=aceptar]').click(function () {
            var proveedoresSeleccionados = $(tablaProveedores).find('tbody tr:not(.model) input.check:checked');
            if (proveedoresSeleccionados.length > 0) {
                var formulario = $('#buscarProveedores').find('input[name=formulario]').val();
                if (formulario == 'RegistroSolicitud') {
                    var contenedor = $('#agregarSolicitudCotizacion div.proveedores').find('table.dataTable tbody');
                    var lista = new Array();
                    $(proveedoresSeleccionados).each(function () {
                        var tr = $(this).parents('tr').eq(0);
                        var obj = $(tr).data('data');
                        lista.push(obj);
                    });

                    getData({ url: '<%: Url.Action("ProveedoresSolicitud", "Proveedor") %>', data: { 'lista': lista, 'length': lista.length }, dataType: 'html' }, function (response) {
                        $(contenedor).html(response);
                        $('#buscarProveedores').data("kendoWindow").close();
                    });
                } else if (formulario == 'BusquedaCotizacion') {
                    var obj = $(proveedoresSeleccionados).parents('tr').eq(0).data('data');
                    $('div.busquedaCotizaciones').find('input[name=razsocPro]').val(obj.razsocPro);
                    $('div.busquedaCotizaciones').find('input[name=codProv]').val(obj.codProv);
                    $('#buscarProveedores').data("kendoWindow").close();
                } else if (formulario == 'BusquedaSolicitud') {
                    var obj = $(proveedoresSeleccionados).parents('tr').eq(0).data('data');
                    $('#buscarSolicitudes').find('input[name=razsocPro]').val(obj.razsocPro);
                    $('#buscarSolicitudes').find('input[name=codProv]').val(obj.codProv);
                    $('#buscarProveedores').data("kendoWindow").close();
                }
            } else {
                msgBox("Debe seleccionar por lo menos un proveedor.", "Información del Sistema");
            }
        });

    });

</script>

<div class="dialog" id="buscarProveedores" title="Búsqueda de Proveedores">
    <div style="padding:6px;">
        
        <fieldset>
            <legend>Criterios de Búsqueda</legend>
            <div>
                <div style="display:inline-block; margin-right:10px;">
                    <table>
                        <tr>
                            <td>Buscar por:</td>
                            <td>
                                <input type="radio" name="criterio" value="ruc" checked="checked" />&nbsp;RUC&nbsp;&nbsp;
                                <input type="radio" name="criterio" value="razonSocial" />&nbsp;Razón Social</td>
                        </tr>
                        <tr>
                            <td>Expresión:</td>
                            <td><input type="text" name="expresion" value="" maxlength="100" /></td>
                        </tr>
                    </table>
                </div>
                <div style="display:inline-block; vertical-align:top; text-align:center;">
                    <input type="button" name="buscar" value="Buscar" title="Buscar proveedores" style="margin-top:5px;" /><br />
                    <input type="button" name="inicializar" value="Inicializar" title="Reiniciar filtro de busqueda" style="margin-top:5px;" />
                </div>
            </div>
        </fieldset>
        <div style="margin-bottom:10px; margin-top:10px;">
            <table class="dataTable table table-bordered" showNumberRows="true">
                <thead>
                    <tr>
                        <th class="model"><a class="onload" href="<%: Url.Action("listaporServicio", "Proveedor") %>" data-params="" root="data"></a></th>
                        <th>Sel</th>
                        <th><a href="" class="order" data-orderby="codProv">Código</a></th>
                        <th><a href="" class="order" data-orderby="rucPro">RUC</a></th>
                        <th><a href="" class="order" data-orderby="razsocPro">Proveedor</a></th>
                        <th class="calificacion"><a href="" class="order" data-orderby="calificacion">Calificación</a></th>
                        <th><a href="" class="order" data-orderby="situacion">Situación</a></th>
                    </tr>
                </thead>
                <tfoot></tfoot>
                <tbody>
                    <tr class="model">
                        <td><input type="checkbox" name="check" class="check" /></td>
                        <td class="codProv"/>
                        <td class="rucPro"/>
                        <td class="razsocPro"/>
                        <td class="calificacion"/>
                        <td class="situacion"/>
                    </tr>
                    <tr style="height:32px;">
                        <td></td>
                        <td class="codProv"/>
                        <td class="rucPro"/>
                        <td class="razsocPro"/>
                        <td class="calificacion"/>
                        <td class="situacion"/>
                    </tr>
                </tbody>
            </table>
        </div>
        <div style="text-align:right; margin-top:10px;">
            <input type="button" name="aceptar" value="Aceptar" title="Agregar proveedores seleccionados" />&nbsp;&nbsp;
            <input type="button" name="salir" value="Salir" title="Salir del formulario" />
            <input type="hidden" name="multiSelect" value="true" />
            <input type="hidden" name="formulario" value="" />
            <input type="hidden" name="codReq" value="0" />
            <input type="hidden" name="codTServ" value="0" />
        </div>
    </div>
</div>