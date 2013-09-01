using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using DemoMVC.Models;

namespace DemoMVC.Controllers
{
    public class EmpleadoController : Controller
    {
        //
        // GET: /Empleado/
        private GRH_Entities _entities;
        private readonly string[] _seleccione = new[] { string.Empty, "--Seleccione--" };

        public ActionResult Agregar()
        {
            _entities = new GRH_Entities();
            var personas = new List<GRH_Persona>();
            var postulantes = (from r in _entities.GRH_Postulante where r.Aprobado == true  select r).ToList();
            foreach (var postulante in postulantes)
            {
                var items = (from r in _entities.GRH_Persona where r.IdPersona == postulante.IdPersona && r.GRH_Empleado.Count==0 select r).ToList();
                foreach (var item in items)
                {
                    personas.Add(item);
                }
            }

            return View(personas);
        }

        public ActionResult DatosAdicionales(int id)
        {
            _entities = new GRH_Entities();
            ViewData["TipoDocumento"] = TipoDocumento();
            ViewData["TipoDerechoHabiente"] = TipoDerechoHabiente();
            var empleado = (from r in _entities.GRH_Empleado where r.IdPersona == id select r).FirstOrDefault();
            if (empleado == null)
            {                
                _entities.AddToGRH_Empleado( new GRH_Empleado {IdPersona = id});
                _entities.SaveChanges();
                empleado = (from r in _entities.GRH_Empleado where r.IdPersona == id select r).FirstOrDefault();                
            }

            return View(empleado);
        }

