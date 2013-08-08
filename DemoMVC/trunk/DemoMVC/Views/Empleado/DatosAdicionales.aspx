<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<DemoMVC.Models.GRH_Persona>" %>

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
    <div class="contenido-top">
        <div>
            <h1>
                Registrar Empleado
                <%= Html.HiddenFor(m=> m.idPersona) %>
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
                                        <%= Html.DisplayFor(m=> m.nombre) %>
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
                                                       foreach (var documento in Model.GRH_Documento)
                                                       {
                                                %>
                                                <tr>
                                                    <td style="display: none;">
                                                        <%= documento.idDocumento %>
                                                    </td>
                                                    <td style="display: none;">
                                                        <%= documento.GRH_TipoDocumento!=null? documento.GRH_TipoDocumento.idTipoDocumento+"":string.Empty %>
                                                    </td>
                                                    <td>
                                                        <%= documento.GRH_TipoDocumento!=null? documento.GRH_TipoDocumento.descripcion:string.Empty %>
                                                    </td>
                                                    <td>
                                                        <%= documento.nroDocumento %>
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
                                        <%= Html.DisplayFor(m=> m.apellidoPaterno) %>
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
                                        <%= Html.DisplayFor(m=> m.apellidoMaterno) %>
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
                                        <%= Html.DisplayFor(m => m.GRH_EstadoCivil.descripcion) %>
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
                                        <%= Model!=null?( Model.sexo==true ? "Masculino":"Femenino"):string.Empty %>
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
                                        <%= Html.DisplayFor(m => m.direccion)%>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        Pais de Residencia
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <%= Html.DisplayFor(m => m.GRH_Pais.descripcion)%>
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
                                        <%=Model!=null? (Model.fechaNacimiento != null ? (Model.fechaNacimiento.ToString().Substring(6, 4) + "-" + Model.fechaNacimiento.ToString().Substring(3, 2) + "-" + Model.fechaNacimiento.ToString().Substring(0, 2)) : string.Empty):string.Empty %>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <%= Html.Label("Pais de Nacimiento") %>
                                    </td>
                                    <td>
                                        :
                                    </td>
                                    <td>
                                        <%= Html.DisplayFor(m => m.GRH_Pais1.descripcion)%>
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
                                                       foreach (var telefono in Model.GRH_Telefono)
                                                       {
                                                %>
                                                <tr>
                                                    <td style="display: none;">
                                                        <%= telefono.idTelefono %>
                                                    </td>
                                                    <td>
                                                        <%= telefono.nroTelefono %>
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
                                                       foreach (var correo in Model.GRH_Correo)
                                                       {
                                                %>
                                                <tr>
                                                    <td style="display: none;">
                                                        <%= correo.idCorreo %>
                                                    </td>
                                                    <td>
                                                        <%= correo.cuentaCorreo %>
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
                    <%= Html.HiddenFor(m=> m.GRH_Empleado.FirstOrDefault().idEmpleado) %>
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Derecho Habientes</span>
                        </div>
                        <div class="texto-noticia">
                            <table id="tblDerechoHabientes">
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
                                            idTipoRelacion
                                        </th>
                                        <th>
                                            <b>Relación</b>
                                        </th>
                                        <th>
                                            <b>Opciones</b>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (Model != null)
                                       {
                                           foreach (var item in Model.GRH_Empleado)
                                           { 
                                               foreach (var der in item.GRH_DerechoHabiente)
                                               {
                                        %>
                                        <tr>
                                        <td>
                                            <%= der.GRH_Persona.nombre %>
                                        </td>
                                        <td>
                                            <%= der.GRH_Persona.apellidoPaterno %>
                                        </td>
                                        <td>
                                            <%= der.GRH_Persona.apellidoMaterno %>
                                        </td>
                                        <td>
                                            <%= der.GRH_Persona.fechaNacimiento != null ? der.GRH_Persona.fechaNacimiento.Value.Year + "-" + der.GRH_Persona.fechaNacimiento.Value.Month.ToString().PadLeft(2, '0') + "-" + der.GRH_Persona.fechaNacimiento.Value.Day.ToString().PadLeft(2, '0') : string.Empty %>
                                        </td>
                                        <td style="display: none;">
                                            <%= der.GRH_Persona.GRH_Documento.Count > 0? der.GRH_Persona.GRH_Documento.FirstOrDefault().GRH_TipoDocumento.idTipoDocumento:0  %>
                                        </td>
                                        <td>
                                            <%= der.GRH_Persona.GRH_Documento.Count > 0? der.GRH_Persona.GRH_Documento.FirstOrDefault().GRH_TipoDocumento.descripcion : string.Empty%>
                                        </td>                                        
                                        <td>
                                            <%= der.GRH_Persona.GRH_Documento.Count > 0? der.GRH_Persona.GRH_Documento.FirstOrDefault().nroDocumento : string.Empty%>
                                        </td>
                                        <td>                                            
                                            <%= (bool)der.GRH_Persona.sexo ?"Masculino":"Femenino" %>
                                        </td>
                                        <td style="display: none;">
                                            <%= der.idTipoDerechoHabiente %>
                                        </td>
                                        <td>
                                            <%= der.GRH_TipoDerechoHabiente.descripcion %>
                                        </td>                                        
                                        <td>
                                            <a class="editar" href="javascript:;">Editar</a> | <a class="eliminar" href="javascript:;">
                                                Eliminar</a>
                                        </td>
                                        </tr>
                                        <%
                                                } 
                                           }
                                       } %>
                                </tbody>
                            </table>
                            <a id="addEstudioRealizado" href="javascript:;">Agregar</a>
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
                                           foreach (var item in Model.GRH_Empleado)
                                           { 
                                               foreach (var der in item.GRH_ContratoPersonal)
                                               {
                                        %>
                                        <tr>
                                        <td style="display: none;">
                                            <%= der.idContratoPersonal %>
                                        </td>
                                        <td>
                                            <%= der.nroContrato %>
                                        </td>
                                        <td>                                            
                                            <%=der.fechaInicio != null ? (der.fechaInicio.ToString().Substring(6, 4) + "-" + der.fechaInicio.ToString().Substring(3, 2) + "-" + der.fechaInicio.ToString().Substring(0, 2)) : string.Empty%>
                                        </td>
                                        <td>
                                            <%=der.fechaFin != null ? (der.fechaFin.ToString().Substring(6, 4) + "-" + der.fechaFin.ToString().Substring(3, 2) + "-" + der.fechaFin.ToString().Substring(0, 2)) : string.Empty%>
                                        </td>                                        
                                        <td>
                                            <a class="editar" href="javascript:;">Editar</a> | <a class="eliminar" href="javascript:;">
                                                Eliminar</a>
                                        </td>
                                        </tr>
                                        <%
                                                } 
                                           }
                                       } %>
                                </tbody>
                            </table>
                            <a id="a1" href="javascript:;">Agregar</a>
                        </div>
                    </div>
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Legajo</span>
                        </div>
                        <div class="texto-noticia">
                            <table id="Table1">
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
                                           foreach (var item in Model.GRH_Empleado)
                                           { 
                                               foreach (var der in item.GRH_ContratoPersonal)
                                               {
                                        %>
                                        <tr>
                                        <td style="display: none;">
                                            <%= der.idContratoPersonal %>
                                        </td>
                                        <td>
                                            <%= der.nroContrato %>
                                        </td>
                                        <td>                                            
                                            <%=der.fechaInicio != null ? (der.fechaInicio.ToString().Substring(6, 4) + "-" + der.fechaInicio.ToString().Substring(3, 2) + "-" + der.fechaInicio.ToString().Substring(0, 2)) : string.Empty%>
                                        </td>                                        
                                        <td>
                                            <a class="editar" href="javascript:;">Editar</a> | <a class="eliminar" href="javascript:;">
                                                Eliminar</a>
                                        </td>
                                        </tr>
                                        <%
                                                } 
                                           }
                                       } %>
                                </tbody>
                            </table>
                            <a id="a2" href="javascript:;">Agregar</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
