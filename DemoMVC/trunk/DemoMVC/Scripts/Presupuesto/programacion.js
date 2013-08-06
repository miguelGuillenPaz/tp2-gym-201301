$(document).ready(function () {

    var selectedPresupuesto;

    $('#tblListadoProgramacion').delegate('.eliminar', "click", function () {
        var tr = $(this).parent().parent();
        var id = $.trim($('td:eq(0)', tr).text());
        if (id != 0) {
            if (confirm('¿Desea eliminar la Programación?')) {
                var data = { id: id };
                var url = '/ProgramacionPreventiva/Eliminar';
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


    $('#addFecha').click(function () {
       
        $('#dialogFechaProgramacion').dialog('option', 'title', 'Agregar Fecha');
        $('#dialogFechaProgramacion').dialog('open');
    });

    $('#dialogFechaProgramacion').dialog({
        autoOpen: false,
        height: 100,
        width: 100,
        resizable: false,
        modal: true,
        buttons: {
            'Enviar': function () {
                    var id = $('#hdnIdDetalle')
                    var fecha = $.trim($('#txtFecha').val());
                    var data = {
                        id: id,
                        fecha: fecha
                    };
                    var url = '/ProgramacionPreventiva/SetFecha';
                    $.ajax({
                        type: 'POST',
                        url: url,
                        data: data,
                        success: function (result) {
                            if (result.result) {                               
                               
                               
                                    var fila = "<tr>" +
                                        "<td style=\"display: none;\">" + "0" + "</td>" +
                                        "<td>" + "0" + "</td>" +
                                        "<td>" + $('#txtFecha').val() + "</td>" +
                                        "<td>" + "0" + "</td>" +
                                        "<td><a class=\"eliminar\" href=\"javascript:;\">Editar</a></td>" +
                                        "</tr>";
                                    $('#tblListadoProgramacion tbody').append(fila);

                                    $('#dialogFechaProgramacion').dialog('close');
                            }
                        },
                        error: function () {
                            __ShowMessage('No se pudo agregar');
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