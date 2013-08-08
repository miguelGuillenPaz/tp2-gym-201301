using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using DemoMVC.Models;

namespace DemoMVC.Controllers
{
    public class EmpleadoController : Controller
    {
        //
        // GET: /Empleado/
        private GRH_Entities _entities;
        private readonly string[] _seleccione = new[] { string.Empty, "--Seleccione--" };

        public ActionResult Alta()
        {
            _entities = new GRH_Entities();
            var personas = new List<GRH_Persona>();
            var postulantes = (from r in _entities.GRH_Postulante where r.aprobado == true select r).ToList();
            foreach (var postulante in postulantes)
            {
                var items = (from r in _entities.GRH_Persona where r.idPersona == postulante.idPersona select r).ToList();
                foreach (var item in items)
                {
                    personas.Add(item);
                }
            }

            return View(personas);
        }

        public ActionResult DatosAdicionales(int id)
        {
            _entities = new GRH_Entities();
            var persona = (from r in _entities.GRH_Persona where r.idPersona == id select r).FirstOrDefault();
            return View(persona);
        }

    }
}
