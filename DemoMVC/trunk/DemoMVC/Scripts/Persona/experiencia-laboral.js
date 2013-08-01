$(document).ready(function () {

    var selectedExperienciaLaboral;

    $('#tblExperienciaLaboral').delegate('.eliminar', "click", function () {
        var tr = $(this).parent().parent();
        var idExperienciaLaboral = $.trim($('td:eq(0)', tr).text());
        if (idExperienciaLaboral != 0) {
            if (confirm('¿Desea eliminar la experiencia laboral?')) {
                var data = { idExperienciaLaboral: idExperienciaLaboral };
                var url = '/Persona/DelExperienciaLaboral';
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
        height: 270,
        width: 300,
        resizable: false,
        modal: true,
        buttons: {
            'Enviar': function () {
                var idPersona = $.trim($('#idPersona').val());
                if (idPersona == '') {
                    idPersona = '0';
                }
                var idExperienciaLaboral = $.trim($('#hdnExperienciaLaboral').val());
                var txtCargo = $.trim($('#txtCargo').val());
                var txtInicio = $.trim($('#txtInicio').val());
                var txtFin = $.trim($('#txtFin').val());
                var txtEmpresa = $.trim($('#txtEmpresa').val());
                var txtConocimiento = $.trim($('#txtConocimiento').val());
                var data = {
                    idPersona: idPersona,
                    idExperienciaLaboral: idExperienciaLaboral,
                    fechaInicio: txtInicio,
                    fechaFin: txtFin,
                    conocimientos: txtConocimiento,
                    cargo: txtCargo,
                    empresa: txtEmpresa
                };                
                var url = '/Persona/SetExperienciaLaboral';
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
                                        "<td>" + $('#txtEmpresa').val() + "</td>" +
                                        "<td>" + $('#txtCargo').val() + "</td>" +
                                        "<td>" + $('#txtInicio').val() + "</td>" +
                                        "<td>" + $('#txtFin').val() + "</td>" +
                                        "<td style=\"display: none;\">" + $('#txtConocimiento').val() + "</td>" +
                                        "<td><a class=\"editar\" href=\"javascript:;\">Editar</a> | <a class=\"eliminar\" href=\"javascript:;\">Eliminar</a></td>" +
                                        "</tr>";
                                $('#tblExperienciaLaboral tbody').append(fila);
                            } else {
                                var tr = selectedExperienciaLaboral;
                                $('td:eq(0)', tr).text($('#hdnExperienciaLaboral').val());
                                $('td:eq(1)', tr).text($('#txtEmpresa').val());
                                $('td:eq(2)', tr).text($('#txtCargo').val());
                                $('td:eq(3)', tr).text($('#txtInicio').val());
                                $('td:eq(4)', tr).text($('#txtFin').val());
                                $('td:eq(5)', tr).text($('#txtConocimiento').val());
                            }
                            $('#dialogExperienciaLaboral').dialog('close');
                        }
                    },
                    error: function () {
                        __ShowMessage('No se pudo actualizar');
                    }
                });


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