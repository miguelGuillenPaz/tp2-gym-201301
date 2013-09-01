$(document).ready(function () {

    $('#tblConvocatoria').delegate('.eliminar', "click", function () {
        var tr = $(this).parent().parent();
        var idConvocatoria = $.trim($('td:eq(0)', tr).text());
        if (idConvocatoria != 0) {
            $('#dialogConfirm #confirm').text('¿Desea eliminar la convocatoria?');
            $('#dialogConfirm').dialog({
                resizable: false,
                height: 140,
                modal: true,
                buttons: {
                    'Aceptar': function () {
                        var data = { id: idConvocatoria };
                        var url = '/Convocatoria/Eliminar';
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


});