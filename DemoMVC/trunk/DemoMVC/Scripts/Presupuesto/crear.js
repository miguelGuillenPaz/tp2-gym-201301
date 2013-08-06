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
            } catch (ex) {
            }

            $('#btnGrabar').click(function () {
               var formDataDetalle = new Array();
                    $('#tblListadoEquipos tbody tr').each(function() {
                        formDataDetalle.push({
                                'idMaquinariaEquipo': $.trim($('td:eq(0)', $(this)).text()),
                                'cantidadMantenimiento':  $(this).find('.cantidad').val(),
                                'montoAprobado': $.trim($('td:eq(5)', $(this)).text())
                            }
                        );
                    });


                    var formData = new Array();
                    formData.push({
                        'ano': $('#txtAno').val(), 
                        'descripcion': $('#txtDescripcion').val(),
                        'formDataDetalle': formDataDetalle
                    });                    
                    
                    url = '/Presupuesto/SetPresupuesto';                   
                    $.ajax({                        
                        url: url,
                        type: 'POST',
                        datatype: "json",
                        traditional: true,
                        data: {
                            formData: JSON.stringify(formData)
                        },                        
                        success: function (result) {                            
                            if (result.result) {
                                window.location.href = '/PresupuestoMtoPreventivo';
                            }                            
                        },
                        error: function () {                            
                            __ShowMessage('No se pudo grabar');
                        }
                    });
            });

        });   