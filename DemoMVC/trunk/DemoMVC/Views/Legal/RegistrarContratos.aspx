<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	RegistrarContratos
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="../../Scripts/Legal/legal_plantillaContrato.js" type="text/javascript"></script>

    <div id="registrarPlantillaContrato">

        <h1>RegistrarContratos</h1>
    
        <select id="cboTipoContrato">
            <option value="1">Contrato de Trabajo a Plazo Indeterminado</option>
            <option value="2">Contrato de Prestación de Servicios</option>
            <option value="3">Contrato de Trabajo Sujeto a Modalidad</option>
        </select>

        <br /><br />

        <div id="tipo_1">
            <h3>Trabajo a Plazo Indeterminado</h3>
        </div>

        <div id="tipo_2">
            <h3>Prestación de Servicios</h3>
        </div>

        <div id="tipo_3">
            <h3>Trabajo Sujeto a Modalidad</h3>
        </div>

    </div>

</asp:Content>
