<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    RegistrarDeclaracionFabrica
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="registrarDeclaracionFabrica">
     <% using (Html.BeginForm("RegistrarDeclaracionFabrica", "Legal", FormMethod.Post, new { enctype = "multipart/form-data" }))
    { %>
        <div class="fila">
            <div class="col2">
                Proyecto
            </div>
            <div class="col6">
                <%: Html.DropDownList("idProyecto", (SelectList)ViewData["Proyectos"],"Seleccionar")%>
            </div>
        </div>
        <div class="fila">
            <div class="col2">
                Descripción
            </div>
            <div class="col2 final">
                <textarea id="txtDescripcion" name="txtDescripcion" cols="" rows=""></textarea>
            </div>
        </div>
        <div class="dFab">
            <fieldset>
                <legend>Archivos Adjuntos</legend>
                <div class="fila">
                    <div class="col3">
                        Declaratoria de fábrica
                    </div>
                    <div class="col5 final">
                        <input id="file1" name="file1" type="file"/>
                    </div>
                </div>
                <div class="fila">
                    <div class="col3">
                        Planos
                    </div>
                    <div class="col5 final">
                        <input id="file2" name="file2" type="file"/>
                    </div>
                </div>
                <div class="fila">
                    <div class="col3">
                        Informe de verificaci&oacute;n t&eacute;cnica
                    </div>
                    <div class="col5 final">
                        <input id="file3" name="file3" type="file"/>
                    </div>
                </div>
            </fieldset>
            <div id="btnGrabarReqLegal">
                <input type="submit" value="Grabar"/>
            </div>
        </div>
        <% } %>
    </div>
</asp:Content>
