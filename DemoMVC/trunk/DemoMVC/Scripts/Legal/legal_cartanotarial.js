//Variable global
var arrPersonas = [];

$("document").ready(function () {

    //-----------------------------------------------------------------------------------------------
    //Cargas iniciales
    $("input[name='optTipoEdif']").removeAttr('checked');
    estadoNomCond(0);
    $('#personas').hide();
    $('.btnEliminarVecino').hide();

    //-----------------------------------------------------------------------------------------------
    //Validaciones campos
    /*$("#txtDNIVecino").keypress(function (e) {
    if (!/[0-9]/.test(String.fromCharCode(e.which)))
    return false;
    });*/

    //-----------------------------------------------------------------------------------------------
    //Eventos de links (botones)

    $("input[name='optTipoEdif']").change(function () {
        if ($(this).val() === 'CON') {
            estadoNomCond(1);
        }
        if ($(this).val() === 'CAS') {
            estadoNomCond(0);
        }
    });

    //Agregar persona a la grilla
    $('.btnAgregarVecino').click(function (e) {
        e.preventDefault();

        var tipoEdif = ($("input[name='optTipoEdif']:checked").val() != undefined) ? $("input[name='optTipoEdif']:checked").val() : '';
        var nomCond = $('#txtNombreCondominio').val();
        var nom = $('#txtNombreVecino').val();
        var ape = $('#txtApellidoVecino').val();
        var dir = $('#txtDireccionVecino').val();
        var dis = $('#cboDistrito').val();
        var nomDis = $('#cboDistrito option:selected').html();
        var idDocId = $('#cboTipoDocIdentidad').val();
        var nroDoc = $('#txtDNIVecino').val();


        if (tipoEdif != '' && nom != '' && ape != '' && dir != '' && dis > 0 && idDocId > 0 && nroDoc != '') {
            if (tipoEdif == 'CON' && nomCond == '') {
                alert('Debe ingresar el nombre del condominio.');
                $('#txtNombreCondominio').focus();
            }
            else if (idDocId == 1 && nroDoc.length < 8) {
                alert('El número de DNI ingresado es inválido.');
                $('#txtDNIVecino').focus();
            }
            else {
                addPersona(tipoEdif.toString(), nom, ape, nomCond, dir, dis, nomDis, idDocId, nroDoc);
                $("input[name='optTipoEdif']").removeAttr('checked');
                $('#datosPersonas input[type=text]').val('');
                $("#cboDistrito").val($("#cboDistrito option:first").val());
                $("#cboTipoDocIdentidad").val($("#cboTipoDocIdentidad option:first").val());
                estadoNomCond(0);
            }
        }
        else {
            //alert('tipoEdif:' + tipoEdif + ', nomCond: ' + nomCond + ', dis: ' + dis);
            alert('Todos los campos son requeridos.');
        }
    });

    //Eliminar persona(s) de la grilla
    $('.btnEliminarVecino').click(function (e) {
        e.preventDefault();

        var arrChecked = new Array();
        $('#personas input:checked').each(function () {
            arrChecked.push($(this).attr('value'));
        });

        if (arrChecked.length > 0) {

            if (confirm("¿Desea eliminar a la(s) persona(s) seleccionada(s) del listado?")) {

                for (var i = 0; i < arrChecked.length; i++) {
                    var val = arrChecked[i];
                    //arrPersonas.splice(val, 1);
                    for (var j = 0; j < arrPersonas.length; j++) {
                        if (arrPersonas[j].p.cNroDocIdentidad === val) {
                            arrPersonas.splice(j, 1);
                        }
                    }
                }

                buildGrilla(arrPersonas);
            }
        }
        else {
            alert('Debe seleccionar una persona por lo menos.');
        }
    });



    //Grabar Requerimiento Legal
    $('.btnGrabarReqLegal').click(function (e) {
        e.preventDefault();
        grabarReqLegal();

    });

    //----------------------------------------------------------------------------
    //Funciones

    function addPersona(tipoEdif, nom, ape, nomCond, dir, dis, nomDis, idDocId, nroDoc) {
        var nomTipoEdif = "";
        switch (tipoEdif) {
            case 'CAS':
                nomTipoEdif = "Casa";
                break;
            case 'CON':
                nomTipoEdif = "Condominio";
                break;
        }

        nomCond = (nomCond != "") ? nomCond : "-";

        arrPersonas.push({
            'p':
                            {
                                'cNombre': nom,
                                'cApellido': ape,
                                'cDireccion': dir,
                                'idDist': dis,
                                'nomDis': nomDis,
                                'cTipoEdificacion': tipoEdif,
                                'nomTipoEdif': nomTipoEdif,
                                'cNombreCondominio': nomCond,
                                'IdDocIdentidad': idDocId,
                                'cNroDocIdentidad': nroDoc
                            }
        });



        buildGrilla(arrPersonas);
    }

});

