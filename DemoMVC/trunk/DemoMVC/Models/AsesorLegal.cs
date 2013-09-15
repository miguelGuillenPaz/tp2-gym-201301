using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMVC.Models
{
    public class AsesorLegal
    {
        public int IdAsesorLegal { get; set; }
        public string Apellido { get; set; }
        public string Nombre { get; set; }
        public int CasosAsignados { get; set; }
    }
}