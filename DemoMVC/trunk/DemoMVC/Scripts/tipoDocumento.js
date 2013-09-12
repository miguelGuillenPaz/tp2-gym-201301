$(document).ready(function () {

    $('#tblTipoDocumento').delegate('.eliminar', "click", function () {
        var tr = $(this).parent().parent();
        var idTipoDocumento = $.trim($('td:eq(0)', tr).text());
        if (idTipoDocumento != 0) {
            $('#dialogConfirm #confirm').text('¿Desea eliminar el Tipo de Documento?');
            $('#dialogConfirm').dialog({
                resizable: false,
                height: 140,
                
                modal: true,
                buttons: {
                    'Aceptar': function () {
                        var data = { id: idTipoDocumento };
                        var url = '/TipoDocumento/Eliminar';
                        $.ajax({
                            type: 'POST',
                            url: url,
                            data: data,
                            success: function (result) {
                                if (result.result) {
                                    tr.remove();
                                    var cantActual = parseInt($('#cant').html());

                                    cantActual--;
                                    __ShowMessage('Registro eliminado satisfactoriamente.');
                                    $('#cant').html(cantActual);
                                    
                                }
                            },
                            error: function () {
                                __ShowMessage('No se pudo eliminar. Este tipo de Documento se encuentra en uso.');
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