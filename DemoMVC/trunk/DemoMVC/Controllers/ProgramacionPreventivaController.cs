using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Collections;
using DemoMVC.Models;
using System.Globalization;

namespace DemoMVC.Controllers
{
    public class ProgramacionPreventivaController : Controller
    {
        private PMP_Entities _entities;
        private readonly string[] _seleccione = new[] { "0", "--Seleccione--" };

        public ActionResult Index()
        {
            _entities = new PMP_Entities();            

            ViewData["ano"] = "";
            ViewData["descripcion"] = "";
            ViewData["estado"] = "TODOS";
            ViewData["TipoEstado"] = CrearTipoEstado();
            ViewData["PresupuestosAprobados"] = PresupuestosAprobados();
            ViewData["nregistros"] = 0;

            return View();
        }

        [HttpPost]
        public ActionResult Index(FormCollection formCollection)
        {
            _entities = new PMP_Entities();
            ViewData["TipoEstado"] = CrearTipoEstado();
            ViewData["PresupuestosAprobados"] = PresupuestosAprobados();
            int idPresupuesto = Convert.ToInt32(formCollection["ddlPresupuestosAprobados"]);
            var res = (from r in _entities.PMP_ProgramacionPreventiva where r.idPptoMtoPreventivo == idPresupuesto select r).ToList();
            if (res.Count ==0)
            {
                var pre = (from r in _entities.PMP_DetallePptoMtoPreventivo where r.idPptoMtoPreventivo == idPresupuesto select r).ToList();
                if (pre.Count > 0)
                {
                    foreach (var item in pre){
                         var pro = new PMP_ProgramacionPreventiva
                             {
                                 idPptoMtoPreventivo = item.idPptoMtoPreventivo,
                                 idMaquinariaEquipo = item.idMaquinariaEquipo,
                                 cantidadMantenimientos = 0,
                                 fechaMaxima = DateTime.Now.AddDays(100),
                                 maximaCantidadMantenimientos = item.cantidadMantenimiento,
                                 estadoActualEquipo = "OPERATIVO"
                             };
                        _entities.AddToPMP_ProgramacionPreventiva(pro);
                        _entities.SaveChanges();
                    }
                }
                res = (from r in _entities.PMP_ProgramacionPreventiva where r.idPptoMtoPreventivo == idPresupuesto select r).ToList();
            }
            ViewData["nregistros"] = res.Count;

            return View(res);
        }

        public ActionResult Detalle(int? id)
        {
            _entities = new PMP_Entities();

            var res = (from r in _entities.PMP_DetalleProgramacionPreventiva where r.idProgramacionPreventiva == id select r).ToList();
            var res2 = (from r in _entities.PMP_ProgramacionPreventiva where r.idProgramacionPreventiva == id select r).FirstOrDefault();

            if (res2 != null)
            {
                ViewData["idProgramacion"] = id;
                ViewData["codigo"] = res2.PMP_MaquinariaEquipo.idMaquinariaEquipo;
                ViewData["descripcion"] = res2.PMP_MaquinariaEquipo.descripcion;
                ViewData["fechaadquisicion"] = res2.PMP_MaquinariaEquipo.fechaRegistro;
            }

            return View(res);
        }

        public ActionResult SetFecha(int id, string fecha)
        { 
            _entities = new PMP_Entities();
            bool resultado;
            int idDetalle = 0;
          
                var prog = new PMP_DetalleProgramacionPreventiva
                {
                    idProgramacionPreventiva = id,
                    fechaProgramacion = DateTime.Parse(fecha)
                };
               _entities.AddToPMP_DetalleProgramacionPreventiva(prog);
               _entities.SaveChanges();
               idDetalle = prog.idDetalleProgramacionPreventiva;
               resultado = true;
          

            return Json(data: new { result = resultado, id = idDetalle},
                        behavior: JsonRequestBehavior.AllowGet);
        }

        //[HttpPost]
        //public ActionResult Index(FormCollection formCollection)
        //{
        //    _entities = new PMP_Entities();

        //    int? ano = formCollection["txtAno"].ToString() == "" ? 0 : int.Parse(formCollection["txtAno"].ToString());
        //    String descripcion = formCollection["txtDescripcion"].ToString().Trim();
        //    String estado = formCollection["ddlEstado"].ToString().Trim();

        //    var res = (from r in _entities.PMP_PptoMtoPreventivo where (ano == 0 || r.ano == ano) select r).ToList();

        //    if (descripcion != "")
        //        res = (from r in res where r.descripcion == descripcion select r).ToList();

        //    if (estado != "TODOS")
        //        res = (from r in res where r.estado == estado select r).ToList();

