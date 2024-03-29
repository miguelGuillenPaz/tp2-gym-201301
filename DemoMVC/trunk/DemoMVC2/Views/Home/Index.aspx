﻿<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Home Page
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- <h2><%: ViewData["Message"] %></h2> -->
    <div class="contenido-top">
        <div class="contenido-izquierda">
            <h1>
                Áreas de negocio del Grupo Graña y Montero:</h1>
            <div class="areas-negocios">
                <div id="ingenieria" class="area ingenieria activo">
                    <a href="areas/construccion.aspx">
                        <h2>
                            Ingeniería y Construcción</h2>
                        <img alt="" src="Images/ingenieria.jpg" />
                    </a>
                </div>
                <div id="infraestructura" class="area infraestructura">
                    <a href="areas/infraestructura.aspx">
                        <h2>
                            Infraestructura</h2>
                        <img alt="" src="Images/infraestructura.jpg" />
                    </a>
                </div>
                <div id="inmobiliaria" class="area inmobiliaria">
                    <a href="areas/inmobiliaria.aspx">
                        <h2>
                            Inmobiliaria</h2>
                        <img alt="" src="Images/inmobiliaria.jpg" />
                    </a>
                </div>
                <div id="servicios" class="area servicios">
                    <a href="areas/servicios.aspx">
                        <h2>
                            Servicios</h2>
                        <img alt="" src="Images/servicios.jpg" />
                    </a>
                </div>
            </div>
         </div>
       <div class="contenido-derecha">
            <h1>
                Noticias</h1>
            <div class="contenedor-noticias">
                <div class="noticia">
                    <div class="head-noticia">
                        <span class="fecha-noticia">05.04.13 </span><span class="titulo-noticia">Segundo Reporte
                            de Sostenibilidad del Grupo Graña y Montero – GRI 2012</span>
                    </div>
                    <div class="texto-noticia">
                        El Grupo Graña y Montero publicó su segundo "Reporte de Sostenibilidad: Nuevos Horizontes,
                        Nuevos Retos" 2012, desarrollado bajo los estándares internacionales de la Global
                        Reporting Initiative (GRI) y verificado (Third Party Checked) por la Asociación
                        Perú 2021... <a class="leer-mas" href="noticias.aspx?noti_id=8">leer más</a>
                    </div>
                </div>
                <div class="noticia">
                    <div class="head-noticia">
                        <span class="fecha-noticia">01.03.13 </span><span class="titulo-noticia">Convocatoria
                            a Junta General de Accionistas para el 26 de marzo de 2013</span>
                    </div>
                    <div class="texto-noticia">
                        El viernes 01 de marzo de 2013 se publicó en el Diario Oficial El Peruano y en El
                        Comercio la convocatoria a Junta General Obligatoria Anual de Accionistas, la misma
                        que se llevará a cabo el 26 de marzo de 2013 a las 15:00 horas en el local de la
                        Sociedad sito en Av. Paseo de la República 4667, Surquillo... <a class="leer-mas"
                            href="noticias.aspx?noti_id=7">leer más</a>
                    </div>
                </div>
                <div class="noticia">
                    <div class="head-noticia">
                        <span class="fecha-noticia">19.10.2012 </span><span class="titulo-noticia">Lanzamiento
                            4ta Edición del Premio Graña y Montero </span>
                    </div>
                    <div class="texto-noticia">
                        Acorde a nuestra Política de Responsabilidad Social, el grupo Graña y Montero reafirma
                        su compromiso con la educación y la gestión del conocimiento al organizar la cuarta
                        edición del "Premio Graña y Montero a la Investigación en Ingeniería Peruana"...
                        <a class="leer-mas" href="noticias.aspx?noti_id=6">leer más</a>
                    </div>
                </div>
                <div class="noticia">
                    <div class="head-noticia">
                        <span class="fecha-noticia">19.10.2012 </span><span class="titulo-noticia">GyM recibe
                            el Premio Latinoamericano de Responsabilidad Social Empresarial 2012</span>
                    </div>
                    <div class="texto-noticia">
                        El jueves 4 de octubre, GyM, empresa constructora del Grupo Graña y Montero recibió
                        el “Premio Latinoamericano a la Responsabilidad Social Empresarial”, otorgado por
                        la Federación Interamericana de la Industria de la Construcción (FIIC) con ocasión
                        del 28° Congreso Interamericano de la Industria de la Construcción realizado en
                        Lima... <a class="leer-mas" href="noticias.aspx?noti_id=5">leer más</a>
                    </div>
                </div>
                <div class="noticia">
                    <div class="head-noticia">
                        <span class="fecha-noticia">19.10.2012 </span><span class="titulo-noticia">Grupo Graña
                            y Montero reconocido como una de "Las Empresas más Admiradas del Perú"</span>
                    </div>
                    <div class="texto-noticia">
                        El pasado 3 de octubre, el Grupo Graña y Montero fue reconocido como una de las
                        10 Empresas más Admiradas del Perú 2012,premio otorgado por Price WaterhouseCoopers
                        y la revista especializada G de Gestión, luego de haber realizado un estudio de
                        consulta entre los ejecutivos más importantes del país. Este reconocimiento destacónuestro
                        desempeño en los criterios de visión estratégica y calidad de su plana gerencial...
                        <a class="leer-mas" href="noticias.aspx?noti_id=4">leer más</a>
                    </div>
                </div>

	</div>	

</asp:Content>
