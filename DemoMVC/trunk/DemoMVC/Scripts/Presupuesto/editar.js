$(document).ready(function () {

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
            'idPptoMtoPreventivo': $('idPptoMtoPreventivo').val(),
            'ano': $('#txtAno').val(),
            'descripcion': $('#txtDescripcion').val(),
            'costoTotalFijo': $('#costoTotalFijo').text(),
            'cantidad': $('#cantidad').text(),
            'costoTotalFinal': $('#costoTotalFinal').text(),
            'formDataDetalle': formDataDetalle
        });
        alert(JSON.stringify(formData));
        url = '/Presupuesto/EditarPresupuesto';
        $.ajax({
            url: url,
            type: 'POST',
            datatype: "json",
            traditional: true,
            data: {
                formData: JSON.stringify(formData)
            },
            success: function (result) {
                if (result.result) {
                    window.location.href = '/Presupuesto';
                }
            },
            error: function () {
                __ShowMessage('No se pudo grabar');
            }
        });
    });

});   