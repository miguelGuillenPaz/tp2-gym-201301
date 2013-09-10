using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.Mvc;
using GYM.SIG.Business;
using GYM.SIG.Entity;
using Microsoft.Reporting.WebForms;
using DemoMVC.Models;

namespace DemoMVC.Controllers
{
    public class CotizacionController : Controller
    {

        private GSC_Entities _entities;
        private readonly string[] _seleccione = new[] { string.Empty, "--Seleccione--" };
        //
        // GET: /Cotizacion/

        public ActionResult Index()
        {
            var fechaHoy = DateTime.Now;

            var fechaInicioMes = fechaHoy.AddDays(-fechaHoy.Day + 1).ToString("dd/MM/yyyy");
            var fechaFinMes = fechaHoy.AddMonths(1).AddDays(-fechaHoy.Day).ToString("dd/MM/yyyy");

            ViewData["fechaInicioMes"] = fechaInicioMes;
            ViewData["fechaFinMes"] = fechaFinMes;
            return View();
        }

        public ActionResult Solicitud()
        {
            var fechaHoy = DateTime.Now;

            var fechaInicioMes = fechaHoy.AddDays(-fechaHoy.Day + 1).ToString("dd/MM/yyyy");
            var fechaFinMes = fechaHoy.AddMonths(1).AddDays(-fechaHoy.Day).ToString("dd/MM/yyyy");

            ViewData["fechaInicioMes"] = fechaInicioMes;
            ViewData["fechaFinMes"] = fechaFinMes;
            return View();
        }

        public ActionResult Evaluar()
        {
            _entities = new GSC_Entities();
            ViewData["Proyecto"] = Proyecto();
            ViewData["Estado"] = Estado();
            ViewData["TipoServicio"] = TipoServicio();
            var solicitud = (from r in _entities.GSC_SolicitudCotizacion select r).ToList();
            return View(solicitud);
        }

