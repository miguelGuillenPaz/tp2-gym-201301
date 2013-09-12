$(document).ready(function () {

    $('#tblEstado').delegate('.eliminar', "click", function () {
        var tr = $(this).parent().parent();
        var idEstado = $.trim($('td:eq(0)', tr).text());
        if (idEstado != 0) {
            $('#dialogConfirm #confirm').text('¿Desea eliminar el Estado de Documento?');
            $('#dialogConfirm').dialog({
                resizable: false,
                height: 140,
                modal: true,
                buttons: {
                    'Aceptar': function () {
                        var data = { id: idEstado };
                        var url = '/Estado/Eliminar';
                        $.ajax({
                            type: 'POST',
                            url: url,
                            data: data,
                            success: function (result) {
                                if (result.result) {
                                    tr.remove();
                                    var cantActual = parseInt($('#cantEstados').html());

                                    cantActual--;
                                    __ShowMessage('Registro eliminado satisfactoriamente.');
                                    $('#cantEstados').html(cantActual);
                                }
                            },
                            error: function () {
                                __ShowMessage('No se pudo eliminar. Este registro se encuentra en uso.');
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