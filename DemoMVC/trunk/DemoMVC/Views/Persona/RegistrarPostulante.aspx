<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<DemoMVC.Models.GRH_Persona>" %>

<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script language="javascript" type="text/javascript">

        $(document).ready(function () {

            var selectedRow;

            $('#tblDocumento').delegate('.eliminar', "click", function () {
                var tr = $(this).parent().parent();
                var idDocumento = $.trim($('td:eq(0)', tr).text());
                if (idDocumento != 0) {
                    if (confirm('¿Desea eliminar el documento?')) {
                        var data = { idDocumento: idDocumento };
                        var url = '<%= Url.Content("~/Persona/DelDocumento") %>';
                        $.ajax({
                            type: 'POST',
                            url: url,
                            data: data,
                            success: function(result) {
                                if (result.result) {
                                    tr.remove();
                                }
                            },
                            error: function() {
                                alert('No se pudo eliminar');
                            }
                        });
                    }
                } else {
                    tr.remove();
                }
            });


            $('#tblDocumento').delegate('.editar', "click", function () {
                $('#hdnAccion').val('U');
                var tr = $(this).parent().parent();
                $('#hdnDocumento').val($.trim($('td:eq(0)', tr).text()));
                $('#ddlTipoDocumento').val($.trim($('td:eq(1)', tr).text()));
                $('#txtDocumento').val($.trim($('td:eq(3)', tr).text()));
                selectedRow = tr;
                $('#dialogDocumento').dialog('option', 'title', 'Editar Documento');
                $('#dialogDocumento').dialog('open');
            });

            $('#addDocumento').click(function () {
                $('#hdnAccion').val('I');
                $('#hdnDocumento').val('0');                
                $('#ddlTipoDocumento').val(0);
                $('#txtDocumento').val('');
                $('#dialogDocumento').dialog('option', 'title', 'Agregar Documento');
                $('#dialogDocumento').dialog('open');
            });

            $('#dialogDocumento').dialog({
                autoOpen: false,
                height: 160,
                width: 300,
                resizable: false,
                modal: true,
                buttons: {
                    'Aceptar': function () {
                        var idPersona = $.trim($('#idPersona').val());
                        if (idPersona == '') {
                            idPersona = '0';
                        }
                        var idDocumento = $.trim($('#hdnDocumento').val());
                        var idTipoDocumento = $.trim($('#ddlTipoDocumento').val());
                        var numeroDocumento = $.trim($('#txtDocumento').val());
                        var data = {
                            idPersona: idPersona,
                            idDocumento: idDocumento,
                            idTipoDocumento: idTipoDocumento,
                            numeroDocumento: numeroDocumento
                        };
                        var url = '<%= Url.Content("~/Persona/SetDocumento") %>';
                        $.ajax({
                            type: 'POST',
                            url: url,
                            data: data,
                            success: function (result) {
                                if (result.result) {
                                    $('#hdnDocumento').val(result.Documento);
                                    $('#idPersona').val(result.Persona);
                                    if ($('#hdnAccion').val() == 'I') {
                                        var fila = "<tr>" +
                                        "<td style=\"display: none;\">" + $('#hdnDocumento').val() + "</td>" +
                                        "<td style=\"display: none;\">" + $('#ddlTipoDocumento').val() + "</td>" +
                                        "<td>" + $('#ddlTipoDocumento option:selected').text() + "</td>" +
                                        "<td>" + $('#txtDocumento').val() + "</td>" +
                                        "<td><a class=\"editar\" href=\"javascript:;\">Editar</a> | <a class=\"eliminar\" href=\"javascript:;\">Eliminar</a></td>" +
                                        "</tr>";
                                        $('#tblDocumento tbody').append(fila);
                                    } else {
                                        var tr = selectedRow;
                                        $('td:eq(0)', tr).text($('#hdnDocumento').val());
                                        $('td:eq(1)', tr).text($('#ddlTipoDocumento').val());
                                        $('td:eq(2)', tr).text($('#ddlTipoDocumento option:selected').text());
                                        $('td:eq(3)', tr).text($('#txtDocumento').val());
                                    }                                    
                                    $('#dialogDocumento').dialog('close');
                                }
                            },
                            error: function () {
                                alert('No se puedo actualizar');
                            }
                        });


                    },
                    Cancel: function () {
                        $(this).dialog('close');
                    }
                },
                close: function () {
                    $(this).dialog('close');
                }
            });

        });
    </script>
    <div class="contenido-top">
        <div>
            <h1>
                Registrar Postulante
                <%= Html.HiddenFor(m=> m.idPersona) %>
            </h1>
            <div class="areas-negocios">
                <div class="lista-central">
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Información Personal</span>
                        </div>
                        <div class="texto-noticia">
                            <table>
                                <tr>
                                    <td>
                                        <%= Html.Label("Nombres") %>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <%= Html.TextBoxFor(m=> m.nombre) %>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        Documentos
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <table id="tblDocumento">
                                            <tbody>
                                                <% if (Model != null)
                                                   {
                                                       foreach (var documento in Model.GRH_Documento)
                                                       {
                                                %>
                                                <tr>
                                                    <td style="display: none;">
                                                        <%= documento.idDocumento %>
                                                    </td>
                                                    <td style="display: none;">
                                                        <%= documento.GRH_TipoDocumento!=null? documento.GRH_TipoDocumento.idTipoDocumento.ToString(CultureInfo.InvariantCulture):string.Empty %>
                                                    </td>
                                                    <td>
                                                        <%= documento.GRH_TipoDocumento!=null? documento.GRH_TipoDocumento.descripcion:string.Empty %>
                                                    </td>
                                                    <td>
                                                        <%= documento.nroDocumento %>
                                                    </td>
                                                    <td>
                                                        <a class="editar" href="javascript:;">Editar</a> | <a class="eliminar" href="javascript:;">
                                                            Eliminar</a>
                                                    </td>
                                                </tr>
                                                <%
                                                   }
                                               } %>
                                            </tbody>
                                        </table>
                                        <a id="addDocumento" href="javascript:;">Agregar</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%= Html.Label("Apellido Paterno") %>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <%= Html.TextBoxFor(m=> m.apellidoPaterno) %>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <%= Html.Label("Apellido Materno") %>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <%= Html.TextBoxFor(m=> m.apellidoMaterno) %>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%= Html.Label("Estado Civil") %>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <%= Html.DropDownListFor(m => m.idEstadoCivil, (IEnumerable<SelectListItem>)ViewData["EstadoCivil"]) %>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        Sexo
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <%= Html.RadioButtonFor(m => m.sexo,true) %>
                                        Masculino
                                        <%= Html.RadioButtonFor(m=> m.sexo,false)%>
                                        Femenino
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Dirección
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <%= Html.TextBoxFor(m=>m.direccion)%>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        Pais de Residencia
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <%= Html.DropDownListFor(m => m.idPais_R, (IEnumerable<SelectListItem>)ViewData["Pais"]) %>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Fecha de Nacimiento
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <%= Html.TextBoxFor(m=> m.fechaNacimiento, new {@type ="date"}) %>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <%= Html.Label("Pais de Nacimiento") %>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <%= Html.DropDownListFor(m => m.idPais_N, (IEnumerable<SelectListItem>)ViewData["Pais"]) %>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Teléfonos
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <table>
                                            <% if (Model != null)
                                               {
                                                   foreach (var telefono in Model.GRH_Telefono)
                                                   {
                                            %>
                                            <tr>
                                                <td>
                                                    <%= telefono.idTelefono %>
                                                </td>
                                                <td>
                                                    <%= telefono.nroTelefono %>
                                                </td>
                                                <td>
                                                    <a href="#">Editar</a> | <a href="#">Eliminar</a>
                                                </td>
                                            </tr>
                                            <%
                                                   }
                                               } %>
                                        </table>
                                        <a href="#">Agregar</a>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        Correos
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <table>
                                            <% if (Model != null)
                                               {
                                                   foreach (var correo in Model.GRH_Correo)
                                                   {
                                            %>
                                            <tr>
                                                <td>
                                                    <%= correo.idCorreo %>
                                                </td>
                                                <td>
                                                    <%= correo.cuentaCorreo %>
                                                </td>
                                                <td>
                                                    <a href="#">Editar</a> | <a href="#">Eliminar</a>
                                                </td>
                                            </tr>
                                            <%
                                                   }
                                               } %>
                                        </table>
                                        <a href="#">Agregar</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Experiencia Laboral</span>
                        </div>
                        <div class="texto-noticia">
                            <table>
                                <thead>
                                    <tr>
                                        <th>
                                            <b>Id</b>
                                        </th>
                                        <th>
                                            <b>Empresa</b>
                                        </th>
                                        <th>
                                            <b>Cargo</b>
                                        </th>
                                        <th>
                                            <b>F. Inicio</b>
                                        </th>
                                        <th>
                                            <b>F. Fin</b>
                                        </th>
                                        <th style="display: none;">
                                            <b>Conocimientos</b>
                                        </th>
                                        <th>
                                            <b>Opciones</b>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (Model != null)
                                       {
                                           foreach (var item in Model.GRH_ExperienciaLaboral)
                                           { %>
                                    <tr>
                                        <td>
                                            <%= item.idExperienciaLaboral %>
                                        </td>
                                        <td>
                                            <%= item.empresa %>
                                        </td>
                                        <td>
                                            <%= item.cargo %>
                                        </td>
                                        <td>
                                            <%= item.fechaInicio %>
                                        </td>
                                        <td>
                                            <%= item.FechaFin %>
                                        </td>
                                        <td style="display: none;">
                                            <%= item.conocimientos %>
                                        </td>
                                        <td>
                                            <a href="">Editar</a> | <a href="">Eliminar</a>
                                        </td>
                                    </tr>
                                    <%
                                           }
                                       } %>
                                </tbody>
                            </table>
                            <a href="">Agregar</a>
                        </div>
                    </div>
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Estudios Realizados</span>
                        </div>
                        <div class="texto-noticia">
                            <table>
                                <thead>
                                    <tr>
                                        <th>
                                            <b>Id</b>
                                        </th>
                                        <th>
                                            <b>Centro de Estudios</b>
                                        </th>
                                        <th>
                                            <b>Cargo</b>
                                        </th>
                                        <th>
                                            <b>F. Inicio</b>
                                        </th>
                                        <th>
                                            <b>F. Fin</b>
                                        </th>
                                        <th style="display: none;">
                                            <b>Conocimientos</b>
                                        </th>
                                        <th>
                                            <b>Opciones</b>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (Model != null)
                                       {
                                           foreach (var item in Model.GRH_EstudioRealizado)
                                           { %>
                                    <tr>
                                        <td>
                                            <%= item.idEstudioRealizado %>
                                        </td>
                                        <td>
                                            <%= item.centroEstudio %>
                                        </td>
                                        <td>
                                            <%= item.GRH_Especialidad !=null? item.GRH_Especialidad.descripcion:string.Empty %>
                                        </td>
                                        <td>
                                            <%= item.fechaInicio %>
                                        </td>
                                        <td>
                                            <%= item.fechaFin %>
                                        </td>
                                        <td style="display: none;">
                                            <%= item.nombreEstudio %>
                                        </td>
                                        <td>
                                            <a href="">Editar</a> | <a href="">Eliminar</a>
                                        </td>
                                    </tr>
                                    <%
                                           }
                                       } %>
                                </tbody>
                            </table>
                            <a href="">Agregar</a>
                        </div>
                    </div>
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Idiomas</span>
                        </div>
                        <div class="texto-noticia">
                            <table>
                                <thead>
                                    <tr>
                                        <th>
                                            <b>Id</b>
                                        </th>
                                        <th>
                                            <b>Idioma</b>
                                        </th>
                                        <th>
                                            <b>Nivel</b>
                                        </th>
                                        <th>
                                            <b>Opciones</b>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (Model != null)
                                       {
                                           foreach (var item in Model.GRH_IdiomaPersona)
                                           { %>
                                    <tr>
                                        <td>
                                            <%= item.idIdiomaPersona %>
                                        </td>
                                        <td>
                                            <%= item.GRH_Idioma!=null? item.GRH_Idioma.descripcion:string.Empty %>
                                        </td>
                                        <td>
                                            <%= item.nativo == true ? "Nativo" : (item.GRH_NivelIdioma!=null?item.GRH_NivelIdioma.descripcion:string.Empty)%>
                                        </td>
                                        <td>
                                            <a href="">Editar</a> | <a href="">Eliminar</a>
                                        </td>
                                    </tr>
                                    <%
                                           }
                                       } %>
                                </tbody>
                            </table>
                            <a href="">Agregar</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="dialogDocumento" title="" style="display: none; z-index: 1000;">
        <input type="hidden" id="hdnDocumento" />
        <input type="hidden" id="hdnAccion" />
        <table>
            <tr>
                <td>
                    Tipo
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.DropDownListFor(m => m.GRH_Documento.FirstOrDefault().idTipoDocumento, (IEnumerable<SelectListItem>)ViewData["TipoDocumento"], new { @id = "ddlTipoDocumento" })%>
                </td>
            </tr>
            <tr>
                <td>
                    Número
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.GRH_Documento.FirstOrDefault().nroDocumento, new { @id = "txtDocumento" })%>
                </td>
            </tr>
        </table>
    </div>

</asp:Content>
