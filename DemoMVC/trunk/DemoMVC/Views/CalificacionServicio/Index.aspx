<%@ Page Title="Title" Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<GYM.SIG.Entity.CalificacionServicio>>" MasterPageFile="~/Views/Shared/Site.Master" %>

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

                $('#tblCalificacion tbody tr').each(function () {
                    if ($('td:eq(3)', this).text().trim().indexOf(proyecto) != -1 && $('td:eq(5)', this).text().indexOf(tipoServicio) != -1 && $('td:eq(7)', this).text().indexOf(situacion) != -1)
                        $(this).show();
                    else
                        $(this).hide();
                });

                if (inicio != '' && fin != '') {
                    $('#tblCalificacion tbody tr').each(function () {
                        var fecha = $('td:eq(1)', this).text().trim();
                        if (fecha >= inicio && fecha <= fin && $('td:eq(3)', this).text().indexOf(proyecto) != -1 && $('td:eq(5)', this).text().indexOf(tipoServicio) != -1 && $('td:eq(7)', this).text().indexOf(situacion) != -1)
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
                $('#ddlPuntualidad').val('');
                $('#ddlCalidad').val('');
                $('#ddlIncidencia').val('');
                $('#txtPuntuacion').val('0');
                $('#dialogCalificacion').dialog({
                    resizable: false,
                    title: 'Registro de Calificación de Servicio',
                    height: 550,
                    width: 650,
                    modal: true,
                    buttons: {
                        "Grabar": function () {
                            var nroRequeridos = 0;
                            $('#dialogCalificacion .required').each(function () {
                                if ($(this).val() == '') {
                                    nroRequeridos = nroRequeridos + 1;
                                    $(this).addClass('required-control');
                                } else {
                                    $(this).removeClass('required-control');
                                }
                            });
                            if (nroRequeridos == 0) {
                                SaveCalificacionServicio($('#IdCalificacion').val(), $('#ddlProyectoDialog').val(), $('#ddlRequerimientoDialog').val(), $('#ddlTipoServicioDialog').val(), $('#Fecha').val(), $('#FechaFin').val(), $('#txtObservacion').val(), $('#ddlPuntualidad').val(), $('#ddlCalidad').val(), $('#ddlIncidencia').val());
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
                if ($('td:eq(7)', tr).text().trim() != 'Anulado') {
                    var data = {
                        idCalificacion: parseInt($('td:eq(0)', tr).text())
                    };
                    $("#dialogConfirm #confirm").text('¿Desea anular la calificación de servicio?');
                    $("#dialogConfirm").dialog({
                        resizable: false,
                        height: 140,
                        modal: true,
                        buttons: {
                            "Aceptar": function () {
                                $(this).dialog("close");
                                $.ajax({
                                    type: 'POST',
                                    url: '/CalificacionServicio/Anular',
                                    data: data,
                                    success: function (result) {
                                        if (result.result) {
                                            $('td:eq(7)', tr).text('Anulado');
                                            __ShowMessage('La calificación de servicio ha sido anulada');
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
                    __ShowMessage('La calificación de servicio está anulada.');
                }
            });

            $('.editar').click(function () {
                var tr = $(this).parent().parent();
                var idCalificacion = parseInt($('td:eq(0)', tr).text());
                var fecha = $('td:eq(1)', tr).text().trim();
                var idProyecto = parseInt($('td:eq(2)', tr).text());
                var idRequerimiento = parseInt($('td:eq(4)', tr).text());
                var fechaFin = $('td:eq(6)', tr).text().trim();
                var idTipoServicio = $('td:eq(8)', tr).text().trim();
                var observacion = $('td:eq(9)', tr).text().trim();
                var puntualidad = $('td:eq(10)', tr).text().trim();
                var calidad = $('td:eq(11)', tr).text().trim();
                var incidencia = $('td:eq(12)', tr).text().trim();
                $('#IdCalificacion').val(idCalificacion);
                $('#ddlProyectoDialog').val(idProyecto);
                $('#Fecha').val(fecha);
                $('#FechaFin').val(fechaFin);
                $('#ddlPuntualidad').val(puntualidad);
                $('#ddlCalidad').val(calidad);
                $('#ddlIncidencia').val(incidencia);
                UpdatePuntuacion();
                $('#txtObservacion').val(observacion);
                LoadRequerimiento($('#ddlProyectoDialog'), 'Dialog', idRequerimiento, idTipoServicio);
                $('#dialogCalificacion').dialog({
                    resizable: false,
                    title: 'Registro de Calificación de Servicio',
                    height: 550,
                    width: 650,
                    modal: true,
                    buttons: {
                        "Grabar": function () {
                            var nroRequeridos = 0;
                            $('#dialogCalificacion .required').each(function () {
                                if ($(this).val() == '') {
                                    nroRequeridos = nroRequeridos + 1;
                                    $(this).addClass('required-control');
                                } else {
                                    $(this).removeClass('required-control');
                                }
                            });
                            if (nroRequeridos == 0) {
                                SaveCalificacionServicio($('#IdCalificacion').val(), $('#ddlProyectoDialog').val(), $('#ddlRequerimientoDialog').val(), $('#ddlTipoServicioDialog').val(), $('#Fecha').val(), $('#FechaFin').val(), $('#txtObservacion').val(), $('#ddlPuntualidad').val(), $('#ddlCalidad').val(), $('#ddlIncidencia').val());
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

            $('#ddlPuntualidad, #ddlCalidad, #ddlIncidencia').change(function () {
                UpdatePuntuacion();
            });
        });

        function UpdatePuntuacion() {
            var puntualidad = parseFloat($('#ddlPuntualidad').val());
            var calidad = parseFloat($('#ddlCalidad').val());
            var incidencia = parseFloat($('#ddlIncidencia').val());            
            $('#txtPuntuacion').val(parseInt(puntualidad + calidad + incidencia));
        }

        function SaveCalificacionServicio(calificacion, proyecto, requerimiento, tipoServicio, fecha, fechaFin, observacion, puntualidad, calidad, incidencia) {
            var data = {
                idCalificacion: calificacion,
                idProyecto: proyecto,
                idRequerimiento: requerimiento,
                idTipoServicio: tipoServicio,
                fecha: fecha,                
                fechaFin: fechaFin,
                observacion: observacion,
                idPuntualidad: puntualidad,
                idCalidad: calidad,
                idIncidencia: incidencia
            };            
            $.ajax({
                type: 'POST',
                url: '/CalificacionServicio/SetCalificacionServicio',
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
                                    $('#dialogCalificacion').dialog('close');
                                    window.location.assign('/CalificacionServicio');
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
                Calificación de Servicio
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
                                        Fecha Calificación Inicio
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
                                        Fecha Calificación Fin
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
                            <table id="tblCalificacion">
                                <thead>
                                    <tr>
                                        
                                        <th style="display: none;">
                                            IdCalificación
                                        </th>
                                        <th>
                                            Fecha Calificación
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
                                            Fecha Fin Servicio
                                        </th>
                                        <th>
                                            Situación
                                        </th>
                                                                                
                                        <th style="display: none;">
                                            IdCorDet
                                        </th>
                                        <th style="display: none;">
                                            Puntualidad
                                        </th>
                                        <th style="display: none;">
                                            Calidad
                                        </th>
                                        <th style="display: none;">
                                            Incidencia
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
                                        <td style="display: none;">
                                            <%= parteDiario.IdCalificacion %>
                                        </td>
                                        <td>
                                            <%=  DemoMVC.Controllers.ParteController.GetFechaFormateada(parteDiario.Fecha) %>
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
                                            <%= DemoMVC.Controllers.ParteController.GetFechaFormateada(parteDiario.FechaFin) %>
                                        </td>                                        
                                        <td>
                                            <%= parteDiario.DescripEstado %>
                                        </td>                                       
                                        <td style="display: none;"><%= parteDiario.IdCorDetReq %> </td>
                                        <td style="display: none;"><%= parteDiario.Observacion %> </td>
                                        <td style="display: none;"><%= parteDiario.IdPuntualidad %> </td>
                                        <td style="display: none;"><%= parteDiario.IdCalidad %> </td>
                                        <td style="display: none;"><%= parteDiario.IdIncidencia %> </td>
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
    <div id="dialogCalificacion" style="display: none;">
        <input type="hidden" id="IdCalificacion" value="0" />
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
                    Fecha Calificación
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
                    Fecha Fin Servicio
                </td>
                <td>
                    :
                </td>
                <td>
                    <input type="date" id="FechaFin" class="required"/>
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
                    Estado
                </td>
                <td>
                    :
                </td>
                <td>
                    <input id="txtEstado" disabled="disabled" value="Creado" />
                </td>
            </tr>
            <tr>
                <td colspan="7">
                </td>
            </tr>
            <tr>
                <td colspan="7"><b>Parámetros de Calificación</b>
                </td>
            </tr>
            <tr>
                <td>Puntualidad</td>
                <td>:</td>
                <td colspan="5">
                                        <%= Html.DropDownList("ddlPuntualidad", (IEnumerable<SelectListItem>)ViewData["ParametroCalificacion"], new { @class = "required" })%>
                </td>
            </tr>
            <tr>
                <td>Materiales</td>
                <td>:</td>
                <td colspan="5">
                    <%= Html.DropDownList("ddlCalidad", (IEnumerable<SelectListItem>)ViewData["ParametroCalificacion"], new { @class = "required" })%>
                </td>
            </tr>
            <tr>
                <td>Incidencias</td>
                <td>:</td>
                <td colspan="5">
                    <%= Html.DropDownList("ddlIncidencia", (IEnumerable<SelectListItem>)ViewData["ParametroCalificacion"], new { @class = "required" })%>
                </td>
            </tr>
            <tr>
                <td>Puntuación</td>
                <td>:</td>
                <td colspan="5">
                    <input type="number" id="txtPuntuacion" value="0" disabled="disabled"/>
                </td>
            </tr>
            <tr>
                <td colspan="7">
                </td>
            </tr>
                        <tr>
                <td colspan="7">Observación
                </td>
            </tr>
            <tr>
                <td colspan="7">
                    <textarea id="txtObservacion" cols="1" rows="3" style="width: 98%;" class="required"></textarea>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>


