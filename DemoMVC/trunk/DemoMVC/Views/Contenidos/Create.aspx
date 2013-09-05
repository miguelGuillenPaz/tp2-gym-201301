<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<DemoMVC.Models.GD_Documento>" %>
<%@ Import Namespace="DemoMVC.HelperClass" %>
<%@ Import Namespace="DemoMVC.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Gestión de Documentos
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link href="../../Content/SiteGD.css" rel="stylesheet" type="text/css" />
<div class="contenido-top">
        <div>
            <h1>
                GESTION DEL DOCUMENTO
            </h1>


<% using (Html.BeginForm("Create", "Contenidos", FormMethod.Post, new { enctype = "multipart/form-data",id="createForm" }))
       {%>
    <div>
      <fieldset>          
          <%:Html.HiddenFor(m=>m.IdDocumento) %>
          <div style="color:Red; font-weight:bold;"><%:Html.ValidationSummary() %></div>
          <br>
          <table cellpadding="0" cellspacing="0"   class="tabla-gestion" border="1">
          <tr>
          <td><div class="editor-label"><%: Html.LabelFor(m=>m.Nombre) %> <span style="font-size:8px; color:Red; vertical-align:top; line-height:15px;">(*)</span></div>&nbsp;&nbsp;</td>
          <td colspan="4"><div class="editor-field"><%: Html.TextBoxFor(m => m.Nombre, new { style = "width:200px;height:20px" })%>&nbsp;&nbsp;<%:Html.ActionLink("Buscar","Buscar",new {@r="Create"}) %></div></td>
          </tr>
          <tr>
          <td style="width:13%"><div class="editor-label"><label for="IdTipoDocumento">Tipo Documento</label> <span style="font-size:8px; color:Red; vertical-align:top; line-height:15px;">(*)</span></div></td>
          <td style="width:30%"><div class="editor-field"><%: Html.DropDownListFor(m => m.IdTipoDocumento, new SelectList((IEnumerable<GD_TipoDocumento>)ViewData["TipoDocumento"], "IdTipoDocumento", "Nombre"), "-- Seleccionar --")%></div></td>
          <td style="width:8%"><div class="editor-label"><label for="IdProyecto">Proyecto</label></div></td>
          <td style="width:32%"><div class="editor-field"><%: Html.DropDownListFor(m => m.IdProyecto, new SelectList((IEnumerable<GPP_Proyecto>)ViewData["Proyecto"], "IdProyecto", "Nombre"), "-- Seleccionar --")%></div></td>
          <td rowspan="5"  valign="top">
          <div class="editor-label">Seleccione Permisos <span style="font-size:8px; color:Red; vertical-align:top; line-height:15px;">(*)</span></div>
          <div class="editor-field" id="chkList"><%:Html.CheckBoxList(new List<SelectListItem>(new SelectList((IEnumerable<SEG_Perfil>)ViewData["Perfil"],
                                                        "IDPerfil", "Nombre")), "SEG_Perfil",
                                                        Model != null ? Model.GD_DocumentoPerfilAcceso.Select(x => x.IdPerfil).ToList() : new List<int>())%>
                                                        <%:Html.ValidationMessage("Documento","Seleccionar un permiso") %>

          </div>
          </td>
          </tr>
          <tr>         
          <td><div class="editor-label"><label for="FechaDocumento">Fecha Documento</label><span style="font-size:8px; color:Red; vertical-align:top; line-height:15px;">(*)</span></div></td>
          <td><div class="editor-field"><%: Html.EditorFor(m=>m.FechaDocumento,"{0:dd/MM/yyyy}")%></div></td>
          <td><div class="editor-label"><label for="IdEstado">Estado</label><span style="font-size:8px; color:Red; vertical-align:top; line-height:15px;">(*)</span></div></td>
          <td><div class="editor-field"><%: Html.DropDownListFor(m => m.IdEstado, new SelectList((IEnumerable<GD_Estado>)ViewData["Estado"], "IdEstado", "Nombre"), "-- Seleccionar --")%></div></td>
          </tr>          
          <tr>         
          <td><div class="editor-label"><%: Html.LabelFor(m=>m.Ubicacion) %> <span style="font-size:8px; color:Red; vertical-align:top; line-height:15px;">(*)</span></div></td>
          <td><div class="editor-field"><%: Html.TextBoxFor(m => m.Ubicacion, new { style = "width:200px;height:20px" })%></div></td>
          <td><div class="editor-label"><label for="IdArea">Area</label><span style="font-size:8px; color:Red; vertical-align:top; line-height:15px;">(*)</span></div></td>
          <td><div class="editor-field"><%: Html.DropDownListFor(m => m.IdArea, new SelectList((IEnumerable<GRH_Area>)ViewData["Area"], "IdArea", "Descripcion"), "-- Seleccionar --")%></div></td>
          </tr>          
          <tr>         
          <td><div class="editor-label"><%: Html.LabelFor(m=>m.Descripcion) %></div></td>
          <td><div class="editor-label"><%: Html.TextAreaFor(m => m.Descripcion, new { style = "width:200px;height:40px" })%></div></td>
          <td><div class="editor-label">Digital <span style="font-size:8px; color:Red; vertical-align:top; line-height:15px;">(*)</span></div></td>
          <td><div class="editor-field"><input type="file" id="upload" name="upload" required="true"/></div></td>
          </tr>          
          <tr>         
          <td><div class="editor-label"><%: Html.LabelFor(m=>m.Tags) %> <span style="font-size:8px; color:Red; vertical-align:top; line-height:15px;">(*)</span></div></td>
          <td><div class="editor-field"><%: Html.TextBoxFor(m => m.Tags, new { style = "width:200px;height:20px" })%></div></td>
          <td></td>
          <td></td>
          </tr>          
          </table>
          <br /><br /><br />
          <div class="editor-label"><b>Historial de Accesos</b></div>
          <div id="historial">
              <table width="90%">
                  <tr><th>Usuario</th><th>Estado</th><th>Fecha</th><th>Descripción</th></tr>
          <% if(Model==null)return;
             foreach (GD_DocumentoHistorial h in Model.GD_DocumentoHistorial)
             {%>
                <tr><td>Usuario1</td><td><%=h.GD_Estado.Nombre %></td><td><%=h.FechaAcceso==null?string.Empty:h.FechaAcceso.ToString("dd/MM/yyyy") %></td><td><%=Model.Descripcion %></td></tr>
             <%} %>
             </table>
         </div>
         <br /><br /><br />
         <p>
            <input type="submit" value="Guardar" />
            <input type="button" value="Eliminar" id="btnEliminar"/>
            <input type="button" value="Cancelar" id="btnCancelar"/>
        </p>
        <br />
     
  </div>
<%} %>
<% using (Html.BeginForm("Delete", "Contenidos",new {id=(Model==null?0:Model.IdDocumento)}, FormMethod.Post,new {id="deleteForm"}))
   { %>
   <%= Html.HttpMethodOverride(HttpVerbs.Delete) %>
   <%--<input id="btnDelete" type="submit" value="Eliminar" />--%>
<% } %>

