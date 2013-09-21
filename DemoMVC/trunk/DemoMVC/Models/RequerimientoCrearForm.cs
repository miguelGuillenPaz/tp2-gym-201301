using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.Web;

namespace DemoMVC.Models
{
    public class RequerimientoCrearForm
    {
        public RequerimientoCrearForm() { }

        public SelectList ListaProyectos { get; set; }

        public string Fecha { get; set; }

    }
}