<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	InformesReq
</asp:Content>

<asp:Content ID="ContentPlan" ContentPlaceHolderID="MainContent" runat="server">
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
        });
    </script>
    <div class="contenido-top">
        <div>
            <h2>
                Informe de Requerimiento
            </h2>
            <hr>
            <table width="100%">
                <tr>
                    <td width="5%">&nbsp;</td>
                    <td width="15%">Requerimiento</td>
                    <td width="15%"><input size="10" id='txtReq' name='txtReq' /></td>
                    <td width="15%">Descripción</td>
                    <td width="15%"><input size="10" id='txtDes' name='txtDes' /></td>
                    <td width="15%">Prioridad</td>
                    <td width="15%">
                        <select id='selPrioridad' name='selPrioridad'>
                            <option value='1'>Alta</option>
                            <option value='2'>Media</option>
                            <option value='3'>Baja</option>
                        </select>
                    </td>
                    <td width="5%">&nbsp;</td>
                <tr>
                <tr>
                    <td width="5%">&nbsp;</td>
                    <td width="15%">Proyecto</td>
                    <td width="15%">
                        <select id='selProy' name='selProy'>
                            <option value='1'>Proy1</option>
                            <option value='2'>Proy2</option>
                            <option value='3'>Proy3</option>
                        </select>
                    </td>
                    <td width="15%">Fecha</td>
                    <td width="15%"><input size="10" id='txtFec' name='txtFec' /></td>
                    <td width="15%">Recurso</td>
                    <td width="15%">
                        <select id='SelRec' name='SelRec'>
                            <option value='1'>Obrero</option>
                            <option value='2'>Equipo</option>
                            <option value='3'>Subcontrata</option>
                        </select>
                    </td>
                    <td width="5%">&nbsp;</td>
                <tr>
            </table>
            <br/><br/>
            <h2>
                Detalle de Recurso
            </h2>
            <hr>
            <table width="100%">
                <tr>
                    <td width="5%">&nbsp;</td>
                    <td width="15%">Cantidad</td>
                    <td width="15%"><input size="10" id='txtCant' name='txtCant' /></td>
                    <td width="15%">Descripción Servicio</td>
                    <td width="15%"><input size="10" id='txtServ' name='txtServ' /></td>
                    <td width="15%">Empleado</td>
                    <td width="15%"><input size="10" id='txtEmp' name='txtEmp' />
                    </td>
                    <td width="5%">&nbsp;</td>
                <tr>
                <tr>
                    <td width="5%">&nbsp;</td>
                    <td width="15%">Fecha Inicio</td>
                    <td width="15%">
                        <input size="10" id='txtFecIni' name='txtFecIni' />
                    </td>
                    <td width="15%">Unidad</td>
                    <td width="15%"><input size="10" id='txtUnidad' name='txtUnidad' /></td>
                    <td width="15%">&nbsp;</td>
                    <td width="15%">&nbsp;</td>
                    <td width="5%">&nbsp;</td>
                <tr>
                <tr>
                    <td width="5%">&nbsp;</td>
                    <td width="15%">Fecha Fin</td>
                    <td width="15%">
                        <input size="10" id='txtFecFin' name='txtFecFin' />
                    </td>
                    <td width="15%">Tipo Servicio</td>
                    <td width="15%">
                        <select id='selTipServ' name='selTipServ'>
                            <option value='1'>Obrero</option>
                            <option value='2'>Equipo</option>
                            <option value='3'>Subcontrata</option>
                        </select>
                    </td>
                    <td width="15%">&nbsp;</td>
                    <td width="15%">&nbsp;
                    </td>
                    <td width="5%">&nbsp;</td>
                <tr>
            </table>
            <br/><br/>
            <table width="100%">
                <tr>
                    <th>Recurso</th>
                    <th>Cantidad</th>
                    <th>Unidad</th>
                    <th>Tipo de Servicio</th>
                    <th>Estado de Servicio</th>
                    <th>&nbsp;  </th>
                </tr>
            </table>
            <br/><br/>
            <center>
                <input type="button" value="Agregar Recurso" onclick="javascript:fAccion(1)" />&nbsp;&nbsp;
                <input type="button" value="Eliminar Recurso" onclick="javascript:fAccion(2)" />&nbsp;&nbsp;
                <input type="button" value="Modificar Recurso" onclick="javascript:fAccion(4)" />&nbsp;&nbsp;
                <input type="button" value="Grabar" />&nbsp;&nbsp;
            </center>
        </div>    
    </div>
</asp:Content>
