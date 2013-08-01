$(document).ready(function () {

    var selectedIdiomaPersona;

    $('#tblIdiomaPersona').delegate('.eliminar', "click", function () {
        var tr = $(this).parent().parent();
        var idIdiomaPersona = $.trim($('td:eq(0)', tr).text());
        if (idIdiomaPersona != 0) {
            if (confirm('¿Desea eliminar el idioma?')) {
                var data = { idIdiomaPersona: idIdiomaPersona };
                var url = '/Persona/DelIdiomaPersona';
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
                        alert('No se pudo eliminar');
                    }
                });
            }
        } else {
            tr.remove();
        }
    });


    $('#tblIdiomaPersona').delegate('.editar', "click", function () {
        $('#hdnAccionIdiomaPersona').val('U');
        var tr = $(this).parent().parent();
        $('#hdnIdiomaPersona').val($.trim($('td:eq(0)', tr).text()));        
        $('#txtIdiomaPersona').val($.trim($('td:eq(1)', tr).text()));
        selectedIdiomaPersona = tr;
        $('#dialogIdiomaPersona').dialog('option', 'title', 'Editar IdiomaPersona');
        $('#dialogIdiomaPersona').dialog('open');
    });

    $('#addIdiomaPersona').click(function () {
        $('#hdnAccionIdiomaPersona').val('I');
        $('#hdnIdiomaPersona').val('0');
        $('#txtIdiomaPersona').val('');
        $('#dialogIdiomaPersona').dialog('option', 'title', 'Agregar IdiomaPersona');
        $('#dialogIdiomaPersona').dialog('open');
    });

    $('#dialogIdiomaPersona').dialog({
        autoOpen: false,
        height: 130,
        width: 300,
        resizable: false,
        modal: true,
        buttons: {
            'Enviar': function () {
                var idPersona = $.trim($('#idPersona').val());
                if (idPersona == '') {
                    idPersona = '0';
                }
                var idIdiomaPersona = $.trim($('#hdnIdiomaPersona').val());
                var cuentaIdiomaPersona = $.trim($('#txtIdiomaPersona').val());
                var data = {
                    idPersona: idPersona,
                    idIdiomaPersona: idIdiomaPersona,
                    cuentaIdiomaPersona: cuentaIdiomaPersona
                };
                var url = '/Persona/SetIdiomaPersona';
                $.ajax({
                    type: 'POST',
                    url: url,
                    data: data,
                    success: function (result) {
                        if (result.result) {
                            $('#hdnIdiomaPersona').val(result.IdiomaPersona);
                            $('#idPersona').val(result.Persona);
                            if ($('#hdnAccionIdiomaPersona').val() == 'I') {
                                var fila = "<tr>" +
                                        "<td style=\"display: none;\">" + $('#hdnIdiomaPersona').val() + "</td>" +
                                        "<td>" + $('#txtIdiomaPersona').val() + "</td>" +
                                        "<td><a class=\"editar\" href=\"javascript:;\">Editar</a> | <a class=\"eliminar\" href=\"javascript:;\">Eliminar</a></td>" +
                                        "</tr>";
                                $('#tblIdiomaPersona tbody').append(fila);
                            } else {
                                var tr = selectedIdiomaPersona;
                                $('td:eq(0)', tr).text($('#hdnIdiomaPersona').val());
                                $('td:eq(1)', tr).text($('#txtIdiomaPersona').val());
                            }
                            $('#dialogIdiomaPersona').dialog('close');
                        }
                    },
                    error: function () {
                        alert('No se pudo actualizar');
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