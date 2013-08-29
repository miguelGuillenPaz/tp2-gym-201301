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

namespace GYM.SIC.GPC.Controllers
{
    public class PresupuestoObraController : Controller
    {
        private S10CronogramaRepository EFS10Cronograma = new S10CronogramaRepository();
        private S10PartidaRespository EFS10Partida = new S10PartidaRespository();
        private GPCPresupuestoRepository EFPresupuesto = new GPCPresupuestoRepository();
        private GPCHistoricoAprobacionesRepository EFHistoricoAprobaciones = new GPCHistoricoAprobacionesRepository();
        private GPCNotificacionesRepository EFNotificaciones = new GPCNotificacionesRepository();
        private GPCSolicitudesRepository EFSolicitudes = new GPCSolicitudesRepository();

        public ActionResult AprobarPresupuesto()
        {
            return View();
        }

        public ActionResult ListarPresupuestos()
        {
            var presupuestos = EFPresupuesto.PresupuestosModel.Where(x => x.IDEstado == EstadosParameters.Pendiente_de_Aprobacion_por_el_Asesor_del_Cliente).ToList();
            return View(presupuestos);
        }

        public ActionResult ListarDetalle(int PresupuestoID)
        {
            var presupuesto = EFPresupuesto.PresupuestosModel.FirstOrDefault(x => x.ID == PresupuestoID);
            return View(presupuesto);
        }

        public ActionResult ListarPartidas(int PresupuestoID)
        {
            var presupuesto = EFPresupuesto.PresupuestosModel.FirstOrDefault(x => x.ID == PresupuestoID);

            var PartidasModel = new List<PartidasModel>();

            var partidas = EFS10Partida.Partidas.Where(x => x.IDPresupuesto == PresupuestoID).ToList();

            partidas.ForEach((partida) =>
            {
                var PartidaModel = new PartidasModel();

                PartidaModel.ID = partida.ID;
                PartidaModel.Nombre = partida.Nombre;

                var categorias = from c in partida.S10DetallePartida.Where(x => x.S10Categoria != null)
                                 select new
                                 {
                                     ID = c.S10Categoria.ID,
                                     Nombre = c.S10Categoria.Nombre
                                 };

                var CategoriasModel = new List<CategoriaModel>();

                categorias.Distinct().ToList().ForEach((categoria) =>
                {
                    var dtoCategoria = new CategoriaModel();
                    dtoCategoria.ID = categoria.ID;
                    dtoCategoria.Nombre = categoria.Nombre;
                    CategoriasModel.Add(dtoCategoria);
                });

                CategoriasModel.ForEach((dtoCategoria) =>
                {
                    var dtoDetallePartidas = new List<DetallePartidaModel>();

                    partida.S10DetallePartida.ToList().ForEach((detallePartida) =>
                    {
                        if (dtoCategoria.ID == detallePartida.S10Categoria.ID)
                        {
                            var dtoDetallePartida = new DetallePartidaModel();

                            dtoDetallePartida.Cantidad = (Decimal)detallePartida.Cantidad;
                            dtoDetallePartida.ID = detallePartida.ID;
                            dtoDetallePartida.Nombre = detallePartida.S10APU.Nombre;
                            dtoDetallePartida.Precio = (Decimal)detallePartida.PrecioUnitarioReal;
                            dtoDetallePartida.UM = detallePartida.S10APU.UM;
                            dtoDetallePartidas.Add(dtoDetallePartida);
                        }
                    });

                    dtoCategoria.DetallePartidasModel = dtoDetallePartidas;
                });

                PartidaModel.CategoriasModel = CategoriasModel;
                PartidasModel.Add(PartidaModel);

            });

            return View(PartidasModel);
        }

        public ActionResult ListarCategorias(int PartidaID)
        {
            var partida = EFS10Partida.Partidas.Where(x => x.ID == PartidaID).ToList().FirstOrDefault();

            var categorias = from c in partida.S10DetallePartida.Where(x => x.S10Categoria != null)
                             select new
                             {
                                 ID = c.S10Categoria.ID,
                                 Nombre = c.S10Categoria.Nombre
                             };

            var CategoriasModel = new List<CategoriaModel>();

            categorias.Distinct().ToList().ForEach((categoria) =>
            {
                var dtoCategoria = new CategoriaModel();
                dtoCategoria.ID = categoria.ID;
                dtoCategoria.Nombre = categoria.Nombre;
                CategoriasModel.Add(dtoCategoria);
            });

            return View(CategoriasModel);
        }