        public JsonResult BuscarCotizaciones(int o, int l, String tipoFecha, int codPro, int codProv, int codTServ, int codEstado, FormCollection collection)
        {
            try
            {
                int codSolCotizacion = collection["codSolCotizacion"] == "" ? 0 : int.Parse(collection["codSolCotizacion"]);
                int codCotizacion = collection["codCotizacion"] == "" ? 0 : int.Parse(collection["codCotizacion"]);

                DateTime inicio = default(DateTime);
                if (collection["fechaInicio"] != "") inicio = DateTime.Parse(collection["fechaInicio"]);

                DateTime fin = default(DateTime);
                if (collection["fechaFin"] != "") fin = DateTime.Parse(collection["fechaFin"]);

                var solicitudes = CotizacionCN.Instancia.ObtenerCotizaciones(tipoFecha, inicio, fin, codPro, codTServ, codEstado, codSolCotizacion, codProv, codCotizacion);

                var order = collection["order"];
                var orderby = collection["orderby"];
                if (order != null)
                {
                    if (orderby.Equals("codSolCotizacion"))
                    {
                        if (order.Equals("asc")) solicitudes = solicitudes.OrderBy(s => s.codSolCotizacion).ToList();
                        else solicitudes = solicitudes.OrderByDescending(s => s.codSolCotizacion).ToList();
                    }
                    else if (orderby.Equals("codCotizacion"))
                    {
                        if (order.Equals("asc")) solicitudes = solicitudes.OrderBy(s => s.codCotizacion).ToList();
                        else solicitudes = solicitudes.OrderByDescending(s => s.codCotizacion).ToList();
                    }
                    else if (orderby.Equals("fechaInicio"))
                    {
                        if (order.Equals("asc")) solicitudes = solicitudes.OrderBy(s => s.fechaInicio).ToList();
                        else solicitudes = solicitudes.OrderByDescending(s => s.fechaInicio).ToList();
                    }
                    else if (orderby.Equals("descTServ"))
                    {
                        if (order.Equals("asc")) solicitudes = solicitudes.OrderBy(s => s.descTServ).ToList();
                        else solicitudes = solicitudes.OrderByDescending(s => s.descTServ).ToList();
                    }
                    else if (orderby.Equals("razsocPro"))
                    {
                        if (order.Equals("asc")) solicitudes = solicitudes.OrderBy(s => s.razsocPro).ToList();
                        else solicitudes = solicitudes.OrderByDescending(s => s.razsocPro).ToList();
                    }
                    else if (orderby.Equals("fechaFin"))
                    {
                        if (order.Equals("asc")) solicitudes = solicitudes.OrderBy(s => s.fechaFin).ToList();
                        else solicitudes = solicitudes.OrderByDescending(s => s.fechaFin).ToList();
                    }
                    else if (orderby.Equals("descMon"))
                    {
                        if (order.Equals("asc")) solicitudes = solicitudes.OrderBy(s => s.descMon).ToList();
                        else solicitudes = solicitudes.OrderByDescending(s => s.descMon).ToList();
                    }
                    else if (orderby.Equals("monto"))
                    {
                        if (order.Equals("asc")) solicitudes = solicitudes.OrderBy(s => s.monto).ToList();
                        else solicitudes = solicitudes.OrderByDescending(s => s.monto).ToList();
                    }
                    else if (orderby.Equals("estado"))
                    {
                        if (order.Equals("asc")) solicitudes = solicitudes.OrderBy(s => s.estado).ToList();
                        else solicitudes = solicitudes.OrderByDescending(s => s.estado).ToList();
                    }
                }

                var model = solicitudes.Skip(o).Take(l);
                int i = 1;
                foreach (var item in model)
                {
                    item.numero = i++;
                    if (item.pdfCotizacion.Length > 0) item.pdfCotizacion = Url.Content("~/ArchivosCotizacion/" + item.codCotizacion + "/" + item.pdfCotizacion);
                }

                return Json(new { response = new { count = solicitudes.Count, data = model } }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { response = new { count = 0, data = "", mensaje = ex.ToString() } }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult SubirArchivo(HttpPostedFileBase file, FormCollection collection)
        {
            try
            {
                var pdfCotizacion = Path.GetFileName(file.FileName);
                int codCotizacion = int.Parse(collection["codCotizacion"]);
                var path = Server.MapPath("~/ArchivosCotizacion/" + codCotizacion);
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }

                path = Path.Combine(path, pdfCotizacion);
                if (System.IO.File.Exists(path))
                    System.IO.File.Delete(path);

                file.SaveAs(path);

                Cotizacion cotizacion = CotizacionCN.Instancia.GetByPrimaryKey(codCotizacion);
                cotizacion.pdfCotizacion = pdfCotizacion;
                cotizacion.eliminarDetalle = false;
                CotizacionCN.Instancia.Update(cotizacion);
                return Json(new { error = false, mensaje = "El archivo se ha subido exitosamente.", path = Url.Content("~/ArchivosCotizacion/" + codCotizacion + "/" + pdfCotizacion) }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { error = true, mensaje = ex.ToString() }, JsonRequestBehavior.AllowGet);
            }
        }

        public ViewResult DetallesCotizacion(int codSolCotizacion, Boolean tomarSession, FormCollection collection, int codCotizacion = 0)
        {
            try
            {
                List<DetalleSolicitudRequerimiento> detalles;
                if (Session["detallesCotizacion"] == null || !tomarSession)
                {
                    detalles = DetalleSolicitudRequerimientoCN.Instancia.ObtenerPorcodSolCotizacion(codSolCotizacion, codCotizacion);
                }
                else
                {
                    detalles = (List<DetalleSolicitudRequerimiento>)Session["detallesCotizacion"];
                }


                var order = collection["order"];
                var orderby = collection["orderby"];

                if (order != null)
                {
                    if (orderby.Equals("desServicio"))
                    {
                        if (order.Equals("asc")) detalles = detalles.OrderBy(s => s.desServicio).ToList();
                        else detalles = detalles.OrderByDescending(s => s.desServicio).ToList();
                    }
                    else if (orderby.Equals("descUM"))
                    {
                        if (order.Equals("asc")) detalles = detalles.OrderBy(s => s.descUM).ToList();
                        else detalles = detalles.OrderByDescending(s => s.descUM).ToList();
                    }
                    else if (orderby.Equals("canDetReq"))
                    {
                        if (order.Equals("asc")) detalles = detalles.OrderBy(s => s.canDetReq).ToList();
                        else detalles = detalles.OrderByDescending(s => s.canDetReq).ToList();
                    }
                    else if (orderby.Equals("precio"))
                    {
                        if (order.Equals("asc")) detalles = detalles.OrderBy(s => s.precio).ToList();
                        else detalles = detalles.OrderByDescending(s => s.precio).ToList();
                    }
                    else if (orderby.Equals("importe"))
                    {
                        if (order.Equals("asc")) detalles = detalles.OrderBy(s => s.importe).ToList();
                        else detalles = detalles.OrderByDescending(s => s.importe).ToList();
                    }
                }

                int i = 1;
                foreach (var item in detalles) item.numero = i++;
                Session["detallesCotizacion"] = detalles;
                ViewData["Mensaje"] = "";
                return View(detalles);
            }
            catch (Exception ex)
            {
                Session["detallesCotizacion"] = new List<DetalleSolicitudRequerimiento>();
                ViewData["Mensaje"] = ex.ToString();
                return View(new List<DetalleSolicitudRequerimiento>());
            }
        }

        public JsonResult ActualizarDetalles(FormCollection collection, int length)
        {
            try
            {
                List<DetalleSolicitudRequerimiento> detalles = (List<DetalleSolicitudRequerimiento>)Session["detallesCotizacion"];

                int codSolCotizacion, codSolDet;
                for (int i = 0; i < length; i++)
                {
                    codSolCotizacion = int.Parse(collection["lista[" + i + "][codSolCotizacion]"]);
                    codSolDet = int.Parse(collection["lista[" + i + "][codSolDet]"]);
                    var detalle = detalles.Find(r => r.codSolCotizacion == codSolCotizacion && r.codSolDet == codSolDet);
                    if (detalle != null)
                    {
                        detalle.precio = Decimal.Parse(collection["lista[" + i + "][precio]"]);
                        detalle.importe = detalle.precio * detalle.canDetReq;
                    }
                }

                Session["detallesCotizacion"] = detalles;
                return Json(new { response = new { error = false, mensaje = "Los detalles han sido actualizados correctamente." } }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { response = new { error = true, mensaje = "La acción no se pudo realizar, intente en unos momentos.", msgsistema = ex.ToString() } }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult EliminarDetalle(int codSolCotizacion, int codSolDet)
        {
            try
            {
                List<DetalleSolicitudRequerimiento> detalles = (List<DetalleSolicitudRequerimiento>)Session["detallesCotizacion"];
                detalles.RemoveAll(r => r.codSolCotizacion == codSolCotizacion && r.codSolDet == codSolDet);
                Session["detallesCotizacion"] = detalles;
                return Json(new { response = new { error = false, mensaje = "El detalle ha sido eliminado de la cotización." } }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { response = new { error = true, mensaje = "La acción no se pudo realizar, intente en unos momentos.", msgsistema = ex.ToString() } }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult Grabar(DateTime fechaInicio, DateTime fechaValidez, String Comentarios, int codSolCotizacion, int codCotizacion, int codMoneda, int codProv, int codTServ, int codFormPag)
        {
            try
            {
                Cotizacion cotizacion = new Cotizacion();
                cotizacion.codCotizacion = codCotizacion;
                cotizacion.codSolCotizacion = codSolCotizacion;
                cotizacion.fechaInicio = fechaInicio;
                cotizacion.fechaFin = fechaValidez;
                cotizacion.Comentarios = Comentarios;
                cotizacion.codMoneda = codMoneda;
                cotizacion.codFormPag = codFormPag;
                cotizacion.codProv = codProv;
                cotizacion.codTServ = codTServ;
                cotizacion.estado = "C";
                cotizacion.eliminarDetalle = true;

                List<DetalleCotizacion> detalles = new List<DetalleCotizacion>();
                List<DetalleSolicitudRequerimiento> requerimientos = (List<DetalleSolicitudRequerimiento>)Session["detallesCotizacion"];
                foreach (var requerimiento in requerimientos)
                {
                    DetalleCotizacion detalleCotizacion = new DetalleCotizacion();
                    detalleCotizacion.codSolCotizacion = requerimiento.codSolCotizacion;
                    detalleCotizacion.codSolDet = requerimiento.codSolDet;
                    detalleCotizacion.codUM = requerimiento.codUM;

                    detalleCotizacion.cantidad = requerimiento.canDetReq;
                    detalleCotizacion.precio = requerimiento.precio;
                    detalleCotizacion.importe = requerimiento.importe;
                    detalles.Add(detalleCotizacion);
                }

                cotizacion.monto = requerimientos.Sum(de => de.importe);
                cotizacion.codCotizacion = CotizacionCN.Instancia.Grabar(cotizacion, detalles);
                return Json(new { response = new { error = false, mensaje = "La cotización se ha registrado correctamente.", codCotizacion = cotizacion.codCotizacion } }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { response = new { error = true, mensaje = "La cotización no se pudo registrar, intente en unos momentos.", msgsistema = ex.ToString() } }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult BuscarSolicitudes(int o, int l, String tipoFecha, int codPro, int codTServ, FormCollection collection, int filtrarEstado = -1)
        {
            try
            {
                int codEstado = int.Parse(collection["codEstado"]);
                int codSolCotizacion = collection["codSolCotizacion"] == "" ? 0 : int.Parse(collection["codSolCotizacion"]);
                int codReq = collection["codReq"] == "" ? 0 : int.Parse(collection["codReq"]);

                DateTime inicio = default(DateTime);
                if (collection["fechaInicio"] != "") inicio = DateTime.Parse(collection["fechaInicio"]);

                DateTime fin = default(DateTime);
                if (collection["fechaFin"] != "") fin = DateTime.Parse(collection["fechaFin"]);

                var solicitudes = SolicitudCotizacionCN.Instancia.ObtenerSolicitudes(tipoFecha, inicio, fin, codPro, codTServ, codEstado, codSolCotizacion, codReq, filtrarEstado);

                var order = collection["order"];
                var orderby = collection["orderby"];
                if (order != null)
                {
                    if (orderby.Equals("codSolCotizacion"))
                    {
                        if (order.Equals("asc")) solicitudes = solicitudes.OrderBy(s => s.codSolCotizacion).ToList();
                        else solicitudes = solicitudes.OrderByDescending(s => s.codSolCotizacion).ToList();
                    }
                    if (orderby.Equals("fechaSolicitud"))
                    {
                        if (order.Equals("asc")) solicitudes = solicitudes.OrderBy(s => s.fecSolCotizacino).ToList();
                        else solicitudes = solicitudes.OrderByDescending(s => s.fecSolCotizacino).ToList();
                    }
                    else if (orderby.Equals("descTServ"))
                    {
                        if (order.Equals("asc")) solicitudes = solicitudes.OrderBy(s => s.descTServ).ToList();
                        else solicitudes = solicitudes.OrderByDescending(s => s.descTServ).ToList();
                    }
                    else if (orderby.Equals("descSolCotizacion"))
                    {
                        if (order.Equals("asc")) solicitudes = solicitudes.OrderBy(s => s.descSolCotizacion).ToList();
                        else solicitudes = solicitudes.OrderByDescending(s => s.descSolCotizacion).ToList();
                    }
                    else if (orderby.Equals("desEstado"))
                    {
                        if (order.Equals("asc")) solicitudes = solicitudes.OrderBy(s => s.desEstado).ToList();
                        else solicitudes = solicitudes.OrderByDescending(s => s.desEstado).ToList();
                    }
                }

                var model = solicitudes.Skip(o).Take(l);
                int i = 1;
                foreach (var item in model) item.numero = i++;

                return Json(new { response = new { count = solicitudes.Count, data = model } }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { response = new { count = 0, data = "", mensaje = ex.ToString() } }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult Anular(int codCotizacion)
        {
            try
            {
                CotizacionCN.Instancia.CambiarEstado(codCotizacion, 3);
                return Json(new { response = new { error = false, mensaje = "La cotización ha sido anulado correctamente." } }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { response = new { error = true, mensaje = "La cotización no se pudo anular, intente en unos momentos.", msgsistema = ex.ToString() } }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult InicializarValores()
        {
            try
            {
                Session["detallesCotizacion"] = null;
                return Json(new { response = new { error = true, mensaje = "" } }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { response = new { error = true, msgsistema = ex.ToString() } }, JsonRequestBehavior.AllowGet);
            }
        }

        public FileResult ExportarCotizaciones(String tipoFecha, String fechaInicio, String fechaFin, int codPro, String nomPro, int codProv, String razsocPro, int codTServ, String descTServ, int codEstado, String desEstado, String codSolCotizacion, String codCotizacion)
        {
            int codSolicitud = codSolCotizacion == "" ? 0 : int.Parse(codSolCotizacion);
            int codCoti = codCotizacion == "" ? 0 : int.Parse(codCotizacion);

            DateTime inicio = default(DateTime);
            if (fechaInicio != "") inicio = DateTime.Parse(fechaInicio);

            DateTime fin = default(DateTime);
            if (fechaFin != "") fin = DateTime.Parse(fechaFin);

            var solicitudes = CotizacionCN.Instancia.ObtenerCotizaciones(tipoFecha, inicio, fin, codPro, codTServ, codEstado, codSolicitud, codProv, codCoti);
            int i = 1;
            foreach (var item in solicitudes) item.numero = i++;

            ReportDataSource data = new ReportDataSource();
            data.Name = "DataSet1";
            data.Value = solicitudes;

            ReportViewer report = new ReportViewer();
            report.LocalReport.ReportPath = Server.MapPath("~\\Reports\\ListaCotizaciones.rdlc");
            report.LocalReport.DataSources.Add(data);

            List<ReportParameter> parametros = new List<ReportParameter>();

            ReportParameter param1 = new ReportParameter("codSolCotizacion", codSolCotizacion == "" ? "-" : codSolCotizacion);
            parametros.Add(param1);

            ReportParameter param2 = new ReportParameter("nomPro", codPro == 0 ? "-" : nomPro);
            parametros.Add(param2);

            ReportParameter param3 = new ReportParameter("descTServ", codTServ == 0 ? "-" : descTServ);
            parametros.Add(param3);

            ReportParameter param4 = new ReportParameter("codCotizacion", codCotizacion == "" ? "-" : codCotizacion);
            parametros.Add(param4);

            ReportParameter param5 = new ReportParameter("estado", codEstado == 0 ? "-" : desEstado);
            parametros.Add(param5);

            ReportParameter param6 = new ReportParameter("fechaActual", "Fecha de Generación: " + DateTime.Now.ToString("dd/MM/yyyy hh:mm"));
            parametros.Add(param6);

            ReportParameter param7 = new ReportParameter("razsocPro", razsocPro == "" ? "-" : razsocPro);
            parametros.Add(param7);

            string leyendaFecha = "";
            if (tipoFecha != "todos")
            {
                string[] expresion = new string[1];
                expresion[0] = "fecha";
                leyendaFecha = "Fecha de " + tipoFecha.Split(expresion, StringSplitOptions.None)[1];
            }
            ReportParameter param8 = new ReportParameter("fechaBusqueda", tipoFecha == "todos" ? "" : "Del " + fechaInicio + " al " + fechaFin + " (por " + leyendaFecha + ")");
            parametros.Add(param8);

            report.LocalReport.SetParameters(parametros);
            report.LocalReport.Refresh();

            byte[] bytes = report.LocalReport.Render("Excel");
            return File(bytes, "xls", "Lista de solicitudes de cotizacion.xls");
        }

        public JsonResult EnviarSolicitudToProveedores(int codSolCotizacion)
        {
            try
            {
                List<Proveedor> proveedores = ProveedorCN.Instancia.listaporSolicitud(codSolCotizacion);
                if (proveedores.Count == 0)
                {
                    return Json(new { response = new { error = true, mensaje = "No ha registrado proveedores a la solicitud seleccionada." } }, JsonRequestBehavior.AllowGet);
                }

                List<DetalleSolicitudRequerimiento> requerimientos = DetalleSolicitudRequerimientoCN.Instancia.ObtenerPorcodSolCotizacion(codSolCotizacion, 0);
                int i = 1;
                foreach (var item in requerimientos) item.numero = i++;

                SolicitudCotizacion solicitud = SolicitudCotizacionCN.Instancia.GetByPrimaryKey(codSolCotizacion);

                ReportDataSource data = new ReportDataSource();
                data.Name = "DataSet1";
                data.Value = requerimientos;

                ReportViewer report = new ReportViewer();
                report.LocalReport.ReportPath = Server.MapPath("~\\Reports\\SolicitudCotizacion.rdlc");
                report.LocalReport.DataSources.Add(data);

                List<ReportParameter> parametros = new List<ReportParameter>();

                ReportParameter param1 = new ReportParameter("codSolCotizacion", codSolCotizacion.ToString());
                parametros.Add(param1);

                ReportParameter param2 = new ReportParameter("nomPro", solicitud.nomPro);
                parametros.Add(param2);

                ReportParameter param3 = new ReportParameter("descTServ", solicitud.descTServ);
                parametros.Add(param3);

                ReportParameter param4 = new ReportParameter("descSolCotizacion", solicitud.descSolCotizacion);
                parametros.Add(param4);

                ReportParameter param5 = new ReportParameter("fecSolCotizacino", solicitud.fechaSolicitud);
                parametros.Add(param5);

                ReportParameter param6 = new ReportParameter("fechaActual", "Fecha de Generación: " + DateTime.Now.ToString("dd/MM/yyyy hh:mm"));
                parametros.Add(param6);

                report.LocalReport.SetParameters(parametros);
                report.LocalReport.Refresh();

                byte[] bytes = report.LocalReport.Render("Pdf");
                using (FileStream fs = new FileStream(Server.MapPath("~\\Files\\Solicitud de Cotizacion.pdf"), FileMode.Create))
                {
                    fs.Write(bytes, 0, bytes.Length);
                }

                MailMessage msg = new MailMessage();

                msg.From = new MailAddress(ConfigurationManager.AppSettings["userFrom"], "Correo de Grupo 001 UPC", Encoding.UTF8);
                msg.Subject = "Solicitud de Cotización";
                msg.SubjectEncoding = Encoding.UTF8;
                msg.Body = "Saludos<br /><br /><p>La presente es para hacerle llegar la solicitud de cotización acorde al requerimiento detallado en el documento adjunto.</p>";
                msg.BodyEncoding = Encoding.UTF8;
                msg.IsBodyHtml = true;
                msg.Attachments.Add(new Attachment(Server.MapPath("~\\Files\\Solicitud de Cotizacion.pdf")));

                //List<Proveedor> proveedores = (List<Proveedor>)Session["proveedoresSolicitud"];                
                foreach (var proveedor in proveedores)
                {
                    msg.To.Add(proveedor.emailProTServ);
                }

                msg.Priority = MailPriority.High;
                SmtpClient client = new SmtpClient();
                client.Credentials = new NetworkCredential(ConfigurationManager.AppSettings["userName"], ConfigurationManager.AppSettings["userPassword"]);
                client.Host = ConfigurationManager.AppSettings["smtpServer"];
                client.EnableSsl = true;
                client.Port = 587;
                client.Send(msg);
                msg.Dispose();

                SolicitudCotizacionCN.Instancia.CambiarEstado(codSolCotizacion, 2); // cambiar estado a enviado
                return Json(new { response = new { error = false, mensaje = "La solicitud se ha enviado con éxito a los proveedores asignados." } }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { response = new { error = true, mensaje = "La solicitud no se pudo enviar, intente en unos momentos.", msgsistema = ex.ToString() } }, JsonRequestBehavior.AllowGet);
            }
        }


        public virtual ActionResult DetalleSolicitudCotizacion(int idSolicitudCotizacion)
        {

            _entities = new GSC_Entities();

            var lista = _entities.GSC_DetalleSolicitudRequerimiento.Where(f => f.IdSolicitudCotizacion == idSolicitudCotizacion)
                     .ToList();
            var table = string.Empty;
            foreach (var requerimiento in lista)
            {
                table += "<tr>";
                table += "<td>" + requerimiento.DescripSolDetalle + "</td>";
                table += "<td>" + Convert.ToDateTime(requerimiento.FecSolDetalle).ToString("yyyy-MM-dd") + "</td>";
                table += "</tr>";
            }


            // ReSharper disable RedundantArgumentName
            return Json(data: new { table },
                        behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        public virtual ActionResult DetalleCotizacion(int idSolicitudCotizacion)
        {

            _entities = new GSC_Entities();

            var lista = _entities.GSC_Cotizacion.Where(f => f.IdSolicitudCotizacion == idSolicitudCotizacion)
                     .ToList();
            var content = string.Empty;
            var i = 0;
            foreach (var cotizacion in lista)
            {
                i++;
                content += "<ul>";
                content += "<li><h2><input type=\"radio\" name=\"cotizacion\"/ value=\"" + cotizacion.IdCotizacion + "\"> Opción " + i + "</h2></li>";
                content += "<li>Proveedor: " + cotizacion.IdProveedor + "</li>";
                content += "<li>Total: " + cotizacion.Total + "</li>";
                content += "<li>Forma de Pago: " + cotizacion.GSC_FormaPago.DescripFormPag + "</li>";
                content += "</ul>";
            }


            // ReSharper disable RedundantArgumentName
            return Json(data: new { content },
                        behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        public virtual ActionResult ElegirCotizacion(int idSolicitudCotizacion, int idCotizacion)
        {
            var resultado = false;
            _entities = new GSC_Entities();

            var lista = _entities.GSC_Cotizacion.Where(f => f.IdSolicitudCotizacion == idSolicitudCotizacion)
                     .ToList();

            foreach (var cotizacion in lista)
            {
                cotizacion.IdEstado = 1;
                _entities.SaveChanges();
            }

            var item = _entities.GSC_Cotizacion.FirstOrDefault(f => f.IdCotizacion == idCotizacion);

            if (item != null)
            {
                item.IdEstado = 5;
                _entities.SaveChanges();
                resultado = true;
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { resultado },
                        behavior: JsonRequestBehavior.AllowGet);
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

        public IEnumerable Proyecto()
        {
            var entities = new GD_Entities();

            var resultado = CargaInicial();

            var lista = (from r in entities.GPP_Proyecto select r);

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.IdProyecto + string.Empty, Text = item.Nombre };
                resultado.Add(selListItem);
            }

            return resultado;
        }

        public IEnumerable Estado()
        {

            var resultado = CargaInicial();

            var lista = (from r in _entities.GSC_Estado select r);

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.IdEstado + string.Empty, Text = item.DescripEstado };
                resultado.Add(selListItem);
            }

            return resultado;
        }

        public IEnumerable TipoServicio()
        {

            var resultado = CargaInicial();

            var lista = (from r in _entities.GSC_TipoServicio select r);

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.IdTipoServicio + string.Empty, Text = item.DescripTServicio };
                resultado.Add(selListItem);
            }

            return resultado;
        }

        public static string GetProyecto(int id)
        {
            var entities = new GD_Entities();

            var item = (from r in entities.GPP_Proyecto select r).FirstOrDefault(f => f.IdProyecto == id);


            return item != null ? item.Nombre : string.Empty;
        }
    }
}
