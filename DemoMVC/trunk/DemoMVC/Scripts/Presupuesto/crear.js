﻿$(document).ready(function () {
    try {
        var textoNoticia = $('.head-noticia').next();
        if (textoNoticia.hasClass('texto-noticia')) {
            if (textoNoticia.css('display') == 'none') {
                textoNoticia.slideDown();
            }
            else {
                textoNoticia.slideUp();
            }
        }
        calcularTotales();
    } catch (ex) {
    }

    $('.cantidad').change(function () {
        var tr = $(this).parent().parent();
        var montoFijo = $.trim($('td:eq(3)', tr).text());
        var cantidad = $(this).val();
        $('td:eq(5)', tr).text(montoFijo * cantidad);
        calcularTotales();
    });

    function calcularTotales() {
        var costoTotalFijo = 0;
        var cantidad = 0;
        var costoTotalFinal = 0;

        $('#tblListadoEquipos tbody tr').each(function () {            
            costoTotalFijo +=parseFloat($.trim($('td:eq(3)', $(this)).text()));
            cantidad += parseFloat($(this).find('.cantidad').val());
            costoTotalFinal += parseFloat($.trim($('td:eq(5)', $(this)).text()));            
        });
        $('#costoTotalFijo').text(costoTotalFijo);
        $('#cantidad').text(cantidad);
        $('#costoTotalFinal').text(costoTotalFinal);
    }

    $('#btnGrabar').click(function () {

        var formDataDetalle = new Array();
        $('#tblListadoEquipos tbody tr').each(function () {
            formDataDetalle.push({
                'idMaquinariaEquipo': $.trim($('td:eq(0)', $(this)).text()),
                'cantidadMantenimiento': $(this).find('.cantidad').val(),
                'montoAprobado': $.trim($('td:eq(5)', $(this)).text())
            }
                        );
        });


        var formData = new Array();
        formData.push({
            'ano': $('#txtAno').val(),
            'descripcion': $('#txtDescripcion').val(),
            'costoTotalFijo': $('#costoTotalFijo').text(),
            'cantidad':$('#cantidad').text(),
            'costoTotalFinal':$('#costoTotalFinal').text(),
            'formDataDetalle': formDataDetalle
        });

        url = '/Presupuesto/SetPresupuesto';
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