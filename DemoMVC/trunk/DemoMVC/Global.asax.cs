using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using DemoMVC.ControllerFactory;
using Viafirma;

namespace DemoMVC
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        // URL en la que se encuentra el servidor de Viafirma Utilizado. 
        public static string URL_VIAFIRMA = "http://testservices.viafirma.com/viafirma";

        // URL en la que se encuentra el WS del servidor de Viafirma Utilizado.
        public static string URL_WS_VIAFIRMA = "http://testservices.viafirma.com/viafirma";

        //Estos parametros se encuentran en el codigo únicamente por el ejemplo:
        //Alias del certificado instalado en servidor
        public static string ALIAS = "xnoccio";
        //Pass del certificado instalado en servidor
        public static string PASS_CERT = "12345";

        public static String DEMO_FILE_PDF_PATH { get; set; }
        public static String DEMO_FILE_XML_PATH { get; set; }
        public static String DEMO_FILE_TXT_PATH { get; set; }
        public static String DEMO_IMAGE_LOGO_PATH { get; set; }
        public static String DEMO_STAMPER_PATH { get; set; }

        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                "Default", // Route name
                "{controller}/{action}/{id}", // URL with parameters
                new { controller = "Home", action = "Index", id = UrlParameter.Optional } // Parameter defaults
            );

        }

        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas(); 
            RegisterRoutes(RouteTable.Routes);
            ControllerBuilder.Current.SetControllerFactory(new NinjectControllerFactory());

            //ViafirmaClientFactory.Init(URL_VIAFIRMA, URL_WS_VIAFIRMA, "ViafirmaDotNetClientWebExample", "WKGLMRX439ETZF49DLMRXMR9Y29DE");

            //// Path del fichero de ejemplo usado en la firma
            //// Se hace la distinción para el caso Windows/Unix
            //String separador = "\\"; // Por defecto Windows
            //if ("UNIX".Equals(System.Environment.OSVersion.Platform.ToString().ToUpper()))
            //{
            //    separador = "/";
            //}

            //string appPath = Environment.CurrentDirectory;
            //DEMO_FILE_PDF_PATH = appPath + separador + "resources" + separador + "exampleSign.pdf";
            //DEMO_FILE_XML_PATH = appPath + separador + "resources" + separador + "prueba.xml";
            //DEMO_FILE_TXT_PATH = appPath + separador + "resources" + separador + "ejemplo.txt";
            //DEMO_IMAGE_LOGO_PATH = appPath + separador + "resources" + separador + "viafirma-400x400.png";
            //DEMO_STAMPER_PATH = appPath + separador + "resources" + separador + "stamperWatermark.png";
        }
    }



    public class Global : System.Web.HttpApplication
    {
        // URL en la que se encuentra el servidor de Viafirma Utilizado. 
        public static string URL_VIAFIRMA = "http://testservices.viafirma.com/viafirma";

        // URL en la que se encuentra el WS del servidor de Viafirma Utilizado.
        public static string URL_WS_VIAFIRMA = "http://testservices.viafirma.com/viafirma";

        //Estos parametros se encuentran en el codigo únicamente por el ejemplo:
        //Alias del certificado instalado en servidor
        public static string ALIAS = "xnoccio";
        //Pass del certificado instalado en servidor
        public static string PASS_CERT = "12345";

        //public static String DEMO_FILE_PDF_PATH { get; set; }
        //public static String DEMO_FILE_XML_PATH { get; set; }
        //public static String DEMO_FILE_TXT_PATH { get; set; }
        //public static String DEMO_IMAGE_LOGO_PATH { get; set; }
        //public static String DEMO_STAMPER_PATH { get; set; }

        protected void Application_Start(object sender, EventArgs e)
        {
            //ViafirmaClientFactory.Init(URL_VIAFIRMA, URL_WS_VIAFIRMA, "ViafirmaDotNetClientWebExample", "WKGLMRX439ETZF49DLMRXMR9Y29DE");

            //// Path del fichero de ejemplo usado en la firma
            //// Se hace la distinción para el caso Windows/Unix
            //String separador = "\\"; // Por defecto Windows
            //if ("UNIX".Equals(System.Environment.OSVersion.Platform.ToString().ToUpper()))
            //{
            //    separador = "/";
            //}

            //string appPath = Environment.CurrentDirectory;
            //DEMO_FILE_PDF_PATH = appPath + separador + "resources" + separador + "exampleSign.pdf";
            //DEMO_FILE_XML_PATH = appPath + separador + "resources" + separador + "prueba.xml";
            //DEMO_FILE_TXT_PATH = appPath + separador + "resources" + separador + "ejemplo.txt";
            //DEMO_IMAGE_LOGO_PATH = appPath + separador + "resources" + separador + "viafirma-400x400.png";
            //DEMO_STAMPER_PATH = appPath + separador + "resources" + separador + "stamperWatermark.png";
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}