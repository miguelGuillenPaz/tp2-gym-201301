<%@ Page Title="Title" Language="C#" Inherits="System.Web.Mvc.ViewPage<DemoMVC.Models.Requerimiento>"
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

            $('#tblbody').delegate('.eliminar', 'click', function () {
                $(this).parent().parent().remove();
            });


            $('#tblbody').delegate('.editar', 'click', function () {
                var tr = $(this).parent().parent();
                $('#txtDescripcion').val($('td:eq(1)', tr).text());
                $('#idUnidadMedida').val($('td:eq(2)', tr).text());
                $('#txtCantidad').val($('td:eq(4)', tr).text());
                $('#idTipoServicio').val($('td:eq(5)', tr).text());
                $('#dialogRequerimiento').dialog({
                    autoOpen: true,
                    height: 300,
                    width: 310,
                    resizable: false,
                    modal: true,
                    title: 'Detalle de Requerimiento',
                    buttons: {
                        'Aceptar': function () {
                            var nroRequeridos = 0;
                            $('#dialogRequerimiento .required').each(function () {
                                if ($(this).val() == '') {
                                    nroRequeridos = nroRequeridos + 1;
                                    $(this).addClass('required-control');
                                } else {
                                    $(this).removeClass('required-control');
                                }
                            });

                            if (nroRequeridos == 0) {
                                if ($('#txtCantidad').val() == '0') {
                                    $(this).addClass('required-control');
                                    __ShowMessage('La cantidad debe ser mayor a cero.');
                                    breakIntoDebugger();
                                }
                                else {
                                    $(this).removeClass('required-control');
                                }
                                $('td:eq(1)', tr).text($('#txtDescripcion').val().toUpperCase());
                                $('td:eq(2)', tr).text($('#idUnidadMedida').val());
                                $('td:eq(3)', tr).text($('#idUnidadMedida option:selected').text());
                                $('td:eq(4)', tr).text($('#txtCantidad').val());
                                $('td:eq(5)', tr).text($('#idTipoServicio').val());
                                $('td:eq(6)', tr).text($('#idTipoServicio option:selected').text());
                                $(this).dialog('close');
                            } else {
                                __ShowMessage('Existen campos obligatorios sin llenar.');
                            }
                        },
                        'Cancelar': function () {
                            $(this).dialog('close');
                        }
                    },
                    close: function () {
                        $(this).dialog('close');
                    }
                });
            });

            $('#btnAgregar').click(function () {
                $('#txtDescripcion').val('');
                $('#idUnidadMedida').val('');
                $('#txtCantidad').val('1');
                $('#idTipoServicio').val('');
                $('#dialogRequerimiento').dialog({
                    autoOpen: true,
                    height: 300,
                    width: 310,
                    resizable: false,
                    modal: true,
                    title: 'Detalle de Requerimiento',
                    buttons: {
                        'Aceptar': function () {
                            var nroRequeridos = 0;
                            $('#dialogRequerimiento .required').each(function () {
                                if ($(this).val() == '') {
                                    nroRequeridos = nroRequeridos + 1;
                                    $(this).addClass('required-control');
                                } else {
                                    $(this).removeClass('required-control');
                                }
                            });
                            if (nroRequeridos == 0) {
                                if ($('#txtCantidad').val() == '0') {
                                    $(this).addClass('required-control');
                                    __ShowMessage('La cantidad debe ser mayor a cero.');
                                    breakIntoDebugger();
                                }
                                else {
                                    $(this).removeClass('required-control');
                                }
                                var tr = '<tr>';
                                tr += '<td>0</td>';
                                tr += '<td>';
                                tr += $('#txtDescripcion').val().toUpperCase();
                                tr += '</td>';
                                tr += '<td>';
                                tr += $('#idUnidadMedida').val();
                                tr += '</td>';
                                tr += '<td>';
                                tr += $('#idUnidadMedida option:selected').text().toUpperCase();
                                tr += '</td>';
                                tr += '<td>';
                                tr += $('#txtCantidad').val();
                                tr += '</td>';
                                tr += '<td>';
                                tr += $('#idTipoServicio').val();
                                tr += '</td>';
                                tr += '<td>';
                                tr += $('#idTipoServicio option:selected').text().toUpperCase();
                                tr += '</td>';
                                tr += '<td style="text-align: center;"><a class="editar button" href="javascript:;">Editar</a> | <a class="eliminar button" href="javascript:;">Eliminar</a></td>';
                                tr += '</tr>';
                                $('#tblbody').append(tr);
                                $(this).dialog('close');
                            } else {
                                __ShowMessage('Existen campos obligatorios sin llenar.');
                            }
                        },
                        'Cancelar': function () {
                            $(this).dialog('close');
                        }
                    },
                    close: function () {
                        $(this).dialog('close');
                    }
                });
            });
        });
    </script>
    <div class="contenido-top">
        <div>
            <h1>
                Informe de Requerimiento
            </h1>
            <div class="areas-negocios">
                <div class="lista-central">
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Requerimiento:
                                <%= Model.idReq %></span>
                                <%= Html.HiddenFor(m=> m.idReq) %>
                        </div>
                        <div class="texto-noticia">
                            <table id="tblHead">
                                <tr>
                                    <td>
                                        Proyecto
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <%= Html.DropDownListFor(m => m.idProyecto, (IEnumerable<SelectListItem>)ViewData["Proyecto"])%>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        Prioridad
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <%= Html.DropDownListFor(m => m.prioridad, (IEnumerable<SelectListItem>)ViewData["Prioridad"])%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Descripción
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td colspan="5">
                                        <%= Html.TextBoxFor(m => m.descripcion)%>
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
                                        <input id="fecha" type="date" value="<%= Model.fecha.ToString().Substring(6, 4) + "-" + Model.fecha.ToString().Substring(3, 2) + "-" + Model.fecha.ToString().Substring(0, 2)%>" />
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        Tipo Recurso
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <%= Html.DropDownListFor(m => m.idTipoRequerimiento, (IEnumerable<SelectListItem>)ViewData["TipoRecurso"])%>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <a id="btnAgregar" class="button" href="javascript:;">Agregar</a>
                            <br />
                            <br />
                            <table id="tblbody">
                                <thead>
                                    <tr>
                                        <th>
                                            IdDet
                                        </th>
                                        <th>
                                            Descripción
                                        </th>
                                        <th>
                                            IdUM
                                        </th>
                                        <th>
                                            Unidad Medida
                                        </th>
                                        <th>
                                            Cantidad
                                        </th>
                                        <th>
                                            IdTS
                                        </th>
                                        <th>
                                            Tipo Servicio
                                        </th>
                                        <th style="width: 180px; text-align: center;">
                                            Opciones
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (Model.ListaDetalleRequerimiento != null)
                                       {
                                           foreach (var requerimiento in Model.ListaDetalleRequerimiento)
                                           {
                                    %>
                                    <tr>
                                        <td><%= requerimiento.codcorDetReq %></td>
                                        <td><%= requerimiento.desReq %></td>
                                        <td><%= requerimiento.codUM %></td>
                                        <td><%= requerimiento.descUM %></td>
                                        <td><%= requerimiento.canDetReq %></td>
                                        <td><%= requerimiento.codTipoServ %></td>
                                        <td><%= requerimiento.descTipoServ %></td>
                                        <td style="text-align: center;">
                                            <a class="editar button" href="javascript:;">Editar</a> | <a class="eliminar button"
                                                href="javascript:;">Eliminar</a>
                                        </td>
                                    </tr>
                                    <%
                                           }
                                       } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="content-button">
                        <a id="btnEnviar" class="button" href="javascript:;">Enviar</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="dialogRequerimiento" style="display: none;">
        <input type="hidden" id="hdnIdDetalle" />
        <table style="width: 100%">
            <tbody>
                <tr>
                    <td colspan="3">
                        Descripción:
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <input id="txtDescripcion" type="text" style="width: 98%" class="required" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Unidad Medida
                    </td>
                    <td>
                        :
                    </td>
                    <td>
                        <%= Html.DropDownList("idUnidadMedida", (IEnumerable<SelectListItem>)ViewData["UnidadMedida"], new{@class="required"})%>
                    </td>
                </tr>
                <tr>
                    <td>
                        Cantidad
                    </td>
                    <td>
                        :
                    </td>
                    <td>
                        <input id="txtCantidad" type="number"  min="0"  value="1" class="required"/>
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
                        <%= Html.DropDownList("idTipoServicio", (IEnumerable<SelectListItem>)ViewData["TipoServicio"], new { @class = "required" })%>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