//-------------------------------------------------------------------------------------------------------------------------------------
//Funciones útiles

function buildGrilla(arrPersonas) {
    if (arrPersonas.length > 0) {
        var cad = '';
        for (var i = 0; i < arrPersonas.length; i++) {
            cad += '<div class="fila">';
            cad += '	<div class="colNombre"><label name="nomPer_' + (i + 1) + '">' + arrPersonas[i].p.cNombre + ' ' + arrPersonas[i].p.cApellido + '</label></div>';
            cad += '	<div class="colDireccion">' + arrPersonas[i].p.cDireccion + '</div>';
            cad += '	<div class="colDistrito">' + arrPersonas[i].p.nomDis + '</div>';
            cad += '	<div class="colTipoEdif">' + arrPersonas[i].p.nomTipoEdif + '</div>';
            cad += '	<div class="colNomCond">' + arrPersonas[i].p.cNombreCondominio + '</div>';
            cad += '	<div class="colEliminar final"><input name="" type="checkbox" value="' + arrPersonas[i].p.cNroDocIdentidad + '" /></div>';
            cad += '</div>';
        }
        $('label#grillaVacia').hide();
        $('#personas').html(cad);
        $('#personas').show();
        $('.btnEliminarVecino').show();
    }
    else {
        $('#personas').html('');
        $('#personas').hide();
        $('.btnEliminarVecino').hide();
        $('label#grillaVacia').show();
    }
}

function estadoNomCond(estado) {
    switch (estado) {
        case 1:
            $('#txtNombreCondominio').attr('disabled', false);
            $('#txtNombreCondominio').removeClass('disabled');
            $('#txtNombreCondominio').focus();
            break;

        case 0:
            $('#txtNombreCondominio').val('');
            $('#txtNombreCondominio').attr('disabled', 'disabled');
            $('#txtNombreCondominio').addClass('disabled');
            break;
    }
}

//Lo llama el botón Grabar
function validarForm() {
    //var idPro = $('#cboProyecto');
    var idPro = $('#idProyecto');
    var desc = $('#txtDescripcion');

    if (idPro.val() <= 0) {
        alert('Debe seleccionar el proyecto asociado al requerimiento legal a solicitar.');
        idPro.focus();
        return false;
    }
    else if (desc.val() == '') {
        alert('Debe ingresar una descripción del requerimiento legal a solicitar.');
        desc.focus();
        return false;
    }
    else if (arrPersonas.length <= 0) {
        alert("Debe ingresar al menos un vecino a quien generarle una carta notarial.");
        return false;
    }
    return true;
}

function grabarReqLegal() {
    if (validarForm()) {

        var idPro = $('#idProyecto').val();
        var desc = $('#txtDescripcion').val();

        var arrVecinos = [];

        for (var i = 0; i < arrPersonas.length; i++) {
            arrVecinos.push({
                'cNombre': arrPersonas[i].p.cNombre,
                'cApellido': arrPersonas[i].p.cApellido,
                'cDireccion': arrPersonas[i].p.cDireccion,
                'idDist': arrPersonas[i].p.idDist,
                'idDep': 1,
                'idProv': 1,
                'cTipoEdificacion': arrPersonas[i].p.cTipoEdificacion,
                'cNombreCondominio': arrPersonas[i].p.cNombreCondominio,
                'IdDocIdentidad': arrPersonas[i].p.idDocId,
                'cNroDocIdentidad': arrPersonas[i].p.cNroDocIdentidad
            });

        }

        $.ajax({
            url: config.contextPath + 'Legal/Confirmacion?idPro=' + idPro + '&desc=' + desc + '&arrVecinos=' + JSON.stringify(arrVecinos),
            type: 'POST',
            datatype: 'json',
            contentType: 'application/json; charset=utf-8',
            success: function (result) {
                alert('La solicitud de su requerimiento legal ha sido registrada.\nEspere por su atención.');
                document.location.href = config.contextPath + 'Legal/Registrar';
            },
            error: function (request, status, err) {
            }
        });
    }
}

function ListaVecinos(nom, ape, dir, dis, dep, prov, tipoEdif, nomCond, idDocId, nroDoc) {
    this.cNombre = nom;
    this.cApellido = ape;
    this.cDireccion = dir;
    this.idDist = dis;
    this.idDep = dep;
    this.idProv = prov;
    this.cTipoEdificacion = tipoEdif;
    this.cNombreCondominio = nomCond;
    this.IdDocIdentidad = idDocId;
    this.cNroDocIdentidad = nroDoc;
}