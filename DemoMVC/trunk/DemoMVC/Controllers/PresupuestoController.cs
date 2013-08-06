using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using DemoMVC.Models;

namespace DemoMVC.Controllers
{
    public class PresupuestoController : Controller
    {
        private PMP_Entities _entities;

        public ActionResult Index()
        {
            _entities = new PMP_Entities();

            var presupuesto = _entities.PMP_PptoMtoPreventivo.ToList();

            ViewData["ano"] = "";
            ViewData["descripcion"] = "";
            ViewData["estado"] = "TODOS";
            ViewData["TipoEstado"] = CrearTipoEstado();
            ViewData["nregistros"] = presupuesto.Count;

            return View(presupuesto);
        }

        [HttpPost]
        public ActionResult Index(FormCollection formCollection)
        {
            _entities = new PMP_Entities();

            int? ano = formCollection["txtAno"].ToString() == "" ? 0 : int.Parse(formCollection["txtAno"].ToString());
            String descripcion = formCollection["txtDescripcion"].ToString().Trim();
            String estado = formCollection["ddlEstado"].ToString().Trim();

            var res = (from r in _entities.PMP_PptoMtoPreventivo where (ano == 0 || r.ano == ano) select r).ToList();

            if (descripcion != "")
                res = (from r in res where r.descripcion == descripcion select r).ToList();

            if (estado != "TODOS")
                res = (from r in res where r.estado == estado select r).ToList();

            ViewData["ano"] = ano;
            ViewData["descripcion"] = descripcion;
            ViewData["estado"] = estado;
            ViewData["TipoEstado"] = CrearTipoEstado();
            ViewData["nregistros"] = res.Count;

            return View(res);
        }

        private static IEnumerable CrearTipoEstado()
        {

            var resultado = new List<SelectListItem>();
            var valores = new string[] { "CREADO", "PENDIENTE DE APROBACIÓN", "APROBADO", "RECHAZADO" };

            foreach (var item in valores)
            {
                var selListItem = new SelectListItem { Value = item.ToString(CultureInfo.InvariantCulture), Text = item };
                resultado.Add(selListItem);
            }

            return resultado;
        }

