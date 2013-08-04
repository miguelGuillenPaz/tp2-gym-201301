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
    <script src="../../Scripts/Postulante/documento.js" type="text/javascript"></script>
    <script src="../../Scripts/Postulante/telefono.js" type="text/javascript"></script>
    <script src="../../Scripts/Postulante/correo.js" type="text/javascript"></script>
    <script src="../../Scripts/Postulante/idioma-persona.js" type="text/javascript"></script>
    <script src="../../Scripts/Postulante/experiencia-laboral.js" type="text/javascript"></script>
    <script src="../../Scripts/Postulante/estudio-realizado.js" type="text/javascript"></script>
    <div class="contenido-top">
        <div>
            <h1>
                Registrar Postulante
                <%= Html.HiddenFor(m=> m.idPersona) %>
            </h1>            
            <div class="areas-negocios">                                
                <div class="lista-central">
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Información Personal</span>
                            <a style="float: right;" href="/Postulante/Editar/<%= Model.idPersona %>">Editar</a>
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
                                        <a id="addDocumento" href="javascript:;">Agregar</a>
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
                                        <a id="addTelefono" href="javascript:;">Agregar</a>
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
                                        <a id="addCorreo" href="javascript:;">Agregar</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Experiencia Laboral</span>
                        </div>
                        <div class="texto-noticia">
                            <table id="tblExperienciaLaboral">
                                <thead>
                                    <tr>
                                        <th style="display: none;">
                                            <b>Id</b>
                                        </th>
                                        <th>
                                            <b>Empresa</b>
                                        </th>
                                        <th>
                                            <b>Cargo</b>
                                        </th>
                                        <th>
                                            <b>F. Inicio</b>
                                        </th>
                                        <th>
                                            <b>F. Fin</b>
                                        </th>
                                        <th style="display: none;">
                                            <b>Conocimientos</b>
                                        </th>
                                        <th>
                                            <b>Opciones</b>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (Model != null)
                                       {
                                           foreach (var item in Model.GRH_ExperienciaLaboral)
                                           { %>
                                    <tr>
                                        <td style="display: none;">
                                            <%= item.idExperienciaLaboral %>
                                        </td>
                                        <td>
                                            <%= item.empresa %>
                                        </td>
                                        <td>
                                            <%= item.cargo %>
                                        </td>
                                        <td>
                                            <%= item.fechaInicio != null ? item.fechaInicio.ToString().Substring(6, 4) + "-" + item.fechaInicio.ToString().Substring(3, 2) + "-" + item.fechaInicio.ToString().Substring(0, 2) : string.Empty%>
                                        </td>
                                        <td>
                                            <%= item.FechaFin != null ? item.FechaFin.ToString().Substring(6,4 ) + "-" + item.FechaFin.ToString().Substring(3, 2) + "-" + item.FechaFin.ToString().Substring(0, 2) : string.Empty%>
                                        </td>
                                        <td style="display: none;">
                                            <%= item.conocimientos %>
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
                            <a id="addExperienciaLaboral" href="javascript:;">Agregar</a>
                        </div>
                    </div>
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Estudios Realizados</span>
                        </div>
                        <div class="texto-noticia">
                            <table id="tblEstudioRealizado">
                                <thead>
                                    <tr>
                                        <th style="display: none;">
                                            <b>Id</b>
                                        </th>
                                        <th>
                                            <b>Centro de Estudio</b>
                                        </th>
                                        <th>
                                            <b>Título Obtenido</b>
                                        </th>
                                        <th style="display: none;">
                                            IdNivel
                                        </th>
                                        <th>
                                            <b>Nivel</b>
                                        </th>
                                        <th style="display: none;">
                                            idEspecialidad
                                        </th>
                                        <th>
                                            <b>Especialidad</b>
                                        </th>
                                        <th style="display: none;">
                                            idSituacion
                                        </th>
                                        <th>
                                            <b>Situación</b>
                                        </th>
                                        <th>
                                            <b>F. Inicio</b>
                                        </th>
                                        <th>
                                            <b>F. Fin</b>
                                        </th>
                                        <th>
                                            <b>Opciones</b>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (Model != null)
                                       {
                                           foreach (var item in Model.GRH_EstudioRealizado)
                                           { %>
                                    <tr>
                                        <td style="display: none;">
                                            <%= item.idEstudioRealizado %>
                                        </td>
                                        <td>
                                            <%= item.centroEstudio %>
                                        </td>
                                        <td>
                                            <%= item.nombreEstudio %>
                                        </td>
                                        <td style="display: none;">
                                            <%= item.GRH_NivelEducativo !=null? item.idNivelEducativo:0 %>
                                        </td>
                                        <td>
                                            <%= item.GRH_NivelEducativo !=null? item.GRH_NivelEducativo.descripcion:string.Empty %>
                                        </td>
                                        <td style="display: none;">
                                            <%= item.GRH_Especialidad !=null? item.idEspecialidad:0 %>
                                        </td>
                                        <td>
                                            <%= item.GRH_Especialidad !=null? item.GRH_Especialidad.descripcion:string.Empty %>
                                        </td>
                                        <td style="display: none;">
                                            <%= item.GRH_SituacionEstudio !=null? item.idSituacionEstudio:0 %>
                                        </td>
                                        <td>
                                            <%= item.GRH_SituacionEstudio != null ? item.GRH_SituacionEstudio.descripcion : string.Empty%>
                                        </td>
                                        <td>
                                            <%= item.fechaInicio != null ? item.fechaInicio.ToString().Substring(6, 4) + "-" + item.fechaInicio.ToString().Substring(3, 2) + "-" + item.fechaInicio.ToString().Substring(0, 2) : string.Empty%>
                                        </td>
                                        <td>
                                            <%= item.fechaFin != null ? item.fechaFin.ToString().Substring(6, 4) + "-" + item.fechaFin.ToString().Substring(3, 2) + "-" + item.fechaFin.ToString().Substring(0, 2) : string.Empty%>
                                        </td>
                                        <td>
                                            <a class="editar" href="javascript:;">Editar</a> | <a class="eliminar" href="javascript:;">Eliminar</a>
                                        </td>
                                    </tr>
                                    <%
                                           }
                                       } %>
                                </tbody>
                            </table>
                            <a id="addEstudioRealizado" href="javascript:;">Agregar</a>
                        </div>
                    </div>
                    <div class="noticia">
                        <div class="head-noticia">
                            <span class="titulo-noticia">Idiomas</span>
                        </div>
                        <div class="texto-noticia">
                            <table id="tblIdiomaPersona">
                                <thead>
                                    <tr>
                                        <th style="display: none;">
                                            <b>Id</b>
                                        </th>
                                        <th style="display: none;">
                                            idIdioma
                                        </th>
                                        <th>
                                            <b>Idioma</b>
                                        </th>
                                        <th style="display: none;">
                                            idNivel
                                        </th>
                                        <th>
                                            <b>Nivel</b>
                                        </th>
                                        <th>
                                            <b>Opciones</b>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (Model != null)
                                       {
                                           foreach (var item in Model.GRH_IdiomaPersona)
                                           { %>
                                    <tr>
                                        <td style="display: none;">
                                            <%= item.idIdiomaPersona %>
                                        </td>
                                        <td style="display: none;">
                                            <%= item.GRH_Idioma!=null? item.idIdioma:0 %>
                                        </td>
                                        <td>
                                            <%= item.GRH_Idioma!=null? item.GRH_Idioma.descripcion:string.Empty %>
                                        </td>
                                        <td style="display: none;">
                                            <%= item.GRH_NivelIdioma!=null? item.idNivelIdioma:0 %>
                                        </td>
                                        <td>
                                            <%= item.nativo == true ? "Nativo" : (item.GRH_NivelIdioma!=null?item.GRH_NivelIdioma.descripcion:string.Empty)%>   
                                        </td>
                                        <td>
                                            <a class="editar" href="javascript:;">Editar</a> | <a class="eliminar" href="javascript:;">Eliminar</a>
                                        </td>
                                    </tr>
                                    <%
                                           }
                                       } %>
                                </tbody>
                            </table>
                            <a id="addIdiomaPersona" href="javascript:;">Agregar</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="dialogTelefono" title="" style="display: none; z-index: 1000;">
        <input type="hidden" id="hdnTelefono" />
        <input type="hidden" id="hdnAccionTelefono" />
        <table>
            <tr>
                <td>
                    Número
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.GRH_Telefono.FirstOrDefault().nroTelefono, new { @id = "txtTelefono", @class = "required" })%>
                </td>
            </tr>
        </table>
    </div>
    <div id="dialogCorreo" title="" style="display: none; z-index: 1000;">
        <input type="hidden" id="hdnCorreo" />
        <input type="hidden" id="hdnAccionCorreo" />
        <table>
            <tr>
                <td>
                    Cuenta
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.GRH_Correo.FirstOrDefault().cuentaCorreo, new { @id = "txtCorreo", @class = "required" })%>
                </td>
            </tr>
        </table>
    </div>
    <div id="dialogDocumento" title="" style="display: none; z-index: 1000;">
        <input type="hidden" id="hdnDocumento" />
        <input type="hidden" id="hdnAccionDocumento" />
        <table>
            <tr>
                <td>
                    Tipo
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.DropDownListFor(m => m.GRH_Documento.FirstOrDefault().idTipoDocumento, (IEnumerable<SelectListItem>)ViewData["TipoDocumento"], new { @id = "ddlTipoDocumento", @class = "required" })%>
                </td>
            </tr>
            <tr>
                <td>
                    Número
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.GRH_Documento.FirstOrDefault().nroDocumento, new { @id = "txtDocumento", @class = "required" })%>
                </td>
            </tr>
        </table>
    </div>
    <div id="dialogExperienciaLaboral" title="" style="display: none; z-index: 1000;">
        <input type="hidden" id="hdnExperienciaLaboral" />
        <input type="hidden" id="hdnAccionExperienciaLaboral" />
        <table>
            <tr>
                <td>
                    Empresa
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.GRH_ExperienciaLaboral.FirstOrDefault().empresa, new { @id = "txtEmpresa", @class="required" })%>
                </td>
            </tr>
            <tr>
                <td>
                    Cargo
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.GRH_ExperienciaLaboral.FirstOrDefault().cargo, new { @id = "txtCargo", @class = "required" })%>
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
                    <%= Html.TextBoxFor(m => m.GRH_ExperienciaLaboral.FirstOrDefault().fechaInicio, new { @id = "txtInicio", @type = "date", @class = "required" })%>
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
                    <%= Html.TextBoxFor(m => m.GRH_ExperienciaLaboral.FirstOrDefault().FechaFin, new { @id = "txtFin",@type="date" })%>
                </td>
            </tr>
            <tr>
                <td>
                    Conocimientos
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextAreaFor(m => m.GRH_ExperienciaLaboral.FirstOrDefault().conocimientos, new { @id = "txtConocimiento", @class = "required" })%>
                </td>
            </tr>
        </table>
    </div>
    <div id="dialogEstudioRealizado" title="" style="display: none; z-index: 1000;">
        <input type="hidden" id="hdnEstudioRealizado" />
        <input type="hidden" id="hdnAccionEstudioRealizado" />
        <table>
            <tr>
                <td>
                    Centro de Estudio
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.GRH_EstudioRealizado.FirstOrDefault().centroEstudio, new { @id = "txtCentro", @class = "required" })%>
                </td>
            </tr>
            <tr>
                <td>
                    Título obtenido
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.GRH_EstudioRealizado.FirstOrDefault().nombreEstudio, new { @id = "txtNombre", @class = "required" })%>
                </td>
            </tr>
            <tr>
                <td>
                    Nivel
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.DropDownListFor(m => m.GRH_EstudioRealizado.FirstOrDefault().idNivelEducativo, (IEnumerable<SelectListItem>)ViewData["NivelEducativo"], new { @id = "ddlNivel", @class = "required" })%>
                </td>
            </tr>
            <tr>
                <td>
                    Especialidad
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.DropDownListFor(m => m.GRH_EstudioRealizado.FirstOrDefault().idEspecialidad, (IEnumerable<SelectListItem>)ViewData["Especialidad"], new { @id = "ddlEspecialidad", @class = "required" })%>
                </td>
            </tr>
            <tr>
                <td>
                    Situación
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.DropDownListFor(m => m.GRH_EstudioRealizado.FirstOrDefault().idSituacionEstudio, (IEnumerable<SelectListItem>)ViewData["SituacionEstudio"], new { @id = "ddlSituacion", @class = "required" })%>
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
                    <%= Html.TextBoxFor(m => m.GRH_EstudioRealizado.FirstOrDefault().fechaInicio, new { @id = "txtInicioE", @type = "date", @class = "required" })%>
                </td>
            </tr>
            <tr id="trFinE">
                <td>
                    <label id="lblFinE">
                        Fecha Fin</label>
                </td>
                <td>
                    <label id="sepFinE">
                        :</label>
                </td>
                <td>
                    <%= Html.TextBoxFor(m => m.GRH_EstudioRealizado.FirstOrDefault().fechaFin, new { @id = "txtFinE",@type="date" })%>
                </td>
            </tr>
        </table>
    </div>
    <div id="dialogIdiomaPersona" title="" style="display: none; z-index: 1000;">
        <input type="hidden" id="hdnIdiomaPersona" />
        <input type="hidden" id="hdnAccionIdiomaPersona" />
        <table>
            <tr>
                <td>
                    Idioma
                </td>
                <td>
                    :
                </td>
                <td>
                    <%= Html.DropDownListFor(m => m.GRH_IdiomaPersona.FirstOrDefault().idIdioma, (IEnumerable<SelectListItem>)ViewData["Idioma"], new { @id = "ddlIdioma", @class = "required" })%>
                </td>
            </tr>
            <tr>
                <td>
                    Nativo
                </td>
                <td>
                    :
                </td>
                <td>                                         
                    <input type="checkbox" id="chkNativo" name="nativo" checked="checked"/>
                </td>
            </tr>
            <tr>
                <td>                    
                    <label id="lblNivelIdioma">Nivel</label>
                </td>
                <td>                    
                    <label id="sepNivelIdioma">:</label>
                </td>
                <td>
                    <%= Html.DropDownListFor(m => m.GRH_IdiomaPersona.FirstOrDefault().idNivelIdioma, (IEnumerable<SelectListItem>)ViewData["NivelIdioma"], new { @id = "ddlNivelIdioma" })%>
                </td>
            </tr>
            
            
        </table>
    </div>

</asp:Content>
