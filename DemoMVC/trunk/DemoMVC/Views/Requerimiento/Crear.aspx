<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<DemoMVC.Models.RequerimientoCrearForm>" %>

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

    <% using (Html.BeginForm())
       { %>

        <div class="contenido-top">
        <div>
            <h2>
                Informe de Requerimiento
            </h2>
            <hr>
            <table width="100%">
                <tr>
                    <td width="5%">&nbsp;</td>
                    <td width="15%">&nbsp;</td>
                    <td width="15%">&nbsp;</td>
                    <td width="15%">Descripción</td>
                    <td width="15%"><input size="10" id='txtDes' name='txtDes' required /></td>
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
                    <td width="5%">&nbsp;</td>
                    <td width="15%">Proyecto</td>
                    <td width="15%">
                       <%: Html.DropDownList("selProy", Model.ListaProyectos, new { style = "width:200px" })%> 
                    </td>
                    <td width="15%">Fecha</td>
                    <td width="15%"><input size="10" id='txtFec' name='txtFec' value=' <%= Model.Fecha %> ' readonly /></td>
                    <td width="15%">Tipo Recurso</td>
                    <td width="15%">
                        <select id='SelRec' name='SelRec'>
                                <option value='3'>Empleados</option>
                                <option value='2'>Materiales</option>
                                <option value='1'>Maquinarias</option>
                        </select>
                    </td>
                    <td width="5%">&nbsp;</td>
                <tr>
                    <td width="5%">&nbsp;</td>
                    <td width="15%">&nbsp;</td>
                    <td width="15%">
                        &nbsp;</td>
                    <td width="15%">&nbsp;</td>
                    <td width="15%">&nbsp;</td>
                    <td width="15%">&nbsp;</td>
                    <td width="15%">
                        &nbsp;</td>
                    <td width="5%">&nbsp;</td>
                <tr>
                    <td width="5%">&nbsp;</td>
                    <td width="15%">&nbsp;</td>
                    <td width="15%">
                        &nbsp;</td>
                    <td width="15%">&nbsp;</td>
                    <td width="15%">&nbsp;</td>
                    <td width="15%">&nbsp;</td>
                    <td width="15%">
                        &nbsp;</td>
                    <td width="5%">&nbsp;</td>
                <tr>
                    <td width="5%">&nbsp;</td>
                    <td width="15%">&nbsp;</td>
                    <td width="15%">
                        &nbsp;</td>
                    <td width="15%">
           

                <input type="submit" value="Grabar" name="submitButton" class="button" />
                
                </td>
                    <td width="15%"><a href='javascript:window.history.back();' class="button">Regresar</a></td>
                    <td width="15%">&nbsp;</td>
                    <td width="15%">
                        &nbsp;</td>
                    <td width="5%">&nbsp;</td>
                </table>
            <br/>
           
    </div>

    <%
       } %>


</asp:Content>



