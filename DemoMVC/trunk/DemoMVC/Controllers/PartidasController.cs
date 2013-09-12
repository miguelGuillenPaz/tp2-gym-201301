using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc; 
using GYM.SIC.GPC.Repositories.GPCRepository;
using GYM.SIC.GPC.Parameters;
using GYM.SIC.GPC.Models;

using DemoMVC.Models;

using System.Threading;

namespace DemoMVC.Controllers
{
    public class PartidasController : Controller
    {
        private GPCPresupuestoRepository EFPresupuesto = new GPCPresupuestoRepository();
        private GPCPartidaRespository EFPartida = new GPCPartidaRespository();
        private GPCDetallePartidaRepository EFDetallePartida = new GPCDetallePartidaRepository();

        public ActionResult ActualizarAvancePartida()
        {
            var presupuestos = from presupuesto
                               in EFPresupuesto.Presupuestos
                               orderby presupuesto.Nombre
                               select new { presupuesto.IDPresupuestoObra, presupuesto.Nombre };

            ViewData["presupuestos"] = new SelectList(presupuestos, "IDPresupuestoObra", "Nombre");
            ViewData["ddlPartida"] = new SelectList(new[] { "(Selecciona Partida)" });

            return View();
        }

        public JsonResult GetPartidas(int presupuesto)
        {
            JsonResult result = new JsonResult();
            var partidas = from partida
                            in EFPartida.Partidas
                           where partida.IDPresupuestoObra == presupuesto
                           orderby partida.Nombre
                           select new { partida.IDPartida, partida.Nombre };

            result.Data = partidas.ToList();
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;

            return result;
        }

