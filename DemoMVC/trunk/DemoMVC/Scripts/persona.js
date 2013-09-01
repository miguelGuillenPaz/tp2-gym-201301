$(document).ready(function () {

    $('#btnEnviar').click(function () {

        var nroRequeridos = 0;
        $('.required').each(function () {
            if ($(this).val() == '') {
                nroRequeridos = nroRequeridos + 1;
                $(this).addClass('required-control');
            } else {
                $(this).removeClass('required-control');
            }
        });

        if (nroRequeridos == 0) {
            var idPersona = $.trim($('#IdPersona').val());
            if (idPersona == '')
                idPersona = 0;
            var nombre = $.trim($('#Nombre').val()).toUpperCase();
            var apellidoPaterno = $.trim($('#ApellidoPaterno').val()).toUpperCase();
            var apellidoMaterno = $.trim($('#ApellidoMaterno').val()).toUpperCase();
            var idEstadoCivil = $.trim($('#IdEstadoCivil').val());
            var sexo = $("input[name='Sexo']:checked").val();
            var direccion = $.trim($('#Direccion').val()).toUpperCase();
            var idPaisR = $.trim($('#IdPaisResidencia').val());
            var fechaNacimiento = $.trim($('#FechaNacimiento').val());
            var idPaisN = $.trim($('#IdPaisNacionalidad').val());
            var disponibilidad = $.trim($('#Disponibilidad').val()).toUpperCase();
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
                idPaisN: idPaisN,
                disponibilidad: disponibilidad
            };

            var url = '/Postulante/SetPersona';
            $.ajax({
                type: 'POST',
                url: url,
                data: data,
                success: function (result) {
                    if (result.result) {
                        $('#idPersona').val(result.Persona);                        
                        $("#dialogConfirm #confirm").text('Actualización satisfactoria.');
                        $("#dialogConfirm").dialog({
                            resizable: false,
                            height: 140,
                            modal: true,
                            buttons: {
                                "Aceptar": function () {
                                    $(this).dialog("close");
                                    window.location.href = '/Postulante/Detalle/' + result.Persona;
                                }                        
                            }
                        });
                    }
                },
                error: function () {
                    __ShowMessage('No se pudo actualizar');
                }
            });
        } else {
            __ShowMessage('Existen campos obligatorios sin llenar.');
        }
    });


});