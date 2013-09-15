using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DemoMVC.Models;

namespace DemoMVC.Controllers
{
    public class EvaluacionController : Controller
    {
        private GRH_Entities _entities;
        private readonly string[] _seleccione = new[] { string.Empty, "--Seleccione--" };

        //
        // GET: /Evaluacion/

        public ActionResult Index()
        {
            _entities = new GRH_Entities();
            ViewData["Perfil"] = Perfil();            
            return View();
        }

        //
        // GET: /Evaluacion/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /Evaluacion/Create

        public ActionResult Create()
        {
            return View();
        } 

        //
        // POST: /Evaluacion/Create

        [HttpPost]
        public ActionResult Create(FormCollection collection)
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
        // GET: /Evaluacion/Edit/5
 
        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /Evaluacion/Edit/5

        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
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
        // GET: /Evaluacion/Delete/5
 
        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /Evaluacion/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here
 
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        private List<SelectListItem> CargaInicial()
        {
            return new List<SelectListItem>
                {
                    new SelectListItem
                        {
                            Value = _seleccione[0],
                            Text = _seleccione[1]
                        }
                };
        }

        private IEnumerable Perfil()
        {

            var resultado = new List<SelectListItem>();

            var lista = (from r in _entities.GRH_Perfil select r);

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.IdPerfil + string.Empty, Text = item.Descripcion };
                resultado.Add(selListItem);
            }

            return resultado;
        }
    }
}
