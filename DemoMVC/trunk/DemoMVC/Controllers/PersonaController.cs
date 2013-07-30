using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Web.Mvc;
using System.Linq;
using DemoMVC.Models;

namespace DemoMVC.Controllers
{
    public class PersonaController : Controller
    {
        //
        // GET: /Persona/
        private GRH_Entities _entities;
        private readonly string[] _seleccione = new[] {"0", "--Seleccione--"};

        public ActionResult RegistrarPostulante(int? id)
        {
            _entities= new GRH_Entities();

            ViewData["EstadoCivil"] = EstadoCivil();
            ViewData["Pais"] = Pais();
            ViewData["TipoDocumento"] = TipoDocumento();
            var persona = (from r in _entities.GRH_Persona where r.idPersona == id select r).FirstOrDefault();
            return View(persona);
        }

        public virtual ActionResult DelDocumento(int idDocumento)
        {
            _entities = new GRH_Entities();
            var res = (from r in _entities.GRH_Documento where r.idDocumento == idDocumento select r).FirstOrDefault();            
            if (res != null)
            {
                _entities.DeleteObject(res);
                _entities.SaveChanges();            
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = true},
                        behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        public virtual ActionResult SetDocumento(int idPersona,int idDocumento, int idTipoDocumento, string numeroDocumento)
        {
            var resultado = false;

            _entities = new GRH_Entities();

            if (idPersona == 0)
            {
                var persona = new GRH_Persona
                    {                        
                        nombre = string.Empty,
                        apellidoMaterno = string.Empty,
                        apellidoPaterno = string.Empty,                        
                    };
                _entities.AddToGRH_Persona(persona);
                _entities.SaveChanges();
                idPersona = persona.idPersona;
            }

            if (idDocumento == 0)
            {
                var documento = new GRH_Documento
                    {
                        idPersona = idPersona,
                        idTipoDocumento = idTipoDocumento,
                        nroDocumento = numeroDocumento
                    };
                _entities.AddToGRH_Documento(documento);
                _entities.SaveChanges();
                idDocumento = documento.idDocumento;
                resultado = true;
            }
            else
            {
                var res = (from r in _entities.GRH_Documento where r.idDocumento == idDocumento select r).FirstOrDefault();
                if (res != null)
                {
                    res.idPersona = idPersona;
                    res.idTipoDocumento = idTipoDocumento;
                    res.nroDocumento = numeroDocumento;
                    _entities.SaveChanges();
                    resultado = true;
                }
                else
                {
                    resultado = false;
                }
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new {result = resultado, Persona = idPersona, Documento = idDocumento},
                        behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        private IEnumerable EstadoCivil()
        {
           
            var resultado = new List<SelectListItem>();

            var lista = (from r in _entities.GRH_EstadoCivil select r);

            resultado.Add(new SelectListItem
                {
                    Value = _seleccione[0],
                    Text = _seleccione[1]
                });

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.idEstadoCivil.ToString(CultureInfo.InvariantCulture), Text = item.descripcion };
                resultado.Add(selListItem);
            }

            return resultado;
        }

        private IEnumerable Pais()
        {

            var resultado = new List<SelectListItem>();

            var lista = (from r in _entities.GRH_Pais select r);

            resultado.Add(new SelectListItem
            {
                Value = _seleccione[0],
                Text = _seleccione[1]
            });

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.idPais.ToString(CultureInfo.InvariantCulture), Text = item.descripcion };
                resultado.Add(selListItem);
            }

            return resultado;
        }

        private IEnumerable TipoDocumento()
        {

            var resultado = new List<SelectListItem>();

            var lista = (from r in _entities.GRH_TipoDocumento select r);

            resultado.Add(new SelectListItem
            {
                Value = _seleccione[0],
                Text = _seleccione[1]
            });

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.idTipoDocumento.ToString(CultureInfo.InvariantCulture), Text = item.descripcion };
                resultado.Add(selListItem);
            }

            return resultado;
        }
    }
}
