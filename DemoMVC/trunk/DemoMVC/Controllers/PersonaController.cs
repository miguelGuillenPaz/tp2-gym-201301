using System.Web.Mvc;
using DemoMVC.Models;

namespace DemoMVC.Controllers
{
    public class PersonaController : Controller
    {
        //
        // GET: /Persona/

        public ActionResult RegistrarPostulante()
        {
            var persona = new Persona();
            var resultado = persona.ObtenerPostulante(out persona, 1);

            return resultado ? View(persona) : View();
        }

    }
}
