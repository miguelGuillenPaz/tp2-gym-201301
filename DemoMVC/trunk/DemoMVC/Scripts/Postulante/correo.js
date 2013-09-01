$(document).ready(function () {

    var selectedCorreo;

    $('#tblCorreo').delegate('.eliminar', "click", function () {
        var tr = $(this).parent().parent();
        var idCorreo = $.trim($('td:eq(0)', tr).text());
        if (idCorreo != 0) {
            $('#dialogConfirm #confirm').text('¿Desea eliminar el correo?');
            $('#dialogConfirm').dialog({
                resizable: false,
                height: 140,
                modal: true,
                buttons: {
                    'Aceptar': function () {
                        var data = { idCorreo: idCorreo };
                        var url = '/Postulante/DelCorreo';
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
                    var idCorreo = $.trim($('#hdnCorreo').val());
                    var cuentaCorreo = $.trim($('#txtCorreo').val());

                    var emailfilter = /(([a-zA-Z0-9\-?\.?]+)@(([a-zA-Z0-9\-_]+\.)+)([a-z]{2,3}))+$/;                    
                    if (emailfilter.test(cuentaCorreo)) {
                        $('#txtCorreo').removeClass('required-control');
                        var data = {
                            idPersona: idPersona,
                            idCorreo: idCorreo,
                            cuentaCorreo: cuentaCorreo
                        };
                        var url = '/Postulante/SetCorreo';
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
                                    $('#dialogConfirm #confirm').text('Actualización satisfactoria.');
                                    $('#dialogConfirm').dialog({
                                        resizable: false,
                                        height: 140,
                                        modal: true,
                                        buttons: {
                                            'Aceptar': function () {
                                                $(this).dialog('close');
                                                $('#dialogCorreo').dialog('close');
                                            }
                                        }
                                    });
                                }
                            },
                            error: function () {
                                __ShowMessage('No se pudo actualizar');
                            }
                        });
                    }
                    else {
                        $('#txtCorreo').addClass('required-control');
                        __ShowMessage('El correo debe tener un formato válido. Ejemplo: user@otros.com');
                    }
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