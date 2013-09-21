using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMVC.Models
{
    public class AsignarRecursoForm
    {
        public AsignarRecursoForm() { }

        public IList<Actividad> ListadoActividad { get; set; }

        public IList<Proyecto> ListadoProyecto { get; set; }

        public IList<Cargo> ListadoCargo { get; set; }

        public IList<Recurso> ListadoEquipos { get; set; }

        public IList<Recurso> ListadoMateriales { get; set; }

        public IList<Recurso> ListadoEmpleados { get; set; }

        public IList<PlanRecursosActividad> ListadoRecursoActividad { get; set; }

    }
}