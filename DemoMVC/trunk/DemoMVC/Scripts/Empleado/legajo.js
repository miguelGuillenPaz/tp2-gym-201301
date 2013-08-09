$(document).ready(function () {

    var selectedLegajo;

    $('#tblLegajo').delegate('.eliminar', "click", function () {
        var tr = $(this).parent().parent();
        var idLegajo = $.trim($('td:eq(0)', tr).text());
        if (idLegajo != 0) {
            if (confirm('¿Desea eliminar el legajo?')) {
                var data = { idLegajo: idLegajo };
                var url = '/Empleado/DelLegajo';
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


    $('#tblLegajo').delegate('.editar', "click", function () {
        $('#hdnAccionLegajo').val('U');
        var tr = $(this).parent().parent();
        $('#hdnLegajo').val($.trim($('td:eq(0)', tr).text()));
        $('#txtNombreArchivo').val($.trim($('td:eq(1)', tr).text()));
        $('#txtUbicacion').val($.trim($('td:eq(2)', tr).text()));
        selectedLegajo = tr;
        $('#dialogLegajo').dialog('option', 'title', 'Editar Legajo');
        $('#dialogLegajo').dialog('open');
    });

    $('#addLegajo').click(function () {
        $('#hdnAccionLegajo').val('I');
        $('#hdnLegajo').val('0');
        $('#txtNombreArchivo').val('');
        $('#txtUbicacion').val('');
        $('#dialogLegajo').dialog('option', 'title', 'Agregar Legajo');
        $('#dialogLegajo').dialog('open');
    });

    $('#dialogLegajo').dialog({
        autoOpen: false,
        height: 170,
        width: 300,
        resizable: false,
        modal: true,
        buttons: {
            'Enviar': function () {

                var nroRequeridos = 0;
                $('#dialogLegajo .required').each(function () {
                    if ($(this).val() == '') {
                        nroRequeridos = nroRequeridos + 1;
                        $(this).addClass('required-control');
                    } else {
                        $(this).removeClass('required-control');
                    }
                });

                if (nroRequeridos == 0) {
                    var idEmpleado = $.trim($('#idEmpleado').val());
                    if (idEmpleado == '') {
                        idEmpleado = '0';
                    }
                    var idLegajo = $.trim($('#hdnLegajo').val());
                    var nombreArchivo = $.trim($('#txtNombreArchivo').val()).toUpperCase(); 
                    var ubicacion = $.trim($('#txtUbicacion').val()).toUpperCase();
                    var data = {
                        idEmpleado: idEmpleado,
                        idLegajo: idLegajo,
                        nombreArchivo: nombreArchivo,
                        ubicacion: ubicacion
                    };
                    
                    var url = '/Empleado/SetLegajo';
                    $.ajax({
                        type: 'POST',
                        url: url,
                        data: data,
                        success: function (result) {
                            if (result.result) {
                                $('#hdnLegajo').val(result.legajo);                                
                                if ($('#hdnAccionLegajo').val() == 'I') {
                                    var fila = "<tr>" +
                                        "<td style=\"display: none;\">" + $('#hdnLegajo').val() + "</td>" +
                                        "<td>" + $('#txtNombreArchivo').val() + "</td>" +
                                        "<td>" + $('#txtUbicacion').val() + "</td>" +
                                        "<td><a class=\"editar\" href=\"javascript:;\">Editar</a> | <a class=\"eliminar\" href=\"javascript:;\">Eliminar</a></td>" +
                                        "</tr>";
                                    $('#tblLegajo tbody').append(fila);
                                } else {
                                    var tr = selectedLegajo;
                                    $('td:eq(0)', tr).text($('#hdnLegajo').val());
                                    $('td:eq(1)', tr).text($('#txtNombreArchivo').val());
                                    $('td:eq(2)', tr).text($('#txtUbicacion').val());
                                }
                                $('#dialogLegajo').dialog('close');
                            }
                        },
                        error: function () {
                            __ShowMessage('No se pudo actualizar');
                        }
                    });
                } else {
                    __ShowMessage('Existen campos obligatorios sin llenar.');
                }

            },
            Cancel: function () {
                $(this).dialog('close');
            }
        },
        close: function () {
            $(this).dialog('close');
        }        
    });

    $('#btnCancelar').click(function () {
        if (confirm('¿Desea cancelar el registro de empleado?')) {
            var idEmpleado = $.trim($('#idEmpleado').val());
            var data = { idEmpleado: idEmpleado };
            var url = '/Empleado/Cancelar';
            $.ajax({
                type: 'POST',
                url: url,
                data: data,
                success: function (result) {
                    if (result.result) {
                        window.location.href = '/Empleado/Agregar';
                    }
                },
                error: function () {
                    __ShowMessage('No se pudo cancelar');
                }
            });
        }
    });
});