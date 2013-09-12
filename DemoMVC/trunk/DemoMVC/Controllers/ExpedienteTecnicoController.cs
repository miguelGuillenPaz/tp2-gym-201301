using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc; 
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
            var presupuestos = EFPresupuesto.Presupuestos.Where(x => x.IDEstado == EstadosParameters.Aprobado).ToList();

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
