using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DemoMVC.Models;
using GYM.SIG.Business;

namespace DemoMVC.Controllers
{
    public class ParteController : Controller
    {
        private GSC_Entities _entities;
        private readonly string[] _seleccione = new[] { string.Empty, "--Seleccione--" };
        //
        // GET: /Parte/

        public ActionResult Index()
        {
            _entities = new GSC_Entities();
            ViewData["Proyecto"] = Proyecto();
            ViewData["Situacion"] = Situacion();
            var parte = (from r in _entities.GSC_ParteDiario select r).ToList();                
            return View(parte);
        }

        //
        // GET: /Parte/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /Parte/Create

        public ActionResult Create()
        {
            return View();
        } 

        //
        // POST: /Parte/Create

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
        // GET: /Parte/Edit/5
 
        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /Parte/Edit/5

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
        // GET: /Parte/Delete/5
 
        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /Parte/Delete/5

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

        public virtual ActionResult Requerimiento(int idProyecto)
        {
            var resultado = CargaInicial();            
            var lista = new DetalleRequerimientoCN().RequerimientoPorProyecto(idProyecto);

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.codReq + string.Empty, Text = item.nomReq };
                resultado.Add(selListItem);
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = true, requerimiento = resultado }, behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        public virtual ActionResult TipoServicio(int idProyecto, int idRequerimiento)
        {
            var resultado = CargaInicial();
            var lista = new TipoServicioCN().ListarTipoServicioPorProyectoYRequerimiento(idProyecto,idRequerimiento);

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.codTServ + string.Empty, Text = item.descTServ };
                resultado.Add(selListItem);
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = true, tipoServicio = resultado }, behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
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

        private IEnumerable Proyecto()
        {

            var resultado = CargaInicial();

            var lista = new ProyectoCN().ListarRequeridos();

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.codPro + string.Empty, Text = item.nomPro };
                resultado.Add(selListItem);
            }

            return resultado;
        }

        private IEnumerable Situacion()
        {

            var resultado = CargaInicial();
            
            var lista = (from r in _entities.GSC_Estado select r).Where(f => f.FlagParteDiario == "1");

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.IdEstado + string.Empty, Text = item.DescripEstado };
                resultado.Add(selListItem);
            }

            return resultado;
        }

        public static string GetHoraFormateada(DateTime? hora)
        {            
            var resultado = string.Empty;
            if (hora != null)
            {
                resultado = hora.Value.Hour + ":" +
                            hora.Value.Minute;
            }
            return resultado;
        }
    }
}
