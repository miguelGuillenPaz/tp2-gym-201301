$(document).ready(function () {

    var selectedDerechoHabiente;

    $('#tblDerechoHabiente').delegate('.eliminar', "click", function () {
        var tr = $(this).parent().parent();
        var idDerechoHabiente = $.trim($('td:eq(0)', tr).text());
        if (idDerechoHabiente != 0) {
            if (confirm('¿Desea eliminar el derecho habiente?')) {
                var data = { idDerechoHabiente: idDerechoHabiente };
                var url = '/Empleado/DelDerechoHabiente';
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


    $('#tblDerechoHabiente').delegate('.editar', "click", function () {

        $('#hdnAccionDerechoHabiente').val('U');
        var tr = $(this).parent().parent();
        $('#hdnPersona').val($.trim($('td:eq(12)', tr).text()));
        $('#hdnDerechoHabiente').val($.trim($('td:eq(0)', tr).text()));
        $('#txtNombre').val($.trim($('td:eq(1)', tr).text()));
        $('#txtApPaterno').val($.trim($('td:eq(2)', tr).text()));
        $('#txtApMaterno').val($.trim($('td:eq(3)', tr).text()));
        $('#txtFecNacimiento').val($.trim($('td:eq(4)', tr).text()));
        $('#hdnDocumento').val($.trim($('td:eq(5)', tr).text()));
        $('#ddlTipoDocumento').val($.trim($('td:eq(6)', tr).text()));
        $('#txtDocumento').val($.trim($('td:eq(8)', tr).text()));

        if ($.trim($('td:eq(9)', tr).text()) == 'Masculino') {
            $('input:radio[name="GRH_Persona.sexo"]').val(true);
        } else {
            $('input:radio[name="GRH_Persona.sexo"]').val(false);
        }

        $('#ddlTipoDerechoHabiente').val($.trim($('td:eq(10)', tr).text()));

        selectedDerechoHabiente = tr;
        $('#dialogDerechoHabiente').dialog('option', 'title', 'Editar Derecho Habiente');
        $('#dialogDerechoHabiente').dialog('open');
    });

    $('#addDerechoHabiente').click(function () {
        $('#hdnAccionDerechoHabiente').val('I');
        $('#hdnDerechoHabiente').val('0');
        $('#hdnPersona').val('0');
        $('#txtNombre').val('');
        $('#txtApPaterno').val('');
        $('#txtApMaterno').val('');
        $('#txtFecNacimiento').val('');
        $("input[name='GRH_Persona.sexo']:checked").val(true);
        $('#hdnDocumento').val('0');
        $('#ddlTipoDocumento').val(0);
        $('#txtDocumento').val('');
        $('#ddlTipoDerechoHabiente').val(0);
        $('#dialogDerechoHabiente').dialog('option', 'title', 'Agregar Derecho Habiente');
        $('#dialogDerechoHabiente').dialog('open');
    });

    $('#dialogDerechoHabiente').dialog({
        autoOpen: false,
        height: 340,
        width: 380,
        resizable: false,
        modal: true,
        buttons: {
            'Enviar': function () {
                var nroRequeridos = 0;
                $('#dialogDerechoHabiente .required').each(function () {
                    if ($(this).val() == '') {
                        nroRequeridos = nroRequeridos + 1;
                        $(this).addClass('required-control');
                    } else {
                        $(this).removeClass('required-control');
                    }
                });

                if (nroRequeridos == 0) {

                    var idPersona = $.trim($('#hdnPersona').val());
                    var idEmpleado = $.trim($('#idEmpleado').val());
                    var idDerechoHabiente = $.trim($('#hdnDerechoHabiente').val());
                    var nombre = $('#txtNombre').val().toUpperCase();
                    var apPaterno = $('#txtApPaterno').val().toUpperCase();
                    var apMaterno = $('#txtApMaterno').val().toUpperCase();
                    var fecNacimiento = $('#txtFecNacimiento').val();
                    var sexo = $("input[name='GRH_Persona.sexo']:checked").val();
                    var idDocumento = $.trim($('#hdnDocumento').val());
                    var idTipoDocumento = $('#ddlTipoDocumento').val();
                    var numDocumento = $('#txtDocumento').val();
                    var idTipoDerechoHabiente = $.trim($('#ddlTipoDerechoHabiente').val());
                    var data = {
                        idPersona: idPersona,
                        idEmpleado: idEmpleado,
                        idDerechoHabiente: idDerechoHabiente,
                        nombre: nombre,
                        apellidoPaterno: apPaterno,
                        apellidoMaterno: apMaterno,
                        fechaNacimiento: fecNacimiento,
                        sexo: sexo,
                        idDocumento: idDocumento,
                        idTipoDocumento: idTipoDocumento,
                        numDocumento: numDocumento,
                        idTipoDerechoHabiente: idTipoDerechoHabiente
                    };                    
                    var url = '/Empleado/SetDerechoHabiente';
                    $.ajax({
                        type: 'POST',
                        url: url,
                        data: data,
                        success: function (result) {
                            if (result.result) {
                                $('#hdnDerechoHabiente').val(result.DerechoHabiente);
                                $('#idPersona').val(result.Persona);
                                if ($('#hdnAccionDerechoHabiente').val() == 'I') {
                                    var fila = "<tr>" +
                                        "<td style=\"display: none;\">" + result.derechoHabiente + "</td>" +
                                        "<td>" + nombre + "</td>" +
                                        "<td>" + apPaterno + "</td>" +
                                        "<td>" + apMaterno + "</td>" +
                                        "<td>" + fecNacimiento + "</td>" +
                                        "<td style=\"display: none;\">" + result.documento + "</td>" +
                                        "<td style=\"display: none;\">" + idTipoDocumento + "</td>" +
                                        "<td>" + $('#ddlTipoDocumento option:selected').text() + "</td>" +
                                        "<td>" + numDocumento + "</td>" +
                                        "<td>" + (sexo?'Masculino':'Femenino') + "</td>" +
                                        "<td style=\"display: none;\">" + idTipoDerechoHabiente + "</td>" +
                                        "<td>" + $('#ddlTipoDerechoHabiente option:selected').text() + "</td>" +
                                        "<td style=\"display: none;\">" + result.persona + "</td>" +
                                        "<td><a class=\"editar\" href=\"javascript:;\">Editar</a> | <a class=\"eliminar\" href=\"javascript:;\">Eliminar</a></td>" +                                        
                                        "</tr>";
                                    $('#tblDerechoHabiente tbody').append(fila);
                                } else {
                                    var tr = selectedDerechoHabiente;
                                    $('td:eq(0)', tr).text(result.derechoHabiente);
                                    $('td:eq(1)', tr).text(nombre);
                                    $('td:eq(2)', tr).text(apPaterno);
                                    $('td:eq(3)', tr).text(apMaterno);
                                    $('td:eq(4)', tr).text(fecNacimiento);
                                    $('td:eq(5)', tr).text(result.documento);
                                    $('td:eq(6)', tr).text(idTipoDocumento);
                                    $('td:eq(7)', tr).text($('#ddlTipoDocumento option:selected').text());
                                    $('td:eq(8)', tr).text(numDocumento);
                                    $('td:eq(9)', tr).text((sexo ? 'Masculino' : 'Femenino'));
                                    $('td:eq(10)', tr).text(idTipoDerechoHabiente);
                                    $('td:eq(11)', tr).text($('#ddlTipoDerechoHabiente option:selected').text());
                                    $('td:eq(12)', tr).text(result.persona);                                    
                                }
                                $('#dialogDerechoHabiente').dialog('close');
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