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
            cantidad += parseFloat($.trim($('td:eq(4)', $(this)).text()));
            costoTotalFinal += parseFloat($.trim($('td:eq(5)', $(this)).text()));            
        });
        $('#costoTotalFijo').text(costoTotalFijo);
        $('#cantidad').text(cantidad);
        $('#costoTotalFinal').text(costoTotalFinal);
    }
    
});   