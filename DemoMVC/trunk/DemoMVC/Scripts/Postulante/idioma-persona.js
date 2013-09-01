$(document).ready(function () {

    var selectedIdiomaPersona;

    $('#tblIdiomaPersona').delegate('.eliminar', "click", function () {
        var tr = $(this).parent().parent();
        var idIdiomaPersona = $.trim($('td:eq(0)', tr).text());
        if (idIdiomaPersona != 0) {
            $('#dialogConfirm #confirm').text('¿Desea eliminar el idioma?');
            $('#dialogConfirm').dialog({
                resizable: false,
                height: 140,
                modal: true,
                buttons: {
                    'Aceptar': function () {
                        var data = { idIdiomaPersona: idIdiomaPersona };
                        var url = '/Postulante/DelIdiomaPersona';
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

    $('#tblIdiomaPersona').delegate('.editar', "click", function () {
        $('#hdnAccionIdiomaPersona').val('U');
        var tr = $(this).parent().parent();
        $('#hdnIdiomaPersona').val($.trim($('td:eq(0)', tr).text()));
        $('#ddlIdioma').val($.trim($('td:eq(1)', tr).text()));
        if ($.trim($('td:eq(4)', tr).text()) == 'Nativo') {
            $('input[name=nativo]').attr('checked', true);
        }
        else {
            $('input[name=nativo]').attr('checked', false);
        }
        if ($('#chkNativo').is(':checked')) {
            $('#ddlNivelIdioma').val('0');
            $('#ddlNivelIdioma').css('display', 'none');
            $('#lblNivelIdioma').css('display', 'none');
            $('#sepNivelIdioma').css('display', 'none');
        } else {
            $('#ddlNivelIdioma').val($.trim($('td:eq(3)', tr).text()));
            $('#ddlNivelIdioma').css('display', 'inline');
            $('#lblNivelIdioma').css('display', 'inline');
            $('#sepNivelIdioma').css('display', 'inline');
        }
        selectedIdiomaPersona = tr;
        $('#dialogIdiomaPersona').dialog('option', 'title', 'Editar Idioma');
        $('#dialogIdiomaPersona').dialog('open');
    });

    $('#addIdiomaPersona').click(function () {
        $('#hdnAccionIdiomaPersona').val('I');
        $('#hdnIdiomaPersona').val('0');
        $('#ddlIdioma').val('0');
        $('#ddlNivelIdioma').val('0');
        $('input[name=nativo]').attr('checked', false);
        $('#ddlNivelIdioma').addClass('required');
        $('#ddlNivelIdioma').css('display', 'inline');
        $('#lblNivelIdioma').css('display', 'inline');
        $('#sepNivelIdioma').css('display', 'inline');
        $('#dialogIdiomaPersona').dialog('option', 'title', 'Agregar Idioma');
        $('#dialogIdiomaPersona').dialog('open');
    });

    $('input[name=nativo]').click(function () {

        if ($('#chkNativo').is(':checked')) {
            $('#ddlNivelIdioma').val('0');
            $('#ddlNivelIdioma').css('display', 'none');
            $('#ddlNivelIdioma').removeClass('required');
            $('#lblNivelIdioma').css('display', 'none');
            $('#sepNivelIdioma').css('display', 'none');
        } else {
            $('#ddlNivelIdioma').css('display', 'inline');
            $('#ddlNivelIdioma').addClass('required');
            $('#lblNivelIdioma').css('display', 'inline');
            $('#sepNivelIdioma').css('display', 'inline');
        }
    });

    $('#dialogIdiomaPersona').dialog({
        autoOpen: false,
        height: 180,
        width: 300,
        resizable: false,
        modal: true,
        buttons: {
            'Enviar': function () {
                var nroRequeridos = 0;
                $('#dialogIdiomaPersona .required').each(function () {
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
                    var idIdiomaPersona = $.trim($('#hdnIdiomaPersona').val());
                    var idIdioma = $.trim($('#ddlIdioma').val());
                    var idNivelIdioma = $.trim($('#ddlNivelIdioma').val());
                    var nativo = $('#chkNativo').is(':checked') ? true : false;
                    var data = {
                        idPersona: idPersona,
                        idIdiomaPersona: idIdiomaPersona,
                        idIdioma: idIdioma,
                        idNivelIdioma: idNivelIdioma,
                        nativo: nativo
                    };
                    var url = '/Postulante/SetIdiomaPersona';
                    $.ajax({
                        type: 'POST',
                        url: url,
                        data: data,
                        success: function (result) {
                            if (result.result) {
                                $('#hdnIdiomaPersona').val(result.IdiomaPersona);
                                $('#idPersona').val(result.Persona);
                                if ($('#hdnAccionIdiomaPersona').val() == 'I') {
                                    var rowNativo;
                                    if (nativo) {
                                        rowNativo = "<td>Nativo</td>";
                                    } else {
                                        rowNativo = "<td>" + $('#ddlNivelIdioma option:selected').text() + "</td>";
                                    }
                                    var fila = "<tr>" +
                                        "<td style=\"display: none;\">" + $('#hdnIdiomaPersona').val() + "</td>" +
                                        "<td style=\"display: none;\">" + $('#ddlIdioma').val() + "</td>" +
                                        "<td>" + $('#ddlIdioma option:selected').text() + "</td>" +
                                        "<td style=\"display: none;\">" + $('#ddlNivelIdioma').val() + "</td>" +
                                        rowNativo +
                                        "<td><a class=\"editar\" href=\"javascript:;\">Editar</a> | <a class=\"eliminar\" href=\"javascript:;\">Eliminar</a></td>" +
                                        "</tr>";
                                    $('#tblIdiomaPersona tbody').append(fila);
                                } else {
                                    var tr = selectedIdiomaPersona;
                                    $('td:eq(0)', tr).text($('#hdnIdiomaPersona').val());
                                    $('td:eq(1)', tr).text($('#ddlIdioma').val());
                                    $('td:eq(2)', tr).text($('#ddlIdioma option:selected').text());
                                    $('td:eq(3)', tr).text($('#ddlNivelIdioma').val());
                                    if (nativo) {
                                        $('td:eq(4)', tr).text('Nativo');
                                    } else {
                                        $('td:eq(4)', tr).text($('#ddlNivelIdioma option:selected').text());
                                    }
                                }                                
                                $('#dialogConfirm #confirm').text('Actualización satisfactoria.');
                                $('#dialogConfirm').dialog({
                                    resizable: false,
                                    height: 140,
                                    modal: true,
                                    buttons: {
                                        'Aceptar': function () {
                                            $(this).dialog('close');
                                            $('#dialogIdiomaPersona').dialog('close');
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