        public ActionResult ListarItems(int PartidaID, int CategoriaID)
        {
            var partida = EFS10Partida.Partidas.Where(x => x.ID == PartidaID).ToList().FirstOrDefault();

            var detallePartidas = EFS10Partida.DetallePartidas.Where(x => x.IDPartida == PartidaID && x.IDCategoria == CategoriaID).ToList();

            var dtoDetallePartidas = new List<DetallePartidaModel>();

            detallePartidas.ForEach((detallePartida) =>
            {

                var DetallePartidaModel = new DetallePartidaModel();

                DetallePartidaModel.Cantidad = (Decimal)detallePartida.Cantidad;
                DetallePartidaModel.ID = detallePartida.ID;
                DetallePartidaModel.Nombre = detallePartida.S10APU.Nombre;
                DetallePartidaModel.Precio = (Decimal)detallePartida.PrecioUnitarioReal;
                DetallePartidaModel.UM = detallePartida.S10APU.UM;
                dtoDetallePartidas.Add(DetallePartidaModel);

            });
            
            return View(dtoDetallePartidas);
        }

        public ActionResult ListarCronograma(int PresupuestoID)
        {
            var presupuesto = EFPresupuesto.PresupuestosModel.FirstOrDefault(x => x.ID == PresupuestoID);

            var CrongramaModel = new CronogramaModel();

            var cronograma = EFS10Cronograma.Cronogramas.Where(x => x.IDPresupuesto == PresupuestoID).FirstOrDefault();

            if (cronograma != null)
            {
                CrongramaModel.Fecha = cronograma.Fecha;
                CrongramaModel.ID = cronograma.ID;
                CrongramaModel.Nombre = cronograma.Nombre;
                CrongramaModel.Responsable = cronograma.Responsable;
            }
            var ActividadesModel = new List<ActividadModel>();

            cronograma.S10Actividad.ToList().ForEach((Actividad) =>
            {
                var ActividadModel = new ActividadModel();

                ActividadModel.Fecha = Actividad.Fecha;
                ActividadModel.Hito = Actividad.Hito;
                ActividadModel.Nombre = Actividad.Nombre;
                ActividadModel.Responsable = Actividad.Responsable;
                ActividadesModel.Add(ActividadModel);

            });

            CrongramaModel.ActividadesModel = ActividadesModel;

            return View(CrongramaModel);
        }

        [HttpPost]
        public JsonResult CambiarEstado(int PresupuestoID, int Estado, string Observacion)
        {
            var presupuesto = EFPresupuesto.Presupuestos.ToList().FirstOrDefault(x => x.ID == PresupuestoID);
            presupuesto.IDEstado = Estado;
            presupuesto.FechaCambioEstado = DateTime.Now;
            presupuesto.UsuarioCambioEstado = "Morgan";
            EFPresupuesto.ActualizarPresupuesto(presupuesto);

            String mensaje = "";

            // aprobar y rechazar
            if (Estado == 6 || Estado == 3)
            {
                var historicoAprobacion = new HistoricoAprobaciones
                {
                    FechaRegistro = DateTime.Now,
                    Observaciones = Observacion,
                    IDPresupuesto = presupuesto.ID,
                    IDUsuario = 2,
                    IDEstado = Estado
                };
                EFHistoricoAprobaciones.ActualizarHistoricoAprobaciones(historicoAprobacion);

                if (Estado == 6)
                {
                    mensaje = "La Aprobación ha sido realizada.";
                }
                else if (Estado == 3)
                {
                    mensaje = "Se ha rechazado el presupuesto correctamente.";
                }

            }

            // solicitar anular
            if (Estado == 4)
            {
                var solicitudes = new Solicitudes
                {
                    FechaRegistro = DateTime.Now,
                    Observaciones = Observacion,
                    IDPresupuesto = presupuesto.ID,
                    IDEstado = Estado,
                    IDUsuario = 2,
                    IDTipoSolicitud = 1
                };
                EFSolicitudes.ActualizarSolicitudes(solicitudes);
                mensaje = "Se ha solicitado la anulación del presupuesto.";
            }

            var notificaciones = new Notificaciones
            {
                FechaRegistro = DateTime.Now,
                Observaciones = Observacion,
                IDPresupuesto = presupuesto.ID
            };
            EFNotificaciones.ActualizarNotificaciones(notificaciones);

            return new JsonResult() { Data = mensaje, JsonRequestBehavior = JsonRequestBehavior.AllowGet };

        }
    }
}
