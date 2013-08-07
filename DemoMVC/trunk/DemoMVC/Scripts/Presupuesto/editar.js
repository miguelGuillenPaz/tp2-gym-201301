$(document).ready(function () {

    $('#ano').keypress(
            function (event) {
                //Allow only backspace and delete                
                if (event.keyCode != 48 && event.keyCode != 46 && event.keyCode != 8) {
                    if (!parseInt(String.fromCharCode(event.which))) {
                        event.preventDefault();
                    }
                }
            }
        );
    
    $('#btnGrabar').click(function () {        
        var formDataDetalle = new Array();
        $('#tblListadoEquipos tbody tr').each(function () {
            formDataDetalle.push({
                'idMaquinariaEquipo': $.trim($('td:eq(0)', $(this)).text()),
                'cantidadMantenimiento': $(this).find('.cantidad').val(),
                'montoAprobado': $.trim($('td:eq(5)', $(this)).text()),
                'idDetallePptoMtoPreventivo': $.trim($('td:eq(6)', $(this)).text())
            });
        });

        var formData = new Array();
        formData.push({
            'idPptoMtoPreventivo': $('#idPptoMtoPreventivo').val(),
            'ano': $('#ano').val(),
            'descripcion': $('#descripcion').val().toUpperCase(),
            'costoTotalFijo': $('#costoTotalFijo').text(),
            'cantidad': $('#cantidad').text(),
            'costoTotalFinal': $('#costoTotalFinal').text(),
            'formDataDetalle': formDataDetalle
        });
        
        $.ajax({
            url: '/Presupuesto/EditarPresupuesto',
            type: 'POST',
            datatype: "json",
            traditional: true,
            data: {
                formData: JSON.stringify(formData)
            },
            success: function (result) {
                if (result.result) {
                    window.location.href = '/Presupuesto';
                } else {
                    __ShowMessage(result.error);
                }
            },
            error: function () {
                __ShowMessage('No se pudo grabar');
            }
        });
    });

});   