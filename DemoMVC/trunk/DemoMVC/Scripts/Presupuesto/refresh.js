$(document).ready(function () {
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
        var montoFijo = parseFloat($.trim($('td:eq(3)', tr).text()));
        var cantidad = parseFloat($(this).val());
        var montoTotal = montoFijo * cantidad;
        $('td:eq(5)', tr).text(montoTotal.toFixed(2));        
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
        $('#costoTotalFijo').text(costoTotalFijo.toFixed(2));
        $('#cantidad').text(cantidad.toFixed(0));
        $('#costoTotalFinal').text(costoTotalFinal.toFixed(2));
    }
    
});   