<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Inconsistencias por Partida
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<link href="../../Content/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="../../Scripts/kendo/kendo.flat.min.css" rel="stylesheet" type="text/css" />
<link href="../../Scripts/kendo/kendo.common.min.css" rel="stylesheet" type="text/css" />
<link href="../../Content/Site.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="../../Scripts/kendo/kendo.web.min.js"></script>

<script type="text/javascript" language="javascript">
    var config = {
        contextPath: '<%=ResolveUrl("~")%>'
    };

    $(document).ready(function () {
        $("#presupuestos").change(function () {
            cambiaElementos($("#presupuestos").val());
        });
        cambiaElementos($("#presupuestos").val());
    });

    function cambiaElementos(presupuesto) {
        var dd = document.getElementById("partidas");
        dd.options.length = 0;
        dd.options[0] = new Option("Espere...");
        dd.selectedIndex = 0;
        dd.disabled = true;

        // Control de errores

        $("#partidas").ajaxError(function (event, request, settings) {
            dd.options[0] = new Option("Presupuesto incorrecto");
        });

        // Obtenemos los datos...

        $.getJSON('<%= Url.Action("GetPartidas") %>', // URL a la acción
                  {presupuesto: presupuesto },        // Objeto JSON con parámetros
                  function (data) {                    // Función de retorno exitoso
                      $.each(data, function (i, item) {
                          dd.options[i] = new Option(item.Nombre, item.IDPartida);
                      });
                      dd.disabled = false;
                  });
    }

    $(function () {
        $("#datepicker").datepicker({
            showOn: "button",
            buttonImage: config.contextPath + 'images/calendar.gif',
            buttonImageOnly: true,
            dateFormat: 'dd/mm/yy'
        });
    });

    $(document).ready(function () {
        $("#btnListar").click(function () {
            var partida = document.getElementById('partidas').options[document.getElementById('partidas').selectedIndex].value;
            var fecha = document.getElementById('datepicker').value;

            if (partida == null || partida == "") {
                $("#mensaje").html('Debe seleccionar una partida');
                $("#mensaje").dialog({ modal: true, buttons: [{ text: "Aceptar", click: function () { $(this).dialog("close"); } }] });

                return false;
            }

            if (fecha == null || fecha == "") {
                $("#mensaje").html('Debe seleccionar una fecha');
                $("#mensaje").dialog({ modal: true, buttons: [{ text: "Aceptar", click: function () { $(this).dialog("close"); } }] });

                return false;
            }

            CargarGrilla(partida, fecha);
        });
    });

    function CargarGrilla(partida, fecha) {
        $.getJSON("/Partidas/ListarRechazados", { partida: partida, fecha: fecha }, function (resultado) {
                $("#DetallesPorPartida").kendoGrid({
                    dataSource: {
                        data: resultado,
                        pageSize: 10
                    },
                    groupable: false,
                    sortable: false,
                    pageable: true,
                    columns: [{
                    field: "IdDetallePartida",
                    width: 36,
                    title: "<center>Código<br />de Ítem</center>",
                    attributes: { style: "text-align: right;" }
                    }, {
                        field: "Categoria",
                    width: 70,
                    title: "<center>Categoría</center>"
                    }, {
                        field: "Descripcion",
                    width: 140,
                    title: "<center>Descripción de Recurso</center>"
                    }, {
                        field: "Unidad",
                    width: 46,
                    title: "<center>Unidad de<br />Medida</center>",
                    attributes: { style: "text-align: center;" }
                    }, {
                        field: "Cantidad",
                    width: 40,
                    title: "<center>Avance<br />Presupuestado</center>",
                    attributes: { style: "text-align: right;" }
                }, 
//                    {
//                    field: "CantidadPresupuesto",
//                    width: 60,
//                    title: "<center>Avance<br />Presupuestado</center>",
//                    attributes: { style: "text-align: right;" }
//                }, 
                
                {
                    field: "CantidadEjecutada",
                    width: 50,
                    title: "<center>Avance Real<br />Ejecutado</center>",
                    attributes: { style: "text-align: right;" }
                    }, {
                        title: "&nbsp;",
                    width: 40,
                        template: function (dataItem) {
                        return "<input type='button' value='Generar' onclick='mostrarAvance(" + kendo.htmlEncode(dataItem.IdAvancePartida) + ")' style='text-transform:none;-webkit-box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; -moz-box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; background-color:#5B74A8; border:1px solid #29447E; font-family:Tahoma,Verdana,Arial,sans-serif; font-size:12px; font-weight:700; padding:2px 6px; height:28px; color:#fff; border-radius:5px; -moz-border-radius:5px; -webkit-border-radius:5px;' />";
                        }
                    }]
                });
            });
    }
