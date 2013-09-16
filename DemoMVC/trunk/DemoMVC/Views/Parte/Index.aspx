<%@ Page Title="Title" Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<GYM.SIG.Entity.ParteDiario>>"
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
            } catch (ex) {
            }

            $('#btnReset').click(function () {
                $('#txtFecIni').val('');
                $('#txtFecFin').val('');
                $('#ddlProyecto').val('');
                $('#ddlRequerimiento').html('').html('<option value="">--Seleccione--</option>'); ;
                $('#ddlTipoServicio').html('').html('<option value="">--Seleccione--</option>'); ;
                $('#ddlSituacion').val('');
            });

            $('#btnBuscar').click(function () {
                var proyecto = '';
                var situacion = '';
                var tipoServicio = '';
                var inicio = $('#txtFecIni').val();
                var fin = $('#txtFecFin').val();
                if ($('#ddlProyecto').val() != '')
                    proyecto = $('#ddlProyecto option:selected').text().trim();
                if ($('#ddlSituacion').val() != '')
                    situacion = $('#ddlSituacion option:selected').text().trim();
                if ($('#ddlTipoServicio').val() != '')
                    tipoServicio = $('#ddlTipoServicio option:selected').text();

                $('#tblParte tbody tr').each(function () {
                    if ($('td:eq(2)', this).text().trim().indexOf(proyecto) != -1 && $('td:eq(4)', this).text().indexOf(tipoServicio) != -1 && $('td:eq(6)', this).text().indexOf(situacion) != -1)
                        $(this).show();
                    else
                        $(this).hide();
                });

                if (inicio != '' && fin != '') {
                    $('#tblParte tbody tr').each(function () {
                        var fecha = $('td:eq(5)', this).text().trim();
                        if (fecha >= inicio && fecha <= fin && $('td:eq(2)', this).text().indexOf(proyecto) != -1 && $('td:eq(4)', this).text().indexOf(tipoServicio) != -1 && $('td:eq(6)', this).text().indexOf(situacion) != -1)
                            $(this).show();
                        else
                            $(this).hide();
                    });
                }


            });

            $('#btnAgregar').click(function () {
                $('#IdParte').val(0);
                $('#ddlProyectoDialog').val('');
                $('#ddlRequerimientoDialog').html('').html('<option value="">--Seleccione--</option>');
                $('#Fecha').val('');
                $('#horaInicio').val('');
                $('#horaFin').val('');
                $('#txtObservacion').val('');
                $('#dialogParte').dialog({
                    resizable: false,
                    title: 'Registro de Parte Diario',
                    height: 430,
                    width: 570,
                    modal: true,
                    buttons: {
                        "Grabar": function () {
                            var nroRequeridos = 0;
                            $('#dialogParte .required').each(function () {
                                if ($(this).val() == '') {
                                    nroRequeridos = nroRequeridos + 1;
                                    $(this).addClass('required-control');
                                } else {
                                    $(this).removeClass('required-control');
                                }
                            });
                            if (nroRequeridos == 0) {
                                SaveParteDiario($('#IdParte').val(), $('#ddlProyectoDialog').val(), $('#ddlRequerimientoDialog').val(), $('#Fecha').val(), $('#horaInicio').val(), $('#horaFin').val(), $('#txtObservacion').val(), $('#ddlTipoServicioDialog').val());
                            } else {
                                __ShowMessage('Existen campos obligatorios sin llenar.');
                            }
                        },
                        "Cancelar": function () {
                            $(this).dialog("close");
                        }
                    }
                });
            });

            $('.anular').click(function () {
                var tr = $(this).parent().parent();
                if ($('td:eq(6)', tr).text().trim() != 'Anulado') {
                    var data = {
                        idParte: parseInt($('td:eq(0)', tr).text())
                    };
                    $("#dialogConfirm #confirm").text('¿Desea anular el parte diario?');
                    $("#dialogConfirm").dialog({
                        resizable: false,
                        height: 140,
                        modal: true,
                        buttons: {
                            "Aceptar": function () {
                                $(this).dialog("close");
                                $.ajax({
                                    type: 'POST',
                                    url: '/Parte/Anular',
                                    data: data,
                                    success: function (result) {
                                        if (result.result) {
                                            $('td:eq(6)', tr).text('Anulado');
                                            __ShowMessage('El parte diario ha sido anulado');
                                        }
                                    },
                                    error: function () {
                                        $(this).dialog("close");
                                        __ShowMessage('No se pudo cargar el combo');
                                    }
                                });
                            },
                            "Cancelar": function () {
                                $(this).dialog("close");
                            }
                        }
                    });
                } else {
                    __ShowMessage('El parte diario está anulado.');
                }
            });

            $('.editar').click(function () {
                var tr = $(this).parent().parent();
                var idParte = parseInt($('td:eq(0)', tr).text());
                var idProyecto = parseInt($('td:eq(1)', tr).text());
                var idRequerimiento = parseInt($('td:eq(3)', tr).text());
                var fecha = $('td:eq(5)', tr).text().trim();
                var horaInicio = $('td:eq(7)', tr).text().trim();
                var horaFin = $('td:eq(8)', tr).text().trim();
                var observacion = $('td:eq(9)', tr).text().trim();
                var idTipoServicio = $('td:eq(10)', tr).text().trim();
                $('#IdParte').val(idParte);
                $('#ddlProyectoDialog').val(idProyecto);
                $('#Fecha').val(fecha);
                $('#horaInicio').val(horaInicio);
                $('#horaFin').val(horaFin);
                $('#txtObservacion').val(observacion);
                LoadRequerimiento($('#ddlProyectoDialog'), 'Dialog', idRequerimiento, idTipoServicio);
                $('#dialogParte').dialog({
                    resizable: false,
                    title: 'Registro de Parte Diario',
                    height: 430,
                    width: 570,
                    modal: true,
                    buttons: {
                        "Grabar": function () {
                            var nroRequeridos = 0;
                            $('#dialogParte .required').each(function () {
                                if ($(this).val() == '') {
                                    nroRequeridos = nroRequeridos + 1;
                                    $(this).addClass('required-control');
                                } else {
                                    $(this).removeClass('required-control');
                                }
                            });
                            if (nroRequeridos == 0) {
                                SaveParteDiario($('#IdParte').val(), $('#ddlProyectoDialog').val(), $('#ddlRequerimientoDialog').val(), $('#Fecha').val(), $('#horaInicio').val(), $('#horaFin').val(), $('#txtObservacion').val(), $('#ddlTipoServicioDialog').val());
                            } else {
                                __ShowMessage('Existen campos obligatorios sin llenar.');
                            }
                        },
                        "Cancelar": function () {
                            $(this).dialog("close");
                        }
                    }
                });
            });

            $('#ddlRequerimiento').change(function () {
                LoadTipoServicio($(this), '', 0);
            });

            $('#ddlProyecto').change(function () {
                LoadRequerimiento($(this), '', 0, 0);
            });

            $('#ddlProyectoDialog').change(function () {
                LoadRequerimiento($(this), 'Dialog', 0, 0);
            });

            $('#ddlRequerimientoDialog').change(function () {
                LoadTipoServicio($(this), 'Dialog', 0);
            });
        });

        function SaveParteDiario(parte, proyecto, requerimiento, fecha, horaInicio, horaFin, observacion, tipoServicio) {
            var data = {
                idParte: parte,
                idProyecto: proyecto,
                idRequerimiento: requerimiento,
                fecha: fecha,
                horaInicio: horaInicio,
                horaFin: horaFin,
                observacion: observacion,
                idTipoServicio: tipoServicio
            };
            $.ajax({
                type: 'POST',
                url: '/Parte/SetParteDiario',
                data: data,
                success: function (result) {
                    if (result.result) {
                        $("#dialogConfirm #confirm").text('El registro ha sido actualizado.');
                        $("#dialogConfirm").dialog({
                            resizable: false,
                            height: 140,
                            modal: true,
                            buttons: {
                                "Aceptar": function () {
                                    $(this).dialog("close");
                                    $('#dialogParte').dialog('close');
                                    window.location.assign('/Parte');
                                }
                            }
                        });
                    }
                },
                error: function () {
                    $(this).dialog("close");
                    __ShowMessage('No se pudo cargar el combo');
                }
            });
        }

        function LoadRequerimiento(proyecto, sitio, idRequerimiento, idTipoServicio) {
            $('#ddlRequerimiento' + sitio).html('');
            if (proyecto.val() > 0) {
                $('#ddlRequerimiento' + sitio).attr('disabled', true);
                var data = {
                    idProyecto: proyecto.val()
                };
                $.ajax({
                    type: 'POST',
                    url: '/Parte/Requerimiento',
                    data: data,
                    success: function (result) {
                        var options = '';
                        if (result.result) {
                            try {
                                for (var i = 0; i < result.requerimiento.length; i++) {
                                    options += '<option ';
                                    if (result.requerimiento[i].Value == idRequerimiento)
                                        options += 'selected ';
                                    options += 'value="' + result.requerimiento[i].Value + '">' + result.requerimiento[i].Text + '</option>';
                                }
                            } catch (ex2) {
                                __ShowMessage(ex2.message);
                            }
                            $('#ddlRequerimiento' + sitio).html(options);
                            $('#ddlRequerimiento' + sitio).removeAttr('disabled');
                            if (idTipoServicio > 0) {                                
                                LoadTipoServicio($('#ddlRequerimientoDialog'), 'Dialog', idTipoServicio);
                            }
                        }
                    },
                    error: function () {
                        __ShowMessage('No se pudo cargar el combo');
                    }
                });
            } else {
                $('#ddlRequerimiento' + sitio).html('<option value="">--Seleccione--</option>');
            }
        }

        function LoadTipoServicio(requerimiento, sitio, idTipoServicio) {
            $('#ddlTipoServicio' + sitio).html('');            
            if (requerimiento.val() > 0) {                
                $('#ddlTipoServicio' + sitio).attr('disabled', true);                
                var data = {
                    idProyecto: $('#ddlProyecto' + sitio).val(),
                    idRequerimiento: requerimiento.val()
                };
                $.ajax({
                    type: 'POST',
                    url: '/Parte/TipoServicio',
                    data: data,
                    success: function (result) {
                        var options = '';
                        if (result.result) {
                            try {                                
                                for (var i = 0; i < result.tipoServicio.length; i++) {
                                    options += '<option ';
                                    if (result.tipoServicio[i].Value == idTipoServicio)
                                        options += 'selected ';
                                    options += 'value="' + result.tipoServicio[i].Value + '">' + result.tipoServicio[i].Text + '</option>';
                                }
                            } catch (ex2) {
                                __ShowMessage(ex2.message);
                            }
                            $('#ddlTipoServicio' + sitio).html(options);
                            $('#ddlTipoServicio' + sitio).removeAttr('disabled');
                        }
                    },
                    error: function () {
                        __ShowMessage('No se pudo cargar el combo');
                    }
                });
            } else {
                $('#ddlTipoServicio' + sitio).html('<option value="">--Seleccione--</option>');
            }
        }

    </script>
    <div class="contenido-top">
        <div>
            <h1>
                Parte Diario
            </h1>
            <div class="areas-negocios">
                <div class="lista-central">
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Filtros</span>
                        </div>
                        <div class="texto-noticia">
                            <table>
                                <tr>
                                    <td>
                                        Proyecto
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <%= Html.DropDownList("ddlProyecto", (IEnumerable<SelectListItem>)ViewData["Proyecto"])%>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        Situacion
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <%= Html.DropDownList("ddlSituacion", (IEnumerable<SelectListItem>)ViewData["Situacion"])%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Requerimiento
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <select id="ddlRequerimiento">
                                            <option value="">--Seleccione--</option>
                                        </select>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        Fecha Inicio
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <input type="date" id="txtFecIni" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Tipo Servicio
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <select id="ddlTipoServicio">
                                            <option value="">--Seleccione--</option>
                                        </select>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        Fecha Fin
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <input type="date" id="txtFecFin" />
                                    </td>
                                </tr>
                            </table>
                            <div class="content-button">
                                <a class="button" id="btnBuscar" href="javascript:;">Buscar</a> | <a class="button"
                                    id="btnReset" href="javascript:;">Inicializar</a>
                            </div>
                        </div>
                    </div>
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Registros:
                                <%= Model.Count() %></span>
                        </div>
                        <div class="texto-noticia">
                            <table id="tblParte">
                                <thead>
                                    <tr>
                                        <th>
                                            Parte Diario
                                        </th>
                                        <th style="display: none;">
                                            IdProyecto
                                        </th>
                                        <th>
                                            Proyecto
                                        </th>
                                        <th>
                                            Requerimiento
                                        </th>
                                        <th>
                                            Tipo Servicio
                                        </th>
                                        <th>
                                            Fecha
                                        </th>
                                        <th>
                                            Situación
                                        </th>
                                        <th style="display: none;">
                                            Hora Inicio
                                        </th>
                                        <th style="display: none;">
                                            Hora Fin
                                        </th>
                                        <th style="display: none;">
                                            Observacion
                                        </th>
                                        <th style="display: none;">
                                            IdCorDet
                                        </th>
                                        <th style="width: 180px; text-align: center;">
                                            Opciones
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (Model != null)
                                       {
                                           foreach (var parteDiario in Model)
                                           {
                                    %>
                                    <tr>
                                        <td>
                                            <%= (parteDiario.IdParteDiario + string.Empty).PadLeft(9,'0') %>
                                        </td>
                                        <td style="display: none;">
                                            <%= parteDiario.IdProyecto %>
                                        </td>
                                        <td>
                                            <%= parteDiario.DescripProyecto %>
                                        </td>
                                        <td>
                                            <%= (parteDiario.IdRequerimiento + string.Empty).PadLeft(9,'0') %>
                                        </td>
                                        <td>
                                            <%= parteDiario.DescripTServicio %>
                                        </td>
                                        <td>
                                            <%= DemoMVC.Controllers.ParteController.GetFechaFormateada(parteDiario.Fecha) %>
                                        </td>
                                        <td>
                                            <%= parteDiario.DescripEstado %>
                                        </td>
                                        <td style="display: none;">
                                            <%= DemoMVC.Controllers.ParteController.GetHoraFormateada(parteDiario.HoraInicio) %>
                                        </td>
                                        <td style="display: none;">
                                            <%= DemoMVC.Controllers.ParteController.GetHoraFormateada(parteDiario.HoraFin)%>
                                        </td>
                                        <td style="display: none;">
                                            <%= parteDiario.Observacion %>
                                        </td>
                                        <td style="display: none;"><%= parteDiario.IdCorDetReq %> </td>
                                        <td style="text-align: center;">
                                            <a class="editar button" href="javascript:;">Editar</a>                                             
                                            | <a class="anular button"
                                                href="javascript:;">Anular</a>                                                
                                        </td>
                                    </tr>
                                    <%
                                           }
                                       } %>
                                </tbody>
                            </table>
                        </div>
                        <div class="content-button">
                            <a class="button" id="btnAgregar" href="javascript:;">Agregar</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="dialogParte" style="display: none;">
        <input type="hidden" id="IdParte" value="0" />
        <table style="width: 100%;">
            <tr>
                <td>
                    Proyecto
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.DropDownList("ddlProyectoDialog", (IEnumerable<SelectListItem>)ViewData["Proyecto"], new {@class="required"})%>
                </td>
                <td>
                </td>
                <td>
                    Fecha
                </td>
                <td>
                    :
                </td>
                <td>
                <input type="date" id="Fecha" class="required" />
                </td>
            </tr>
            <tr>
                <td>
                    Requerimiento
                </td>
                <td>
                    :
                </td>
                <td>
                    
                        <select id="ddlRequerimientoDialog" class="required">
                        <option value="">--Seleccione--</option>
                    </select>
                </td>
                <td>
                </td>
                <td>
                    Hora Inicio
                </td>
                <td>
                    :
                </td>
                <td>
                    <input type="time" id="horaInicio" />
                </td>
            </tr>
            <tr>
                <td>
                    Tipo Servicio
                </td>
                <td>:
                </td>
                <td>
                       <select id="ddlTipoServicioDialog" class="required">
                        <option value="">--Seleccione--</option>
                    </select>
                </td>
                <td>
                </td>
                <td>
                    Hora Fin
                </td>
                <td>
                    :
                </td>
                <td>
                    <input type="time" id="horaFin" />
                </td>
            </tr>
            <tr>
                <td colspan="7">
                </td>
            </tr>
            <tr>
                <td colspan="7">
                    <textarea id="txtObservacion" cols="1" rows="10" style="width: 98%;" class="required"></textarea>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
