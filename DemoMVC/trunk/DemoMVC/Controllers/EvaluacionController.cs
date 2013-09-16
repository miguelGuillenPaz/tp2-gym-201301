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
            if (idPerfil > 0)
            {
                var evaluacionCompetencia =
                    _entities.GRH_EvaluacionCompetencia.FirstOrDefault(f => f.IdPerfil == idPerfil);
                if (evaluacionCompetencia != null)
                {
                    var idEvaluacionCompetencia = evaluacionCompetencia.IdEvaluacionCompetencia;
                    var lista =
                        _entities.GRH_EvaluacionCompetenciaEvaluador.Where(
                            f => f.IdEvaluacionCompetencia == idEvaluacionCompetencia);
                    foreach (var item in lista)
                    {
                        var selListItem = new SelectListItem
                            {
                                Value = item.IdEmpleado + string.Empty,
                                Text = item.GRH_Empleado.GRH_Persona.Nombre + " " + item.GRH_Empleado.GRH_Persona.ApellidoPaterno + " " + item.GRH_Empleado.GRH_Persona.ApellidoMaterno
                            };
                        resultado.Add(selListItem);
                    }
                }
            }
            else
            {
                var empleados =_entities.GRH_Empleado.ToList();
                foreach (var empleado in empleados)
                {
                    var selListItem = new SelectListItem
                    {
                        Value = empleado.IdEmpleado + string.Empty,
                        Text = empleado.GRH_Persona.Nombre + " " + empleado.GRH_Persona.ApellidoPaterno + " " + empleado.GRH_Persona.ApellidoMaterno
                    };
                    resultado.Add(selListItem);
                }
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = true, evaluador = resultado }, behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        private int GetIdEvaluacionCompetencia(int idPerfil)
        {
            var id = 0;
            var evaluacionCompetencia =
                       _entities.GRH_EvaluacionCompetencia.FirstOrDefault(f => f.IdPerfil == idPerfil);
            if (evaluacionCompetencia != null)
            {
                id = evaluacionCompetencia.IdEvaluacionCompetencia;
            }
            else
            {
                var evaluacion = new GRH_EvaluacionCompetencia
                    {
                        Fecha = DateTime.Now,
                        IdPerfil = idPerfil
                    };
                _entities.AddToGRH_EvaluacionCompetencia(evaluacion);
                _entities.SaveChanges();
                id = evaluacion.IdEvaluacionCompetencia;
            }
            return id;
        }

        public virtual ActionResult SetCuestionario(int idPerfil, int idCuestionario)
        {

            var idEvaluacionCompetencia = GetIdEvaluacionCompetencia(idPerfil);

            var evaluacionCompetenciaCuestionario = new GRH_EvaluacionCompetenciaCuestionario
            {
                IdCuestionario = idCuestionario,
                IdEvaluacionCompetencia = idEvaluacionCompetencia
            };
            _entities.AddToGRH_EvaluacionCompetenciaCuestionario(evaluacionCompetenciaCuestionario);
            _entities.SaveChanges();            

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = true }, behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        public virtual ActionResult DelCuestionario(int idPerfil, int idCuestionario)
        {

            var idEvaluacionCompetencia = GetIdEvaluacionCompetencia(idPerfil);

            var evaluacionCompetenciaCuestionario =
                _entities.GRH_EvaluacionCompetenciaCuestionario.Where(
                    f => f.IdCuestionario == idCuestionario && f.IdEvaluacionCompetencia == idEvaluacionCompetencia).ToList();

            foreach (var cuestionario in evaluacionCompetenciaCuestionario)
            {
                _entities.DeleteObject(cuestionario);
                _entities.SaveChanges();
            }
            
            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = true }, behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        public virtual ActionResult SetEvaluador(int idPerfil, int idEmpleado)
        {

            var idEvaluacionCompetencia = GetIdEvaluacionCompetencia(idPerfil);

            var evaluacionCompetenciaEvaluador = new GRH_EvaluacionCompetenciaEvaluador
            {
                IdEmpleado = idEmpleado,
                IdEvaluacionCompetencia = idEvaluacionCompetencia,
                IdCuestionario = 1
            };
            _entities.AddToGRH_EvaluacionCompetenciaEvaluador(evaluacionCompetenciaEvaluador);
            _entities.SaveChanges();

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = true }, behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        public virtual ActionResult DelEvaluador(int idPerfil, int idEmpleado)
        {

            var idEvaluacionCompetencia = GetIdEvaluacionCompetencia(idPerfil);

            var evaluacionCompetenciaEvaluador =
                _entities.GRH_EvaluacionCompetenciaEvaluador.Where(
                    f => f.IdEmpleado == idEmpleado && f.IdEvaluacionCompetencia == idEvaluacionCompetencia).ToList();

            foreach (var evaluador in evaluacionCompetenciaEvaluador)
            {
                _entities.DeleteObject(evaluador);
                _entities.SaveChanges();
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = true }, behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        public virtual ActionResult GetCuestionario(int idPerfil)
        {
            var resultado = new List<SelectListItem>();
            if (idPerfil > 0)
            {
                var evaluacionCompetencia =
                    _entities.GRH_EvaluacionCompetencia.FirstOrDefault(f => f.IdPerfil == idPerfil);

                if (evaluacionCompetencia != null)
                {
                    var idEvaluacionCompetencia = evaluacionCompetencia.IdEvaluacionCompetencia;
                    var lista =
                        _entities.GRH_EvaluacionCompetenciaCuestionario.Where(
                            f => f.IdEvaluacionCompetencia == idEvaluacionCompetencia);
                    foreach (var item in lista)
                    {
                        var selListItem = new SelectListItem
                            {
                                Value = item.IdCuestionario + string.Empty,
                                Text = item.GRH_CartillaCuestionario.Nombre
                            };
                        resultado.Add(selListItem);
                    }
                }
            }
            else
            {
                var cuestionarios =
                    _entities.GRH_CartillaCuestionario.ToList();
                foreach (var cuestionario in cuestionarios)
                {
                    var selListItem = new SelectListItem
                    {
                        Value = cuestionario.IdCuestionario + string.Empty,
                        Text = cuestionario.Nombre
                    };
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