        public ActionResult Crear()
        {
            return View(new PMP_Entities().PMP_MaquinariaEquipo.ToList());
        }
        public virtual ActionResult CrearPresupuesto(string formData)
        {
            _entities = new PMP_Entities();
            var pmpPptoMtoPreventivo = new PMP_PptoMtoPreventivo();            
            var js = new JavaScriptSerializer();
            var presupuesto = (object[])js.DeserializeObject(formData);
            if (presupuesto != null)
            {
                foreach (Dictionary<string, object> itemsJson in presupuesto)
                {
                    bool resultTry;
                    int ano;
                    resultTry = int.TryParse((string)itemsJson["ano"], out ano);
                    if (resultTry)
                        pmpPptoMtoPreventivo.ano = ano;

                    decimal costoTotalFijo;
                    resultTry = decimal.TryParse((string)itemsJson["costoTotalFijo"], out costoTotalFijo);
                    if (resultTry)
                        pmpPptoMtoPreventivo.montoEstimado = costoTotalFijo;

                    int cantidad;
                    resultTry = int.TryParse((string)itemsJson["cantidad"], out cantidad);
                    if (resultTry)
                        pmpPptoMtoPreventivo.cantidadMantencion = cantidad;

                    decimal costoTotalFinal;
                    resultTry = decimal.TryParse((string)itemsJson["costoTotalFinal"], out costoTotalFinal);
                    if (resultTry)
                        pmpPptoMtoPreventivo.montoFinal = costoTotalFinal;

                    pmpPptoMtoPreventivo.descripcion = (string)itemsJson["descripcion"];
                    pmpPptoMtoPreventivo.fechaRegistro = DateTime.Now;
                    pmpPptoMtoPreventivo.estado = "CREADO";

                    _entities.AddToPMP_PptoMtoPreventivo(pmpPptoMtoPreventivo);
                    _entities.SaveChanges();
                    
                    var deserializedLeanExcepcionDetalleModel = (object[])itemsJson["formDataDetalle"];
                    foreach (Dictionary<string, object> subItemsJson in deserializedLeanExcepcionDetalleModel)
                    {
                        var pmpDetallePptoMtoPreventivo = new PMP_DetallePptoMtoPreventivo();
                        int idMaquinariaEquipo;
                        resultTry = int.TryParse((string)subItemsJson["idMaquinariaEquipo"], out idMaquinariaEquipo);
                        if (resultTry)
                            pmpDetallePptoMtoPreventivo.idMaquinariaEquipo = idMaquinariaEquipo;

                        int cantidadMantenimiento;
                        resultTry = int.TryParse((string)subItemsJson["cantidadMantenimiento"], out cantidadMantenimiento);
                        if (resultTry)
                            pmpDetallePptoMtoPreventivo.cantidadMantenimiento = cantidadMantenimiento;

                        decimal montoAprobado;
                        resultTry = decimal.TryParse((string)subItemsJson["montoAprobado"], out montoAprobado);
                        if (resultTry)
                            pmpDetallePptoMtoPreventivo.montoAprobado = montoAprobado;

                        pmpDetallePptoMtoPreventivo.idPptoMtoPreventivo = pmpPptoMtoPreventivo.idPptoMtoPreventivo;

                        _entities.AddToPMP_DetallePptoMtoPreventivo(pmpDetallePptoMtoPreventivo);
                        _entities.SaveChanges();
                    }
                    
                }
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = true }, behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        public virtual ActionResult EditarPresupuesto(string formData)
        {
            _entities = new PMP_Entities();            
            var js = new JavaScriptSerializer();
            var presupuesto = (object[])js.DeserializeObject(formData);
            if (presupuesto != null)
            {
                foreach (Dictionary<string, object> itemsJson in presupuesto)
                {
                    bool resultTry;
                    int idPptoMtoPreventivo;
                    resultTry = int.TryParse((string)itemsJson["idPptoMtoPreventivo"], out idPptoMtoPreventivo);
                    if (resultTry)
                    {
                        var res = (from r in _entities.PMP_PptoMtoPreventivo where r.idPptoMtoPreventivo == idPptoMtoPreventivo select r).FirstOrDefault();
                        if (res != null)
                        {
                            int ano;
                            resultTry = int.TryParse((string)itemsJson["ano"], out ano);
                            if (resultTry)
                                res.ano = ano;

                            decimal costoTotalFijo;
                            resultTry = decimal.TryParse((string)itemsJson["costoTotalFijo"], out costoTotalFijo);
                            if (resultTry)
                                res.montoEstimado = costoTotalFijo;

                            int cantidad;
                            resultTry = int.TryParse((string)itemsJson["cantidad"], out cantidad);
                            if (resultTry)
                                res.cantidadMantencion = cantidad;


                            decimal costoTotalFinal;
                            resultTry = decimal.TryParse((string)itemsJson["costoTotalFinal"], out costoTotalFinal);
                            if (resultTry)
                                res.montoFinal = costoTotalFinal;

                            res.descripcion = (string)itemsJson["descripcion"];

                            _entities.SaveChanges();

                            var subItemsJsons = (object[])itemsJson["formDataDetalle"];
                            foreach (Dictionary<string, object> subItemsJson in subItemsJsons)
                            {
                                int idDetallePptoMtoPreventivo;
                                resultTry = int.TryParse((string)subItemsJson["idDetallePptoMtoPreventivo"], out idDetallePptoMtoPreventivo);
                                if (resultTry)
                                {
                                    var det = (from r in _entities.PMP_DetallePptoMtoPreventivo where r.idDetallePptoMtoPreventivo == idDetallePptoMtoPreventivo select r).FirstOrDefault();
                                    if (det != null)
                                    {
                                        int cantidadMantenimiento;
                                        resultTry = int.TryParse((string) subItemsJson["cantidadMantenimiento"],
                                                                 out cantidadMantenimiento);
                                        if (resultTry)
                                            det.cantidadMantenimiento = cantidadMantenimiento;

                                        decimal montoAprobado;
                                        resultTry = decimal.TryParse((string) subItemsJson["montoAprobado"],
                                                                     out montoAprobado);
                                        if (resultTry)
                                            det.montoAprobado = montoAprobado;
                                        
                                        _entities.SaveChanges();
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = true }, behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        public ActionResult Editar(int id)
        {
            _entities = new PMP_Entities();
            var res = (from r in _entities.PMP_PptoMtoPreventivo where r.idPptoMtoPreventivo == id select r).FirstOrDefault();
            return View(res);
        }

    }
}
