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
        public virtual ActionResult SetPresupuesto(string formData)
        {
            _entities = new PMP_Entities();

            var js = new JavaScriptSerializer();
            var presupuesto = (object[])js.DeserializeObject(formData);
            if (presupuesto != null)
            {
                foreach (Dictionary<string, object> itemsJson in presupuesto)
                {
                    var x = itemsJson;
                }
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = true }, behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

    }
}
