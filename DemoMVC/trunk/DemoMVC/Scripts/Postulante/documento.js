$(document).ready(function () {

    var selectedDocumento;

    $('#tblDocumento').delegate('.eliminar', "click", function () {
        var tr = $(this).parent().parent();
        var idDocumento = $.trim($('td:eq(0)', tr).text());
        if (idDocumento != 0) {
            if (confirm('¿Desea eliminar el documento?')) {
                var data = { idDocumento: idDocumento };
                var url = '/Postulante/DelDocumento';
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


    $('#tblDocumento').delegate('.editar', "click", function () {
        $('#hdnAccionDocumento').val('U');
        var tr = $(this).parent().parent();
        $('#hdnDocumento').val($.trim($('td:eq(0)', tr).text()));
        $('#ddlTipoDocumento').val($.trim($('td:eq(1)', tr).text()));
        $('#txtDocumento').val($.trim($('td:eq(3)', tr).text()));
        selectedDocumento = tr;
        $('#dialogDocumento').dialog('option', 'title', 'Editar Documento');
        $('#dialogDocumento').dialog('open');
    });

    $('#addDocumento').click(function () {
        $('#hdnAccionDocumento').val('I');
        $('#hdnDocumento').val('0');
        $('#ddlTipoDocumento').val(0);
        $('#txtDocumento').val('');
        $('#dialogDocumento').dialog('option', 'title', 'Agregar Documento');
        $('#dialogDocumento').dialog('open');
    });

    $('#dialogDocumento').dialog({
        autoOpen: false,
        height: 190,
        width: 260,
        resizable: false,
        modal: true,
        buttons: {
            'Enviar': function () {
                var nroRequeridos = 0;
                $('#dialogDocumento .required').each(function () {
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
                    var idDocumento = $.trim($('#hdnDocumento').val());
                    var idTipoDocumento = $.trim($('#ddlTipoDocumento').val());
                    var numeroDocumento = $.trim($('#txtDocumento').val());
                    var data = {
                        idPersona: idPersona,
                        idDocumento: idDocumento,
                        idTipoDocumento: idTipoDocumento,
                        numeroDocumento: numeroDocumento
                    };
                    var url = '/Postulante/SetDocumento';
                    $.ajax({
                        type: 'POST',
                        url: url,
                        data: data,
                        success: function (result) {
                            if (result.result) {
                                $('#hdnDocumento').val(result.Documento);
                                $('#idPersona').val(result.Persona);
                                if ($('#hdnAccionDocumento').val() == 'I') {
                                    var fila = "<tr>" +
                                        "<td style=\"display: none;\">" + $('#hdnDocumento').val() + "</td>" +
                                        "<td style=\"display: none;\">" + $('#ddlTipoDocumento').val() + "</td>" +
                                        "<td>" + $('#ddlTipoDocumento option:selected').text() + "</td>" +
                                        "<td>" + $('#txtDocumento').val() + "</td>" +
                                        "<td><a class=\"editar\" href=\"javascript:;\">Editar</a> | <a class=\"eliminar\" href=\"javascript:;\">Eliminar</a></td>" +
                                        "</tr>";
                                    $('#tblDocumento tbody').append(fila);
                                } else {
                                    var tr = selectedDocumento;
                                    $('td:eq(0)', tr).text($('#hdnDocumento').val());
                                    $('td:eq(1)', tr).text($('#ddlTipoDocumento').val());
                                    $('td:eq(2)', tr).text($('#ddlTipoDocumento option:selected').text());
                                    $('td:eq(3)', tr).text($('#txtDocumento').val());
                                }
                                $('#dialogDocumento').dialog('close');
                            } else {
                                __ShowMessage(result.Error);
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