<script type="text/javascript" language="javascript">
    $(function () {
        $("#FechaDocumento").datepicker({ dateFormat: "dd/mm/yy" });
        $("#btnCancelar").click(function () {
            $("input[type=text]").val("");
            $("select").val("0");
        });
        $("#createForm").submit(function () {
            var existChecked = $('input[type=checkbox]:checked').length > 0;
            if (!existChecked) {
                $("#chkList").addClass("input-validation-error");
            } else {
                $("#chkList").removeClass("input-validation-error");
            }
            return existChecked;
        });

        $("#btnEliminar").click(function () {
            $("<div>Seguro desea eliminar el documento?</div>").dialog({ model: true,
                buttons: {
                    Si: function () {
                        $("#deleteForm").submit();
                        $(this).dialog("close");
                    },
                    No: function () {
                        $(this).dialog("close");
                    }
                }
            });
        });

//        $("#upload").change(function (e) {
//            if ($.inArray($("#upload").val().split('.').toLowerCase(), "pdf") == -1) {
//                $("#upload").val("");
//                $("<div>Solo se permiten pdf</div>").dialog({ modal: true, buttons: { Aceptar: function () { $(this).dialog("close"); } } });
//                e.preventDefault();
//            }
//        });
    });
</script>

    </div>
</div>



</asp:Content>
