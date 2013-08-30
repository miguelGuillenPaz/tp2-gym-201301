using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DemoMVC.Models;

namespace DemoMVC.Controllers
{
    public class ConvocatoriaController : Controller
    {
        private GRH_Entities _entities;
        //
        // GET: /Convocatoria/

        public ActionResult Index()
        {
            _entities = new GRH_Entities();
            var convocatoria = (from r in _entities.GRH_Convocatoria  select r).ToList();
            return View(convocatoria);
        }

        //
        // GET: /Convocatoria/Detalle/5

        public ActionResult Detalle(int id)
        {
            return View();
        }

        //
        // GET: /Convocatoria/Crear

        public ActionResult Crear()
        {
            return View();
        } 

        //
        // POST: /Convocatoria/Crear

        [HttpPost]
        public ActionResult Crear(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
        
        //
        // GET: /Convocatoria/Editar/5
 
        public ActionResult Editar(int id)
        {
            return View();
        }

        //
        // POST: /Convocatoria/Editar/5

        [HttpPost]
        public ActionResult Editar(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here
 
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /Convocatoria/Eliminar/5
 
        public ActionResult Eliminar(int id)
        {
            return View();
        }

        //
        // POST: /Convocatoria/Eliminar/5

        [HttpPost]
        public ActionResult Eliminar(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add Eliminar logic here
 
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
