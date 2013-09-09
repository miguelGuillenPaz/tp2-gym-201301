var idTipoContrato = 0;

$("document").ready(function () {

    var nroClausula = 0;
    var cadClausula = '';
    cadClausula += '<div class="fila">';
    cadClausula += '    <div class="col1 paddingTop">Cláusula 1:</div>';
    cadClausula += '    <div class="col6"><input id="txtClau_1" type="text" class="text10" /></div>';
    cadClausula += '</div>';

    $('#cboTipoContrato').change(function () {
        idTipoContrato = $(this).val();
        $('#tipo_1, #tipo_2, #tipo_3').hide();
        $('#tipo_' + idTipoContrato).show();
    });

    $('#chkClausula').change(function () {
        if ($(this).is(":checked")) {
            $('#clausulas').show();
            nroClausula = 1;
        }
        else {
            $('#clausulas').hide();
            nroClausula = 0;
        }
    });

    $('.lnkAgregar').click(function (e) {
        e.preventDefault();
        nroClausula += 1;
        addAnotherTextBox();
    });

    function addAnotherTextBox() {
        var cad = '';
        cad += '<div class="fila">';
        cad += '    <div class="col1 paddingTop">Cláusula ' + nroClausula + ':</div>';
        cad += '    <div class="col6"><input id="txtClau_' + nroClausula + '" type="text" class="text10" /></div>';
        cad += '</div>';
        $("#dynClausulas").append(cad);
    }

});