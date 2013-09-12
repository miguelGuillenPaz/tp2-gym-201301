using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using DemoMVC.Models;
using DemoMVC.Persistencia;
using GYM.SIG.Business;

namespace DemoMVC.Controllers
{
    public class RequerimientoController : Controller
    {
        private readonly string[] _seleccione = new[] { string.Empty, "--Seleccione--" };
        //
        // GET: /Requerimiento/

        public ActionResult Index()
        {
            List<Requerimiento> requerimiento = null;
            var requerimientoDAO = new RequerimientoDAO();
            requerimiento = requerimientoDAO.ListarRequerimiento();
            return View(requerimiento);
        }

        public ActionResult Crear()
        {
            return View();
        }

        public ActionResult Editar(int id)
        {
            ViewData["Proyecto"] = Proyecto();
            ViewData["TipoRecurso"] = TipoRecurso();
            ViewData["Prioridad"] = Prioridad();
            ViewData["UnidadMedida"] = UnidadMedida();
            ViewData["TipoServicio"] = TipoServicio();
            Requerimiento requerimiento = null;
            var requerimientoDAO = new RequerimientoDAO();
            requerimiento = requerimientoDAO.ObtenerRequerimiento(id);
            return View(requerimiento);
        }

        public ViewResult ObtenerDeSolicitud(FormCollection collection, int codSolCotizacion = 0)
        {
            try
            {
                List<GYM.SIG.Entity.DetalleRequerimiento> lista;
                if (Session["requerimientosSolicitud"] == null) lista = DetalleRequerimientoCN.Instancia.listaporSolicitud(codSolCotizacion);
                else lista = (List<GYM.SIG.Entity.DetalleRequerimiento>)Session["requerimientosSolicitud"];

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
                List<GYM.SIG.Entity.DetalleRequerimiento> requerimientos;
                if (Session["requerimientosSolicitud"] == null) requerimientos = new List<GYM.SIG.Entity.DetalleRequerimiento>();
                else requerimientos = (List<GYM.SIG.Entity.DetalleRequerimiento>)Session["requerimientosSolicitud"];

                for (int i = 0; i < length; i++)
                {
                    var item = new GYM.SIG.Entity.DetalleRequerimiento();
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
                List<GYM.SIG.Entity.DetalleRequerimiento> requerimientos;
                if (Session["requerimientosSolicitud"] == null) requerimientos = new List<GYM.SIG.Entity.DetalleRequerimiento>();
                else requerimientos = (List<GYM.SIG.Entity.DetalleRequerimiento>)Session["requerimientosSolicitud"];

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

        public IEnumerable Prioridad()
        {

            var resultado = CargaInicial();

            resultado.Add(new SelectListItem { Value = "1", Text = "Alta" });
            resultado.Add(new SelectListItem { Value = "2", Text = "Media" });
            resultado.Add(new SelectListItem { Value = "3", Text = "Baja" });

            return resultado;
        }

        public IEnumerable TipoRecurso()
        {            
            var resultado = CargaInicial();            
            
            var requerimientoDAO = new RequerimientoDAO();
            var listarTipoRecurso = requerimientoDAO.ListarTipoRecurso();

            foreach (var item in listarTipoRecurso)
            {
                var selListItem = new SelectListItem { Value = item.idTipoReq + string.Empty, Text = item.descripcion };
                resultado.Add(selListItem);
            }

            return resultado;
        }

        public IEnumerable UnidadMedida()
        {
            var entities = new GSC_Entities();

            var resultado = CargaInicial();

            var lista = (from r in entities.GSC_UnidadMedida select r);

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.IdUnidadMedida + string.Empty, Text = item.AbrviaUMedi };
                resultado.Add(selListItem);
            }

            return resultado;
        }

        public IEnumerable TipoServicio()
        {
            var entities = new GSC_Entities();

            var resultado = CargaInicial();

            var lista = (from r in entities.GSC_TipoServicio select r);

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.IdTipoServicio + string.Empty, Text = item.DescripTServicio };
                resultado.Add(selListItem);
            }

            return resultado;
        }

       
    }
}
