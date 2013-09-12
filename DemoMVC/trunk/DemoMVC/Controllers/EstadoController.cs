using System;
using System.Collections.Generic;
using System.Linq;
using System.Configuration;
using System.Web.Mvc;
using DemoMVC.Models;
using System.Collections;

namespace DemoMVC.Controllers
{
    public class EstadoController : Controller
    {
        //
        // GET: /Estado/
        public IFormsAuthenticationService FormsService { get; set; }
        private GD_Entities _entities;

        private readonly string[] _seleccione = new[] { string.Empty, "--Seleccione--" };

        public ActionResult Index()
        {
            _entities = new GD_Entities();
            var estado = (from R in _entities.GD_Estado select R).ToList();
            return View(estado);
        }   
            
        /*public int Conteo()
        {
            _entities = new GD_Entities();
            var estado = (from td in _entities.GD_Estado select td).ToList();
            return estado.Count();

        }*/
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

                var estado = new GD_Estado
                {
                    Nombre = nombre
                };
                _entities.AddToGD_Estado(estado);
                _entities.SaveChanges();
                //return new JsonResult() { ContentType = "text/html", Data = "Se ha registrado el Expediente Técnico Satisfactoriamente", JsonRequestBehavior = JsonRequestBehavior.AllowGet };

                //string s = "$('#prueba').html('Updated!');";
                //return JavaScript(s); 
                //JavaScript("alert('Update is successful.')");
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
        public ActionResult Editar(int id)
        {
            _entities = new GD_Entities();

            //ViewData["Perfil"] = Perfil();
            var estado = (from td in _entities.GD_Estado where td.IdEstado == id select td).FirstOrDefault();
            return View(estado);
        }
        
        [HttpPost]
        public ActionResult Editar(int id, FormCollection collection)
        {

            _entities = new GD_Entities();

            try
            {
                var nombre = collection["Nombre"].ToUpper();
                
                var res = (from r in _entities.GD_Estado where r.IdEstado == id select r).FirstOrDefault();
                if (res != null)
                {
                    res.Nombre = nombre;
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
                var res = (from r in _entities.GD_Estado where r.IdEstado == id select r).FirstOrDefault();
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
