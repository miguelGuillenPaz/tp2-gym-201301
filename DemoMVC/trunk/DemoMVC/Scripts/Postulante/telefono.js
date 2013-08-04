$(document).ready(function () {

    var selectedTelefono;

    $('#tblTelefono').delegate('.eliminar', "click", function () {
        var tr = $(this).parent().parent();
        var idTelefono = $.trim($('td:eq(0)', tr).text());
        if (idTelefono != 0) {
            if (confirm('¿Desea eliminar el teléfono?')) {
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
            }
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
                    var idPersona = $.trim($('#idPersona').val());
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
                                $('#dialogTelefono').dialog('close');
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