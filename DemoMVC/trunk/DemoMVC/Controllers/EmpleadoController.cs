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
            var persona = (from r in _entities.GRH_Persona where r.GRH_Postulante.Count != 0 select r).ToList();
            return View(persona);            
        }

        public ActionResult DatosAdicionales(int id)
        {   _entities = new GRH_Entities();
            var persona = (from r in _entities.GRH_Persona where r.idPersona == id select r).FirstOrDefault();
            return View(persona);
        }

    }
}
