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
    public class PresupuestoObraController : Controller
    {
        // BD GYM
        private IGPCPresupuestoRepository EFPresupuesto;
        private IGPCPartidaRespository EFPartida;
        private IGPCHistoricoAprobacionesRepository EFHistoricoAprobaciones;
        private IGPCNotificacionesRepository EFNotificaciones;
        private IGPCSolicitudesRepository EFSolicitudes;
        private IGPCCronogramaRepository EFCronograma;

        public PresupuestoObraController(
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


        public ActionResult AprobarPresupuesto()
        {
            return View();
        }

        public ActionResult ListarPresupuestos()
        {
            var presupuestos = EFPresupuesto.Presupuestos.Where(x => x.IDEstado == EstadosParameters.Pendiente_de_Aprobacion_por_el_Asesor_del_Cliente).ToList();

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

        public ActionResult ListarPartidas(int PresupuestoID)
        {
            var presupuesto = EFPresupuesto.PresupuestoObraPorID(PresupuestoID);

            var PartidasModel = new List<PartidasModel>();

            var partidas = EFPartida.Partidas.Where(x => x.IDPresupuestoObra == PresupuestoID).ToList();

            partidas.ForEach((partida) =>
            {
                var PartidaModel = new PartidasModel();

                ModelCopier.CopyModel(partida, PartidaModel);

                var categorias = from c in partida.GPC_DetallePartida.Where(x => x.GPC_Categoria != null)
                                 select new
                                 {
                                     ID = c.GPC_Categoria.IDCategoria,
                                     Nombre = c.GPC_Categoria.Nombre
                                 };

                var CategoriasModel = new List<CategoriaModel>();

                categorias.Distinct().ToList().ForEach((categoria) =>
                {
                    var CategoriaModel = new CategoriaModel();
                    ModelCopier.CopyModel(categoria, CategoriaModel);
                    CategoriasModel.Add(CategoriaModel);
                });

                CategoriasModel.ForEach((CategoriaModel) =>
                {
                    var DetallePartidasModel = new List<DetallePartidaModel>();

                    partida.GPC_DetallePartida.ToList().ForEach((detallePartida) =>
                    {
                        if (CategoriaModel.IDCategoria == detallePartida.GPC_Categoria.IDCategoria)
                        {
                            var DetallePartidaModel = new DetallePartidaModel();

                            ModelCopier.CopyModel(detallePartida, DetallePartidaModel);

                            DetallePartidaModel.Nombre = detallePartida.GPC_APU.Nombre;
                            DetallePartidaModel.UM = detallePartida.GPC_APU.UM;
                            DetallePartidasModel.Add(DetallePartidaModel);
                        }
                    });

                    CategoriaModel.DetallePartidasModel = DetallePartidasModel;
                });

                PartidaModel.CategoriasModel = CategoriasModel;
                PartidasModel.Add(PartidaModel);

            });

            return View(PartidasModel);
        }

        public ActionResult ListarCategorias(int PartidaID)
        {
            var partida = EFPartida.PartidaPorID(PartidaID);

            var categorias = from c in partida.GPC_DetallePartida.Where(x => x.GPC_Categoria != null)
                             select new
                             {
                                 ID = c.GPC_Categoria.IDCategoria,
                                 Nombre = c.GPC_Categoria.Nombre
                             };

            var CategoriasModel = new List<CategoriaModel>();

            categorias.Distinct().ToList().ForEach((categoria) =>
            {
                var CategoriaModel = new CategoriaModel();

                ModelCopier.CopyModel(categoria, CategoriaModel);
                CategoriasModel.Add(CategoriaModel);
            });

            return View(CategoriasModel);
        }

        public ActionResult ListarItems(int PartidaID, int CategoriaID)
        {
            var detallePartidas = EFPartida.DetallePartidas.Where(x => x.IDPartida == PartidaID && x.IDCategoria == CategoriaID).ToList();
            var dtoDetallePartidas = new List<DetallePartidaModel>();

            detallePartidas.ForEach((detallePartida) =>
            {
                var DetallePartidaModel = new DetallePartidaModel();
                ModelCopier.CopyModel(detallePartida, DetallePartidaModel);
                DetallePartidaModel.Nombre = detallePartida.GPC_APU.Nombre;
                DetallePartidaModel.UM = detallePartida.GPC_APU.UM;
                dtoDetallePartidas.Add(DetallePartidaModel);

            });

            return View(dtoDetallePartidas);
        }

        public ActionResult ListarCronograma(int PresupuestoID)
        {
            var presupuesto = EFPresupuesto.PresupuestoObraPorID(PresupuestoID);
            var CrongramaModel = new CronogramaModel();
            var cronograma = EFCronograma.Cronogramas.Where(x => x.IDPresupuestoObra == PresupuestoID).FirstOrDefault();

            if (cronograma != null)
            {
                ModelCopier.CopyModel(cronograma, CrongramaModel);
            }

            var ActividadesModel = new List<ActividadModel>();

            cronograma.GPC_ActividadObra.ToList().ForEach((Actividad) =>
            {
                var ActividadModel = new ActividadModel();
                ModelCopier.CopyModel(Actividad, ActividadModel);
                ActividadesModel.Add(ActividadModel);

            });

            CrongramaModel.ActividadesModel = ActividadesModel;
            return View(CrongramaModel);
        }

        [HttpPost]
        public JsonResult CambiarEstado(int PresupuestoID, int Estado, string Observacion)
        {
            var presupuesto = EFPresupuesto.Presupuestos.ToList().FirstOrDefault(x => x.IDPresupuestoObra == PresupuestoID);
            presupuesto.IDEstado = Estado;
            presupuesto.FechaCambioEstado = DateTime.Now;
            presupuesto.UsuarioCambioEstado = "Morgan";
            EFPresupuesto.ActualizarPresupuesto(presupuesto);

            String mensaje = "";

            // aprobar y rechazar
            if (Estado == EstadosParameters.Aprobado || Estado == EstadosParameters.Rechazado)
            {
                var historicoAprobacion = new GPC_HistoricoAprobacion
                {
                    FechaRegistro = DateTime.Now,
                    Observacion = Observacion,
                    IDPresupuestoObra = presupuesto.IDPresupuestoObra,
                    IDUsuario = 2,
                    IDEstado = Estado
                };
                EFHistoricoAprobaciones.ActualizarHistoricoAprobaciones(historicoAprobacion);

                if (Estado == EstadosParameters.Aprobado)
                {
                    mensaje = "La Aprobación ha sido realizada.";
                }
                else if (Estado == EstadosParameters.Rechazado)
                {
                    mensaje = "Se ha rechazado el presupuesto correctamente.";
                }
            }

            // solicitar anular
            if (Estado == EstadosParameters.En_Solicitud_de_Anulacion)
            {
                var solicitudes = new GPC_Solicitud
                {
                    FechaRegistro = DateTime.Now,
                    Observacion = Observacion,
                    IDPresupuestoObra = presupuesto.IDPresupuestoObra,
                    IDEstado = Estado,
                    IDUsuario = 2,
                    IDTipoSolicitud = 1
                };
                EFSolicitudes.ActualizarSolicitudes(solicitudes);
                mensaje = "Se ha solicitado la anulación del presupuesto.";
            }

            var notificaciones = new GPC_Notificacion
            {
                FechaRegistro = DateTime.Now,
                Observacion = Observacion,
                IDPresupuestoObra = presupuesto.IDPresupuestoObra
            };
            EFNotificaciones.ActualizarNotificaciones(notificaciones);

            return new JsonResult() { Data = mensaje, JsonRequestBehavior = JsonRequestBehavior.AllowGet };

        }
    }
}