        public JsonResult ListarDetalles(int partida, string fecha)
        {
            string fechaAvance = fecha.Substring(6) + fecha.Substring(3, 2) + fecha.Substring(0, 2);

            try
            {
                JsonResult result = new JsonResult();

                var detalles = from detalle
                                   in EFDetallePartida.DetallePartida(fechaAvance)
                               where detalle.IDPartida == partida
                               select detalle;

                result.Data = detalles.ToList();
                result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;

                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public ActionResult AvancePartida(int IdDetallePartida)
        {
            var usuarios = from usuario
                           in EFDetallePartida.Usuarios()
                           orderby usuario.NombreUsuario
                           select new { usuario.IdUsuario, usuario.NombreUsuario };

            ViewData["destinatarios"] = new SelectList(usuarios, "IdUsuario", "NombreUsuario");

            ViewData["IdDetallePartida"] = IdDetallePartida; 
            
            if (Request.IsAjaxRequest())
                return PartialView();

            return View();
        }

        [HttpPost]
        public JsonResult AvancePartida(int IdDetallePartida, string Destinatario, string Cantidad, string FechaAprobacion, string Observacion)
        {
            try
            {
                int CantidadEjecutada;
                DateTime dtFecha;

                if (string.IsNullOrEmpty(Cantidad.Trim()))
                    throw new Exception("Debe ingresar la cantidad");

                if (string.IsNullOrEmpty(Destinatario.Trim()))
                    throw new Exception("Debe seleccionar al destinatario");

                if (string.IsNullOrEmpty(FechaAprobacion.Trim()))
                    throw new Exception("Debe ingresar la fecha de ejecución");

                if (string.IsNullOrEmpty(Observacion.Trim()))
                    throw new Exception("Debe ingresar la observación");

                try
                {
                    CantidadEjecutada = Convert.ToInt32(Cantidad);
                }
                catch (Exception)
                {                    
                    throw new Exception("El valor de la cantidad no es correcta");
                }

                try
                {
                    dtFecha = Convert.ToDateTime(FechaAprobacion);
                }
                catch (Exception)
                {
                    throw new Exception("El valor de la fecha de aprobación no es correcta");
                }

                var ExisteAvancePartida = (from avancePartida
                                in EFDetallePartida.AvancePartida
                                           where avancePartida.FechaEjecucion == dtFecha && avancePartida.IDDetallePartida == IdDetallePartida
                                           select avancePartida.IDAvancePartida).DefaultIfEmpty().FirstOrDefault();

                int IdAvancePartidaKey = 0;
                if (ExisteAvancePartida != 0)
                    IdAvancePartidaKey = ExisteAvancePartida;

                var avancePartidaNew = new GPC_AvancePartida
                {
                    IDAvancePartida = IdAvancePartidaKey,
                    IDDetallePartida = IdDetallePartida,
                    IDEstado = 1, //Pendiente de Aprobación por el Jefe de Obra
                    IDUsuarioEmisor = Convert.ToInt32(Destinatario), // Usuario Destinatario
                    IDUsuarioDestinatario = Convert.ToInt32(Destinatario), // Usuario Destinatario
                    FechaRegistro = DateTime.Now,
                    CantidadEjecutada = CantidadEjecutada,
                    Observacion = Observacion,
                    FechaEjecucion = dtFecha
                };

                EFDetallePartida.CrearAvancePartida(avancePartidaNew);

                return new JsonResult() { ContentType = "text/html", Data = "0|Se ha registrado el Avance de Partida satisfactoriamente", JsonRequestBehavior = JsonRequestBehavior.AllowGet };
            }
            catch (Exception ex)
            {                
                return new JsonResult() { ContentType = "text/html", Data = "1|" + ex.Message, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
            }
        }

        public ActionResult ActualizarInconsistenciaPartida()
        {
            var presupuestos = from presupuesto
                               in EFPresupuesto.Presupuestos
                               orderby presupuesto.Nombre
                               select new { presupuesto.IDPresupuestoObra, presupuesto.Nombre };

            ViewData["presupuestos"] = new SelectList(presupuestos, "IDPresupuestoObra", "Nombre");
            ViewData["ddlPartida"] = new SelectList(new[] { "(Selecciona Partida)" });

            return View();
        }

        public JsonResult ListarRechazados(int partida, string fecha)
        {
            string fechaAvance = fecha.Substring(6) + fecha.Substring(3, 2) + fecha.Substring(0, 2);

            try
            {
                JsonResult result = new JsonResult();

                var detalles = from detalle
                                   in EFDetallePartida.InconsistenciaPartida(partida, fechaAvance)                               
                               select detalle;

                result.Data = detalles.ToList();
                result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;

                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public ActionResult InconsistenciaPartida(int IdAvancePartida)
        {
            try
            {
                GPC_InconsistenciaAvancePartida c = EFDetallePartida.GetInconsistenciaAvancePartida(IdAvancePartida);

                if (c == null)
                {
                    ViewData["IdInconsistenciaAvancePartida"] = 0;
                    ViewData["IdAvancePartida"] = IdAvancePartida;
                    ViewData["Justificacion"] = "";
                }
                else
                {
                    ViewData["IdInconsistenciaAvancePartida"] = c.IDInconsistenciaAvancePartida;
                    ViewData["IdAvancePartida"] = IdAvancePartida;
                    ViewData["Justificacion"] = c.Justificacion;
                }
            
            if (Request.IsAjaxRequest())
                return PartialView();

            return View();
        }
            catch (Exception ex)
            {                
                throw ex;
            }
        }

        [HttpPost]
        public JsonResult InconsistenciaPartida(int IdInconsistenciaAvancePartida, int IdAvancePartida, string Observacion)
        {
            try
            {
                if (string.IsNullOrEmpty(Observacion.Trim()))
                    throw new Exception("Debe ingresar la observacion para la inconsistencia de la partida");

                var InconsistenciaPartida = new GPC_InconsistenciaAvancePartida
                {
                    IDInconsistenciaAvancePartida = IdInconsistenciaAvancePartida,
                    IDAvancePartida = IdAvancePartida,
                    IDUsuarioJustifica = 1,
                    FechaRegistro = DateTime.Now,
                    Justificacion = Observacion
                };

                EFDetallePartida.ActualizarInconsistenciaPartida(InconsistenciaPartida);

                return new JsonResult() { ContentType = "text/html", Data = "0|Se ha registrado la Inconsistencia de Partida satisfactoriamente", JsonRequestBehavior = JsonRequestBehavior.AllowGet };
            }
            catch (Exception ex)
            {
                return new JsonResult() { ContentType = "text/html", Data = "1|" + ex.Message, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
            }            
        }

    }
}
