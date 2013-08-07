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
        //alert("1");
        $('#dialogFechaProgramacion').dialog('option', 'title', 'Agregar Fecha');
        $('#dialogFechaProgramacion').dialog('open');
    });

    $('#dialogFechaProgramacion').dialog({
        autoOpen: false,
        height: 200,
        width: 400,
        resizable: false,
        modal: true,
        buttons: {
            'Enviar': function () {
                var id = $('#idProgramacionPreventiva').val();
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
                        $('#dialogFechaProgramacion').dialog('close');    
                        if (result.result) {
                            var fila = "<tr>" +
                                        "<td style=\"display: none;\">" + result.id + "</td>" +
                                        "<td>" + ($('#tblListadoProgramacion tbody tr').length + 1) + "</td>" +
                                        "<td>" + $('#txtFecha').val() + "</td>" +
                                        "<td>" + result.dias + "</td>" +
                                        "<td><a class=\"eliminar\" href=\"javascript:;\">Eliminar</a></td>" +
                                        "</tr>";
                            $('#tblListadoProgramacion tbody').append(fila);                                                
                        } else {
                    __ShowMessage(result.error);
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