</script>
<script type="text/javascript">
    $(function () {
        $('#dialog').dialog({
            autoOpen: false,
            width: 600,
            resizable: false,
            title: 'Inconsistencia de Avance por Partida',
            modal: true,
            buttons: [
                { text: "Guardar", click: function () {
                    var dlg = $(this);
                    $.ajax({
                        url: '<%= Url.Action("InconsistenciaPartida") %>',
                        type: 'POST',
                        data: {
                            IdInconsistenciaAvancePartida: $("#IdInconsistenciaAvancePartida").val(),
                            IdAvancePartida: $("#IdAvancePartida").val(),
                            Observacion: $("#observacion").val()
                        },
                        success: function (data) {
                            var elem = data.split('|');
                            var tipoError = elem[0];
                            var mensaje = elem[1];

                            $("#mensaje").html(mensaje);

                            if (tipoError == '"0') {
                                dlg.dialog('close');

                                var partida = document.getElementById('partidas').options[document.getElementById('partidas').selectedIndex].value;
                                var fecha = document.getElementById('datepicker').value;

                                CargarGrilla(partida, fecha);
                            }

                            $("#mensaje").dialog({ modal: true, buttons: [{ text: "Aceptar", click: function () { $(this).dialog("close"); } }] });
                        },
                        error: function (data) {
                            alert(data.responseText);
                        }
                    });
                } 
                },
                { text: "Cancelar", click: function () { $(this).dialog("close"); } }
            ]
        });
    });

    function mostrarAvance(IdAvancePartida) {
        $('#dialog').load("InconsistenciaPartida?IdAvancePartida=" + IdAvancePartida,
                        function (response, status, xhr) {
                            $('#dialog').dialog('open');
                        });
    }
</script>

<div class="contenido-top">
    <div class="gpc-page">
        <div style="width: 100%; float: left; display: block;">
            <h1>Inconsistencias por Partida</h1>
            <table cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td><%: Html.Label("Presupuesto:")%></td>
                    <td><%: Html.DropDownList("presupuestos", (SelectList)ViewData["presupuestos"])%></td>
                </tr>
                <tr>
                    <td><%: Html.Label("Partida:")%></td>
                    <td>
                        <select id="partidas" name="partidas" disabled="disabled">
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><%: Html.Label("Fecha:")%></td>
                    <td><input type="text" id="datepicker" disabled="disabled" style="width: 100px" /></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input id="btnListar" type="button" value="Mostrar Ítems" style="text-transform:none;-webkit-box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; -moz-box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; box-shadow:rgba(0,0,0,0.0.1) 0 1px 0 0; background-color:#5B74A8; border:1px solid #29447E; font-family:Tahoma,Verdana,Arial,sans-serif; font-size:12px; font-weight:700; padding:2px 6px; height:28px; color:#fff; border-radius:5px; -moz-border-radius:5px; -webkit-border-radius:5px;" /></td>
                </tr>
            </table>
            <div id="DetallesPorPartida">
            </div>
            <div id="dialog" title="Inconsistencia por Partida" style="overflow: hidden;"></div>
            <div id="mensaje" title="Inconsistencia por Partida" style="overflow: hidden;"></div>
        </div>
    </div>
    <div class="clear">
    </div>
</div>

</asp:Content>
