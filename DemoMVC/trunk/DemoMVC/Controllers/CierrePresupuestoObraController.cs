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

    }
}
