using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GYM.SIC.GPC.Models;
using GYM.SIC.GPC.Parameters;
using GYM.SIC.GPC.Repositories.GPCRepository; 
using DemoMVC;
using DemoMVC.Models;
using DemoMVC.Helpers;

namespace GYM.SIC.GPC.Controllers
{
    public class CierrePresupuestoObraController : Controller
    {
        // BD GYM
        private IGPCPresupuestoRepository EFPresupuesto;
        private IGPCPartidaRespository EFPartida;
        private IGPCHistoricoAprobacionesRepository EFHistoricoAprobaciones;
        private IGPCNotificacionesRepository EFNotificaciones;
        private IGPCSolicitudesRepository EFSolicitudes;
        private IGPCCronogramaRepository EFCronograma;
        private IGPCInconsistenciaPresupuestoObraRepository EFInconsistencia;

        public CierrePresupuestoObraController(
            IGPCPresupuestoRepository EFPresupuesto,
            IGPCPartidaRespository EFPartida,
            IGPCHistoricoAprobacionesRepository EFHistoricoAprobaciones,
            IGPCNotificacionesRepository EFNotificaciones,
            IGPCSolicitudesRepository EFSolicitudes,
            IGPCCronogramaRepository EFCronograma,
            IGPCInconsistenciaPresupuestoObraRepository EFInconsistencia)
        {
            this.EFPresupuesto = EFPresupuesto;
            this.EFPartida = EFPartida;
            this.EFHistoricoAprobaciones = EFHistoricoAprobaciones;
            this.EFNotificaciones = EFNotificaciones;
            this.EFSolicitudes = EFSolicitudes;
            this.EFCronograma = EFCronograma;
            this.EFInconsistencia = EFInconsistencia;
        }



        //
        // GET: /CierrePresupuestoObra/

        public ActionResult CerrarPresupuesto(bool MostrarConfirmacion = false)
        {
            var Model = new ListadoPresupuestosModel();
            Model.MostrarConfirmacion = MostrarConfirmacion;
            return View("CerrarPresupuesto", Model);
        }

        public JsonResult ListarPresupuestos()
        {
            var presupuestos = EFPresupuesto.Presupuestos.Where(x => x.IDEstado == EstadosParameters.Pendiente_de_Cierre_por_el_Supervisor_de_Presupuesto || x.IDEstado == EstadosParameters.Con_Inconsistencias).ToList();

            var presupuestosModel = new List<PresupuestoModel>();

            presupuestos.ForEach((presupuesto) =>
            {
                var presupuestoModel = new PresupuestoModel();
                presupuestoModel.RazonSocial = presupuesto.GPC_ClienteObra.RazonSocial;
                presupuestoModel.Direccion = presupuesto.GPC_Obra.Direccion;
                ModelCopier.CopyModel(presupuesto, presupuestoModel);
                presupuestosModel.Add(presupuestoModel);
            });

            return new JsonResult() { Data = presupuestosModel, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }

        public ActionResult ListarDetalle(int PresupuestoID)
        {
            var presupuesto = EFPresupuesto.PresupuestoObraPorID(PresupuestoID);
            var presupuestoModel = new PresupuestoModel();
            presupuestoModel.RazonSocial = presupuesto.GPC_ClienteObra.RazonSocial;
            presupuestoModel.Direccion = presupuesto.GPC_Obra.Direccion;
            ModelCopier.CopyModel(presupuesto, presupuestoModel);
            return View(presupuestoModel);
        }

        [HttpPost]
        public JsonResult CambiarEstado(int PresupuestoID, int Estado, string Observacion)
        {
            String mensaje = "";
            var presupuesto = EFPresupuesto.Presupuestos.ToList().FirstOrDefault(x => x.IDPresupuestoObra == PresupuestoID);
            presupuesto.IDEstado = Estado;
            presupuesto.FechaCambioEstado = DateTime.Now;
            presupuesto.UsuarioCambioEstado = "Arturo";

            // cerrado  9
            if (Estado == EstadosParameters.Cerrado_por_el_Supervisor_de_Presupuesto)
            {
                mensaje = "El Cierre del Presupuesto ha sido realizado.";
                presupuesto.Observaciones = Observacion;
            }

            if (Estado == EstadosParameters.Con_Inconsistencias || Estado == EstadosParameters.En_solicitud_de_Actualizacion)
            {
                var notificaciones = new GPC_Notificacion
                {
                    FechaRegistro = DateTime.Now,
                    Observacion = Observacion,
                    IDPresupuestoObra = presupuesto.IDPresupuestoObra
                };
                EFNotificaciones.ActualizarNotificaciones(notificaciones);

                //con inconsistencias   10
                if (Estado == EstadosParameters.Con_Inconsistencias)
                {
                    var inconsistencias = new GPC_InconsistenciaPresupuestoObra
                    {
                        IDPresupuestoObra = presupuesto.IDPresupuestoObra,
                        IDUsuarioGenera = 1,
                        FechaRegistro = DateTime.Now,
                        Observacion = Observacion
                    };
                    EFInconsistencia.ActualizarInconsistencias(inconsistencias);
                    mensaje = "Se ha notificado la justificacion de las inconsistencias.";
                }


                // solicitar actualizacion  11
                if (Estado == EstadosParameters.En_solicitud_de_Actualizacion)
                {
                    presupuesto.Observaciones = Observacion;
                    mensaje = "Se ha notificado la actualización del presupuesto.";
                }
            }

            EFPresupuesto.ActualizarPresupuesto(presupuesto);

            return new JsonResult() { Data = mensaje, JsonRequestBehavior = JsonRequestBehavior.AllowGet };

        }

        public ActionResult ListarInconsistencias(int PresupuestoID)
        {
            var inconsistencia = EFInconsistencia.InconsistenciaPorId(PresupuestoID);
            var InconsistenciaModel = new InconsistenciaPresupuestoObra();

            if (inconsistencia != null)
            {
                ModelCopier.CopyModel(inconsistencia, InconsistenciaModel);
            }

           
            JsonResult result = new JsonResult();
            result.Data = InconsistenciaModel;
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;

            return result;
        }


    }
}
