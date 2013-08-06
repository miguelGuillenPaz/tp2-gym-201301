<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<DemoMVC.Models.PMP_DetalleProgramacionPreventiva>>" %>

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

            <table id="datos">
                <tr>
                    <td>
                        Código
                    </td>
                    <td>
                        :
                    </td>
                    <td>
                        <%: ViewData["codigo"]%>
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
                        <%: ViewData["descripcion"]%>
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
                         <%: ViewData["fechaadquisicion"]%>
                    </td>
                </tr>
            </table>

            <table id="tblListadoProgramacion">
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
                           foreach (var item in Model)
                           {
                    %>
                    <tr>
                        <td style="display: none;">
                            <%= item.idDetalleProgramacionPreventiva %>
                        </td>
                        <td>
                            <%=i++%>
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
        <input type="hidden" id="hdnIdDetalle" value='<%: ViewData["idProgramacion"]%>' />
       <table style="width: 100%;">
           <tr>
               <td>
                   Fecha
               </td>
               <td>
                   :
               </td>
               <td>
                    <%= Html.TextBoxFor(m => m.FirstOrDefault().fechaProgramacion, new { @id = "txtFecha",@type="date" })%>
               </td>
           </tr>
    
       </table>
   </div>
</asp:Content>
