<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<DemoMVC.Models.PMP_ProgramacionPreventiva>" %>

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
    <script src="../../Scripts/Presupuesto/programacion.js" type="text/javascript"></script>
    <div class="contenido-top">
        <div>
            <h1>
                Programacion Maquinarias y Equipo </h1>
                <% if (Model != null)
                   { %>
                   <%= Html.HiddenFor(m=>m.idProgramacionPreventiva) %>
            <table id="datos"  class="table100">
                <tr>
                    <td>
                        Código
                    </td>
                    <td>
                        :
                    </td>
                    <td>
                        <%: Model.PMP_MaquinariaEquipo.idMaquinariaEquipo %>
                    </td>
                </tr>
                <tr>
                    <td>
                        Descripción
                    </td>
                    <td>
                        :
                    </td>
                    <td>
                        <%: Model.PMP_MaquinariaEquipo.descripcion %>
                    </td>
                </tr>
                <tr>
                    <td>
                        Fecha de adquisición
                    </td>
                    <td>
                        :
                    </td>
                    <td>
                         <%: Model.PMP_MaquinariaEquipo.fechaRegistro %>
                    </td>
                </tr>
            </table>
            <% } %>
            <table id="tblListadoProgramacion"  class="table100 table100b">
                <thead>
                    <tr>
                        <th style="display: none;">
                            <b>id</b>
                        </th>
                        <th>
                            <b>Nro.</b>
                        </th>
                        <th>
                            <b>Fecha Programación</b>
                        </th>
                        <th>
                            <b>Dias Faltantes</b>
                        </th>  
                        <th>
                            <b>Eliminar</b>
                        </th>                       
                    </tr>
                </thead>
                <tbody>
                    <% if (Model != null)
                       {
                           var i = 0;
                           foreach (var item in Model.PMP_DetalleProgramacionPreventiva)
                           {
                               i = i + 1;
                    %>
                    <tr>
                        <td style="display: none;">
                            <%= item.idDetalleProgramacionPreventiva %>
                        </td>
                        <td>                            
                            <%= i%>
                        </td>
                        <td>
                            <%=item.fechaProgramacion %>
                        </td>
                        <td>
                            0
                        </td>       
                         <td>
                            <a class="eliminar" href="javascript:;">Eliminar</a>
                        </td>                   
                    </tr>
                    <%}
                       } %>
                </tbody>
            </table>          
        
            <a id="addFecha" href="javascript:;">Agregar</a>
        </div>
    </div>
   <div id="dialogFechaProgramacion" title="" style="display: none; z-index: 1000;">
        <input type="hidden" id="hdnIdDetalle" value='0' />

       <table style="width: 100%;">
           <tr>
               <td>
                   Fecha
               </td>
               <td>
                   :
               </td>
               <td>
                   <input id="txtFecha" type="date" />
               </td>
           </tr>
    
       </table>
   </div>
</asp:Content>
