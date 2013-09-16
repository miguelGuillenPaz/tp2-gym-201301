using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using DemoMVC.Models;
using GYM.SIG.Business;

namespace DemoMVC.Controllers
{
    public class CalificacionServicioController : Controller
    {
        private GSC_Entities _entities;
        private readonly string[] _seleccione = new[] { string.Empty, "--Seleccione--" };
        //
        // GET: /CalificacionServicio/

        public ActionResult Index()
        {
            _entities = new GSC_Entities();
            ViewData["Proyecto"] = Proyecto();
            ViewData["Situacion"] = Situacion();
            ViewData["ParametroCalificacion"] = ParametroCalificacion();
            var lista = new CalificacionServicioCN().ListarTodos();
            return View(lista);
        }

        public virtual ActionResult Anular(int idCalificacion)
        {
            _entities = new GSC_Entities();
            //editar
            var calificacionServicio = (from r in _entities.GSC_CalificacionServicio where r.IdCalificacion == idCalificacion select r).FirstOrDefault();

            if (calificacionServicio != null)
            {
                calificacionServicio.IdEstado = 3;
                _entities.SaveChanges();
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = true }, behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        public virtual ActionResult SetCalificacionServicio(int idCalificacion, int idProyecto, int idRequerimiento, int idTipoServicio, 
            string fecha, string fechaFin, string observacion,int idPuntualidad, int idCalidad, int idIncidencia)
        {
          
            _entities = new GSC_Entities();

            if (idCalificacion == 0)
            {

                //Insertar
                var calificacionNuevo = new GSC_CalificacionServicio
                {                    
                    IdProyecto = idProyecto,
                    IdRequerimiento = idRequerimiento,
                    IdCorDetReq = idTipoServicio,
                    FechaCalificacion = new DateTime(Convert.ToInt32(fecha.Substring(0, 4)), Convert.ToInt32(fecha.Substring(5, 2)), Convert.ToInt32(fecha.Substring(8, 2))),
                    FechaFinServicio = new DateTime(Convert.ToInt32(fechaFin.Substring(0, 4)), Convert.ToInt32(fechaFin.Substring(5, 2)), Convert.ToInt32(fechaFin.Substring(8, 2))),
                    Observacion = observacion,
                    IdParametroCalificacionPuntualidad = idPuntualidad,
                    IdParametroCalificacionCalidad = idCalidad,
                    IdParametroCalificacionIncidencia = idIncidencia,
                    IdEstado = 1,
                };
                _entities.AddToGSC_CalificacionServicio(calificacionNuevo);
                _entities.SaveChanges();
            }
            else
            {
                //editar
                var calificacionServicio = (from r in _entities.GSC_CalificacionServicio where r.IdCalificacion == idCalificacion select r).FirstOrDefault();

                if (calificacionServicio != null)
                {
                    calificacionServicio.IdProyecto = idProyecto;
                    calificacionServicio.IdRequerimiento = idRequerimiento;
                    calificacionServicio.IdCorDetReq = idTipoServicio;
                    calificacionServicio.FechaCalificacion = new DateTime(Convert.ToInt32(fecha.Substring(0, 4)),
                                                                          Convert.ToInt32(fecha.Substring(5, 2)),
                                                                          Convert.ToInt32(fecha.Substring(8, 2)));
                    calificacionServicio.FechaFinServicio = new DateTime(Convert.ToInt32(fechaFin.Substring(0, 4)),
                                                                         Convert.ToInt32(fechaFin.Substring(5, 2)),
                                                                         Convert.ToInt32(fechaFin.Substring(8, 2)));
                    calificacionServicio.Observacion = observacion;
                    calificacionServicio.IdParametroCalificacionPuntualidad = idPuntualidad;
                    calificacionServicio.IdParametroCalificacionCalidad = idCalidad;
                    calificacionServicio.IdParametroCalificacionIncidencia = idIncidencia;
                    _entities.SaveChanges();
                }
            }


            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = true }, behavior: JsonRequestBehavior.AllowGet);
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

            var lista = (from r in _entities.GSC_Estado select r).Where(f => f.FlagCalificacion == "1");

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.IdEstado + string.Empty, Text = item.DescripEstado };
                resultado.Add(selListItem);
            }

            return resultado;
        }

        private IEnumerable ParametroCalificacion()
        {

            var resultado = CargaInicial();

            var lista = (from r in _entities.GSC_ParametroCalificacion select r).ToList();

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.IdParametroCalificacion + string.Empty, Text = item.DescripParamCalif };
                resultado.Add(selListItem);
            }

            return resultado;
        }
    }
}
