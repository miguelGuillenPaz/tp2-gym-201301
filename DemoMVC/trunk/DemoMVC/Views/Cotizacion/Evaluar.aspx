<%@ Page Title="Title" Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<DemoMVC.Models.GSC_SolicitudCotizacion>>"
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

            $('.seleccionar').click(function () {
                var tr = $(this).parent().parent();
                var idSolicitudCotizacion = $('td:eq(0)', tr).text();

                var data = { idSolicitudCotizacion: idSolicitudCotizacion };
                $.ajax({
                    type: 'POST',
                    url: '/Cotizacion/DetalleSolicitudCotizacion',
                    data: data,
                    success: function (response) {

                        $('#tblDetalle tbody').html('');
                        $('#tblDetalle tbody').append(response.table);

                        $.ajax({
                            type: 'POST',
                            url: '/Cotizacion/DetalleCotizacion',
                            data: data,
                            success: function (response2) {
                                $('#divOpcion').html('');
                                $('#divOpcion').append(response2.content);
                            }
                        });

                        $('#dialogSeleccionar').dialog({
                            resizable: false,
                            title: 'Seleccionar Cotización',
                            height: 400,
                            width: 500,
                            modal: true,
                            buttons: {
                                "Aceptar": function () {                                    
                                    if ($('input[name=cotizacion]:checked').val() == undefined) {
                                        $("#dialogConfirm #confirm").text('Debe seleccionar un proveedor.');
                                        $("#dialogConfirm").dialog({
                                            resizable: false,
                                            height: 140,
                                            modal: true,
                                            buttons: {
                                                "Aceptar": function() {
                                                    $(this).dialog("close");
                                                }
                                            }
                                        });
                                    } else {
                                        $("#dialogConfirm #confirm").text('¿Está seguro de seleccionar al proveedor?');
                                        $("#dialogConfirm").dialog({
                                            resizable: false,
                                            height: 140,
                                            modal: true,
                                            buttons: {
                                                "Aceptar": function() {

                                                    var idCotizacion = $('input[name=cotizacion]:checked').val();

                                                    var data2 = { idSolicitudCotizacion: idSolicitudCotizacion, idCotizacion: idCotizacion };
                                                    $.ajax({
                                                        type: 'POST',
                                                        url: '/Cotizacion/ElegirCotizacion',
                                                        data: data2,
                                                        success: function(resultado) {
                                                            if (resultado.resultado) {
                                                                $("#dialogConfirm #confirm").text('El proveedor fue seleccionado.');
                                                                $("#dialogConfirm").dialog({
                                                                    resizable: false,
                                                                    height: 140,
                                                                    modal: true,
                                                                    buttons: {
                                                                        "Aceptar": function() {
                                                                            $(this).dialog("close");
                                                                            $('#dialogSeleccionar').dialog("close");
                                                                        }
                                                                    }
                                                                });
                                                            }
                                                        }
                                                    });
                                                    $(this).dialog("close");
                                                },
                                                "Cancelar": function() {
                                                    $(this).dialog("close");
                                                }
                                            }
                                        });
                                    }
                                },
                                "Cancelar": function () {
                                    $(this).dialog("close");
                                }
                            }
                        });
                    },
                    error: function () {
                        __ShowMessage('No se pudo eliminar');
                    }
                });


            });

            $('#btnBuscar').click(function () {
                var proyecto = '';
                var situacion = '';
                var tipoServicio = '';
                if ($('#IdProyecto').val() != '')
                    proyecto = $('#IdProyecto option:selected').text();
                if ($('#IdEstado').val() != '')
                    situacion = $('#IdEstado option:selected').text();
                if ($('#IdTipoServicio').val() != '')
                    tipoServicio = $('#IdTipoServicio option:selected').text();

                $('#tblSolicitud tbody tr').each(function () {
                    if ($('td:eq(2)', this).text().indexOf(proyecto) != -1 && $('td:eq(3)', this).text().indexOf(tipoServicio) != -1 && $('td:eq(4)', this).text().indexOf(situacion) != -1)
                        $(this).show();
                    else
                        $(this).hide();
                });

            });
        });
    </script>
    <div class="contenido-top">
        <div>
            <h1>
                Evaluar Cotización
            </h1>
            <div class="areas-negocios">
                <div class="lista-central">
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Filtros</span>
                        </div>
                        <div class="texto-noticia">
                            <table>
                                <thead>
                                    <tr>
                                        <th style="width: 100px;">
                                        </th>
                                        <th style="width: 10px;">
                                        </th>
                                        <th>
                                        </th>
                                        <th style="width: 50px;">
                                        </th>
                                        <th style="width: 100px;">
                                        </th>
                                        <th style="width: 10px;">
                                        </th>
                                        <th>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            Proyecto
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td>
                                            <%= Html.DropDownList("IdProyecto", (IEnumerable<SelectListItem>)ViewData["Proyecto"])%>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            Situación
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td>
                                            <%= Html.DropDownList("IdEstado", (IEnumerable<SelectListItem>)ViewData["Estado"])%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Tipo de Servicio
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td>
                                            <%= Html.DropDownList("IdTipoServicio", (IEnumerable<SelectListItem>)ViewData["TipoServicio"])%>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </tbody>
                            </table><div class="content-button">
                            <a href="javascript:;" id="btnBuscar" class="button">Buscar</a>
                        </div>
                        </div>
                        
                    </div>
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Solicitudes de Cotización</span>
                        </div>
                        <div class="texto-noticia">
                            <table id="tblSolicitud">
                                <thead>
                                    <tr>
                                        <th>
                                            <b>Nro. Solicitud</b>
                                        </th>
                                        <th>
                                            <b>Fecha Sol.</b>
                                        </th>
                                        <th>
                                            <b>Proyecto</b>
                                        </th>
                                        <th>
                                            <b>Tipo de Servicio</b>
                                        </th>
                                        <th>
                                            <b>Situación</b>
                                        </th>
                                        <th>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (Model != null)
                                       {
                                           foreach (var solicitudCotizacion in Model)
                                           {
                                    %>
                                    <tr>
                                        <td>
                                            <%= solicitudCotizacion.IdSolicitudCotizacion %>
                                        </td>
                                        <td>
                                            <%= (solicitudCotizacion.FecSolCotizacion + "").Substring(6, 4) + "-" + (solicitudCotizacion.FecSolCotizacion + "").Substring(3, 2) + "-" + (solicitudCotizacion.FecSolCotizacion + "").Substring(0, 2)%>
                                        </td>
                                        <td>
                                            <%= DemoMVC.Controllers.CotizacionController.GetProyecto(Convert.ToInt32(solicitudCotizacion.GSC_DetalleSolicitudRequerimiento.FirstOrDefault().IdProyecto)) %>
                                        </td>
                                        <td>
                                            <%= solicitudCotizacion.GSC_TipoServicio.DescripTServicio %>
                                        </td>
                                        <td>
                                            <%= solicitudCotizacion.GSC_Estado != null ?solicitudCotizacion.GSC_Estado.DescripEstado:""%>
                                        </td>
                                        <td style="text-align: center;">
                                            <a href="javascript:;" class="button seleccionar">Seleccionar</a>
                                        </td>
                                    </tr>
                                    <%
                                           }
                                       } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="dialogSeleccionar" style="display: none;">
        <fieldset>
            <legend>Detalle de Solicitud</legend>
            <table id="tblDetalle" style="width: 100%; margin-bottom: 15px;">
                <thead>
                    <tr>
                        <th>
                            Descripción
                        </th>
                        <th>
                            Fecha
                        </th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </fieldset>
        <div id="divOpcion">
        </div>
    </div>
</asp:Content>
