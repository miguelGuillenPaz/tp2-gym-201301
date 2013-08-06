$(document).ready(function () {

    $('#btnBuscar').click(function () {        
        $('#tblListadoEquipos tbody tr').each(function () {
            var parametro = $('#txtParametro').val().toUpperCase();
            var texto = $.trim($('td:eq(2)', $(this)).text()).toUpperCase();
            var n = texto.indexOf(parametro);            
            if (n > -1) {
                $(this).show();
            } else {
                $(this).hide();                
            }
        });

    });

});   