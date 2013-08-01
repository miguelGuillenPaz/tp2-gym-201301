$(document).ready(function () {

    var selectedEstudioRealizado;

    $('#tblEstudioRealizado').delegate('.eliminar', "click", function () {
        var tr = $(this).parent().parent();
        var idEstudioRealizado = $.trim($('td:eq(0)', tr).text());
        if (idEstudioRealizado != 0) {
            if (confirm('¿Desea eliminar el estudio realizado?')) {
                var data = { idEstudioRealizado: idEstudioRealizado };
                var url = '/Persona/DelEstudioRealizado';
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


    $('#tblEstudioRealizado').delegate('.editar', "click", function () {
        $('#hdnAccionEstudioRealizado').val('U');
        var tr = $(this).parent().parent();
        $('#hdnEstudioRealizado').val($.trim($('td:eq(0)', tr).text()));
        $('#txtCentro').val($.trim($('td:eq(1)', tr).text()));
        $('#txtNombre').val($.trim($('td:eq(2)', tr).text()));
        $('#ddlNivel').val($.trim($('td:eq(3)', tr).text()));        
        $('#ddlEspecialidad').val($.trim($('td:eq(5)', tr).text()));
        $('#ddlSituacion').val($.trim($('td:eq(7)', tr).text()));
        if ($('#ddlSituacion').val() == 2) {
            $('#txtFinE').val('');
            $('#txtFinE').css('display', 'none');
            $('#lblFinE').css('display', 'none');
            $('#sepFinE').css('display', 'none');
        } else {
            $('#txtFinE').css('display', 'inline');
            $('#lblFinE').css('display', 'inline');
            $('#sepFinE').css('display', 'inline');
        }
        $('#txtInicioE').val($.trim($('td:eq(9)', tr).text()));
        $('#txtFinE').val($.trim($('td:eq(10)', tr).text()));
        selectedEstudioRealizado = tr;
        $('#dialogEstudioRealizado').dialog('option', 'title', 'Editar Estudio Realizado');
        $('#dialogEstudioRealizado').dialog('open');
    });

    $('#addEstudioRealizado').click(function () {
        $('#hdnAccionEstudioRealizado').val('I');
        $('#hdnEstudioRealizado').val('0');
        $('#txtCentro').val('');
        $('#txtNombre').val('');
        $('#ddlNivel').val('0');
        $('#ddlEspecialidad').val('0');
        $('#ddlSituacion').val('0');
        $('#txtInicioE').val('');
        $('#txtFinE').val('');
        $('#txtFinE').css('display', 'inline');
        $('#lblFinE').css('display', 'inline');
        $('#sepFinE').css('display', 'inline');
        $('#dialogEstudioRealizado').dialog('option', 'title', 'Agregar Estudio Realizado');
        $('#dialogEstudioRealizado').dialog('open');

    });

    $('#ddlSituacion').change(function () {
        if ($(this).val() == 2) {
            $('#txtFinE').val('');
            $('#txtFinE').css('display', 'none');
            $('#lblFinE').css('display', 'none');
            $('#sepFinE').css('display', 'none');
        } else {
            $('#txtFinE').css('display', 'inline');
            $('#lblFinE').css('display', 'inline');
            $('#sepFinE').css('display', 'inline');
        }
    });

    $('#dialogEstudioRealizado').dialog({
        autoOpen: false,
        height: 300,
        width: 300,
        resizable: false,
        modal: true,
        buttons: {
            'Enviar': function () {
                var idPersona = $.trim($('#idPersona').val());
                if (idPersona == '') {
                    idPersona = '0';
                }
                var idEstudioRealizado = $.trim($('#hdnEstudioRealizado').val());
                var txtCentro = $.trim($('#txtCentro').val());
                var txtNombre = $.trim($('#txtNombre').val());
                var idNivel = $.trim($('#ddlNivel').val());
                var idEspecialidad = $.trim($('#ddlEspecialidad').val());
                var idSituacion = $.trim($('#ddlSituacion').val());
                var txtInicio = $.trim($('#txtInicioE').val());
                var txtFin = $.trim($('#txtFinE').val());
                var data = {
                    idPersona: idPersona,
                    idEstudioRealizado: idEstudioRealizado,
                    idEspecialidad: idEspecialidad,
                    idNivel: idNivel,
                    idSituacion: idSituacion,
                    centroEstudio: txtCentro,
                    fechaInicio: txtInicio,
                    fechaFin: txtFin,
                    nombreEstudio: txtNombre
                };
                var url = '/Persona/SetEstudioRealizado';
                $.ajax({
                    type: 'POST',
                    url: url,
                    data: data,
                    success: function (result) {
                        if (result.result) {
                            $('#hdnEstudioRealizado').val(result.EstudioRealizado);
                            $('#idPersona').val(result.Persona);
                            if ($('#hdnAccionEstudioRealizado').val() == 'I') {
                                var fila = "<tr>" +
                                        "<td style=\"display: none;\">" + $('#hdnEstudioRealizado').val() + "</td>" +
                                        "<td>" + $('#txtCentro').val() + "</td>" +
                                        "<td>" + $('#txtNombre').val() + "</td>" +
                                        "<td style=\"display: none;\">" + $('#ddlNivel').val() + "</td>" +
                                        "<td>" + $('#ddlNivel option:selected').text() + "</td>" +
                                        "<td style=\"display: none;\">" + $('#ddlEspecialidad').val() + "</td>" +
                                        "<td>" + $('#ddlEspecialidad option:selected').text() + "</td>" +
                                        "<td style=\"display: none;\">" + $('#ddlSituacion').val() + "</td>" +
                                        "<td>" + $('#ddlSituacion option:selected').text() + "</td>" +
                                        "<td>" + $('#txtInicioE').val() + "</td>" +
                                        "<td>" + $('#txtFinE').val() + "</td>" +
                                        "<td><a class=\"editar\" href=\"javascript:;\">Editar</a> | <a class=\"eliminar\" href=\"javascript:;\">Eliminar</a></td>" +
                                        "</tr>";
                                $('#tblEstudioRealizado tbody').append(fila);
                            } else {
                                var tr = selectedEstudioRealizado;
                                $('td:eq(0)', tr).text($('#hdnEstudioRealizado').val());
                                $('td:eq(1)', tr).text($('#txtCentro').val());
                                $('td:eq(2)', tr).text($('#txtNombre').val());
                                $('td:eq(3)', tr).text($('#ddlNivel').val());
                                $('td:eq(4)', tr).text($('#ddlNivel option:selected').text());
                                $('td:eq(5)', tr).text($('#ddlEspecialidad').val());
                                $('td:eq(6)', tr).text($('#ddlEspecialidad option:selected').text());
                                $('td:eq(7)', tr).text($('#ddlSituacion').val());
                                $('td:eq(8)', tr).text($('#ddlSituacion option:selected').text());
                                $('td:eq(9)', tr).text($('#txtInicioE').val());
                                $('td:eq(10)', tr).text($('#txtFinE').val());
                            }
                            $('#dialogEstudioRealizado').dialog('close');
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