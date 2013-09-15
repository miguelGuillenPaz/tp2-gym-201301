<%@ Page Title="Title" Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<DemoMVC.Models.GSC_ParteDiario>>"
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

            $('#btnAgregar').click(function () {
                $('#dialogParte').dialog({
                    resizable: false,
                    title: 'Registro de Parte Diario',
                    height: 400,
                    width: 550,
                    modal: true,
                    buttons: {
                        "Grabar": function () {
                            alert($('#horaInicio').val());
                            $(this).dialog("close");
                        },
                        "Cancelar": function () {
                            $(this).dialog("close");
                        }
                    }
                });
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
                $('#IdParte').val(idParte);
                $('#ddlProyectoDialog').val(idProyecto);
                $('#Fecha').val(fecha);
                $('#horaInicio').val(horaInicio);
                $('#horaFin').val(horaFin);
                $('#txtObservacion').val(observacion);
                LoadRequerimiento($('#ddlProyectoDialog'), 'Dialog', idRequerimiento);
                $('#dialogParte').dialog({
                    resizable: false,
                    title: 'Registro de Parte Diario',
                    height: 430,
                    width: 570,
                    modal: true,
                    buttons: {
                        "Grabar": function () {
                            alert($('#horaInicio').val());
                            $(this).dialog("close");
                        },
                        "Cancelar": function () {
                            $(this).dialog("close");
                        }
                    }
                });
            });

            $('#ddlRequerimiento').change(function () {
                $('#ddlTipoServicio').html('');
                if ($(this).val() > 0) {
                    $('#ddlTipoServicio').attr('disabled', true);
                    var data = {
                        idProyecto: $('#ddlProyecto').val(),
                        idRequerimiento: $(this).val()
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
                                        options += '<option value="' + result.tipoServicio[i].Value + '">' + result.tipoServicio[i].Text + '</option>';
                                    }
                                } catch (ex2) {
                                    __ShowMessage(ex2.message);
                                }
                                $('#ddlTipoServicio').html(options);
                                $('#ddlTipoServicio').removeAttr('disabled');
                            }
                        },
                        error: function () {
                            __ShowMessage('No se pudo cargar el combo');
                        }
                    });
                } else {
                    $('#ddlTipoServicio').html('<option value="">--Seleccione--</option>');
                }
            });

            $('#ddlProyecto').change(function () {
                LoadRequerimiento($(this), '', 0);
            });
        });

        function LoadRequerimiento(proyecto, sitio, idRequerimiento) {
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
                                    id="btnReset" href="javascript:;">Buscar</a>
                            </div>
                        </div>
                    </div>
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Registros:
                                <%= Model.Count() %></span>
                        </div>
                        <div class="texto-noticia">
                            <table>
                                <thead>
                                    <tr>
                                        <th>
                                            Parte Diario
                                        </th>
                                        <th>
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
                                        <th>
                                            Hora Inicio
                                        </th>                                        
                                        <th>
                                            Hora Fin
                                        </th>          
                                        <th>
                                            Observacion
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
                                        <td>
                                            <%= parteDiario.IdProyecto %>
                                        </td>
                                        <td>
                                            <%= DemoMVC.Controllers.CotizacionController.GetProyecto(parteDiario.IdProyecto)%>
                                        </td>
                                        <td>
                                            <%= (parteDiario.IdRequerimiento + string.Empty).PadLeft(9,'0') %>
                                        </td>
                                        <td>
                                            <%= DemoMVC.Controllers.CotizacionController.GetTipoServicio(parteDiario.IdRequerimiento) %>
                                        </td>
                                        <td>
                                            <%= parteDiario.Fecha.ToString().Substring(6, 4) + "-" + parteDiario.Fecha.ToString().Substring(3, 2) + "-" + parteDiario.Fecha.ToString().Substring(0, 2)%>
                                        </td>                                        
                                        <td>
                                            <%= parteDiario.GSC_Estado.DescripEstado %>
                                        </td>
                                        <td>
                                            <%= DemoMVC.Controllers.ParteController.GetHoraFormateada(parteDiario.HoraInicio) %>
                                        </td>
                                        <td>
                                            <%= DemoMVC.Controllers.ParteController.GetHoraFormateada(parteDiario.HoraFin)%>
                                        </td>
                                        <td>
                                            <%= parteDiario.Observacion %>
                                        </td>
                                        <td style="text-align: center;">
                                            <a class="editar button" href="javascript:;">editar</a> | <a class="eliminar button"
                                                href="javascript:;">Eliminar</a>
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
        <input type="hidden" id="IdParte" value="0"/>
        <table style="width: 100%;">
            <tr>
                <td>
                    Proyecto
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.DropDownList("ddlProyectoDialog", (IEnumerable<SelectListItem>)ViewData["Proyecto"])%>
                </td>
                <td>
                </td>
                <td>
                    Requerimiento
                </td>
                <td>
                    :
                </td>
                <td>
                    <select id="ddlRequerimientoDialog">
                        <option value="">--Seleccione--</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    Fecha
                </td>
                <td>
                    :
                </td>
                <td>
                    <input type="date" id="Fecha" />
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
                </td>
                <td>                    
                </td>
                <td>                    
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
            <tr><td colspan="7"></td></tr>
            <tr><td colspan="7">
                    <textarea id="txtObservacion" cols="1" rows="10" style="width: 98%;"></textarea>
                </td></tr>
        </table>
    </div>
</asp:Content>
