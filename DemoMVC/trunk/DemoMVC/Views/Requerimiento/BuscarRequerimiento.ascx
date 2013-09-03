<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<script type="text/javascript">

    $(document).ready(function () {

        var tablaRequerimientos = $('#buscarRequerimientos').find('table.dataTable');

        $('#buscarRequerimientos').bind('open', function () {
            $(tablaRequerimientos).find('tbody tr:not(.model)').remove();
            var filaBlanco = $(tablaRequerimientos).find('tbody tr.model').clone();
            $(filaBlanco).removeClass('model');
            $(filaBlanco).css('height', '32px');
            $(filaBlanco).find('a, input').remove();
            $(tablaRequerimientos).find('tbody').append(filaBlanco);
            $(tablaRequerimientos).find('tfoot').empty();

            var reiniciar = $('#buscarRequerimientos').find('input[name=reiniciar]').val();
            if (reiniciar == 'true') $('#buscarRequerimientos').find('input[name=inicializar]').triggerHandler('click');
        });

        $(tablaRequerimientos).bind('finished', function (e, p) {
            if (p.count > 0) {
                $(tablaRequerimientos).show();
                $('#buscarRequerimientos').find('input[name=aceptar]').show();
            } else {
                $(tablaRequerimientos).hide();
                $('#buscarRequerimientos').find('input[name=aceptar]').hide();
                msgBox("No existen registros de requerimientos", "Información del Sistema");
            }
        });

        $('#buscarRequerimientos').find('input[name=salir]').click(function () {
            $('#buscarRequerimientos').data("kendoWindow").close();
        });

        $('#buscarRequerimientos').find('input[name=aceptar]').click(function () {
            var requerimientosSeleccionados = $(tablaRequerimientos).find('tbody tr:not(.model) input.check:checked').length;
            if (requerimientosSeleccionados > 0) {

                var contenedor = $('#agregarSolicitudCotizacion div.requerimientos').find('table.dataTable tbody');
                var lista = new Array();
                $(tablaRequerimientos).find('tbody tr:not(.model) input.check:checked').each(function () {
                    var tr = $(this).parents('tr').eq(0);
                    var obj = $(tr).data('data');
                    lista.push(obj);
                });

                getData({ url: '<%: Url.Action("RequerimientosSolicitud", "Requerimiento") %>', data: { 'lista': lista, 'length': lista.length }, dataType: 'html' }, function (response) {
                    $(contenedor).html(response);
                    $('#buscarRequerimientos').data("kendoWindow").close();
                });
            } else {
                msgBox("Debe seleccionar por lo menos un requerimiento.", "Información del Sistema");
            }
        });

        $('#buscarRequerimientos').find('input[name=buscar]').click(function () {
            var codPro = parseFloat($('#buscarRequerimientos').find('select[name=codPro] option:selected').val());
            var codTServ = parseFloat($('#buscarRequerimientos').find('select[name=codTServ] option:selected').val());
            
            var codReq = $('#buscarRequerimientos').find('input[name=codReq]').val();
            $(tablaRequerimientos).find('a.onload').attr('data-params', 'codPro:' + codPro + ',codTServ:' + codTServ + ',codReq:' + codReq);
            $(tablaRequerimientos).dataTable();
        });

        $('#buscarRequerimientos').find('input[name=inicializar]').click(function () {
            $('#buscarRequerimientos').find('select[name=codPro]').val(0);
            $('#buscarRequerimientos').find('select[name=codTServ]').val(0);
            $('#buscarRequerimientos').find('input[name=codReq]').val('');
        });

    });

</script>

<div class="dialog" id="buscarRequerimientos" title="Búsqueda de Requerimientos">
    <div style="padding:6px;">        
        <fieldset>
            <legend>Filtros</legend>
            <div>
                <div style="display:inline-block; margin-right:10px;">
                    <table>
                        <tr>
                            <td>Tipo Servicio:</td>
                            <td colspan="3"><%: Html.DropDownList("codTServ", new SelectList(Negocio.TipoServicioCN.Instancia.listartodos(true), "codTServ", "descTServ"))%></td>
                        </tr>
                        <tr>
                            <td>Proyecto:</td>
                            <td><%: Html.DropDownList("codPro", new SelectList(Negocio.ProyectoCN.Instancia.listartodos(true), "codPro", "nomPro")) %></td>
                            <td>Nro Req.:</td>
                            <td><input type="text" name="codReq" value="" style="width:80px;" class="digits" maxlength="5" /></td>
                        </tr>
                    </table>
                </div>
                <div style="display:inline-block; vertical-align:top; text-align:center;">
                    <input type="button" name="buscar" value="Buscar" title="Buscar requerimientos" style="margin-top:5px" /><br />
                    <input type="button" name="inicializar" value="Inicializar" title="Reiniciar filtro de busqueda" style="margin-top:5px;" />
                </div>
            </div>
        </fieldset>
        <div style="margin-top:5px;">
            <table class="dataTable table table-bordered" showNumberRows="true">
                <thead>
                    <tr>
                        <th class="model"><a href="<%: Url.Action("listarPendientes", "Requerimiento") %>" class="onload" root="data" data-params=""></a></th>
                        <th>Sel</th>
                        <th><a href="" class="order" data-orderby="nomPro">Proyecto</a></th>
                        <th><a href="" class="order" data-orderby="codReq">Nº Req.</a></th>
                        <th><a href="" class="order" data-orderby="desReq">Descripción Req.</a></th>
                        <th><a href="" class="order" data-orderby="desServicio">Detalle</a></th>
                        <th><a href="" class="order" data-orderby="descUM">Unidad Medida</a></th>
                        <th><a href="" class="order" data-orderby="canDetReq">Cantidad</a></th>
                    </tr>
                </thead>
                <tfoot></tfoot>
                <tbody>
                    <tr class="model">
                        <td><input type="checkbox" name="check" class="check" /></td>
                        <td class="nomPro"></td>
                        <td class="codReq"></td>
                        <td class="desReq"></td>
                        <td class="desServicio"></td>
                        <td class="descUM"></td>
                        <td class="canDetReq"></td>
                    </tr>
                    <tr style="height:32px;">
                        <td></td>
                        <td class="nomPro"></td>
                        <td class="codReq"></td>
                        <td class="desReq"></td>
                        <td class="desServicio"></td>
                        <td class="descUM"></td>
                        <td class="canDetReq"></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div style="text-align:right; margin-top:5px;">
            <input type="button" name="aceptar" value="Aceptar" title="Agregar requerimientos seleccionados" />&nbsp;&nbsp;
            <input type="button" name="salir" value="Salir" title="Salir del formulario" />
            <input type="hidden" name="reiniciar" value="true" />
        </div>
    </div>
</div>