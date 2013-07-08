using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DemoMVC.Models;

namespace DemoMVC.Controllers
{
    [HandleError]
    public class PlanificacionController : Controller
    {
        //
        // GET: /Planificacion/

        public ActionResult Index()
        {
            return View();
        }

        //Muestra plan de proyecto detalle y lo crea
        public ActionResult CrearPlan()
        {
            return View();
        }

        //Muestra plan de proyecto detalle y lo crea
        [HttpPost]
        public ActionResult CrearPlan(string returnUrl)
        {
            return RedirectToAction("IngresoActividades", "Planificacion");
        }

        //Listado de proyectos pre-aprobados
        public ActionResult ListadoProyPlan()
        {
            return View();
        }

        //Post
        [HttpPost]
        public ActionResult ListadoProyPlan(string returnUrl)
        {
            return View(returnUrl);
        }

        //Ingreso de Actividades
        public ActionResult IngresoActividades()
        {
            return View();
        }

        //Ingreso de Actividades - Post
        [HttpPost]
        public ActionResult IngresoActividades(string returnUrl)
        {
            ViewData["Message"] = "El Plan de Proyecto ha sido creado satisfactoriamente";
            return View();
        }

    }
}
