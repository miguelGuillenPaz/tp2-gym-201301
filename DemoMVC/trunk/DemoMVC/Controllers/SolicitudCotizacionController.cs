using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using GYM.SIG.Business;
using GYM.SIG.Entity;
using Microsoft.Reporting.WebForms;

namespace DemoMVC.Controllers
{
    public class SolicitudCotizacionController : Controller
    {
        //
        // GET: /SolicitudCotizacion/

        public ActionResult Index()
        {
            return View();
        }

        public JsonResult InicializarValores()
        {
            try
            {
                Session["proveedoresSolicitud"] = null;
                Session["requerimientosSolicitud"] = null;
                return Json(new { response = new { error = true, mensaje = "" } }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { response = new { error = true, msgsistema = ex.ToString() } }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult Grabar(DateTime fecSolCotizacino, DateTime fechaVencimiento, int codTServ, String descSolCotizacion, int codSolCotizacion)
        {
            try
            {
                SolicitudCotizacion solicitud = new SolicitudCotizacion();
                solicitud.codSolCotizacion = codSolCotizacion;
                solicitud.fecSolCotizacino = fecSolCotizacino;
                solicitud.fechaVencimiento = fechaVencimiento;
                solicitud.descSolCotizacion = descSolCotizacion;
                solicitud.codTServ = codTServ;
                solicitud.codEstado = 1;

                List<DetalleSolicitudRequerimiento> requerimientosSolicitud = new List<DetalleSolicitudRequerimiento>();
                List<DetalleRequerimiento> requerimientos = (List<DetalleRequerimiento>)Session["requerimientosSolicitud"];
                foreach (var requerimiento in requerimientos)
                {
                    DetalleSolicitudRequerimiento solicitudRequerimiento = new DetalleSolicitudRequerimiento();
                    solicitudRequerimiento.codPro = requerimiento.codPro;
                    solicitudRequerimiento.codReq = requerimiento.codReq;
                    solicitudRequerimiento.codcorDetReq = requerimiento.codcorDetReq;
                    requerimientosSolicitud.Add(solicitudRequerimiento);
                }

                List<SolicitudProveedorTipoServicio> proveedoresSolicitud = new List<SolicitudProveedorTipoServicio>();
                List<Proveedor> proveedores = (List<Proveedor>)Session["proveedoresSolicitud"];
                foreach (var proveedor in proveedores)
                {
                    SolicitudProveedorTipoServicio solicitudProveedor = new SolicitudProveedorTipoServicio();
                    solicitudProveedor.codProv = proveedor.codProv;
                    solicitudProveedor.codTServ = codTServ;
                    proveedoresSolicitud.Add(solicitudProveedor);
                }

                solicitud.codSolCotizacion = SolicitudCotizacionCN.Instancia.GrabarSolicitud(solicitud, proveedoresSolicitud, requerimientosSolicitud);
                return Json(new { response = new { error = false, mensaje = "La solicitud se ha registrado correctamente.", codSolCotizacion = solicitud.codSolCotizacion } }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { response = new { error = true, mensaje = "La solicitud no se pudo registrar, intente en unos momentos.", msgsistema = ex.ToString() } }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult BuscarSolicitudProveedores(int o, int l, int codProv, int codTServ, FormCollection collection)
        {
            try
            {
                int codSolCotizacion = collection["codSolCotizacion"] == "" ? 0 : int.Parse(collection["codSolCotizacion"]);
                var solicitudes = SolicitudProveedorTipoServicioCN.Instancia.listarporSolicitud(codSolCotizacion, codTServ, codProv);

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
                    else if (orderby.Equals("razsocPro"))
                    {
                        if (order.Equals("asc")) solicitudes = solicitudes.OrderBy(s => s.razsocPro).ToList();
                        else solicitudes = solicitudes.OrderByDescending(s => s.razsocPro).ToList();
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

        public JsonResult Anular(int codSolCotizacion)
        {
            try
            {
                SolicitudCotizacionCN.Instancia.CambiarEstado(codSolCotizacion, 3);
                return Json(new { response = new { error = false, mensaje = "La solicitud de cotización ha sido anulado correctamente." } }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { response = new { error = true, mensaje = "La solicitud no se pudo anular, intente en unos momentos.", msgsistema = ex.ToString() } }, JsonRequestBehavior.AllowGet);
            }
        }

        public FileResult ExportarSolicitudes(String tipoFecha, String fechaInicio, String fechaFin, int codPro, String nomPro, int codTServ, String descTServ, int codEstado, String desEstado, String codSolCotizacion, String codReq)
        {
            int codSolicitud = codSolCotizacion == "" ? 0 : int.Parse(codSolCotizacion);
            int codRequerimiento = codReq == "" ? 0 : int.Parse(codReq);

            DateTime inicio = default(DateTime);
            if (fechaInicio != "") inicio = DateTime.Parse(fechaInicio);

            DateTime fin = default(DateTime);
            if (fechaFin != "") fin = DateTime.Parse(fechaFin);

            var solicitudes = SolicitudCotizacionCN.Instancia.ObtenerSolicitudes(tipoFecha, inicio, fin, codPro, codTServ, codEstado, codSolicitud, codRequerimiento);
            int i = 1;
            foreach (var item in solicitudes) item.numero = i++;

            ReportDataSource data = new ReportDataSource();
            data.Name = "DataSet1";
            data.Value = solicitudes;

            ReportViewer report = new ReportViewer();
            report.LocalReport.ReportPath = Server.MapPath("~\\Reports\\ListaSolicitudes.rdlc");
            report.LocalReport.DataSources.Add(data);

            List<ReportParameter> parametros = new List<ReportParameter>();

            ReportParameter param1 = new ReportParameter("codSolCotizacion", codSolCotizacion == "" ? "-" : codSolCotizacion);
            parametros.Add(param1);

            ReportParameter param2 = new ReportParameter("nomPro", codPro == 0 ? "-" : nomPro);
            parametros.Add(param2);

            ReportParameter param3 = new ReportParameter("descTServ", codTServ == 0 ? "-" : descTServ);
            parametros.Add(param3);

            ReportParameter param4 = new ReportParameter("codReq", codReq == "" ? "-" : codReq);
            parametros.Add(param4);

            ReportParameter param5 = new ReportParameter("estado", codEstado == 0 ? "-" : desEstado);
            parametros.Add(param5);

            ReportParameter param6 = new ReportParameter("fechaActual", "Fecha de Generación: " + DateTime.Now.ToString("dd/MM/yyyy hh:mm"));
            parametros.Add(param6);

            string leyendaFecha = "";
            if (tipoFecha != "todos")
            {
                string[] expresion = new string[1];
                expresion[0] = "fecha";
                leyendaFecha = "Fecha de " + tipoFecha.Split(expresion, StringSplitOptions.None)[1];
            }
            ReportParameter param7 = new ReportParameter("fechaBusqueda", tipoFecha == "todos" ? "" : "Del " + fechaInicio + " al " + fechaFin + " (por " + leyendaFecha + ")");
            parametros.Add(param7);

            report.LocalReport.SetParameters(parametros);
            report.LocalReport.Refresh();

            byte[] bytes = report.LocalReport.Render("Excel");
            return File(bytes, "xls", "Lista de solicitudes de cotizacion.xls");
        }

        public JsonResult EliminarRequerimiento(int codReq, int codcorDetReq, int codPro, int codSolCotizacion = 0, int codSolDet = 0)
        {
            try
            {
                DetalleCotizacion detalle = DetalleCotizacionCN.Instancia.ObtenerPorSolicitud(codSolCotizacion, codSolDet);
                if (detalle == null)
                {
                    List<DetalleRequerimiento> requerimientos = (List<DetalleRequerimiento>)Session["requerimientosSolicitud"];
                    requerimientos.RemoveAll(r => r.codReq == codReq && r.codcorDetReq == codcorDetReq && r.codPro == codPro);
                    Session["requerimientosSolicitud"] = requerimientos;
                    return Json(new { response = new { error = false, mensaje = "El requerimiento ha sido eliminado de la solicitud." } }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { response = new { error = true, mensaje = "El detalle esta presente en una cotización (" + detalle.desEstado + ") no puede ser eliminado de la solicitud." } }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                return Json(new { response = new { error = true, mensaje = "La acción no se pudo realizar, intente en unos momentos.", msgsistema = ex.ToString() } }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult EliminarProveedores(FormCollection collection, int length)
        {
            try
            {
                List<Proveedor> proveedores = (List<Proveedor>)Session["proveedoresSolicitud"];
                int codProv = 0;
                String[] Ids = collection["lista[]"].Split(',');
                for (int i = 0; i < length; i++)
                {
                    codProv = int.Parse(Ids[i]);
                    proveedores.RemoveAll(p => p.codProv == codProv);
                }

                Session["proveedoresSolicitud"] = proveedores;
                String mensaje = "Los proveedores han sido eliminados de la solicitud";
                if (length == 1) mensaje = "El proveedor ha sido eliminado de la solicitud.";

                return Json(new { response = new { error = false, mensaje = mensaje } }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { response = new { error = true, mensaje = "La acción no se pudo realizar, intente en unos momentos.", msgsistema = ex.ToString() } }, JsonRequestBehavior.AllowGet);
            }
        }

    }
}
