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
                                    </td>
                                    <td>                                        
                                    </td>
                                    <td>
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
                            </table>
                        </div>
                    </div>                    
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
                                            <b>Nombres y Apellidos</b>
                                        </th>
                                        <th>
                                            <b>Fecha de Nacimiento</b>
                                        </th>
                                        <th style="display: none;">
                                            IdTipoDocumento
                                        </th>
                                        <th>
                                            <b>Tipo de Documento</b>
                                        </th>
                                        <th>
                                            <b>Número de Documento</b>
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
                                            <b>Tipo de Relación</b>
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
                                           { %>
                                    <tr>
                                        <td style="display: none;">
                                            <%= item.idPersona %>
                                        </td>
                                        <td>
                                            <%= item.GRH_Persona.nombre %>                                            
                                        </td>
                                        <td>
                                            
                                        </td>
                                        <td style="display: none;">                                            
                                        </td>
                                        <td>                                            
                                        </td>
                                        <td style="display: none;">                                            
                                        </td>
                                        <td>                                            
                                        </td>
                                        <td style="display: none;">                                            
                                        </td>
                                        <td>                                            
                                        </td>
                                        <td>                                            
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
                            <a id="addEstudioRealizado" href="javascript:;">Agregar</a>
                        </div>
                    </div>                    
                </div>
            </div>
        </div>
    </div>
</asp:Content>
