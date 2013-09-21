using System;
using System.Web.Mvc;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMVC.Models
{
    public class RequerimientoForm
    {
        public RequerimientoForm() { }

        public Requerimiento Requerimiento { get; set; }

        public SelectList ListadoProyectos { get; set; }

        public IList<DetalleRequerimiento> ListadoDetalleRequerimiento { get; set; }


    }
}