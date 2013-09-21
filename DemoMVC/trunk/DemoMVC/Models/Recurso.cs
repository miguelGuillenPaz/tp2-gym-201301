using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMVC.Models
{
    public class Recurso
    {

        public Recurso()
        { 
        
        }

        public int IdRecurso { get; set; }
        public String Descripcion { get; set; }
        public double Precio { get; set; }
        public int IdTipoRecurso { get; set; }

    }
}