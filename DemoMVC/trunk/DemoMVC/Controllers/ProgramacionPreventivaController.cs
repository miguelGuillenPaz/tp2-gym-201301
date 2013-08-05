using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DemoMVC.Controllers
{
    public class ProgramacionPreventivaController : Controller
    {
        //
        // GET: /ProgramacionPreventiva/

        public ActionResult Index()
        {
            return View();
        }

        //
        // GET: /ProgramacionPreventiva/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /ProgramacionPreventiva/Create

        public ActionResult Create()
        {
            return View();
        } 

        //
        // POST: /ProgramacionPreventiva/Create

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
        // GET: /ProgramacionPreventiva/Edit/5
 
        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /ProgramacionPreventiva/Edit/5

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
        // GET: /ProgramacionPreventiva/Delete/5
 
        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /ProgramacionPreventiva/Delete/5

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
    }
}
