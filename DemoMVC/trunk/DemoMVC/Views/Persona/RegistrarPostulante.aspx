<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<DemoMVC.Models.Persona>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Registrar Postulante
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="contenido-top">
        <div>
            <h1>
                Registrar Postulante
            </h1>
            <div class="areas-negocios">
                <%= Html.LabelFor(m=>m.EstadoCivilId) %>                                                   
                   <%= Html.DropDownListFor(m => m.EstadoCivilId, (IEnumerable<SelectListItem>)Model.EstadoCivil) %>
            </div>
        </div>
    </div>
</asp:Content>
