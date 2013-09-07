var idTipoContrato = 0;

$("document").ready(function () {

    $('#cboTipoContrato').change(function () {
        idTipoContrato = $(this).val();
        $('#tipo_1, #tipo_2, #tipo_3').hide();
        $('#tipo_' + idTipoContrato).show();
    });

});