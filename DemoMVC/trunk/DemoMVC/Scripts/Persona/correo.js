$(document).ready(function () {

    var selectedCorreo;

    $('#tblCorreo').delegate('.eliminar', "click", function () {
        var tr = $(this).parent().parent();
        var idCorreo = $.trim($('td:eq(0)', tr).text());
        if (idCorreo != 0) {
            if (confirm('¿Desea eliminar el correo?')) {
                var data = { idCorreo: idCorreo };
                var url = '/Persona/DelCorreo';
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


    $('#tblCorreo').delegate('.editar', "click", function () {
        $('#hdnAccionCorreo').val('U');
        var tr = $(this).parent().parent();
        $('#hdnCorreo').val($.trim($('td:eq(0)', tr).text()));
        $('#txtCorreo').val($.trim($('td:eq(1)', tr).text()));
        selectedCorreo = tr;
        $('#dialogCorreo').dialog('option', 'title', 'Editar Correo');
        $('#dialogCorreo').dialog('open');
    });

    $('#addCorreo').click(function () {
        $('#hdnAccionCorreo').val('I');
        $('#hdnCorreo').val('0');
        $('#txtCorreo').val('');
        $('#dialogCorreo').dialog('option', 'title', 'Agregar Correo');
        $('#dialogCorreo').dialog('open');
    });

    $('#dialogCorreo').dialog({
        autoOpen: false,
        height: 130,
        width: 300,
        resizable: false,
        modal: true,
        buttons: {
            'Enviar': function () {

                var nroRequeridos = 0;
                $('#dialogCorreo .required').each(function () {
                    if ($(this).val() == '' || $(this).val() == '0') {
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
                    var idCorreo = $.trim($('#hdnCorreo').val());
                    var cuentaCorreo = $.trim($('#txtCorreo').val());
                    var data = {
                        idPersona: idPersona,
                        idCorreo: idCorreo,
                        cuentaCorreo: cuentaCorreo
                    };
                    var url = '/Persona/SetCorreo';
                    $.ajax({
                        type: 'POST',
                        url: url,
                        data: data,
                        success: function (result) {
                            if (result.result) {
                                $('#hdnCorreo').val(result.Correo);
                                $('#idPersona').val(result.Persona);
                                if ($('#hdnAccionCorreo').val() == 'I') {
                                    var fila = "<tr>" +
                                        "<td style=\"display: none;\">" + $('#hdnCorreo').val() + "</td>" +
                                        "<td>" + $('#txtCorreo').val() + "</td>" +
                                        "<td><a class=\"editar\" href=\"javascript:;\">Editar</a> | <a class=\"eliminar\" href=\"javascript:;\">Eliminar</a></td>" +
                                        "</tr>";
                                    $('#tblCorreo tbody').append(fila);
                                } else {
                                    var tr = selectedCorreo;
                                    $('td:eq(0)', tr).text($('#hdnCorreo').val());
                                    $('td:eq(1)', tr).text($('#txtCorreo').val());
                                }
                                $('#dialogCorreo').dialog('close');
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