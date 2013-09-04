using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GYM.SIC.GPC.Repositories.S10Repository;
using GYM.SIC.GPC.Repositories.GPCRepository;
using GYM.SIC.GPC.Parameters;
using GYM.SIC.GPC.Models;
using System.IO;
using System.Text.RegularExpressions;
using DemoMVC;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Controllers
{
    public class ExpedienteTecnicoController : Controller
    {
        // BD S10
        private S10CronogramaRepository EFS10Cronograma = new S10CronogramaRepository();
        private S10PartidaRespository EFS10Partida = new S10PartidaRespository();

        // BD GYM
        private GPCPresupuestoRepository EFPresupuesto = new GPCPresupuestoRepository();
        private GPCExpedienteTecnicoRepository EFExpedienteTecnico = new GPCExpedienteTecnicoRepository();

        public ActionResult RegistrarExpedienteTecnico()
        {
            return View();
        }

        public ActionResult ListarPresupuestos()
        {
            var presupuestos = EFPresupuesto.PresupuestosModel.Where(x => x.IDEstado == EstadosParameters.Aprobado).ToList();
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

        public ActionResult ListarCronograma(int PresupuestoID)
        {
            var presupuesto = EFPresupuesto.PresupuestosModel.FirstOrDefault(x => x.ID == PresupuestoID);

            var CrongramaModel = new CronogramaModel();

            var cronograma = EFS10Cronograma.Cronogramas.Where(x => x.IDPresupuesto == PresupuestoID).FirstOrDefault();

            if (cronograma != null)
            {
                CrongramaModel.FechaInicio = cronograma.FechaInicio;
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
        public JsonResult ActualizarExpedienteTecnico(int IDPresupuesto, string Observacion, HttpPostedFileBase Archivo)
        {
            if (Archivo != null)
            {
                Regex rgx = new Regex(@"^.*\.(doc|docx|pdf)$");

                if (rgx.IsMatch(Archivo.FileName))
                {
                    var PhysicalPath = Path.Combine("C:\\Archivos\\ExpedienteTecnico", new FileInfo(Archivo.FileName).Name);

                    var ExpedienteTecnico = new GPC_ExpedienteTecnico
                    {
                        IDPresupuestoObra = IDPresupuesto,
                        RutaArchivoAnalisis = PhysicalPath,
                        NombreArchivo = new FileInfo(Archivo.FileName).Name,
                        FechaModificacion = DateTime.Now,
                        Observacion = Observacion
                    };

                    EFExpedienteTecnico.ActualizarExpedienteTecnico(ExpedienteTecnico);
                    var presupuesto = EFPresupuesto.Presupuestos.Where(x => x.IDPresupuestoObra == IDPresupuesto).FirstOrDefault();

                    presupuesto.IDEstado = EstadosParameters.Con_Expediente_Tecnico;
                    EFPresupuesto.ActualizarPresupuesto(presupuesto);

                    Archivo.SaveAs(PhysicalPath);

                }
                else
                {
                    return new JsonResult() { ContentType = "text/html", Data = "La extensión del archivo no es .doc, .docx o .pdf.", JsonRequestBehavior = JsonRequestBehavior.AllowGet };
                }
            }
            else
            {
                return new JsonResult() { ContentType = "text/html", Data = "No ha adjuntado ningún archivo.", JsonRequestBehavior = JsonRequestBehavior.AllowGet };
            }
            return new JsonResult() { ContentType = "text/html", Data = "Se ha registrado el Expediente Técnico Satisfactoriamente", JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }
    }
}
