<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Registrar Plantilla de Contrato
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="../../Scripts/Legal/legal_plantillaContrato.js" type="text/javascript"></script>
    <script type="text/javascript">

        //Ajax setup config==================================================================================
        $.ajaxSetup({
            // Disable caching of AJAX responses */
            cache: false
        });
        //Context Route======================================================================================
        var config = {
            contextPath: '<%=ResolveUrl("~")%>'
        };

        $("document").ready(function () {
            var bSuccess = '<%= Session["bInsertSuccess"] %>';
            //var bEsConfirmacion = '<%= Session["bEsConfirmacion"] %>';
            //if (bEsConfirmacion == true) {
            /*if (bSuccess) {
                alert("La solicitud de su requerimiento legal ha sido registrada.\nEspere por su atención.");
            }*/
            //}
        });

    </script>

    <div id="registrarPlantillaContrato">

        <h1>Registrar Requerimiento Legal Plantilla de Contrato</h1>

        <% using (Html.BeginForm())
       { %>

        <div class="fila">
            <div class="col1">Proyecto:</div>
            <div class="col5">
                <%: Html.DropDownList("idProyecto", (SelectList)ViewData["Proyectos"],"Seleccionar")%>
            </div>
            <div class="col2 paddingTop">Tipo de Contrato:</div>
            <div class="col3 final">
                <select id="cboTipoContrato">
                    <option value="0">Seleccionar</option>
                    <option value="1">Contrato de Trabajo a Plazo Indeterminado</option>
                    <option value="2">Contrato de Prestación de Servicios</option>
                    <option value="3">Contrato de Trabajo Sujeto a Modalidad</option>
                </select>
            </div>
        </div>

        <div class="fila">
            <div class="col1">Descripción:</div>
            <div class="col2 final"><textarea id="txtDescripcion" name="txtDescripcion" cols="" rows=""></textarea></div>
        </div>

        <div id="tipo_1">
            <fieldset id="">
                <legend>Datos de Contrato</legend>
                <div class="fila">
                    <div class="col3 paddingTop">Nombre del personal a contratar:</div>
                    <div class="col6"><input id="txtNombre" name="txtNombre" type="text" class="text1" /></div>
                    <div class="col2 paddingTop">Horario de trabajo:</div>
                    <div class="col5 final">de <input id="txtIniTrabajo" name="txtIniTrabajo" type="text" class="text0" /> a <input id="txtFinTrabajo" name="txtFinTrabajo" type="text" class="text0" /></div>
                </div>
                <div class="fila">
                    <div class="col3 paddingTop">DNI del personal a contratar:</div>
                    <div class="col6"><input id="txtDni" name="txtDni" type="text" class="text1" /></div>
                    <div class="col2 paddingTop">Horario de refrigerio:</div>
                    <div class="col5 final">de <input id="txtIniRefri" name="txtIniRefri" type="text" class="text0" /> a <input id="txtFinRefri" name="txtFinRefri" type="text" class="text0" /></div>
                </div>
                <div class="fila">
                    <div class="col3 paddingTop">Cargo:</div>
                    <div class="col6"><input id="txtCargo" name="txtCargo" type="text" class="text1" /></div>
                    <div class="col2 paddingTop">Periodo de prueba:</div>
                    <div class="col4 final"><input id="txtPeriodo" name="txtPeriodo" type="text" class="text1" /></div>
                </div>
                <div class="fila">
                    <div class="col3 paddingTop">Labor a desempeñar:</div>
                    <div class="col6"><input id="txtLabor" name="txtLabor" type="text" class="text1" /></div>
                </div>
            </fieldset>
        </div>

        <div id="tipo_2">
            <fieldset id="Fieldset1">
                <legend>Datos de Contrato</legend>
                <div class="fila">
                    <div class="col3 paddingTop">Empresa Outsourcing:</div>
                    <div class="col6"><input id="txtOutsourcing" name="txtOutsourcing" type="text" class="text1" /></div>
                    <div class="col3 paddingTop">N. Ficha Poder Judicial:</div>
                    <div class="col5 final"><input id="txtFicha" name="txtFicha" type="text" class="text1" /></div>
                </div>
                <div class="fila">
                    <div class="col3 paddingTop">RUC:</div>
                    <div class="col6"><input id="txtRuc" name="txtRuc" type="text" maxlength="11" class="text1" /></div>
                    <div class="col3 paddingTop">Objeto Social Outsourcing:</div>
                    <div class="col5 final"><input id="txtObjetoOutsourcing" name="txtObjetoOutsourcing" type="text" class="text1" /></div>
                </div>
                <div class="fila">
                    <div class="col3 paddingTop">Domicilio:</div>
                    <div class="col6"><input id="txtDomicilio" name="txtDomicilio" type="text" class="text1" /></div>
                    <div class="col3 paddingTop">Servicio a brindar:</div>
                    <div class="col4 final"><input id="txtServicio" name="txtServicio" type="text" class="text1" /></div>
                </div>
                <div class="fila">
                    <div class="col3 paddingTop">Representante Legal:</div>
                    <div class="col6"><input id="txtRepresentante" name="txtRepresentante" type="text" class="text1" /></div>
                    <div class="col3 paddingTop">Duración del contrato:</div>
                    <div class="col6 final"><input id="txtDuracion" name="txtDuracion" type="text" class="text1" /></div>
                </div>
                <div class="fila">
                    <div class="col3 paddingTop">DNI Representante L.:</div>
                    <div class="col6"><input id="txtDniRL" name="txtDniRL" type="text" maxlength="8" class="text1" /></div>
                    <div class="col3 paddingTop">Juez para controversia:</div>
                    <div class="col6 final"><input id="txtJuez" name="txtJuez" type="text" class="text1" /></div>
                </div>
            </fieldset>
        </div>

        <div id="tipo_3">
            <fieldset id="Fieldset2">
                <legend>Datos de Contrato</legend>
                <div class="fila">
                    <div class="col3 paddingTop">Nombre del personal a contratar:</div>
                    <div class="col6"><input id="txtNombreMod" name="txtNombreMod" type="text" class="text1" /></div>
                    <div class="col3 paddingTop">Horario de trabajo:</div>
                    <div class="col5 final">de <input id="txtIniTrabajoMod" name="txtIniTrabajoMod" type="text" class="text0" /> a <input id="txtFinTrabajoMod" name="txtFinTrabajoMod" type="text" class="text0" /></div>
                </div>
                <div class="fila">
                    <div class="col3 paddingTop">DNI del personal a contratar:</div>
                    <div class="col6"><input id="txtDniMod" name="txtDniMod" type="text" maxlength="8" class="text1" /></div>
                    <div class="col3 paddingTop">Horario de refrigerio:</div>
                    <div class="col5 final">de <input id="txtIniRefriMod" name="txtIniRefriMod" type="text" class="text0" /> a <input id="txtFinRefriMod" name="txtFinRefriMod" type="text" class="text0" /></div>
                </div>
                <div class="fila">
                    <div class="col3 paddingTop">Modalidad del contrato:</div>
                    <div class="col6"><input id="txtModalidad" name="txtModalidad" type="text" class="text1" /></div>
                    <div class="col3 paddingTop">Juez para controversia:</div>
                    <div class="col4 final"><input id="txtJuezMod" name="txtJuezMod" type="text" class="text1" /></div>
                </div>
                <div class="fila">
                    <div class="col3 paddingTop">Duración:</div>
                    <div class="col6"><input id="txtDuracionMod" name="txtDuracionMod" type="text" class="text1" /></div>
                </div>
            </fieldset>
        </div>

        <br /><br />

        <label><input type="checkbox" id="chkClausula" name="chkTieneClausula" value=""> Incluir Cláusulas adicionales</label>

        <div id="clausulas">
            <fieldset id="Fieldset3">
                <legend>Cláusulas</legend>
                <div id="dynClausulas">
                    <div class="fila">
                        <div class="col1 paddingTop">Cláusula 1:</div>
                        <div class="col6"><input id="txtClau_1" type="text" class="text10" /></div>
                    </div>
                </div>
                <div id="divLnkAgregar"><a id="lnkAgregar" class="lnkAgregar" href="javascript:void(0);">+ Agregar cláusula</a></div>
            </fieldset>
        </div>

        <div id="btnGrabarReqLegal">
            <a class="btnGrabarReqLegal btn" href="#">Grabar</a>
        </div>

       <% } %>

    </div>

</asp:Content>
