<%@ Page Title="Title" Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>"
    MasterPageFile="~/Views/Shared/Site.Master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
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
                $('#lstPerfil').removeAttr('multiple');
            } catch (ex) {
            }

            $('#btnAddEvaluador').click(function () {

                if ($('#lstEvaluadorTodos').val() != null) {
                    var value = $('#lstEvaluadorTodos').val();
                    var text = $('#lstEvaluadorTodos option:selected').text();

                    var data = {
                        idPerfil: $('#IdPerfil').val(),
                        idEmpleado: value
                    };
                    $.ajax({
                        type: 'POST',
                        url: '/Evaluacion/SetEvaluador',
                        data: data,
                        success: function (result) {
                            if (result.result) {
                                $('#lstEvaluadorSeleccionados').append('<option value="' + value + '">' + text + '</option>');
                                $('#lstEvaluadorTodos option:selected').remove();
                            }
                        },
                        error: function () {
                            __ShowMessage('No se pudo realizar la transacción');
                        }
                    });

                } else {
                    __ShowMessage('No se pudo agregar ningún evaluador.');
                }
            });

            $('#btnRemoveEvaluador').click(function () {
                if ($('#lstEvaluadorSeleccionados').val() != null) {
                    var value = $('#lstEvaluadorSeleccionados').val();
                    var text = $('#lstEvaluadorSeleccionados option:selected').text();
                    var data = {
                        idPerfil: $('#IdPerfil').val(),
                        idEmpleado: value
                    };
                    $.ajax({
                        type: 'POST',
                        url: '/Evaluacion/DelEvaluador',
                        data: data,
                        success: function (result) {
                            if (result.result) {
                                $('#lstEvaluadorTodos').append('<option value="' + value + '">' + text + '</option>');
                                $('#lstEvaluadorSeleccionados option:selected').remove();
                            }
                        },
                        error: function () {
                            __ShowMessage('No se pudo realizar la transacción');
                        }
                    });
                } else {
                    __ShowMessage('No se pudo quitar ningún cuestionario.');
                }
            });

            $('#btnAddCuestionario').click(function () {

                if ($('#lstCuestionarioTodos').val() != null) {
                    var value = $('#lstCuestionarioTodos').val();
                    var text = $('#lstCuestionarioTodos option:selected').text();

                    var data = {
                        idPerfil: $('#IdPerfil').val(),
                        idCuestionario: value
                    };
                    $.ajax({
                        type: 'POST',
                        url: '/Evaluacion/SetCuestionario',
                        data: data,
                        success: function (result) {
                            if (result.result) {
                                $('#lstCuestionarioSeleccionados').append('<option value="' + value + '">' + text + '</option>');
                                $('#lstCuestionarioTodos option:selected').remove();
                            }
                        },
                        error: function () {
                            __ShowMessage('No se pudo realizar la transacción');
                        }
                    });

                } else {
                    __ShowMessage('No se pudo agregar ningún cuestionario.');
                }
            });

            $('#btnRemoveCuestionario').click(function () {
                if ($('#lstCuestionarioSeleccionados').val() != null) {
                    var value = $('#lstCuestionarioSeleccionados').val();
                    var text = $('#lstCuestionarioSeleccionados option:selected').text();
                    var data = {
                        idPerfil: $('#IdPerfil').val(),
                        idCuestionario: value
                    };
                    $.ajax({
                        type: 'POST',
                        url: '/Evaluacion/DelCuestionario',
                        data: data,
                        success: function (result) {
                            if (result.result) {
                                $('#lstCuestionarioTodos').append('<option value="' + value + '">' + text + '</option>');
                                $('#lstCuestionarioSeleccionados option:selected').remove();
                            }
                        },
                        error: function () {
                            __ShowMessage('No se pudo realizar la transacción');
                        }
                    });
                } else {
                    __ShowMessage('No se pudo quitar ningún cuestionario.');
                }
            });

            $('#lstPerfil').change(function () {
                $('#IdPerfil').val($('#lstPerfil').val());
                $('#txtSeleccionado').val($('#lstPerfil option:selected').text());
                GetEvaluador($('#IdPerfil').val(), $('#lstEvaluador'));
                GetCuestionario($('#IdPerfil').val(), $('#lstCuestionario'));
            });

            $('#btnCuestionario').click(function () {
                if ($('#IdPerfil').val() > 0) {
                    GetCuestionarioDialog();
                    $('#dialogCuestionario').dialog({
                        resizable: false,
                        title: 'Cuestionario => Perfil: ' + $('#txtSeleccionado').val(),
                        height: 350,
                        width: 650,
                        modal: true,
                        buttons: {
                            'Cerrar': function () {
                                GetCuestionario($('#IdPerfil').val(), $('#lstCuestionario'));
                                $(this).dialog("close");
                            }
                        }
                    });
                } else {
                    __ShowMessage('Debe seleccionar un perfil.');
                    $('#lstPerfil').focus();
                }
            });


            $('#btnEvaluador').click(function () {
                if ($('#IdPerfil').val() > 0) {
                    GetEvaluadorDialog();
                    $('#dialogEvaluador').dialog({
                        resizable: false,
                        title: 'Evaluador => Perfil: ' + $('#txtSeleccionado').val(),
                        height: 350,
                        width: 650,
                        modal: true,
                        buttons: {
                            'Cerrar': function () {
                                GetEvaluador($('#IdPerfil').val(), $('#lstEvaluador'));
                                $(this).dialog("close");
                            }
                        }
                    });
                } else {
                    __ShowMessage('Debe seleccionar un perfil.');
                    $('#lstPerfil').focus();
                }
            });

        });

        function GetCuestionario(idPerfil, lista) {
            lista.attr('disabled', true);
            var data = {
                idPerfil: idPerfil
            };
            $.ajax({
                type: 'POST',
                url: '/Evaluacion/GetCuestionario',
                data: data,
                success: function (result) {
                    var options = '';
                    if (result.result) {
                        try {
                            for (var i = 0; i < result.cuestionario.length; i++) {
                                options += '<option value="' + result.cuestionario[i].Value + '">' + result.cuestionario[i].Text + '</option>';

                                $('#lstCuestionarioTodos option').each(function () {
                                    if ($(this).val() == result.cuestionario[i].Value) {
                                        $(this).remove();
                                    }
                                });

                            }
                        } catch (ex2) {
                            __ShowMessage(ex2.message);
                        }
                        lista.html(options);
                        lista.removeAttr('disabled');
                    }
                },
                error: function () {
                    __ShowMessage('No se pudo cargar la lista');
                }
            });
        }

        function GetCuestionarioDialog() {
            $('#lstCuestionarioTodos').attr('disabled', true);
            var data = {
                idPerfil: 0
            };
            $.ajax({
                type: 'POST',
                url: '/Evaluacion/GetCuestionario',
                data: data,
                success: function (result) {
                    var options = '';
                    if (result.result) {
                        try {
                            for (var i = 0; i < result.cuestionario.length; i++) {
                                options += '<option value="' + result.cuestionario[i].Value + '">' + result.cuestionario[i].Text + '</option>';
                            }
                            $('#lstCuestionarioTodos').html(options);
                            $('#lstCuestionarioTodos').removeAttr('disabled');
                            
                            $('#lstCuestionarioSeleccionados').attr('disabled', true);
                            data = {
                                idPerfil: $('#IdPerfil').val()
                            };
                            $.ajax({
                                type: 'POST',
                                url: '/Evaluacion/GetCuestionario',
                                data: data,
                                success: function (result1) {
                                    options = '';
                                    if (result1.result) {
                                        try {
                                            for (var i1 = 0; i1 < result1.cuestionario.length; i1++) {
                                                options += '<option value="' + result1.cuestionario[i1].Value + '">' + result1.cuestionario[i1].Text + '</option>';

                                                $('#lstCuestionarioTodos option').each(function () {
                                                    if ($(this).val() == result1.cuestionario[i1].Value) {
                                                        $(this).remove();
                                                    }
                                                });

                                            }
                                            $('#lstCuestionarioSeleccionados').html(options);
                                            $('#lstCuestionarioSeleccionados').removeAttr('disabled');
                                        } catch (ex4) {
                                            __ShowMessage(ex4.message);
                                        }                                        

                                    }
                                },
                                error: function () {
                                    __ShowMessage('No se pudo cargar la lista');
                                }
                            });    
                        } catch (ex2) {
                            __ShowMessage(ex2.message);
                        }                    
                    }
                },
                error: function () {
                    __ShowMessage('No se pudo cargar la lista');
                }
            });
        }

        function GetEvaluadorDialog() {
            $('#lstEvaluadorTodos').attr('disabled', true);
            var data = {
                idPerfil: 0
            };
            $.ajax({
                type: 'POST',
                url: '/Evaluacion/GetEvaluador',
                data: data,
                success: function (result) {
                    var options = '';
                    if (result.result) {
                        try {
                            for (var i = 0; i < result.evaluador.length; i++) {
                                options += '<option value="' + result.evaluador[i].Value + '">' + result.evaluador[i].Text + '</option>';
                            }
                            $('#lstEvaluadorTodos').html(options);
                            $('#lstEvaluadorTodos').removeAttr('disabled');

                            $('#lstEvaluadorSeleccionados').attr('disabled', true);
                            data = {
                                idPerfil: $('#IdPerfil').val()
                            };
                            $.ajax({
                                type: 'POST',
                                url: '/Evaluacion/GetEvaluador',
                                data: data,
                                success: function (result1) {
                                    options = '';
                                    if (result1.result) {
                                        try {
                                            for (var i1 = 0; i1 < result1.evaluador.length; i1++) {
                                                options += '<option value="' + result1.evaluador[i1].Value + '">' + result1.evaluador[i1].Text + '</option>';

                                                $('#lstEvaluadorTodos option').each(function () {
                                                    if ($(this).val() == result1.evaluador[i1].Value) {
                                                        $(this).remove();
                                                    }
                                                });

                                            }
                                            $('#lstEvaluadorSeleccionados').html(options);
                                            $('#lstEvaluadorSeleccionados').removeAttr('disabled');
                                        } catch (ex4) {
                                            __ShowMessage(ex4.message);
                                        }                                        
                                    }
                                },
                                error: function () {
                                    __ShowMessage('No se pudo cargar la lista');
                                }
                            });
                        } catch (ex2) {
                            __ShowMessage(ex2.message);
                        }
                    }
                },
                error: function () {
                    __ShowMessage('No se pudo cargar la lista');
                }
            });
        }

        function GetEvaluador(idPerfil, lista) {
            lista.attr('disabled', true);
            var data = {
                idPerfil: idPerfil
            };
            $.ajax({
                type: 'POST',
                url: '/Evaluacion/GetEvaluador',
                data: data,
                success: function (result) {
                    var options = '';
                    if (result.result) {
                        try {
                            for (var i = 0; i < result.evaluador.length; i++) {
                                
                                options += '<option value="' + result.evaluador[i].Value + '">' + result.evaluador[i].Text + '</option>';

                                $('#lstEvaluadorTodos option').each(function () {
                                    if ($(this).val() == result.evaluador[i].Value) {
                                        $(this).remove();
                                    }
                                });
                            }
                        } catch (ex2) {
                            __ShowMessage(ex2.message);
                        }
                        lista.html(options);
                        lista.removeAttr('disabled');
                    }
                },
                error: function () {
                    __ShowMessage('No se pudo cargar la lista');
                }
            });
        }
    </script>
    <div class="contenido-top">
        <div>
            <h1>
                Evaluación de competencias
            </h1>
            <div class="areas-negocios">
                <div class="lista-central">
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Configuración</span>
                        </div>
                        <div class="texto-noticia">
                            <table>
                                <tr>
                                    <td rowspan="3">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>
                                                        Perfil de Empleado
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <%: Html.ListBox("lstPerfil", (IEnumerable<SelectListItem>)ViewData["Perfil"], new { @size = "23", @style="width:100%;" })%>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td>
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>
                                                        Perfil Seleccionado
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <input type="hidden" id="IdPerfil" value="0" />
                                                        <input id="txtSeleccionado" type="text" disabled="disabled" value="Seleccione un Perfil de Empleado"
                                                            style="width: 99%;" />
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>
                                                        Cuestionarios
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <select name="lstCuestionario" id="lstCuestionario" size="5" style="width: 100%;">
                                                        </select>
                                                    </td>
                                                </tr>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th style="text-align: right; font-weight: normal;">
                                                        <a id="btnCuestionario" href="javascript:;" class="button">Cuestionarios</a>
                                                    </th>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>
                                                        Evaluadores
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <select name="lstEvaluador" id="lstEvaluador" size="5" style="width: 100%;">
                                                        </select>
                                                    </td>
                                                </tr>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th style="text-align: right; font-weight: normal;">
                                                        <a id="btnEvaluador" href="javascript:;" class="button">Evaluadores</a>
                                                    </th>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <br />
                </div>
            </div>
        </div>
    </div>
    <div id="dialogEvaluador" style="display: none;">
        <table style="width: 100%;">
            <tr>
                <td>
                    <table style="width: 100%;">
                        <thead>
                            <tr>
                                <th>
                                    Evaluadores
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <select name="lstEvaluadorTodos" id="lstEvaluadorTodos" size="10" style="width: 100%;">
                                    </select>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
                 <td style="width: 50px;">
                    <div style="text-align: center;"><a id="btnAddEvaluador" class="button">>></a></div><br/>
                    <br/>
                    <div style="text-align: center;"><a id="btnRemoveEvaluador" class="button"><<</a></div>
                </td>
                <td>
                    <table style="width: 100%;">
                        <thead>
                            <tr>
                                <th>
                                    Evaluadores Seleccionados
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <select name="lstEvaluadorSeleccionados" id="lstEvaluadorSeleccionados" size="10"
                                        style="width: 100%;">
                                    </select>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dialogCuestionario" style="display: none;">
        <table style="width: 100%;">
            <tr>
                <td>
                    <table style="width: 100%;">
                        <thead>
                            <tr>
                                <th>
                                    Cuestionarios
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <select name="lstCuestionarioTodos" id="lstCuestionarioTodos" size="10" style="width: 100%;">
                                    </select>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
                <td style="width: 50px;">
                    <div style="text-align: center;"><a id="btnAddCuestionario" class="button">>></a></div>
                    <br/>
                    <br/>
                    <div style="text-align: center;"><a id="btnRemoveCuestionario" class="button"><<</a></div>
                </td>
                <td>
                    <table style="width: 100%;">
                        <thead>
                            <tr>
                                <th>
                                    Cuestionarios Seleccionados
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <select name="lstCuestionarioSeleccionados" id="lstCuestionarioSeleccionados" size="10"
                                        style="width: 100%;">
                                    </select>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
