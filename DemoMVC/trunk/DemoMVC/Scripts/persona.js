$(document).ready(function () {

    $('#btnEnviar').click(function () {
        var idPersona = $.trim($('#idPersona').val());
        if (idPersona == '')
            idPersona = 0;
        var nombre = $.trim($('#nombre').val());
        var apellidoPaterno = $.trim($('#apellidoPaterno').val());
        var apellidoMaterno = $.trim($('#apellidoMaterno').val());
        var idEstadoCivil = $.trim($('#idEstadoCivil').val());
        var sexo = $("input[name='sexo']:checked").val();
        var direccion = $.trim($('#direccion').val());
        var idPaisR = $.trim($('#idPais_R').val());
        var fechaNacimiento = $.trim($('#fechaNacimiento').val());
        var idPaisN = $.trim($('#idPais_N').val());
        var data = {
            idPersona: idPersona,
            nombre: nombre,
            apellidoPaterno: apellidoPaterno,
            apellidoMaterno: apellidoMaterno,
            idEstadoCivil: idEstadoCivil,
            sexo: sexo,
            direccion: direccion,
            idPaisR: idPaisR,
            fechaNacimiento: fechaNacimiento,
            idPaisN: idPaisN
        };
        alert(JSON.stringify(data));
        var url = '/Persona/SetPersona';
        $.ajax({
            type: 'POST',
            url: url,
            data: data,
            success: function (result) {
                if (result.result) {
                    $('#idPersona').val(result.Persona);
                    window.location.href = '/Persona/Mostrar/' + result.Persona;
                }
            },
            error: function () {
                __ShowMessage('No se pudo actualizar');
            }
        });
    });


});