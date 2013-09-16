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
    public class EvaluacionController : Controller
    {
        private readonly GRH_Entities _entities = new GRH_Entities();
        private readonly string[] _seleccione = new[] { string.Empty, "--Seleccione--" };

        //
        // GET: /Evaluacion/

        public ActionResult Index()
        {
            
            ViewData["Perfil"] = Perfil();            
            return View();
        }

        public virtual ActionResult GetEvaluador(int idPerfil)
        {
            var resultado = new List<SelectListItem>();
            var evaluacionCompetencia = _entities.GRH_EvaluacionCompetencia.FirstOrDefault(f => f.IdPerfil == idPerfil);

            if (evaluacionCompetencia != null)
            {
                var idEvaluacionCompetencia = evaluacionCompetencia.IdEvaluacionCompetencia;
                var lista =
                    _entities.GRH_EvaluacionCompetenciaEvaluador.Where(
                        f => f.IdEvaluacionCompetencia == idEvaluacionCompetencia);
                foreach (var item in lista)
                {
                    var selListItem = new SelectListItem {Value = item.IdEvaluacionCompetenciaEvaluador + string.Empty, Text = item.GRH_EvaluacionCompetencia.GRH_Empleado.GRH_Persona.Nombre};
                    resultado.Add(selListItem);
                }
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = true, evaluador = resultado }, behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        public virtual ActionResult GetCuestionario(int idPerfil)
        {
            var resultado = new List<SelectListItem>();
            var evaluacionCompetencia = _entities.GRH_EvaluacionCompetencia.FirstOrDefault(f => f.IdPerfil == idPerfil);

            if (evaluacionCompetencia != null)
            {
                var idEvaluacionCompetencia = evaluacionCompetencia.IdEvaluacionCompetencia;
                var lista =
                    _entities.GRH_EvaluacionCompetenciaCuestionario.Where(
                        f => f.IdEvaluacionCompetencia == idEvaluacionCompetencia);
                foreach (var item in lista)
                {
                var selListItem = new SelectListItem { Value = item.IdEvaluacionCompetenciaCuestionario + string.Empty, Text = item.GRH_CartillaCuestionario.Nombre };
                    resultado.Add(selListItem);
                }
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = true, cuestionario = resultado }, behavior: JsonRequestBehavior.AllowGet);
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
