using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using GYM.SIG.Business;
using GYM.SIG.Entity;

namespace DemoMVC.Controllers
{
    public class ProveedorController : Controller
    {
        //
        // GET: /Proveedor/

        public ActionResult Index()
        {
            return View();
        }

        public ViewResult ObtenerDeSolicitud(FormCollection collection, int codSolCotizacion = 0)
        {
            try
            {
                List<Proveedor> proveedores;
                if (Session["proveedoresSolicitud"] == null) proveedores = ProveedorCN.Instancia.listaporSolicitud(codSolCotizacion);
                else proveedores = (List<Proveedor>)Session["proveedoresSolicitud"];

                var order = collection["order"];
                var orderby = collection["orderby"];
                if (order != null)
                {
                    if (orderby.Equals("codProv"))
                    {
                        if (order.Equals("asc")) proveedores = proveedores.OrderBy(p => p.codProv).ToList();
                        else proveedores = proveedores.OrderByDescending(p => p.codProv).ToList();
                    }
                    else if (orderby.Equals("rucPro"))
                    {
                        if (order.Equals("asc")) proveedores = proveedores.OrderBy(p => p.rucPro).ToList();
                        else proveedores = proveedores.OrderByDescending(p => p.rucPro).ToList();
                    }
                    else if (orderby.Equals("razsocPro"))
                    {
                        if (order.Equals("asc")) proveedores = proveedores.OrderBy(p => p.razsocPro).ToList();
                        else proveedores = proveedores.OrderByDescending(p => p.razsocPro).ToList();
                    }
                    else if (orderby.Equals("contactoProTServ"))
                    {
                        if (order.Equals("asc")) proveedores = proveedores.OrderBy(p => p.contactoProTServ).ToList();
                        else proveedores = proveedores.OrderByDescending(p => p.contactoProTServ).ToList();
                    }
                    else if (orderby.Equals("emailProTServ"))
                    {
                        if (order.Equals("asc")) proveedores = proveedores.OrderBy(p => p.emailProTServ).ToList();
                        else proveedores = proveedores.OrderByDescending(p => p.emailProTServ).ToList();
                    }
                    else if (orderby.Equals("calificacion"))
                    {
                        if (order.Equals("asc")) proveedores = proveedores.OrderBy(p => p.calificacion).ToList();
                        else proveedores = proveedores.OrderByDescending(p => p.calificacion).ToList();
                    }
                }

                int k = 1;
                foreach (var item in proveedores) item.numero = k++;
                Session["proveedoresSolicitud"] = proveedores;
                ViewData["Mensaje"] = "";
                return View("ProveedoresSolicitud", proveedores);
            }
            catch (Exception ex)
            {
                ViewData["Mensaje"] = ex.ToString();
                return View("ProveedoresSolicitud");
            }
        }

        public ViewResult ProveedoresSolicitud(FormCollection collection, int length)
        {
            try
            {
                List<Proveedor> proveedores;
                if (Session["proveedoresSolicitud"] == null) proveedores = new List<Proveedor>();
                else proveedores = (List<Proveedor>)Session["proveedoresSolicitud"];

                for (int i = 0; i < length; i++)
                {
                    Proveedor item = new Proveedor();
                    item.codProv = int.Parse(collection["lista[" + i + "][codProv]"]);
                    item.rucPro = collection["lista[" + i + "][rucPro]"];
                    item.razsocPro = collection["lista[" + i + "][razsocPro]"];
                    item.calificacion = int.Parse(collection["lista[" + i + "][calificacion]"]);
                    item.emailProTServ = collection["lista[" + i + "][emailProTServ]"];
                    item.contactoProTServ = collection["lista[" + i + "][contactoProTServ]"];

                    if (proveedores.Where(r => r.codProv == item.codProv).Count() == 0)
                        proveedores.Add(item);
                }

                int k = 1;
                foreach (var item in proveedores) item.numero = k++;
                Session["proveedoresSolicitud"] = proveedores;
                ViewData["Mensaje"] = "";
                return View(proveedores);
            }
            catch (Exception ex)
            {
                ViewData["Mensaje"] = ex.ToString();
                return View();
            }
        }

