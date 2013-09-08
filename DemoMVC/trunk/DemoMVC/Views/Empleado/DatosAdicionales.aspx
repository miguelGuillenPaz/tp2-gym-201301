<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<DemoMVC.Models.GRH_Empleado>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
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
    <script src="../../Scripts/Empleado/derecho-habiente.js" type="text/javascript"></script>
    <script src="../../Scripts/Empleado/contrato-personal.js" type="text/javascript"></script>
        <script src="../../Scripts/Empleado/legajo.js" type="text/javascript"></script>
    <div class="contenido-top">
        <div>
            <h1>
                Registrar Empleado                
                <%= Html.HiddenFor(m=> m.IdPersona) %>
                <%= Html.HiddenFor(m=> m.IdEmpleado) %>
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
                                        <%= Html.DisplayFor(m=> m.GRH_Persona.Nombre) %>
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
                                                       foreach (var documento in Model.GRH_Persona.GRH_Documento)
                                                       {
                                                %>
                                                <tr>
                                                    <td style="display: none;">
                                                        <%= documento.IdDocumento %>
                                                    </td>
                                                    <td style="display: none;">
                                                        <%= documento.GRH_TipoDocumento != null ? documento.GRH_TipoDocumento.IdTipoDocumento + "" : string.Empty%>
                                                    </td>
                                                    <td>
                                                        <%= documento.GRH_TipoDocumento != null ? documento.GRH_TipoDocumento.Descripcion : string.Empty%>
                                                    </td>
                                                    <td>
                                                        <%= documento.NumeroDocumento %>
                                                    </td>
                                                </tr>
                                                <%
                                                       }
                                                   } %>
                                            </tbody>
                                        </table>
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
                                        <%= Html.DisplayFor(m => m.GRH_Persona.ApellidoPaterno)%>
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
                                        <%= Html.DisplayFor(m => m.GRH_Persona.ApellidoMaterno)%>
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
                                        <%= Html.DisplayFor(m => m.GRH_Persona.GRH_EstadoCivil.Descripcion)%>
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
                                        <%= Model != null ? (Model.GRH_Persona.Sexo == true ? "Masculino" : "Femenino") : string.Empty%>
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
                                        <%= Html.DisplayFor(m => m.GRH_Persona.Direccion)%>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        País de Residencia
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <%= Html.DisplayFor(m => m.GRH_Persona.GRH_Pais.Descripcion)%>
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
                                        <%=Model != null ? (Model.GRH_Persona.FechaNacimiento != null ? (Model.GRH_Persona.FechaNacimiento.ToString().Substring(6, 4) + "-" + Model.GRH_Persona.FechaNacimiento.ToString().Substring(3, 2) + "-" + Model.GRH_Persona.FechaNacimiento.ToString().Substring(0, 2)) : string.Empty) : string.Empty%>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        País de Nacimiento
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <%= Html.DisplayFor(m => m.GRH_Persona.GRH_Pais1.Descripcion)%>
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
                                        <table id="tblTelefono">
                                            <tbody>
                                                <% if (Model != null)
                                                   {
                                                       foreach (var telefono in Model.GRH_Persona.GRH_Telefono)
                                                       {
                                                %>
                                                <tr>
                                                    <td style="display: none;">
                                                        <%= telefono.IdTelefono %>
                                                    </td>
                                                    <td>
                                                        <%= telefono.NumeroTelefono %>
                                                    </td>
                                                </tr>
                                                <%
                                                       }
                                                   } %>
                                            </tbody>
                                        </table>
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
                                        <table id="tblCorreo">
                                            <tbody>
                                                <% if (Model != null)
                                                   {
                                                       foreach (var correo in Model.GRH_Persona.GRH_Correo)
                                                       {
                                                %>
                                                <tr>
                                                    <td style="display: none;">
                                                        <%= correo.IdCorreo %>
                                                    </td>
                                                    <td>
                                                        <%= correo.CuentaCorreo %>
                                                    </td>
                                                </tr>
                                                <%
                                                       }
                                                   } %>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>                    
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Derecho Habientes</span>
                        </div>
                        <div class="texto-noticia">
                            <table id="tblDerechoHabiente">
                                <thead>
                                    <tr>
                                        <th style="display: none;">
                                            <b>Id</b>
                                        </th>
                                        <th>
                                            <b>Nombres</b>
                                        </th>
                                        <th>
                                            <b>Apellidos Paternos</b>
                                        </th>
                                        <th>
                                            <b>Apellidos Maternos</b>
                                        </th>
                                        <th>
                                            <b>Fec. Nacimiento</b>
                                        </th>
                                         <th style="display: none;">
                                            IdDocumento
                                        </th>
                                        <th style="display: none;">
                                            IdTipoDocumento
                                        </th>
                                        <th>
                                            <b>Tipo de Doc.</b>
                                        </th>
                                        <th>
                                            <b>Nro. de Documento</b>
                                        </th>
                                        <th style="display: none;">
                                            idSexo
                                        </th>
                                        <th>
                                            <b>Sexo</b>
                                        </th>
                                        <th style="display: none;">
                                            idTipoDerechoHabiente
                                        </th>
                                        <th>
                                            <b>Relación</b>
                                        </th>
                                         <th style="display: none;">
                                            <b>IdPersona</b>
                                        </th>
                                        <th>
                                            <b>Opciones</b>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (Model != null)
                                       {
                                           foreach (var item in Model.GRH_DerechoHabiente)
                                           { 
                                    %>
                                    <tr>
                                         <td style="display: none;">
                                            <%= item.IdDerechoHabiente %>
                                        </td>
                                        <td>
                                            <%= item.GRH_Persona.Nombre %>
                                        </td>
                                        <td>
                                            <%= item.GRH_Persona.ApellidoPaterno %>
                                        </td>
                                        <td>
                                            <%= item.GRH_Persona.ApellidoMaterno %>
                                        </td>
                                        <td>
                                            <%= item.GRH_Persona.FechaNacimiento != null ? item.GRH_Persona.FechaNacimiento.Value.Year + "-" + item.GRH_Persona.FechaNacimiento.Value.Month.ToString().PadLeft(2, '0') + "-" + item.GRH_Persona.FechaNacimiento.Value.Day.ToString().PadLeft(2, '0') : string.Empty%>
                                        </td>
                                        <td style="display: none;">
                                            <%= item.GRH_Persona.GRH_Documento.Count > 0? item.GRH_Persona.GRH_Documento.FirstOrDefault().IdDocumento:0  %>
                                        </td>
                                        <td style="display: none;">
                                            <%= item.GRH_Persona.GRH_Documento.Count > 0? item.GRH_Persona.GRH_Documento.FirstOrDefault().GRH_TipoDocumento.IdTipoDocumento:0  %>
                                        </td>
                                        <td>
                                            <%= item.GRH_Persona.GRH_Documento.Count > 0? item.GRH_Persona.GRH_Documento.FirstOrDefault().GRH_TipoDocumento.Descripcion : string.Empty%>
                                        </td>
                                        <td>
                                            <%= item.GRH_Persona.GRH_Documento.Count > 0? item.GRH_Persona.GRH_Documento.FirstOrDefault().NumeroDocumento : string.Empty%>
                                        </td>
                                        <td>
                                            <%= (bool)item.GRH_Persona.Sexo ?"Masculino":"Femenino" %>
                                        </td>
                                        <td style="display: none;">
                                            <%= item.IdTipoDerechoHabiente %>
                                        </td>
                                        <td>
                                            <%= item.GRH_TipoDerechoHabiente.Descripcion %>
                                        </td>
                                         <td style="display: none;">
                                            <%= item.GRH_Persona.IdPersona %>
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
                            <a id="addDerechoHabiente" href="javascript:;">Agregar</a>
                        </div>
                    </div>
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Contrato Personal</span>
                        </div>
                        <div class="texto-noticia">
                            <table id="tblContratoPersonal">
                                <thead>
                                    <tr>
                                        <th style="display: none;">
                                            <b>Id</b>
                                        </th>
                                        <th>
                                            <b>Nro. Contrato</b>
                                        </th>
                                        <th>
                                            <b>Fecha Inicio</b>
                                        </th>
                                        <th>
                                            <b>Fecha Fin</b>
                                        </th>
                                        <th>
                                            <b>Opciones</b>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (Model != null)
                                       {
                                           foreach (var item in Model.GRH_ContratoPersonal)
                                           {                                               
                                    %>
                                    <tr>
                                        <td style="display: none;">
                                            <%= item.IdContratoPersonal %>
                                        </td>
                                        <td>
                                            <%= item.NumeroContrato %>
                                        </td>
                                        <td>
                                            <%=item.FechaInicio != null ? (item.FechaInicio.ToString().Substring(6, 4) + "-" + item.FechaInicio.ToString().Substring(3, 2) + "-" + item.FechaInicio.ToString().Substring(0, 2)) : string.Empty%>
                                        </td>
                                        <td>
                                            <%=item.FechaFin != null ? (item.FechaFin.ToString().Substring(6, 4) + "-" + item.FechaFin.ToString().Substring(3, 2) + "-" + item.FechaFin.ToString().Substring(0, 2)) : string.Empty%>
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
                            <a id="addContratoPersonal" href="javascript:;">Agregar</a>
                        </div>
                    </div>
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Legajo</span>
                        </div>
                        <div class="texto-noticia">
                            <table id="tblLegajo">
                                <thead>
                                    <tr>
                                        <th style="display: none;">
                                            <b>Id</b>
                                        </th>
                                        <th>
                                            <b>Documento</b>
                                        </th>
                                        <th>
                                            <b>Ubicación Física</b>
                                        </th>
                                        <th>
                                            <b>Opciones</b>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (Model != null)
                                       {
                                           foreach (var item in Model.GRH_Legajo)
                                           {                                               
                                    %>
                                    <tr>
                                        <td style="display: none;">
                                            <%= item.IdLegajo %>
                                        </td>
                                        <td>
                                            <%= item.NombreArchivo %>
                                        </td>
                                        <td>
                                            <%= item.Ubicacion %>
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
                            <a id="addLegajo" href="javascript:;">Agregar</a>
                        </div>
                    </div>
                </div>
                 <a id="btnEnviar" href="/Empleado/Agregar" class="button" >Enviar</a> | <a id="btnCancelar" href="javascript:;" class="button" >Cancelar</a>
            </div>
        </div>
    </div>
    <div id="dialogDerechoHabiente" title="" style="display: none; z-index: 1000;">
        <input type="hidden" id="hdnDerechoHabiente" />
        <input type="hidden" id="hdnPersona" />
        <input type="hidden" id="hdnEmpleado" />
        <input type="hidden" id="hdnDocumento" />
        <input type="hidden" id="hdnAccionDerechoHabiente" />
        <table>
            <thead><tr>
                <th style="width: 250px"></th>
                <th></th>
                <th></th>
                </tr>
            </thead>
            <tbody>
            <tr>
                <td>
                    Nombres
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.GRH_Persona.Nombre, new { @id = "txtNombre", @class = "required" })%>
                </td>
            </tr>
            <tr>
                <td>
                    Apellido Paterno
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.GRH_Persona.ApellidoPaterno, new { @id = "txtApPaterno", @class = "required" })%>
                </td>
            </tr>
            <tr>
                <td>
                    Apellido Materno
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.GRH_Persona.ApellidoMaterno, new { @id = "txtApMaterno", @class = "required" })%>
                </td>
            </tr>
            <tr>
                <td>
                    Fec. Nacimiento
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.GRH_Persona.FechaNacimiento, new { @id = "txtFecNacimiento",@type = "date", @class = "required" })%>
                </td>
            </tr>
            <tr>
                <td>
                    Sexo
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.RadioButtonFor(m => m.GRH_Persona.Sexo, true)%>
                    Masculino
                    <br />
                    <%= Html.RadioButtonFor(m => m.GRH_Persona.Sexo, false)%>
                    Femenino
                </td>
            </tr>
            <tr>
                <td>
                    Tipo de Doc.
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.DropDownListFor(m => m.GRH_Persona.GRH_Documento.FirstOrDefault().IdTipoDocumento, (IEnumerable<SelectListItem>)ViewData["TipoDocumento"], new { @id = "ddlTipoDocumento", @class = "required" })%>
                </td>
            </tr>
            <tr>
                <td>
                    Nro. de Documento
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.GRH_Persona.GRH_Documento.FirstOrDefault().NumeroDocumento, new { @id = "txtDocumento", @class = "required" })%>
                </td>
            </tr>
            <tr>
                <td>
                    Tipo Derecho Habiente
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.DropDownListFor(m => m.GRH_DerechoHabiente.FirstOrDefault().IdTipoDerechoHabiente, (IEnumerable<SelectListItem>)ViewData["TipoDerechoHabiente"], new { @id = "ddlTipoDerechoHabiente", @class = "required" })%>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <div id="dialogContratoPersonal" title="" style="display: none; z-index: 1000;">
        <input type="hidden" id="hdnContratoPersonal" />
        <input type="hidden" id="hdnAccionContratoPersonal" />        
        <table>
            <thead><tr>
                <th style="width: 250px"></th>
                <th></th>
                <th></th>
                </tr>
            </thead>
            <tbody>
            <tr>
                <td>
                    Nro. Contrato
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.GRH_ContratoPersonal.FirstOrDefault().NumeroContrato, new { @id = "txtNumero", @class = "required" })%>
                </td>
            </tr>            
            <tr>
                <td>
                    Fecha Inicio
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.GRH_ContratoPersonal.FirstOrDefault().FechaInicio, new { @id = "txtInicio",@type = "date", @class = "required" })%>
                </td>
            </tr>
            <tr>
                <td>
                    Fecha Fin
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.GRH_ContratoPersonal.FirstOrDefault().FechaFin, new { @id = "txtFin",@type = "date", @class = "required" })%>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <div id="dialogLegajo" title="" style="display: none; z-index: 1000;">
        <input type="hidden" id="hdnLegajo" />
        <input type="hidden" id="hdnAccionLegajo" />        
        <table>
            <thead><tr>
                <th style="width: 250px"></th>
                <th></th>
                <th></th>
                </tr>
            </thead>
            <tbody>
            <tr>
                <td>
                    Documento
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.GRH_Legajo.FirstOrDefault().NombreArchivo, new { @id = "txtNombreArchivo", @class = "required" })%>
                </td>
            </tr>            
            <tr>
                <td>
                    Ubicación
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.GRH_Legajo.FirstOrDefault().Ubicacion, new { @id = "txtUbicacion", @class = "required" })%>
                </td>
            </tr>            
            </tbody>
        </table>
    </div>
</asp:Content>
