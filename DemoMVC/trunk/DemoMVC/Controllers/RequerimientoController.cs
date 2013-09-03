using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using GYM.SIG.Business;
using GYM.SIG.Entity;

namespace DemoMVC.Controllers
{
    public class RequerimientoController : Controller
    {
        //
        // GET: /Requerimiento/

        public ActionResult Index()
        {
            return View();
        }

        public ViewResult ObtenerDeSolicitud(FormCollection collection, int codSolCotizacion = 0)
        {
            try
            {
                List<DetalleRequerimiento> lista;
                if (Session["requerimientosSolicitud"] == null) lista = DetalleRequerimientoCN.Instancia.listaporSolicitud(codSolCotizacion);
                else lista = (List<DetalleRequerimiento>)Session["requerimientosSolicitud"];

                var orderby = collection["orderby"];
                var order = collection["order"];
                if (order != null)
                {
                    if (orderby.Equals("nomPro"))
                    {
                        if (order.Equals("asc")) lista = lista.OrderBy(r => r.nomPro).ToList();
                        else lista = lista.OrderByDescending(r => r.nomPro).ToList();
                    }
                    else if (orderby.Equals("codReq"))
                    {
                        if (order.Equals("asc")) lista = lista.OrderBy(r => r.codReq).ToList();
                        else lista = lista.OrderByDescending(r => r.codReq).ToList();
                    }
                    else if (orderby.Equals("desReq"))
                    {
                        if (order.Equals("asc")) lista = lista.OrderBy(r => r.desReq).ToList();
                        else lista = lista.OrderByDescending(r => r.desReq).ToList();
                    }
                    else if (orderby.Equals("desServicio"))
                    {
                        if (order.Equals("asc")) lista = lista.OrderBy(r => r.desServicio).ToList();
                        else lista = lista.OrderByDescending(r => r.desServicio).ToList();
                    }
                    else if (orderby.Equals("descUM"))
                    {
                        if (order.Equals("asc")) lista = lista.OrderBy(r => r.descUM).ToList();
                        else lista = lista.OrderByDescending(r => r.descUM).ToList();
                    }
                    else if (orderby.Equals("canDetReq"))
                    {
                        if (order.Equals("asc")) lista = lista.OrderBy(r => r.canDetReq).ToList();
                        else lista = lista.OrderByDescending(r => r.canDetReq).ToList();
                    }
                }

                int k = 1;
                foreach (var item in lista) item.numero = k++;

                Session["requerimientosSolicitud"] = lista;
                ViewData["Mensaje"] = "";
                return View("RequerimientosSolicitud", lista);
            }
            catch (Exception ex)
            {
                ViewData["Mensaje"] = ex.ToString();
                return View("RequerimientosSolicitud");
            }
        }

        public ViewResult RequerimientosSolicitud(FormCollection collection, int length)
        {
            try
            {
                List<DetalleRequerimiento> requerimientos;
                if (Session["requerimientosSolicitud"] == null) requerimientos = new List<DetalleRequerimiento>();
                else requerimientos = (List<DetalleRequerimiento>)Session["requerimientosSolicitud"];

                for (int i = 0; i < length; i++)
                {
                    DetalleRequerimiento item = new DetalleRequerimiento();
                    item.codReq = int.Parse(collection["lista[" + i + "][codReq]"]);
                    item.codcorDetReq = int.Parse(collection["lista[" + i + "][codcorDetReq]"]);
                    item.codPro = int.Parse(collection["lista[" + i + "][codPro]"]);
                    item.canDetReq = int.Parse(collection["lista[" + i + "][canDetReq]"]);
                    item.descUM = collection["lista[" + i + "][descUM]"];
                    item.desServicio = collection["lista[" + i + "][desServicio]"];
                    item.nomPro = collection["lista[" + i + "][nomPro]"];
                    item.desReq = collection["lista[" + i + "][desReq]"];

                    if (requerimientos.Where(r => r.codReq == item.codReq && r.codcorDetReq == item.codcorDetReq && r.codPro == item.codPro).Count() == 0)
                        requerimientos.Add(item);
                }

                int k = 1;
                foreach (var item in requerimientos) item.numero = k++;
                Session["requerimientosSolicitud"] = requerimientos;
                ViewData["Mensaje"] = "";
                return View(requerimientos);
            }
            catch (Exception ex)
            {
                ViewData["Mensaje"] = ex.ToString();
                return View();
            }
        }

