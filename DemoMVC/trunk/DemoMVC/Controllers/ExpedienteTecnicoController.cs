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
using DemoMVC.Helpers;

namespace GYM.SIC.GPC.Controllers
{
    public class ExpedienteTecnicoController : Controller
    { 
        // BD GYM
        private IGPCPresupuestoRepository EFPresupuesto;
        private IGPCPartidaRespository EFPartida;
        private IGPCCronogramaRepository EFCronograma;
        private IGPCExpedienteTecnicoRepository EFExpedienteTecnico;

        public ExpedienteTecnicoController(
            IGPCPresupuestoRepository EFPresupuesto,
            IGPCPartidaRespository EFPartida,
            IGPCCronogramaRepository EFCronograma,
            IGPCExpedienteTecnicoRepository EFExpedienteTecnico)
        {
            this.EFPresupuesto = EFPresupuesto;
            this.EFPartida = EFPartida;
            this.EFCronograma = EFCronograma;
            this.EFExpedienteTecnico = EFExpedienteTecnico; 
        }
      

        public ActionResult RegistrarExpedienteTecnico()
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
                                     IDCategoria = c.GPC_Categoria.IDCategoria,
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
                                 IDCategoria = c.GPC_Categoria.IDCategoria,
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
