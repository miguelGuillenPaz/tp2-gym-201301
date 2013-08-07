$(document).ready(function () {

    $('#btnBuscar').click(function () {        
        $('#tblListadoEquipos tbody tr').each(function () {
            var paramDescripcion = $('#txtParametro').val().toUpperCase();
            var paramTipo = $('#ddlTipo').val().toUpperCase();
            var descripcion = $.trim($('td:eq(2)', $(this)).text()).toUpperCase();
            var tipo = $.trim($('td:eq(7)', $(this)).text()).toUpperCase();
            var d = descripcion.indexOf(paramDescripcion);
            var t = tipo.indexOf(paramTipo);            
            if (d > -1 && t>-1) {
                $(this).show();
            } else {
                $(this).hide();                
            }
        });

    });

});   