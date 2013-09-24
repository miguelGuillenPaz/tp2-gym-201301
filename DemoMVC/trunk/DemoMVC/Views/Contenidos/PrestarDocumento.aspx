<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<DemoMVC.Models.GD_Documento>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	PrestarDocumento
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
<link href="../../Content/SiteGD.css" rel="stylesheet" type="text/css" />

    </p>

    <div class="contenido-top">
        <div>
            <h1>
                PRESTAR DOCUMENTO
            </h1>
    <fieldset>
        <legend>Gestión del Documento</legend>
        <br />
          <table cellpadding="1" cellspacing="1" class="tabla-gestion">
          <tr>
          <td><div class="display-label">Nombre: </div> </td>
          <td width="300"><div class="display-field"><%: Model.Nombre %></div></td>
          <td><div class="display-field"><%:Html.ActionLink("Buscar","Buscar",new {@r="PrestarDocumento"}) %></div></td>
          </tr>
          <tr>
          <td><div class="display-label">Tipo Documento: </div></td>
          <td><div class="display-field"><%: Model.GD_TipoDocumento==null?string.Empty:Model.GD_TipoDocumento.Nombre%></div></td>
          <td></td>
          </tr>
          <tr>
          <td><div class="display-label">Descripción:</div></td>
          <td><div class="display-field"><%: Html.TextArea("descripcion", new { style = "width:150px;height:60px" })%></div></td>
          <td><%if (ViewData["firma"] =="1")
                { %>
                <div style="text-align: center;">
                    <img src="../../Images/llave.png" id="llave" /><br />
                    <strong>Documento Firmado Digitálmente</strong>
                </div>
                <% //}
                }%></td>
          </tr>
          <tr>
          <td><div class="display-label">Proyecto: </div></td>
          <td><div class="display-field"><%:Model.GPP_Proyecto == null ? string.Empty : Model.GPP_Proyecto.Nombre%></div></td>
          <td></td>
          </tr>
          <tr>
          <td><div class="display-label">Área:</div></td>
          <td><div class="display-field"><%--<%: Model.GRH_Area == null ? string.Empty : Model.GRH_Area.Nombre%>--%></div></td>
          <td></td>
          </tr>
          <tr>
          <td><div class="display-label">Estado: </div></td>
          <td><div class="display-field"><%: Model.GD_Estado == null ? string.Empty : Model.GD_Estado.Nombre%></div></td>
          <td></td>
          </tr>
          <tr>
          <td valign="top"><div class="display-label">Tags</div></td>
          <td><div class="display-field"><%: Model.Tags %></div></td>
          <td></td>
          </tr>
          
          </table>
          <br />
    </fieldset>
     
    <div class="editor-label">
    <% String prueba = string.Empty;
        if (Model.IdDocumento.ToString() == "0")
           prueba = "data='../../Upload/Inicio.pdf'";
       else
           prueba = "data='../../Upload/" + Model.IdDocumento.ToString() + ".pdf'";%>
            <object  <%= prueba %> type="application/pdf" width="100%" height="350px">
                <param wmode="transparent"/>
            </object>
          </div>
    </div>
</div>
</asp:Content>

