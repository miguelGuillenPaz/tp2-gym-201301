using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GYM.SIC.GPC.Models;
using GYM.SIC.GPC.Parameters;
using GYM.SIC.GPC.Repositories.GPCRepository;
using GYM.SIC.GPC.Repositories.S10Repository;
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

        public CierrePresupuestoObraController(
            IGPCPresupuestoRepository EFPresupuesto,
            IGPCPartidaRespository EFPartida,
            IGPCHistoricoAprobacionesRepository EFHistoricoAprobaciones,
            IGPCNotificacionesRepository EFNotificaciones,
            IGPCSolicitudesRepository EFSolicitudes,
            IGPCCronogramaRepository EFCronograma)
        {
            this.EFPresupuesto = EFPresupuesto;
            this.EFPartida = EFPartida;
            this.EFHistoricoAprobaciones = EFHistoricoAprobaciones;
            this.EFNotificaciones = EFNotificaciones;
            this.EFSolicitudes = EFSolicitudes;
            this.EFCronograma = EFCronograma;
        }



        //
        // GET: /CierrePresupuestoObra/

        public ActionResult CerrarPresupuesto()
        {
            return View();
        }

        public ActionResult ListarPresupuestos()
        {
            var presupuestos = EFPresupuesto.Presupuestos.Where(x => x.IDEstado == EstadosParameters.Pendiente_de_Cierre_por_el_Supervisor_de_Presupuesto).ToList();

            var presupuestosModel = new List<PresupuestoModel>();

            presupuestos.ForEach((presupuesto) =>
            {
                var presupuestoModel = new PresupuestoModel();
                presupuestoModel.RazonSocial = presupuesto.GPC_ClienteObra.RazonSocial;
                presupuestoModel.Direccion = presupuesto.GPC_Obra.Direccion;
                ModelCopier.CopyModel(presupuesto, presupuestoModel);
                presupuestosModel.Add(presupuestoModel);
            });

            return View(presupuestosModel);
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
            var presupuesto = EFPresupuesto.Presupuestos.ToList().FirstOrDefault(x => x.IDPresupuestoObra == PresupuestoID);
            presupuesto.IDEstado = Estado;
            presupuesto.FechaCambioEstado = DateTime.Now;
            presupuesto.UsuarioCambioEstado = "Arturo";
            presupuesto.Observaciones = Observacion;
            EFPresupuesto.ActualizarPresupuesto(presupuesto);

            String mensaje = "";

            // cerrado
            if (Estado == EstadosParameters.Cerrado_por_el_Supervisor_de_Presupuesto)
            {
                mensaje = "El Cierre del Presupuesto ha sido realizado.";
            }

            //con inconsistencias
            //if (Estado == EstadosParameters.Presupuesto_con_Inconsistencias)
            //{
            //    mensaje = "Presupuesto con Inconsistencias.";
            //}
 

            // solicitar actializacion
            //if (Estado == EstadosParameters.En_solicitud_de_Actualizacion)
            //{
            //    var notificaciones = new GPC_Notificacion
            //    {
            //        FechaRegistro = DateTime.Now,
            //        Observacion = Observacion,
            //        IDPresupuestoObra = presupuesto.IDPresupuestoObra,
            //    };
            //    EFNotificaciones.ActualizarNotificaciones(notificaciones);
            //    mensaje = "Se ha solicitado la actualización del presupuesto.";
            //}

            return new JsonResult() { Data = mensaje, JsonRequestBehavior = JsonRequestBehavior.AllowGet };

        }

    }
}
