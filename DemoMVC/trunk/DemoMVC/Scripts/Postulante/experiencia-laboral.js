$(document).ready(function () {

    var selectedExperienciaLaboral;

    $('#tblExperienciaLaboral').delegate('.eliminar', "click", function () {
        var tr = $(this).parent().parent();
        var idExperienciaLaboral = $.trim($('td:eq(0)', tr).text());
        if (idExperienciaLaboral != 0) {
            $('#dialogConfirm #confirm').text('¿Desea eliminar la experiencia laboral?');
            $('#dialogConfirm').dialog({
                resizable: false,
                height: 140,
                modal: true,
                buttons: {
                    'Aceptar': function () {
                        var data = { idExperienciaLaboral: idExperienciaLaboral };
                        var url = '/Postulante/DelExperienciaLaboral';
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


    $('#tblExperienciaLaboral').delegate('.editar', "click", function () {
        $('#hdnAccionExperienciaLaboral').val('U');
        var tr = $(this).parent().parent();
        $('#hdnExperienciaLaboral').val($.trim($('td:eq(0)', tr).text()));
        $('#txtEmpresa').val($.trim($('td:eq(1)', tr).text()));
        $('#txtCargo').val($.trim($('td:eq(2)', tr).text()));
        $('#txtInicio').val($.trim($('td:eq(3)', tr).text()));
        $('#txtFin').val($.trim($('td:eq(4)', tr).text()));
        $('#txtConocimiento').val($.trim($('td:eq(5)', tr).text()));
        selectedExperienciaLaboral = tr;
        $('#dialogExperienciaLaboral').dialog('option', 'title', 'Editar Experiencia Laboral');
        $('#dialogExperienciaLaboral').dialog('open');
    });

    $('#addExperienciaLaboral').click(function () {
        $('#hdnAccionExperienciaLaboral').val('I');
        $('#hdnExperienciaLaboral').val('0');
        $('#txtCargo').val('');
        $('#txtEmpresa').val('');
        $('#txtConocimiento').val('');
        $('#txtInicio').val('');
        $('#txtFin').val('');
        $('#dialogExperienciaLaboral').dialog('option', 'title', 'Agregar Experiencia Laboral');
        $('#dialogExperienciaLaboral').dialog('open');
    });

    $('#dialogExperienciaLaboral').dialog({
        autoOpen: false,
        height: 360,
        width: 295,
        resizable: false,
        modal: true,
        buttons: {
            'Enviar': function () {

                var nroRequeridos = 0;
                $('#dialogExperienciaLaboral .required').each(function () {
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
                    var idExperienciaLaboral = $.trim($('#hdnExperienciaLaboral').val());
                    var txtCargo = $.trim($('#txtCargo').val().toUpperCase());
                    var txtInicio = $.trim($('#txtInicio').val());
                    var txtFin = $.trim($('#txtFin').val());
                    var txtEmpresa = $.trim($('#txtEmpresa').val().toUpperCase());
                    var txtConocimiento = $.trim($('#txtConocimiento').val());
                    if (txtInicio < txtFin) {
                        $('#txtInicio').removeClass('required-control');
                        $('#txtFin').removeClass('required-control');
                        var data = {
                            idPersona: idPersona,
                            idExperienciaLaboral: idExperienciaLaboral,
                            fechaInicio: txtInicio,
                            fechaFin: txtFin,
                            conocimientos: txtConocimiento,
                            cargo: txtCargo,
                            empresa: txtEmpresa
                        };
                        var url = '/Postulante/SetExperienciaLaboral';
                        $.ajax({
                            type: 'POST',
                            url: url,
                            data: data,
                            success: function (result) {
                                if (result.result) {
                                    $('#hdnExperienciaLaboral').val(result.ExperienciaLaboral);
                                    $('#idPersona').val(result.Persona);
                                    if ($('#hdnAccionExperienciaLaboral').val() == 'I') {
                                        var fila = "<tr>" +
                                        "<td style=\"display: none;\">" + $('#hdnExperienciaLaboral').val() + "</td>" +
                                        "<td>" + txtEmpresa + "</td>" +
                                        "<td>" + txtCargo + "</td>" +
                                        "<td>" + txtInicio + "</td>" +
                                        "<td>" + txtFin + "</td>" +
                                        "<td style=\"display: none;\">" + txtConocimiento + "</td>" +
                                        "<td><a class=\"editar button\" href=\"javascript:;\">Editar</a> | <a class=\"eliminar button\" href=\"javascript:;\">Eliminar</a></td>" +
                                        "</tr>";
                                        $('#tblExperienciaLaboral tbody').append(fila);
                                    } else {
                                        var tr = selectedExperienciaLaboral;
                                        $('td:eq(0)', tr).text($('#hdnExperienciaLaboral').val());
                                        $('td:eq(1)', tr).text(txtEmpresa);
                                        $('td:eq(2)', tr).text(txtCargo);
                                        $('td:eq(3)', tr).text(txtInicio);
                                        $('td:eq(4)', tr).text(txtFin);
                                        $('td:eq(5)', tr).text(txtConocimiento);
                                    }                                    
                                    $('#dialogConfirm #confirm').text('Actualización satisfactoria.');
                                    $('#dialogConfirm').dialog({
                                        resizable: false,
                                        height: 140,
                                        modal: true,
                                        buttons: {
                                            'Aceptar': function () {
                                                $(this).dialog('close');
                                                $('#dialogExperienciaLaboral').dialog('close');
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
                        $('#txtInicio').addClass('required-control');
                        $('#txtFin').addClass('required-control');
                        __ShowMessage('La fecha de fin debe ser mayor a la fecha de inicio.');
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