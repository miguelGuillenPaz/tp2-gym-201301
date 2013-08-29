<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    RegistrarExpedienteTecnico
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
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
        //====================================================================================================
        $(function () {
            $.ajax({
                url: config.contextPath + 'ExpedienteTecnico/ListarPresupuestos',
                type: 'POST',
                datatype: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    $('#ListarPresupuesto').html(data);
                },
                error: function (request, status, err) {
                }
            });
        });
    </script>
    <div class="contenido-top">
        <div class="gpc-page">
            <div style="width: 100%; float: left; display: block;">
                <h1>
                    Registro de Expediente Técnico</h1>
                <br />
                <h3 class="gpc-subtitulo">
                    Presupuestos Aprobados</h3>
                <br />
            </div>
            <div id="ListarPresupuesto">
            </div>
        </div>
        <div class="clear">
        </div>
    </div>
</asp:Content>