        public JsonResult listaporServicio(int o, int l, int codTServ, FormCollection collection)
        {
            try
            {
                var tipoBusqueda = collection["tipoBusqueda"];
                var expresion = collection["expresion"];
                var proveedores = ProveedorCN.Instancia.listaporServicio(tipoBusqueda, expresion, codTServ);

                var order = collection["order"];
                var orderby = collection["orderby"];
                if (order != null)
                {
                    if (orderby.Equals("codProv"))
                    {
                        if (order.Equals("asc")) proveedores = proveedores.OrderBy(p => p.codProv).ToList();
                        else proveedores = proveedores.OrderByDescending(p => p.codProv).ToList();
                    }
                    else if (orderby.Equals("rucPro"))
                    {
                        if (order.Equals("asc")) proveedores = proveedores.OrderBy(p => p.rucPro).ToList();
                        else proveedores = proveedores.OrderByDescending(p => p.rucPro).ToList();
                    }
                    else if (orderby.Equals("razsocPro"))
                    {
                        if (order.Equals("asc")) proveedores = proveedores.OrderBy(p => p.razsocPro).ToList();
                        else proveedores = proveedores.OrderByDescending(p => p.razsocPro).ToList();
                    }
                    else if (orderby.Equals("contactoProTServ"))
                    {
                        if (order.Equals("asc")) proveedores = proveedores.OrderBy(p => p.contactoProTServ).ToList();
                        else proveedores = proveedores.OrderByDescending(p => p.contactoProTServ).ToList();
                    }
                    else if (orderby.Equals("emailProTServ"))
                    {
                        if (order.Equals("asc")) proveedores = proveedores.OrderBy(p => p.emailProTServ).ToList();
                        else proveedores = proveedores.OrderByDescending(p => p.emailProTServ).ToList();
                    }
                    else if (orderby.Equals("calificacion"))
                    {
                        if (order.Equals("asc")) proveedores = proveedores.OrderBy(p => p.calificacion).ToList();
                        else proveedores = proveedores.OrderByDescending(p => p.calificacion).ToList();
                    }
                    else if (orderby.Equals("situacion"))
                    {
                        if (order.Equals("asc")) proveedores = proveedores.OrderBy(p => p.situacion).ToList();
                        else proveedores = proveedores.OrderByDescending(p => p.situacion).ToList();
                    }
                }

                var model = proveedores.Skip(o).Take(l);
                int k = 1;
                foreach (var item in model) item.numero = k++;
                return Json(new { response = new { count = proveedores.Count, data = model } }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { response = new { count = 0, data = "", mensaje = ex.ToString() } }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult listar(int o, int l, FormCollection collection)
        {
            try
            {

                var proveedores = ProveedorCN.Instancia.listartodos();

                var order = collection["order"];
                var orderby = collection["orderby"];
                if (order != null)
                {
                    if (orderby.Equals("codProv"))
                    {
                        if (order.Equals("asc")) proveedores = proveedores.OrderBy(p => p.codProv).ToList();
                        else proveedores = proveedores.OrderByDescending(p => p.codProv).ToList();
                    }
                    else if (orderby.Equals("rucPro"))
                    {
                        if (order.Equals("asc")) proveedores = proveedores.OrderBy(p => p.rucPro).ToList();
                        else proveedores = proveedores.OrderByDescending(p => p.rucPro).ToList();
                    }
                    else if (orderby.Equals("razsocPro"))
                    {
                        if (order.Equals("asc")) proveedores = proveedores.OrderBy(p => p.razsocPro).ToList();
                        else proveedores = proveedores.OrderByDescending(p => p.razsocPro).ToList();
                    }
                    else if (orderby.Equals("estadoPro"))
                    {
                        if (order.Equals("asc")) proveedores = proveedores.OrderBy(p => p.estadoPro).ToList();
                        else proveedores = proveedores.OrderByDescending(p => p.estadoPro).ToList();
                    }
                }

                var model = proveedores.Skip(o).Take(l);
                return Json(new { response = new { count = proveedores.Count, data = model } }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { response = new { count = 0, data = "", mensaje = ex.ToString() } }, JsonRequestBehavior.AllowGet);
            }
        }

    }
}
