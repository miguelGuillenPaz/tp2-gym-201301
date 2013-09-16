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

            $('#lstPerfil').change(function () {
                $('#IdPerfil').val($('#lstPerfil').val());
                $('#txtSeleccionado').val($('#lstPerfil option:selected').text());
            });

            $('#btnEvaluador').click(function () {
                if ($('#IdPerfil').val() > 0) {
                    $('#dialogEvaluador').dialog({
                        resizable: false,
                        title: 'Evaluador => Perfil: ' + $('#txtSeleccionado').val(),
                        height: 550,
                        width: 650,
                        modal: true,
                        buttons: {
                            'Enviar': function () {
                                var nroRequeridos = 0;
                                $('#dialogEvaluador .required').each(function () {
                                    if ($(this).val() == '') {
                                        nroRequeridos = nroRequeridos + 1;
                                        $(this).addClass('required-control');
                                    } else {
                                        $(this).removeClass('required-control');
                                    }
                                });
                                if (nroRequeridos == 0) {

                                } else {
                                    __ShowMessage('Existen campos obligatorios sin llenar.');
                                }
                            },
                            'Cancelar': function () {
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
                                                        <%: Html.ListBox("lstPerfil", (IEnumerable<SelectListItem>)ViewData["Perfil"], new { @size = "20", @style="width:100%;" })%>
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
                                                        <input id="txtSeleccionado" type="text" disabled="disabled" value="Seleccione un Perfil de Empleado" style="width: 99%;" />
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
                                                        <select name="lstCuestionario" id="lstCuestionario" size="5" style="width: 100%;" >
                                                            <option value="1">item 1</option>
                                                            <option value="2">item 2</option>
                                                            <option value="3">item 3</option>
                                                            <option value="4">item 4</option>
                                                            <option value="0">All</option>
                                                        </select>
                                                    </td>
                                                </tr>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th style="text-align: right;font-weight: normal;">
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
                                                        <select name="lstEvaluador" id="lstEvaluador" size="5" style="width: 100%;" >
                                                            <option value="1">item 1</option>
                                                            <option value="2">item 2</option>
                                                            <option value="3">item 3</option>
                                                            <option value="4">item 4</option>
                                                            <option value="0">All</option>
                                                        </select>
                                                    </td>
                                                </tr>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th style="text-align: right;font-weight: normal;">
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
        <table>
            <tr>
                <td></td>
                <td></td>
                <td></td>
            </tr>
        </table>
    </div>
</asp:Content>
