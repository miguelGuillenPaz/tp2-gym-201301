using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMVC.Models
{
    public class LegalDeclaracionFabricaDocumento
    {
        public LegalDeclaracionFabricaDocumento()
        {

        }
        public int idDeclaracionFabricaDocumento { get; set; }
        public int idDeclaracionFabricaTipo { get; set; }
        public string descripcionDocumento { get; set; }
        public string ruta { get; set; }
    }
}