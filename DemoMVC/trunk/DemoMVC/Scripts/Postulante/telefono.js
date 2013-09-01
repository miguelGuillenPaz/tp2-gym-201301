$(document).ready(function () {

    var selectedTelefono;

    $('#dialogTelefono').delegate('.integer', 'keydown', function (event) {
        if (event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 ||
        (event.keyCode == 65 && event.ctrlKey === true)) {
            return;
        }
        else if (event.keyCode == 46 || event.keyCode == 37 || event.keyCode == 39) {
            return;
        }
        else {
            if ((event.keyCode < 48 || event.keyCode > 57) &&
                (event.keyCode < 96 || event.keyCode > 105)) {
                event.preventDefault();
            }
        }

    });

    $('#tblTelefono').delegate('.eliminar', "click", function () {
        var tr = $(this).parent().parent();
        var idTelefono = $.trim($('td:eq(0)', tr).text());
        if (idTelefono != 0) {
            $('#dialogConfirm #confirm').text('¿Desea eliminar el teléfono?');
            $('#dialogConfirm').dialog({
                resizable: false,
                height: 140,
                modal: true,
                buttons: {
                    'Aceptar': function () {
                        var data = { idTelefono: idTelefono };
                        var url = '/Postulante/DelTelefono';
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
                        $(this).dialog('close');
                    },
                    'Cancelar': function () {
                        $(this).dialog('close');
                    }
                }
            });            
        } else {
            tr.remove();
        }
    });


    $('#tblTelefono').delegate('.editar', "click", function () {
        $('#hdnAccionTelefono').val('U');
        var tr = $(this).parent().parent();
        $('#hdnTelefono').val($.trim($('td:eq(0)', tr).text()));
        $('#txtTelefono').val($.trim($('td:eq(1)', tr).text()));
        selectedTelefono = tr;
        $('#dialogTelefono').dialog('option', 'title', 'Editar Teléfono');
        $('#dialogTelefono').dialog('open');
    });

    $('#addTelefono').click(function () {
        $('#hdnAccionTelefono').val('I');
        $('#hdnTelefono').val('0');
        $('#txtTelefono').val('');
        $('#dialogTelefono').dialog('option', 'title', 'Agregar Teléfono');
        $('#dialogTelefono').dialog('open');
    });

    $('#dialogTelefono').dialog({
        autoOpen: false,
        height: 130,
        width: 300,
        resizable: false,
        modal: true,
        buttons: {
            'Enviar': function () {
                var nroRequeridos = 0;
                $('#dialogTelefono .required').each(function () {
                    if ($(this).val() == '') {
                        nroRequeridos = nroRequeridos + 1;
                        $(this).addClass('required-control');
                    } else {
                        $(this).removeClass('required-control');
                    }
                });

                if (nroRequeridos == 0) {
                    var idPersona = $.trim($('#IdPersona').val());
                    if (idPersona == '') {
                        idPersona = '0';
                    }
                    var idTelefono = $.trim($('#hdnTelefono').val());
                    var numeroTelefono = $.trim($('#txtTelefono').val());
                    var data = {
                        idPersona: idPersona,
                        idTelefono: idTelefono,
                        numeroTelefono: numeroTelefono
                    };
                    var url = '/Postulante/SetTelefono';
                    $.ajax({
                        type: 'POST',
                        url: url,
                        data: data,
                        success: function (result) {
                            if (result.result) {
                                $('#hdnTelefono').val(result.Telefono);
                                $('#idPersona').val(result.Persona);
                                if ($('#hdnAccionTelefono').val() == 'I') {
                                    var fila = "<tr>" +
                                        "<td style=\"display: none;\">" + $('#hdnTelefono').val() + "</td>" +
                                        "<td>" + $('#txtTelefono').val() + "</td>" +
                                        "<td><a class=\"editar\" href=\"javascript:;\">Editar</a> | <a class=\"eliminar\" href=\"javascript:;\">Eliminar</a></td>" +
                                        "</tr>";
                                    $('#tblTelefono tbody').append(fila);
                                } else {
                                    var tr = selectedTelefono;
                                    $('td:eq(0)', tr).text($('#hdnTelefono').val());
                                    $('td:eq(1)', tr).text($('#txtTelefono').val());
                                }                                
                                $('#dialogConfirm #confirm').text('Actualización satisfactoria.');
                                $('#dialogConfirm').dialog({
                                    resizable: false,
                                    height: 140,
                                    modal: true,
                                    buttons: {
                                        'Aceptar': function () {
                                            $(this).dialog('close');
                                            $('#dialogTelefono').dialog('close');
                                        }
                                    }
                                });
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

});