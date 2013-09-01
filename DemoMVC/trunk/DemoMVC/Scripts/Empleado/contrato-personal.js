$(document).ready(function () {

    var selectedContratoPersonal;

    $('#tblContratoPersonal').delegate('.eliminar', "click", function () {
        var tr = $(this).parent().parent();
        var idContratoPersonal = $.trim($('td:eq(0)', tr).text());
        if (idContratoPersonal != 0) {
            $("#dialogConfirm #confirm").text('¿Desea eliminar el contrato personal?');
            $("#dialogConfirm").dialog({
                resizable: false,
                height: 140,
                modal: true,
                buttons: {
                    "Aceptar": function () {
                        var data = { idContratoPersonal: idContratoPersonal };
                        var url = '/Empleado/DelContratoPersonal';
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
                        $(this).dialog("close");                        
                    },
                    "Cancelar": function () {
                        $(this).dialog("close");
                    }
                }
            });                
        } else {
            tr.remove();
        }
    });


    $('#tblContratoPersonal').delegate('.editar', "click", function () {
        $('#hdnAccionContratoPersonal').val('U');
        var tr = $(this).parent().parent();
        $('#hdnContratoPersonal').val($.trim($('td:eq(0)', tr).text()));        
        $('#txtNumero').val($.trim($('td:eq(1)', tr).text()));        
        $('#txtInicio').val($.trim($('td:eq(2)', tr).text()));
        $('#txtFin').val($.trim($('td:eq(3)', tr).text()));       
        selectedContratoPersonal = tr;
        $('#dialogContratoPersonal').dialog('option', 'title', 'Editar Contrato Personal');
        $('#dialogContratoPersonal').dialog('open');
    });

    $('#addContratoPersonal').click(function () {
        $('#hdnAccionContratoPersonal').val('I');
        $('#hdnContratoPersonal').val('0');
        $('#txtNumero').val('');
        $('#txtInicio').val('');
        $('#txtFin').val('');        
        $('#dialogContratoPersonal').dialog('option', 'title', 'Agregar Contrato Personal');
        $('#dialogContratoPersonal').dialog('open');
    });

    $('#dialogContratoPersonal').dialog({
        autoOpen: false,
        height: 200,
        width: 300,
        resizable: false,
        modal: true,
        buttons: {
            'Enviar': function () {

                var nroRequeridos = 0;
                $('#dialogContratoPersonal .required').each(function () {
                    if ($(this).val() == '') {
                        nroRequeridos = nroRequeridos + 1;
                        $(this).addClass('required-control');
                    } else {
                        $(this).removeClass('required-control');
                    }
                });

                if (nroRequeridos == 0) {
                    var idEmpleado = $.trim($('#IdEmpleado').val());
                    if (idEmpleado == '') {
                        idEmpleado = '0';
                    }
                    var idContratoPersonal = $.trim($('#hdnContratoPersonal').val());
                    var txtNumero = $.trim($('#txtNumero').val().toUpperCase());
                    var txtInicio = $.trim($('#txtInicio').val());
                    var txtFin = $.trim($('#txtFin').val());                    
                    var data = {
                        idEmpleado: idEmpleado,
                        idContratoPersonal: idContratoPersonal,
                        nroContrato:txtNumero,
                        fechaInicio: txtInicio,
                        fechaFin: txtFin
                    };
                    
                    var url = '/Empleado/SetContratoPersonal';
                    $.ajax({
                        type: 'POST',
                        url: url,
                        data: data,
                        success: function (result) {
                            if (result.result) {
                                $('#hdnContratoPersonal').val(result.contratoPersonal);                                
                                if ($('#hdnAccionContratoPersonal').val() == 'I') {
                                    var fila = "<tr>" +
                                        "<td style=\"display: none;\">" + result.contratoPersonal + "</td>" +
                                        "<td>" + txtNumero + "</td>" +
                                        "<td>" + txtInicio + "</td>" +
                                        "<td>" + txtFin + "</td>" +                                        
                                        "<td><a class=\"editar\" href=\"javascript:;\">Editar</a> | <a class=\"eliminar\" href=\"javascript:;\">Eliminar</a></td>" +
                                        "</tr>";
                                    $('#tblContratoPersonal tbody').append(fila);
                                } else {
                                    var tr = selectedContratoPersonal;
                                    $('td:eq(0)', tr).text(idContratoPersonal);
                                    $('td:eq(1)', tr).text(txtNumero);                                    
                                    $('td:eq(2)', tr).text(txtInicio);
                                    $('td:eq(3)', tr).text(txtFin);                                    
                                }                                
                                $("#dialogConfirm #confirm").text('Actualización satisfactoria.');
                                $("#dialogConfirm").dialog({
                                    resizable: false,
                                    height: 140,
                                    modal: true,
                                    buttons: {
                                        "Aceptar": function () {
                                            $(this).dialog("close");
                                            $('#dialogContratoPersonal').dialog('close');
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