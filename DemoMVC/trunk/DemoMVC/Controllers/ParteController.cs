using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
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
            var lista = new ParteDiarioCN().ListarTodos();
            return View(lista);
        }
        public virtual ActionResult Anular(int idParte)
        {
            _entities = new GSC_Entities();
            //editar
            var parte = (from r in _entities.GSC_ParteDiario where r.IdParteDiario == idParte select r).FirstOrDefault();

            if (parte != null)
            {                
                parte.IdEstado = 3;
                _entities.SaveChanges();
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = true }, behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        public virtual ActionResult SetParteDiario(int idParte, int idProyecto, int idRequerimiento, string fecha, string horaInicio, string horaFin, string observacion, int idTipoServicio)
        {
            DateTime? inicio = null;
            if (!string.IsNullOrEmpty(horaInicio))
                inicio = new DateTime(Convert.ToInt32(fecha.Substring(0, 4)), Convert.ToInt32(fecha.Substring(5, 2)),
                                      Convert.ToInt32(fecha.Substring(8, 2)), Convert.ToInt32(horaInicio.Substring(0, 2)), Convert.ToInt32(horaInicio.Substring(3, 2)), 0);
            DateTime? fin = null;
            if (!string.IsNullOrEmpty(horaFin))
                fin = new DateTime(Convert.ToInt32(fecha.Substring(0, 4)), Convert.ToInt32(fecha.Substring(5, 2)),
                                      Convert.ToInt32(fecha.Substring(8, 2)), Convert.ToInt32(horaFin.Substring(0, 2)), Convert.ToInt32(horaFin.Substring(3, 2)), 0);

            _entities = new GSC_Entities();

            if (idParte == 0)
            {
                
                //Insertar
                var parteNuevo = new GSC_ParteDiario
                    {
                        IdCorDetReq = idTipoServicio,
                        IdProyecto = idProyecto,
                        IdRequerimiento = idRequerimiento,
                        Fecha = new DateTime(Convert.ToInt32(fecha.Substring(0, 4)), Convert.ToInt32(fecha.Substring(5, 2)), Convert.ToInt32(fecha.Substring(8, 2))),
                        HoraInicio = inicio,
                        HoraFin = fin,
                        Observacion = observacion,
                        IdEstado = 1,                       
                    };
                _entities.AddToGSC_ParteDiario(parteNuevo);
                _entities.SaveChanges();
            }
            else
            {
                //editar
                var parte = (from r in _entities.GSC_ParteDiario where r.IdParteDiario == idParte select r).FirstOrDefault();

                if (parte != null)
                {
                    parte.IdProyecto = idProyecto;
                    parte.IdRequerimiento = idRequerimiento;
                    parte.Fecha = new DateTime(Convert.ToInt32(fecha.Substring(0, 4)), Convert.ToInt32(fecha.Substring(5, 2)), Convert.ToInt32(fecha.Substring(8, 2)));
                    parte.HoraInicio = inicio;
                    parte.HoraFin = fin;
                    parte.Observacion = observacion;
                    _entities.SaveChanges();
                }
            }
            
            
            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = true}, behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        public virtual ActionResult Requerimiento(int idProyecto)
        {
            var resultado = CargaInicial();            
            var lista = new DetalleRequerimientoCN().RequerimientoPorProyecto(idProyecto);

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.Value + string.Empty, Text = item.Text };
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
            if (hora != default(DateTime))
            {
                if (hora != null)
                    resultado = (hora.Value.Hour + string.Empty).PadLeft(2, '0') + ":" +
                                (hora.Value.Minute + string.Empty).PadLeft(2, '0');
            }
            return resultado;
        }

        public static string GetFechaFormateada(DateTime? fecha)
        {
            var resultado = string.Empty;
            if (fecha != default(DateTime))
            {
                var fechaUtil = Convert.ToDateTime(fecha);
                resultado = fechaUtil.ToString("yyyy-MM-dd");
            }
            return resultado;
        }
    }
}
