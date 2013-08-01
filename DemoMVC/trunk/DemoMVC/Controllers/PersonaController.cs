using System;
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
        private readonly string[] _seleccione = new[] { "0", "--Seleccione--" };

        //public ActionResult RegistrarPostulante(int id)
        //{
        //    _entities = new GRH_Entities();

        //    ViewData["EstadoCivil"] = EstadoCivil();
        //    ViewData["Pais"] = Pais();
        //    ViewData["TipoDocumento"] = TipoDocumento();
        //    ViewData["Especialidad"] = Especialidad();
        //    ViewData["NivelEducativo"] = NivelEducativo();
        //    ViewData["SituacionEstudio"] = SituacionEstudio();
        //    var persona = (from r in _entities.GRH_Persona where r.idPersona == id select r).FirstOrDefault();
        //    return View(persona);
        //}

        public ActionResult Mostrar(int? id)
        {
            _entities = new GRH_Entities();

            ViewData["EstadoCivil"] = EstadoCivil();
            ViewData["Pais"] = Pais();
            ViewData["TipoDocumento"] = TipoDocumento();
            ViewData["Especialidad"] = Especialidad();
            ViewData["NivelEducativo"] = NivelEducativo();
            ViewData["SituacionEstudio"] = SituacionEstudio();
            var persona = (from r in _entities.GRH_Persona where r.idPersona == id select r).FirstOrDefault();
            return View(persona);
        }

        public ActionResult Editar(int id)
        {
            _entities = new GRH_Entities();

            ViewData["EstadoCivil"] = EstadoCivil();
            ViewData["Pais"] = Pais();
            ViewData["TipoDocumento"] = TipoDocumento();            
            var persona = (from r in _entities.GRH_Persona where r.idPersona == id select r).FirstOrDefault();
            return View(persona);
        }


        private int StartPersona()
        {
            _entities = new GRH_Entities();
            var persona = new GRH_Persona
                    {
                        nombre = string.Empty,
                        apellidoMaterno = string.Empty,
                        apellidoPaterno = string.Empty,
                    };
            _entities.AddToGRH_Persona(persona);
            _entities.SaveChanges();
            return persona.idPersona;
        }

        #region Documento
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
            return Json(data: new { result = true },
                        behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        public virtual ActionResult SetDocumento(int idPersona, int idDocumento, int idTipoDocumento, string numeroDocumento)
        {
            bool resultado;
            if (idPersona == 0)
                idPersona = StartPersona();

            _entities = new GRH_Entities();
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
            return Json(data: new { result = resultado, Persona = idPersona, Documento = idDocumento },
                        behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }
        #endregion

        #region Telefono
        public virtual ActionResult DelTelefono(int idTelefono)
        {
            _entities = new GRH_Entities();
            var res = (from r in _entities.GRH_Telefono where r.idTelefono == idTelefono select r).FirstOrDefault();
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

        public virtual ActionResult SetTelefono(int idPersona, int idTelefono, string numeroTelefono)
        {
            bool resultado;
            if (idPersona == 0)
                idPersona = StartPersona();

            _entities = new GRH_Entities();
            if (idTelefono == 0)
            {
                var documento = new GRH_Telefono
                {
                    idPersona = idPersona,                    
                    nroTelefono = numeroTelefono
                };
                _entities.AddToGRH_Telefono(documento);
                _entities.SaveChanges();
                idTelefono = documento.idTelefono;
                resultado = true;
            }
            else
            {
                var res = (from r in _entities.GRH_Telefono where r.idTelefono == idTelefono select r).FirstOrDefault();
                if (res != null)
                {
                    res.idPersona = idPersona;                    
                    res.nroTelefono = numeroTelefono;
                    _entities.SaveChanges();
                    resultado = true;
                }
                else
                {
                    resultado = false;
                }
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = resultado, Persona = idPersona, Telefono = idTelefono },
                        behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }
        #endregion

        #region Correo
        public virtual ActionResult DelCorreo(int idCorreo)
        {
            _entities = new GRH_Entities();
            var res = (from r in _entities.GRH_Correo where r.idCorreo == idCorreo select r).FirstOrDefault();
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

        public virtual ActionResult SetCorreo(int idPersona, int idCorreo, string cuentaCorreo)
        {
            bool resultado;
            if (idPersona == 0)
                idPersona = StartPersona();

            _entities = new GRH_Entities();
            if (idCorreo == 0)
            {
                var documento = new GRH_Correo
                {
                    idPersona = idPersona,
                    cuentaCorreo = cuentaCorreo
                };
                _entities.AddToGRH_Correo(documento);
                _entities.SaveChanges();
                idCorreo = documento.idCorreo;
                resultado = true;
            }
            else
            {
                var res = (from r in _entities.GRH_Correo where r.idCorreo == idCorreo select r).FirstOrDefault();
                if (res != null)
                {
                    res.idPersona = idPersona;
                    res.cuentaCorreo = cuentaCorreo;
                    _entities.SaveChanges();
                    resultado = true;
                }
                else
                {
                    resultado = false;
                }
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = resultado, Persona = idPersona, Correo = idCorreo },
                        behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }
        #endregion


        #region IdiomaPersona
        public virtual ActionResult DelIdiomaPersona(int idIdiomaPersona)
        {
            _entities = new GRH_Entities();
            var res = (from r in _entities.GRH_IdiomaPersona where r.idIdiomaPersona == idIdiomaPersona select r).FirstOrDefault();
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

        public virtual ActionResult SetIdiomaPersona(int idPersona, int idIdiomaPersona, int idIdioma, int idNivelIdioma, bool nativo)
        {
            bool resultado;
            if (idPersona == 0)
                idPersona = StartPersona();

            _entities = new GRH_Entities();
            if (idIdiomaPersona == 0)
            {
                var idioma = new GRH_IdiomaPersona
                {
                    idPersona = idPersona,
                    idIdioma = idIdioma,
                    idNivelIdioma = idNivelIdioma,
                    nativo = nativo
                };
                _entities.AddToGRH_IdiomaPersona(idioma);
                _entities.SaveChanges();
                idIdiomaPersona = idioma.idIdiomaPersona;
                resultado = true;
            }
            else
            {
                var res = (from r in _entities.GRH_IdiomaPersona where r.idIdiomaPersona == idIdiomaPersona select r).FirstOrDefault();
                if (res != null)
                {
                    res.idPersona = idPersona;
                    res.idIdioma = idIdioma;
                    res.idNivelIdioma = idNivelIdioma;
                    res.nativo = nativo;
                    _entities.SaveChanges();
                    resultado = true;
                }
                else
                {
                    resultado = false;
                }
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = resultado, Persona = idPersona, IdiomaPersona = idIdiomaPersona },
                        behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }
        #endregion


        #region Experiencia Laboral

        public virtual ActionResult DelExperienciaLaboral(int idExperienciaLaboral)
        {
            _entities = new GRH_Entities();
            var res = (from r in _entities.GRH_ExperienciaLaboral where r.idExperienciaLaboral == idExperienciaLaboral select r).FirstOrDefault();
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

        public virtual ActionResult SetExperienciaLaboral(int idPersona, int idExperienciaLaboral, string fechaInicio, string fechaFin, string conocimientos, string cargo, string empresa)
        {
            bool resultado;
            if (idPersona == 0)
                idPersona = StartPersona();

            _entities = new GRH_Entities();
            if (idExperienciaLaboral == 0)
            {
                var experienciaLaboral = new GRH_ExperienciaLaboral
                {
                    idPersona = idPersona,
                    conocimientos = conocimientos,
                    cargo = cargo,
                    empresa = empresa
                };
                if (!string.IsNullOrEmpty(fechaInicio))
                    experienciaLaboral.fechaInicio = new DateTime(Convert.ToInt32(fechaInicio.Substring(0, 4)),
                                                                  Convert.ToInt32(fechaInicio.Substring(5, 2)),
                                                                  Convert.ToInt32(fechaInicio.Substring(8, 2)));
                if (!string.IsNullOrEmpty(fechaFin))
                    experienciaLaboral.FechaFin = new DateTime(Convert.ToInt32(fechaFin.Substring(0, 4)),
                                            Convert.ToInt32(fechaFin.Substring(5, 2)),
                                            Convert.ToInt32(fechaFin.Substring(8, 2)));

                _entities.AddToGRH_ExperienciaLaboral(experienciaLaboral);
                _entities.SaveChanges();
                idExperienciaLaboral = experienciaLaboral.idExperienciaLaboral;
                resultado = true;
            }
            else
            {
                var res = (from r in _entities.GRH_ExperienciaLaboral where r.idExperienciaLaboral == idExperienciaLaboral select r).FirstOrDefault();
                if (res != null)
                {
                    res.idPersona = idPersona;
                    if (!string.IsNullOrEmpty(fechaInicio))
                        res.fechaInicio = new DateTime(Convert.ToInt32(fechaInicio.Substring(0, 4)),
                                                       Convert.ToInt32(fechaInicio.Substring(5, 2)),
                                                       Convert.ToInt32(fechaInicio.Substring(8, 2)));
                    if (!string.IsNullOrEmpty(fechaFin))
                        res.FechaFin = new DateTime(Convert.ToInt32(fechaFin.Substring(0, 4)),
                                                    Convert.ToInt32(fechaFin.Substring(5, 2)),
                                                    Convert.ToInt32(fechaFin.Substring(8, 2)));
                    res.conocimientos = conocimientos;
                    res.cargo = cargo;
                    res.empresa = empresa;
                    _entities.SaveChanges();
                    resultado = true;
                }
                else
                {
                    resultado = false;
                }
            }


            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = resultado, Persona = idPersona, ExperienciaLaboral = idExperienciaLaboral },
                        behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        #endregion

        #region Estudio Realizado

        public virtual ActionResult DelEstudioRealizado(int idEstudioRealizado)
        {
            _entities = new GRH_Entities();
            var res = (from r in _entities.GRH_EstudioRealizado where r.idEstudioRealizado == idEstudioRealizado select r).FirstOrDefault();
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

        public virtual ActionResult SetEstudioRealizado(int idPersona, int idEstudioRealizado,int idEspecialidad,int idNivel, int idSituacion, string centroEstudio, string fechaInicio, string fechaFin, string nombreEstudio)
        {
            bool resultado;
            if (idPersona == 0)
                idPersona = StartPersona();

            _entities = new GRH_Entities();
            if (idEstudioRealizado == 0)
            {
                var estudioRealizado = new GRH_EstudioRealizado
                {
                    idPersona = idPersona,
                    idEspecialidad = idEspecialidad,
                    idNivelEducativo = idNivel,
                    idSituacionEstudio = idSituacion,
                    centroEstudio = centroEstudio,
                    nombreEstudio = nombreEstudio
                };
                if (!string.IsNullOrEmpty(fechaInicio))
                    estudioRealizado.fechaInicio = new DateTime(Convert.ToInt32(fechaInicio.Substring(0, 4)),
                                                                  Convert.ToInt32(fechaInicio.Substring(5, 2)),
                                                                  Convert.ToInt32(fechaInicio.Substring(8, 2)));
                if (!string.IsNullOrEmpty(fechaFin))
                    estudioRealizado.fechaFin = new DateTime(Convert.ToInt32(fechaFin.Substring(0, 4)),
                                            Convert.ToInt32(fechaFin.Substring(5, 2)),
                                            Convert.ToInt32(fechaFin.Substring(8, 2)));

                _entities.AddToGRH_EstudioRealizado(estudioRealizado);
                _entities.SaveChanges();
                idEstudioRealizado = estudioRealizado.idEstudioRealizado;
                resultado = true;
            }
            else
            {
                var res = (from r in _entities.GRH_EstudioRealizado where r.idEstudioRealizado == idEstudioRealizado select r).FirstOrDefault();
                if (res != null)
                {
                    res.idPersona = idPersona;
                    res.idEspecialidad = idEspecialidad;
                    res.idNivelEducativo = idNivel;
                    res.idSituacionEstudio = idSituacion;
                    res.centroEstudio = centroEstudio;
                    res.nombreEstudio = nombreEstudio;
                    if (!string.IsNullOrEmpty(fechaInicio))
                        res.fechaInicio = new DateTime(Convert.ToInt32(fechaInicio.Substring(0, 4)),
                                                       Convert.ToInt32(fechaInicio.Substring(5, 2)),
                                                       Convert.ToInt32(fechaInicio.Substring(8, 2)));
                    else
                        res.fechaInicio = null;

                    if (!string.IsNullOrEmpty(fechaFin))
                        res.fechaFin = new DateTime(Convert.ToInt32(fechaFin.Substring(0, 4)),
                                                    Convert.ToInt32(fechaFin.Substring(5, 2)),
                                                    Convert.ToInt32(fechaFin.Substring(8, 2)));
                    else
                        res.fechaFin = null;
                    
                    _entities.SaveChanges();
                    resultado = true;
                }
                else
                {
                    resultado = false;
                }
            }


            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = resultado, Persona = idPersona, EstudioRealizado = idEstudioRealizado },
                        behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }

        #endregion

        #region Tablas Paramétricas
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

        private IEnumerable Especialidad()
        {

            var resultado = new List<SelectListItem>();

            var lista = (from r in _entities.GRH_Especialidad select r);

            resultado.Add(new SelectListItem
            {
                Value = _seleccione[0],
                Text = _seleccione[1]
            });

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.idEspecialidad.ToString(CultureInfo.InvariantCulture), Text = item.descripcion };
                resultado.Add(selListItem);
            }

            return resultado;
        }

        private IEnumerable NivelEducativo()
        {

            var resultado = new List<SelectListItem>();

            var lista = (from r in _entities.GRH_NivelEducativo select r);

            resultado.Add(new SelectListItem
            {
                Value = _seleccione[0],
                Text = _seleccione[1]
            });

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.idNivelEducativo.ToString(CultureInfo.InvariantCulture), Text = item.descripcion };
                resultado.Add(selListItem);
            }

            return resultado;
        }

        private IEnumerable SituacionEstudio()
        {

            var resultado = new List<SelectListItem>();

            var lista = (from r in _entities.GRH_SituacionEstudio select r);

            resultado.Add(new SelectListItem
            {
                Value = _seleccione[0],
                Text = _seleccione[1]
            });

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.idSituacionEstudio.ToString(CultureInfo.InvariantCulture), Text = item.descripcion };
                resultado.Add(selListItem);
            }

            return resultado;
        }

        private IEnumerable NivelIdioma()
        {

            var resultado = new List<SelectListItem>();

            var lista = (from r in _entities.GRH_NivelIdioma select r);

            resultado.Add(new SelectListItem
            {
                Value = _seleccione[0],
                Text = _seleccione[1]
            });

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.idNivelIdioma.ToString(CultureInfo.InvariantCulture), Text = item.descripcion };
                resultado.Add(selListItem);
            }

            return resultado;
        }
        #endregion
    }
}