        //    ViewData["ano"] = ano;
        //    ViewData["descripcion"] = descripcion;
        //    ViewData["estado"] = estado;
        //    ViewData["TipoEstado"] = CrearTipoEstado();
        //    ViewData["nregistros"] = res.Count;

        //    return View(res);
        //}

        public ActionResult Eliminar(int id)
        {
            _entities = new PMP_Entities();

            var res = (from r in _entities.PMP_DetalleProgramacionPreventiva where r.idDetalleProgramacionPreventiva == id select r).FirstOrDefault();
            if (res != null)
            {
                _entities.DeleteObject(res);
                _entities.SaveChanges();
            }

            return Json(data: new { result = true },
                        behavior: JsonRequestBehavior.AllowGet);
        }

        public ActionResult Enviar(int idPptoMtoPreventivo)
        {
            _entities = new PMP_Entities();

            var res = (from r in _entities.PMP_PptoMtoPreventivo where r.idPptoMtoPreventivo == idPptoMtoPreventivo select r).FirstOrDefault();
            if (res != null)
            {
                _entities.DeleteObject(res);
                res.estado = "PENDIENTE DE APROBACIÓN";
                _entities.SaveChanges();
            }

            return Json(data: new { result = true },
                        behavior: JsonRequestBehavior.AllowGet);
        }

        public ActionResult SetPresupuesto(int idPptoMtoPreventivo, int ano, string descripcion, decimal montoEstimado,
            decimal montoFinal, int cantidadMantencion, string estado)
        {
            bool resultado;

            _entities = new PMP_Entities();
            if (idPptoMtoPreventivo == 0)
            {
                var presupuesto = new PMP_PptoMtoPreventivo
                {
                    idPptoMtoPreventivo = idPptoMtoPreventivo,
                    ano = ano,
                    descripcion = descripcion,
                    montoEstimado = montoEstimado,
                    montoFinal = montoFinal,
                    cantidadMantencion = cantidadMantencion,
                    estado = estado
                };
                _entities.AddToPMP_PptoMtoPreventivo(presupuesto);
                _entities.SaveChanges();
                idPptoMtoPreventivo = presupuesto.idPptoMtoPreventivo;
                resultado = true;
            }
            else
            {
                var res = (from r in _entities.PMP_PptoMtoPreventivo where r.idPptoMtoPreventivo == idPptoMtoPreventivo select r).FirstOrDefault();
                if (res != null)
                {
                    res.idPptoMtoPreventivo = idPptoMtoPreventivo;
                    res.ano = ano;
                    res.descripcion = descripcion;
                    res.montoEstimado = montoEstimado;
                    res.montoFinal = montoFinal;
                    res.cantidadMantencion = cantidadMantencion;
                    res.estado = estado;
                    _entities.SaveChanges();
                    resultado = true;
                }
                else
                {
                    resultado = false;
                }
            }

            return Json(data: new { result = resultado, idPptoMtoPreventivo = idPptoMtoPreventivo, ano = ano },
                        behavior: JsonRequestBehavior.AllowGet);
        }



        //
        // GET: /PresupuestoMtoPreventivo/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /PresupuestoMtoPreventivo/Create

        public ActionResult Crear()
        {
            return View();
        }

        //
        // POST: /PresupuestoMtoPreventivo/Create

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
        // GET: /PresupuestoMtoPreventivo/Edit/5

        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /PresupuestoMtoPreventivo/Edit/5

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
        // GET: /PresupuestoMtoPreventivo/Delete/5

        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /PresupuestoMtoPreventivo/Delete/5

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

        private IEnumerable PresupuestosAprobados()
        {

            var resultado = new List<SelectListItem>
                {
                    new SelectListItem
                        {
                            Value = _seleccione[0],
                            Text = _seleccione[1]
                        }
                };
            var lista = (from r in _entities.PMP_PptoMtoPreventivo where r.estado.Equals("APROBADO") select r);

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.idPptoMtoPreventivo + string.Empty, Text = item.descripcion };
                resultado.Add(selListItem);
            }

            return resultado;
        }

        private IEnumerable CrearTipoEstado()
        {

            var resultado = new List<SelectListItem>();
            var valores = new string[] { "CREADO", "PENDIENTE DE APROBACIÓN", "APROBADO", "RECHAZADO" };
            var lista = (from r in valores select r);


            foreach (var item in valores)
            {
                var selListItem = new SelectListItem { Value = item.ToString(CultureInfo.InvariantCulture), Text = item };
                resultado.Add(selListItem);
            }

            return resultado;
        }
    }
}
