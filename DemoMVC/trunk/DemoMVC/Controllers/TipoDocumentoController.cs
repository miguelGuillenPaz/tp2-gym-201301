using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web.Mvc;
using DemoMVC.Models;
using System.Collections;

namespace DemoMVC.Controllers
{
    public class TipoDocumentoController : Controller
    {
        //
        // GET: /TipoDocumento/
        public IFormsAuthenticationService FormsService { get; set; }
        private GD_Entities _entities;

        private readonly string[] _seleccione = new[] { string.Empty, "--Seleccione--" };
        public ActionResult Index()
        {
            _entities = new GD_Entities();
            //ViewData["Count"] = Conteo();
            var tipoDocumento = (from td in _entities.GD_TipoDocumento select td).ToList();
            return View(tipoDocumento);
        }
        public int Conteo()
        {
            _entities = new GD_Entities();
            var tipoDocumento = (from td in _entities.GD_TipoDocumento select td).ToList();
            return tipoDocumento.Count();
 
        }
        public ActionResult Registrar()
        {
            _entities = new GD_Entities();
            //ViewData["Perfil"] = Perfil();
            return View();
        }
        [HttpPost]
        public ActionResult Registrar(FormCollection collection)
        {
            _entities = new GD_Entities();
            try
            {
                var nombre = collection["Nombre"].ToUpper();
                var vigencia = Convert.ToInt16(collection["Vigencia"]);


                var tipoDocumento = new GD_TipoDocumento
                {
                    Nombre = nombre,
                    Vigencia = vigencia
                };
                _entities.AddToGD_TipoDocumento(tipoDocumento);                
                _entities.SaveChanges();
    
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
        
        /*
        public ActionResult Index(FormCollection collection)
        {
            _entities = new GD_Entities();
            try
            {
                var nombre = collection["Nombre"].ToUpper();
                var vigencia = Convert.ToInt16(collection["Vigencia"]);
                var tipoDocumento = new GD_TipoDocumento
                {
                    Nombre = nombre,
                    Vigencia = vigencia
                };
                _entities.AddToGD_TipoDocumento(tipoDocumento);
                _entities.SaveChanges();

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
        */
        public ActionResult Editar(int id)
        {
            _entities = new GD_Entities();

            //ViewData["Perfil"] = Perfil();
            var tipoDocumento = (from td in _entities.GD_TipoDocumento where td.IdTipoDocumento == id select td).FirstOrDefault();
            return View(tipoDocumento);
        }

        [HttpPost]
        public ActionResult Editar(int id, FormCollection collection)
        {
            
            _entities = new GD_Entities();

            try
            {
                var nombre = collection["Nombre"].ToUpper();
                var vigencia = Convert.ToInt16(collection["Vigencia"]);

                var res = (from r in _entities.GD_TipoDocumento where r.IdTipoDocumento == id select r).FirstOrDefault();
                if (res != null)
                {
                    res.Nombre = nombre;
                    res.Vigencia = vigencia;
                    _entities.SaveChanges();
                }

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
        public virtual ActionResult Eliminar(int id)
        {
            _entities = new GD_Entities();
            try
            {
                var res = (from r in _entities.GD_TipoDocumento where r.IdTipoDocumento == id select r).FirstOrDefault();
                if (res != null)
                {
                    _entities.DeleteObject(res);
                    _entities.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                // ReSharper disable RedundantArgumentName
                return View();
                // ReSharper restore RedundantArgumentName
            }
            return Json(data: new { result = true },
                         behavior: JsonRequestBehavior.AllowGet);
        }
    }
}
