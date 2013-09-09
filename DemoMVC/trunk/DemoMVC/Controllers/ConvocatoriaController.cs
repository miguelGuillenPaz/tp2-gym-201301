using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web.Mvc;
using DemoMVC.Models;
using System.Collections;

namespace DemoMVC.Controllers
{
    public class ConvocatoriaController : Controller
    {
        public IFormsAuthenticationService FormsService { get; set; }
        private GRH_Entities _entities;
        private readonly string[] _seleccione = new[] { string.Empty, "--Seleccione--" };
        //
        // GET: /Convocatoria/

        public ActionResult Index()
        {
            _entities = new GRH_Entities();
            var convocatoria = (from r in _entities.GRH_Convocatoria select r).ToList();
            return View(convocatoria);
        }

        //
        // GET: /Convocatoria/Participar

        public ActionResult Participar()
        {
            _entities = new GRH_Entities();
            var idPostulante = Convert.ToInt32(ConfigurationManager.AppSettings["IdPostulante"]);
            Session["IdPostulante"] = idPostulante;

            var postulante = (from r in _entities.GRH_Postulante where r.IdPostulante == idPostulante select r).FirstOrDefault();

            if (FormsService == null) { FormsService = new FormsAuthenticationService(); }
            if (postulante != null) FormsService.SignIn(postulante.GRH_Persona.Nombre,true);


            var dtNow = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            var convocatorias =
                (from r in _entities.GRH_Convocatoria select r).Where(
                    f => f.FechaInicio <= dtNow && f.FechaFin >= dtNow).ToList();
            
            return View(convocatorias);
        }        

        //
        // GET: /Convocatoria/Detalle/5

        public ActionResult Detalle(int id)
        {
            _entities = new GRH_Entities();            
            var convocatoria = (from r in _entities.GRH_Convocatoria where r.IdConvocatoria == id select r).FirstOrDefault();
            return View(convocatoria);
        }

        [HttpPost]
        public ActionResult Detalle(int id, FormCollection collection)
        {

            _entities = new GRH_Entities();
            var convocatoriaPostulante = new GRH_ConvocatoriaPostulante
                {
                    IdConvocatoria = id,
                    IdPostulante = Convert.ToInt32(Session["IdPostulante"]),
                    FechaPostulacion = DateTime.Now
                };
            _entities.AddToGRH_ConvocatoriaPostulante(convocatoriaPostulante);
            _entities.SaveChanges();

            return Redirect("/Convocatoria/Participar");
            //return View(convocatoria);
        }

        //
        // GET: /Convocatoria/Crear

        public ActionResult Crear()
        {
            _entities = new GRH_Entities();
            ViewData["Perfil"] = Perfil();
            return View();
        }

        //
        // POST: /Convocatoria/Crear

        [HttpPost]
        public ActionResult Crear(FormCollection collection)
        {
            _entities = new GRH_Entities();
            try
            {
                var titulo = collection["Titulo"].ToUpper();
                var detalle = collection["Detalle"];
                var fechaInicio = new DateTime(
                    Convert.ToInt32(collection["FechaInicio"].Substring(0, 4)),
                    Convert.ToInt32(collection["FechaInicio"].Substring(5, 2)),
                    Convert.ToInt32(collection["FechaInicio"].Substring(8, 2))
                    );
                var fechaFin = new DateTime(
                    Convert.ToInt32(collection["FechaFin"].Substring(0, 4)),
                    Convert.ToInt32(collection["FechaFin"].Substring(5, 2)),
                    Convert.ToInt32(collection["FechaFin"].Substring(8, 2))
                    );
                var cantidad = Convert.ToInt32(collection["CantidadVacantes"]);
                var idPerfil = Convert.ToInt32(collection["IdPerfil"]);

                var convocatoria = new GRH_Convocatoria
                {
                    Titulo = titulo,
                    Detalle = detalle,
                    FechaInicio = fechaInicio,
                    FechaFin = fechaFin,
                    CantidadVacantes = cantidad,
                    IdPerfil = idPerfil
                };
                _entities.AddToGRH_Convocatoria(convocatoria);
                _entities.SaveChanges();

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /Convocatoria/Editar/5

        public ActionResult Editar(int id)
        {
            _entities = new GRH_Entities();

            ViewData["Perfil"] = Perfil();
            var convocatoria = (from r in _entities.GRH_Convocatoria where r.IdConvocatoria == id select r).FirstOrDefault();
            return View(convocatoria);
        }

        //
        // POST: /Convocatoria/Editar/5

        [HttpPost]
        public ActionResult Editar(int id, FormCollection collection)
        {
            _entities = new GRH_Entities();

            try
            {
                var titulo = collection["Titulo"].ToUpper();
                var detalle = collection["Detalle"];
                var fechaInicio = new DateTime(
                    Convert.ToInt32(collection["FechaInicio"].Substring(0, 4)),
                    Convert.ToInt32(collection["FechaInicio"].Substring(5, 2)),
                    Convert.ToInt32(collection["FechaInicio"].Substring(8, 2))
                    );
                var fechaFin = new DateTime(
                    Convert.ToInt32(collection["FechaFin"].Substring(0, 4)),
                    Convert.ToInt32(collection["FechaFin"].Substring(5, 2)),
                    Convert.ToInt32(collection["FechaFin"].Substring(8, 2))
                    );
                var cantidad = Convert.ToInt32(collection["CantidadVacantes"]);
                var idPerfil = Convert.ToInt32(collection["IdPerfil"]);

                var res = (from r in _entities.GRH_Convocatoria where r.IdConvocatoria == id select r).FirstOrDefault();
                if (res != null)
                {
                    res.Titulo = titulo;
                    res.Detalle = detalle;
                    res.FechaInicio = fechaInicio;
                    res.FechaFin = fechaFin;
                    res.CantidadVacantes = cantidad;
                    res.IdPerfil = idPerfil;
                    _entities.SaveChanges();
                }

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        public virtual ActionResult Eliminar(int id)
        {
            _entities = new GRH_Entities();
            var res = (from r in _entities.GRH_Convocatoria where r.IdConvocatoria == id select r).FirstOrDefault();
            if (res != null)
            {
                _entities.DeleteObject(res);
                _entities.SaveChanges();
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = true },
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

        private IEnumerable Perfil()
        {

            var resultado = CargaInicial();

            var lista = (from r in _entities.GRH_Perfil select r);

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.IdPerfil + string.Empty, Text = item.Descripcion };
                resultado.Add(selListItem);
            }

            return resultado;
        }
    }
}
