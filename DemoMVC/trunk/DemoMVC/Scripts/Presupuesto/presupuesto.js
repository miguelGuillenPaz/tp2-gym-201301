$(document).ready(function () {

    var selectedPresupuesto;

    $('#tblListadoPresupuesto').delegate('.eliminar', "click", function () {
        var tr = $(this).parent().parent();
        var idPptoMtoPreventivo = $.trim($('td:eq(0)', tr).text());
        if (idPptoMtoPreventivo != 0) {
            if (confirm('¿Desea eliminar el Presupuesto?')) {
                var data = { idPptoMtoPreventivo: idPptoMtoPreventivo };
                var url = '/Presupuesto/EliminarPresupuesto';
                $.ajax({
                    type: 'POST',
                    url: url,
                    data: data,
                    success: function (result) {
                        if (result.result) {
                            tr.remove();
                        }
                    },
                    error: function () {
                        __ShowMessage('No se pudo eliminar');
                    }
                });
            }
        } else {
            tr.remove();
        }
    });

    $('#tblListadoPresupuesto').delegate('.enviar', "click", function () {
        var tr = $(this).parent().parent();
        var idPptoMtoPreventivo = $.trim($('td:eq(0)', tr).text());
        if (idPptoMtoPreventivo != 0) {
            if (confirm('¿Desea enviar el Presupuesto?')) {
                var data = { idPptoMtoPreventivo: idPptoMtoPreventivo };
                var url = '/Presupuesto/EnviarPresupuesto';
                $.ajax({
                    type: 'POST',
                    url: url,
                    data: data,
                    success: function (result) {
                        if (result.result) {
                            $('td:eq(6)', tr).text('APROBADO');
                        }
                    },
                    error: function () {
                        __ShowMessage('No se pudo enviar');
                    }
                });
            }
        } else {
            tr.remove();
        }
    });


    $('#addPresupuesto').click(function () {
        $('#hdnAccionPresupuesto').val('I');
        $('#hdnPresupuesto').val('0');
        $('#txtIdPptoMtoPreventivo').val('');
        $('#txtAno').val('');
        $('#txtDescripcion').val('');
        $('#txtCostoTotalFijo').val('');
        $('#txtCostoTotalFinal').val('');
        $('#txtCantidad').val('');
        $('#dialogPresupuesto').dialog('option', 'title', 'Agregar Presupuesto');
        $('#dialogPresupuesto').dialog('open');
    });

    $('#dialogPresupuesto').dialog({
        autoOpen: false,
        height: 300,
        width: 600,
        resizable: false,
        modal: true,
        buttons: {
            'Enviar': function () {
                /* var nroRequeridos = 0;
                $('#dialogPresupuesto .required').each(function () {
                if ($(this).val() == '' || $(this).val() == '0') {
                nroRequeridos = nroRequeridos + 1;
                $(this).addClass('required-control');
                } else {
                $(this).removeClass('required-control');
                }
                });*/

                //if (nroRequeridos == 0) {
                var idPptoMtoPreventivo = $.trim($('#idPptoMtoPreventivo').val());
                if (idPptoMtoPreventivo == '') {
                    idPptoMtoPreventivo = '0';
                }
                //var idTelefono = $.trim($('#hdnTelefono').val());
                var ano = $.trim($('#txtAno').val());
                var data = {
                    idPptoMtoPreventivo: idPptoMtoPreventivo,
                    ano: ano,
                    descripcion: descripcion,
                    montoEstimado: montoEstimado,
                    montoFinal: montoFinal,
                    cantidadMantencion: cantidadMantencion,
                    estado: estado
                };
                var url = '/PresupuestoMtoPreventivo/SetPresupuesto';
                $.ajax({
                    type: 'POST',
                    url: url,
                    data: data,
                    success: function (result) {
                        if (result.result) {
                            $('#hdnPresupuesto').val(result.idPptoMtoPreventivo);

                            if ($('#hdnAccionPresupuesto').val() == 'I') {
                                var fila = "<tr>" +
                                        "<td style=\"display: none;\">" + $('#hdnPresupuesto').val() + "</td>" +
                                        "<td>" + $('#txtIdPptoMtoPreventivo').val() + "</td>" +
                                        "<td>" + $('#txtAno').val() + "</td>" +
                                        "<td><a class=\"editar\" href=\"javascript:;\">Editar</a> | <a class=\"eliminar\" href=\"javascript:;\">Eliminar</a></td>" +
                                        "</tr>";
                                $('#tblListadoPresupuesto tbody').append(fila);
                            } else {
                                var tr = selectedTelefono;
                                $('td:eq(0)', tr).text($('#hdnPresupuesto').val());
                                $('td:eq(0)', tr).text($('#txtIdPptoMtoPreventivo').val());
                            }
                            $('#dialogPresupuesto').dialog('close');
                        }
                    },
                    error: function () {
                        __ShowMessage('No se pudo actualizar');
                    }
                });
                //} else {
                //    __ShowMessage('Existen campos obligatorios sin llenar.');
                //}

            },
            Cancel: function () {
                $(this).dialog('close');
            }
        },
        close: function () {
            $(this).dialog('close');
        }
    });

});