        public JsonResult listarporSolicitud(int o, int l, int codSolCotizacion, FormCollection collection)
        {
            try
            {
                var lista = DetalleSolicitudRequerimientoCN.Instancia.ObtenerPorcodSolCotizacion(codSolCotizacion, 0);

                var orderby = collection["orderby"];
                var order = collection["order"];
                if (order != null)
                {
                    if (orderby.Equals("codReq"))
                    {
                        if (order.Equals("asc")) lista = lista.OrderBy(r => r.codReq).ToList();
                        else lista = lista.OrderByDescending(r => r.codReq).ToList();
                    }
                    else if (orderby.Equals("nomPro"))
                    {
                        if (order.Equals("asc")) lista = lista.OrderBy(r => r.nomPro).ToList();
                        else lista = lista.OrderByDescending(r => r.nomPro).ToList();
                    }
                    else if (orderby.Equals("desServicio"))
                    {
                        if (order.Equals("asc")) lista = lista.OrderBy(r => r.desServicio).ToList();
                        else lista = lista.OrderByDescending(r => r.desServicio).ToList();
                    }
                    else if (orderby.Equals("desReq"))
                    {
                        if (order.Equals("asc")) lista = lista.OrderBy(r => r.desReq).ToList();
                        else lista = lista.OrderByDescending(r => r.desReq).ToList();
                    }
                    else if (orderby.Equals("descUM"))
                    {
                        if (order.Equals("asc")) lista = lista.OrderBy(r => r.descUM).ToList();
                        else lista = lista.OrderByDescending(r => r.descUM).ToList();
                    }
                    else if (orderby.Equals("canDetReq"))
                    {
                        if (order.Equals("asc")) lista = lista.OrderBy(r => r.canDetReq).ToList();
                        else lista = lista.OrderByDescending(r => r.canDetReq).ToList();
                    }
                }

                var model = lista.Skip(o).Take(l);
                int i = 1;
                foreach (var item in model) item.numero = i++;

                return Json(new { response = new { count = lista.Count, data = model } }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { response = new { count = 0, data = "", mensaje = ex.ToString() } }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult listarPendientes(int o, int l, int codPro, int codTServ, FormCollection collection)
        {
            try
            {
                List<DetalleRequerimiento> requerimientos;
                if (Session["requerimientosSolicitud"] == null) requerimientos = new List<DetalleRequerimiento>();
                else requerimientos = (List<DetalleRequerimiento>)Session["requerimientosSolicitud"];

                int codReq = collection["codReq"] == "" ? 0 : int.Parse(collection["codReq"]);
                var lista = DetalleRequerimientoCN.Instancia.listarPendientes(codPro, codTServ, codReq);
                foreach (var item in requerimientos)
                {
                    lista.RemoveAll(r => r.codReq == item.codReq && r.codcorDetReq == item.codcorDetReq && r.codPro == item.codPro);
                }

                var orderby = collection["orderby"];
                var order = collection["order"];
                if (order != null)
                {
                    if (orderby.Equals("codReq"))
                    {
                        if (order.Equals("asc")) lista = lista.OrderBy(r => r.codReq).ToList();
                        else lista = lista.OrderByDescending(r => r.codReq).ToList();
                    }
                    else if (orderby.Equals("nomPro"))
                    {
                        if (order.Equals("asc")) lista = lista.OrderBy(r => r.nomPro).ToList();
                        else lista = lista.OrderByDescending(r => r.nomPro).ToList();
                    }
                    else if (orderby.Equals("desReq"))
                    {
                        if (order.Equals("asc")) lista = lista.OrderBy(r => r.desReq).ToList();
                        else lista = lista.OrderByDescending(r => r.desReq).ToList();
                    }
                    else if (orderby.Equals("desServicio"))
                    {
                        if (order.Equals("asc")) lista = lista.OrderBy(r => r.desServicio).ToList();
                        else lista = lista.OrderByDescending(r => r.desServicio).ToList();
                    }
                    else if (orderby.Equals("descUM"))
                    {
                        if (order.Equals("asc")) lista = lista.OrderBy(r => r.descUM).ToList();
                        else lista = lista.OrderByDescending(r => r.descUM).ToList();
                    }
                    else if (orderby.Equals("canDetReq"))
                    {
                        if (order.Equals("asc")) lista = lista.OrderBy(r => r.canDetReq).ToList();
                        else lista = lista.OrderByDescending(r => r.canDetReq).ToList();
                    }
                }

                var model = lista.Skip(o).Take(l);
                return Json(new { response = new { count = lista.Count, data = model } }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { response = new { count = 0, data = "", mensaje = ex.ToString() } }, JsonRequestBehavior.AllowGet);
            }
        }

    }
}