        public virtual ActionResult DelDerechoHabiente(int idDerechoHabiente)
        {
            _entities = new GRH_Entities();
            var res = (from r in _entities.GRH_DerechoHabiente where r.IdDerechoHabiente == idDerechoHabiente select r).FirstOrDefault();
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

        

        public virtual ActionResult SetDerechoHabiente(int idPersona, int idEmpleado, int idDerechoHabiente, string nombre, string apellidoPaterno, string apellidoMaterno, string fechaNacimiento,
            bool sexo, int idDocumento, int idTipoDocumento, string numDocumento, int idTipoDerechoHabiente)
        {
            bool resultado;
            _entities = new GRH_Entities();

            if (idPersona == 0)
            {
                var persona = new GRH_Persona()
                    {
                        Nombre = nombre,
                        ApellidoPaterno = apellidoPaterno,
                        ApellidoMaterno = apellidoPaterno,
                        FechaNacimiento = DateTime.Parse(fechaNacimiento),
                        Sexo = sexo
                    };
                _entities.AddToGRH_Persona(persona);
                _entities.SaveChanges();
                idPersona = persona.IdPersona;
            }
            else
            {
                var persona = (from r in _entities.GRH_Persona where r.IdPersona == idPersona select r).FirstOrDefault();
                if (persona != null)
                {
                    persona.Nombre = nombre;
                    persona.ApellidoPaterno = apellidoPaterno;
                    persona.ApellidoMaterno = apellidoMaterno;
                    persona.FechaNacimiento = DateTime.Parse(fechaNacimiento);
                    persona.Sexo = sexo;                    
                    _entities.SaveChanges();
                }
            }

            if (idDocumento == 0)
            {
                var documento = new GRH_Documento()
                {
                    IdPersona = idPersona,
                    IdTipoDocumento = idTipoDocumento,
                    NumeroDocumento = numDocumento
                };
                _entities.AddToGRH_Documento(documento);
                _entities.SaveChanges();
                idDocumento = documento.IdDocumento;
            }
            else
            {
                var documento = (from r in _entities.GRH_Documento where r.IdDocumento == idDocumento select r).FirstOrDefault();
                if (documento != null)
                {
                    documento.IdTipoDocumento = idTipoDocumento;
                    documento.NumeroDocumento = numDocumento;                                        
                    _entities.SaveChanges();
                }
            }

            if (idDerechoHabiente == 0)
            {
                var derechoHabiente = new GRH_DerechoHabiente
                {
                    IdPersona = idPersona,
                    IdEmpleado = idEmpleado,
                    IdTipoDerechoHabiente = idTipoDerechoHabiente
                };                
                _entities.AddToGRH_DerechoHabiente(derechoHabiente);
                _entities.SaveChanges();
                idDerechoHabiente = derechoHabiente.IdDerechoHabiente;                

                resultado = true;
            }
            else
            {
                var res = (from r in _entities.GRH_DerechoHabiente where r.IdDerechoHabiente == idDerechoHabiente select r).FirstOrDefault();
                if (res != null)
                {
                    res.IdTipoDerechoHabiente = idTipoDerechoHabiente;
                    _entities.SaveChanges();
                    resultado = true;
                }
                else
                {
                    resultado = false;
                }
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = resultado, persona = idPersona, documento = idDocumento, derechoHabiente = idDerechoHabiente },
                        behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        public virtual ActionResult DelContratoPersonal(int idContratoPersonal)
        {
            _entities = new GRH_Entities();
            var res = (from r in _entities.GRH_ContratoPersonal where r.IdContratoPersonal == idContratoPersonal select r).FirstOrDefault();
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

        public virtual ActionResult SetContratoPersonal(int idEmpleado, int idContratoPersonal, string nroContrato, string fechaInicio, string fechaFin)
        {
            bool resultado;
            
            _entities = new GRH_Entities();
            if (idContratoPersonal == 0)
            {
                var contratoPersonal = new GRH_ContratoPersonal
                {
                    IdEmpleado = idEmpleado,
                    NumeroContrato = nroContrato,
                    FechaInicio = DateTime.Parse(fechaInicio),
                    FechaFin =DateTime.Parse(fechaFin)
                };
                _entities.AddToGRH_ContratoPersonal(contratoPersonal);
                _entities.SaveChanges();
                idContratoPersonal = contratoPersonal.IdContratoPersonal;
                resultado = true;
            }
            else
            {
                var res = (from r in _entities.GRH_ContratoPersonal where r.IdContratoPersonal == idContratoPersonal select r).FirstOrDefault();
                if (res != null)
                {
                    res.IdEmpleado = idEmpleado;
                    res.NumeroContrato = nroContrato;
                    res.FechaInicio = DateTime.Parse(fechaInicio);
                    res.FechaFin = DateTime.Parse(fechaFin);
                    _entities.SaveChanges();
                    resultado = true;
                }
                else
                {
                    resultado = false;
                }
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = resultado, contratoPersonal = idContratoPersonal },
                        behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        public virtual ActionResult DelLegajo(int idLegajo)
        {
            _entities = new GRH_Entities();
            var res = (from r in _entities.GRH_Legajo where r.IdLegajo == idLegajo select r).FirstOrDefault();
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


        public virtual ActionResult Cancelar(int idEmpleado)
        {
            _entities = new GRH_Entities();
            var derechoHabientes = (from r in _entities.GRH_DerechoHabiente where r.IdEmpleado == idEmpleado select r).ToList();
            foreach (var derechoHabiente in derechoHabientes)
            {
                _entities.DeleteObject(derechoHabiente);
                _entities.SaveChanges();
            }
            var contratoPersonales = (from r in _entities.GRH_ContratoPersonal where r.IdEmpleado == idEmpleado select r).ToList();
            foreach (var contratoPersonal in contratoPersonales)
            {
                _entities.DeleteObject(contratoPersonal);
                _entities.SaveChanges();
            }
            var legajos = (from r in _entities.GRH_Legajo where r.IdEmpleado == idEmpleado select r).ToList();
            foreach (var legajo in legajos)
            {
                _entities.DeleteObject(legajo);
                _entities.SaveChanges();
            }

            var res = (from r in _entities.GRH_Empleado where r.IdEmpleado == idEmpleado select r).FirstOrDefault();
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

        public virtual ActionResult SetLegajo(int idEmpleado, int idLegajo, string nombreArchivo, string ubicacion)
        {
            bool resultado;

            _entities = new GRH_Entities();
            if (idLegajo == 0)
            {
                var legajo = new GRH_Legajo
                {
                    IdEmpleado = idEmpleado,                    
                    NombreArchivo = nombreArchivo,
                    Ubicacion = ubicacion
                };
                _entities.AddToGRH_Legajo(legajo);
                _entities.SaveChanges();
                idLegajo = legajo.IdLegajo;
                resultado = true;
            }
            else
            {
                var res = (from r in _entities.GRH_Legajo where r.IdLegajo == idLegajo select r).FirstOrDefault();
                if (res != null)
                {
                    res.IdEmpleado = idEmpleado;
                    res.NombreArchivo = nombreArchivo;
                    res.Ubicacion = ubicacion;
                    _entities.SaveChanges();
                    resultado = true;
                }
                else
                {
                    resultado = false;
                }
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = resultado, legajo = idLegajo },
                        behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        #region Tablas Paramétricas

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

        private IEnumerable TipoDocumento()
        {

            var resultado = CargaInicial();

            var lista = (from r in _entities.GRH_TipoDocumento select r);
            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.IdTipoDocumento + string.Empty, Text = item.Descripcion };
                resultado.Add(selListItem);
            }

            return resultado;
        }

        private IEnumerable TipoDerechoHabiente()
        {

            var resultado = CargaInicial();

            var lista = (from r in _entities.GRH_TipoDerechoHabiente select r);
            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.IdTipoDerechoHabiente + string.Empty, Text = item.Descripcion };
                resultado.Add(selListItem);
            }

            return resultado;
        }
        #endregion
    }
}
