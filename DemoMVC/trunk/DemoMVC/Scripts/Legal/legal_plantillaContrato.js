var arrClausulas = [];
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
            arrClausulas = [];
        }
    });

    //Validaciones campos
    $("#txtDni, #txtDniRL, #txtDniMod, #txtRuc").keypress(function (e) {
    if (!/[0-9]/.test(String.fromCharCode(e.which)))
    return false;
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

    $('.btnGrabarReqLegal').click(function (e) {
        e.preventDefault();
        grabarReqLegal();
    });

    //---------
    function grabarReqLegal() {

        var validoFormCampos = false;
        var validoClausulas = true;
        var totClauLlenas = 0;

        var idPro = $('#idProyecto');
        var idTipoContrato = $('#cboTipoContrato');
        var desc = $('#txtDescripcion');

        if (idPro.val() <= 0) {
            alert('Debe seleccionar el proyecto asociado al requerimiento legal a solicitar.');
            idPro.focus();
            return;
        }
        else if (idTipoContrato.val() <= 0) {
            alert('Debe seleccionar un tipo de contrato.');
            idTipoContrato.focus();
            return;
        }
        else if (desc.val() == '') {
            alert('Debe ingresar una descripción del requerimiento legal a solicitar.');
            desc.focus();
            return;
        }

        //Plazo Indeterminado
        var nom = $('#txtNombre').val();
        var dni = $('#txtDni').val();
        var cargo = $('#txtCargo').val();
        var labor = $('#txtLabor').val();
        var iniLab = $('#txtIniTrabajo').val();
        var finLab = $('#txtFinTrabajo').val();
        var iniRefri = $('#txtIniRefri').val();
        var finRefri = $('#txtFinRefri').val();
        var periodo = $('#txtPeriodo').val();

        //Prestacion Servicios
        var outsourcing = $('#txtOutsourcing').val();
        var ruc = $('#txtRuc').val();
        var domicilio = $('#txtDomicilio').val();
        var representante = $('#txtRepresentante').val();
        var dniRepresentante = $('#txtDniRL').val();
        var fichaPJ = $('#txtFicha').val();
        var objetoSocial = $('#txtObjetoOutsourcing').val();
        var servicios = $('#txtServicio').val();
        var duracion = $('#txtDuracion').val();
        var juez = $('#txtJuez').val();

        //Sujeto Modalidad
        var nomSM = $('#txtNombreMod').val();
        var dniSM = $('#txtDniMod').val();
        var modalidad = $('#txtModalidad').val();
        var duracionSM = $('#txtDuracionMod').val();
        var iniLabSM = $('#txtIniTrabajoMod').val();
        var finLabSM = $('#txtFinTrabajoMod').val();
        var iniRefriSM = $('#txtIniRefriMod').val();
        var finRefriSM = $('#txtFinRefriMod').val();
        var juezMod = $('#txtJuezMod').val();

        //alert("nom: " + nom + ", dni: " + dni + ", cargo: " + cargo + ", labor: " + labor + ", iniLab: " + iniLab + ", finLab: " + finLab + ", iniRefri: " + iniRefri + ", finRefri: " + finRefri + ", periodo: " + periodo);

        //validar
        if (idTipoContrato.val() == 1) {
            //Plazo Indeterminado
            if (nom != '' && dni != '' && cargo != '' && labor != '' && iniLab != '' && finLab != '' && iniRefri != '' && finRefri != '' && periodo != '') {
                validoFormCampos = true;
            }
            else {
                alert('Todos los campos son requeridos.');
                return;
            }
        }

        else if (idTipoContrato.val() == 2) {
            if (outsourcing != '' && ruc != '' && domicilio != '' && representante != '' && dniRepresentante != '' && fichaPJ != '' && objetoSocial != '' && servicios != '' && duracion != '' && juez != '') {
                validoFormCampos = true;
            }
            else {
                alert('Todos los campos son requeridos.');
                return;
            }
        }

        else if (idTipoContrato.val() == 3) {
            if (nomSM != '' && dniSM != '' && modalidad != '' && duracionSM != '' && iniLabSM != '' && finLabSM != '' && iniRefriSM != '' && finRefriSM != '' && juezMod != '') {
                validoFormCampos = true;
            }
            else {
                alert('Todos los campos son requeridos.');
                return;
            }
        }

        
        if ($('#chkClausula').is(":checked")) {
            for (var z = 1; z <= nroClausula; z++) {
                var clau = $('#txtClau_' + z).val();
                if (clau != '') {
                    totClauLlenas += 1;
                    arrClausulas.push({
                        'DescripcionClausula': clau
                    });
                }
            }
            //alert(arrClausulas.length);
            if (totClauLlenas < 1) { //si indico clausulas adicionales, pero no ingreso al menos una
            //if (!todasClausulasConTexto) { //si indico clausulas adicionales, pero no ingreso ninguna o dejo alguna en blanco
                validoClausulas = false;
            }
        }

        //alert('validoFormCampos: ' + validoFormCampos);
        //alert('validoClausulas: ' + validoClausulas);
        //si el formulario está completo, Grabar. Si no, mostrar mensaje de error
        if (validoFormCampos) {

            if (validoClausulas) {

                $.ajax({
                    //url: config.contextPath + 'Legal/Confirmacion?idPro=' + idPro + '&desc=' + desc + '&arrVecinos=' + JSON.stringify(arrVecinos),
                    url: config.contextPath + 'Legal/ConfirmacionPlantillaContrato?idPro=' + idPro.val() + '&tipoContrato=' + idTipoContrato.val() + '&desc=' + desc.val()
                      + '&nombreTrab=' + nom + '&dniTrab=' + dni + '&cargoTrab=' + cargo + '&laborDesempenar=' + labor + '&horaIniLabor=' + iniLab + '&horaFinLabor=' + finLab + '&horaIniRefri=' + iniRefri + '&horaFinRefri=' + finRefri + '&periodoPrueba=' + periodo
                      + '&outsourcing=' + outsourcing + '&ruc=' + ruc + '&domicilio=' + domicilio + '&representante=' + representante + '&dniRepresentante=' + dniRepresentante + '&fichaPJ=' + fichaPJ + '&objetoSocial=' + objetoSocial + '&servicios=' + servicios + '&duracion=' + duracion + '&juez=' + juez
                      + '&nomSM=' + nomSM + '&dniSM=' + dniSM + '&modalidad=' + modalidad + '&duracionSM=' + duracionSM + '&iniLabSM=' + iniLabSM + '&finLabSM=' + finLabSM + '&iniRefriSM=' + iniRefriSM + '&finRefriSM=' + finRefriSM + '&juezMod=' + juezMod
                      + '&arrClausulas=' + JSON.stringify(arrClausulas),
                    type: 'POST',
                    datatype: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (result) {
                        //alert('La solicitud de su requerimiento legal ha sido registrada.\nEspere por su atención.');
                        document.location.href = config.contextPath + 'Legal/RegistrarContratos';
                    },
                    error: function (request, status, err) {
                    }
                });

            }
            else {
                alert('Si indica incluir cláusulas adicionales, debe ingresar por lo menos una.');
            }

        }
        else {
            alert('Todos los campos son requeridos.');
        }

    }

});