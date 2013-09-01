using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using DemoMVC.Models;

namespace DemoMVC.Controllers
{
    public class PostulanteController : Controller
    {
        //
        // GET: /Postulante/
        private GRH_Entities _entities;
        private readonly string[] _seleccione = new[] { string.Empty, "--Seleccione--" };

        public ActionResult Detalle(int id)
        {
            _entities = new GRH_Entities();
            ViewData["TipoDocumento"] = TipoDocumento();
            ViewData["EstadoCivil"] = EstadoCivil();
            ViewData["Pais"] = Pais();
            ViewData["Especialidad"] = Especialidad();
            ViewData["NivelEducativo"] = NivelEducativo();
            ViewData["SituacionEstudio"] = SituacionEstudio();
            ViewData["NivelIdioma"] = NivelIdioma();
            ViewData["Idioma"] = Idioma();
            var persona = (from r in _entities.GRH_Persona where r.IdPersona == id select r).FirstOrDefault();
            return View(persona);
        }

        public ActionResult Crear(int? id)
        {
            _entities = new GRH_Entities();

            ViewData["EstadoCivil"] = EstadoCivil();
            ViewData["Pais"] = Pais();
            var persona = (from r in _entities.GRH_Persona where r.IdPersona == id select r).FirstOrDefault();
            return View(persona);
        }

        public ActionResult Editar(int id)
        {
            _entities = new GRH_Entities();

            ViewData["EstadoCivil"] = EstadoCivil();
            ViewData["Pais"] = Pais();
            ViewData["TipoDocumento"] = TipoDocumento();
            var persona = (from r in _entities.GRH_Persona where r.IdPersona == id select r).FirstOrDefault();
            return View(persona);
        }

        private int StartPersona()
        {
            _entities = new GRH_Entities();
            var persona = new GRH_Persona
            {
                Nombre = string.Empty,
                ApellidoMaterno = string.Empty,
                ApellidoPaterno = string.Empty,
            };
            _entities.AddToGRH_Persona(persona);
            _entities.SaveChanges();
            return persona.IdPersona;
        }

        #region Documento
        public virtual ActionResult DelDocumento(int idDocumento)
        {
            _entities = new GRH_Entities();
            var res = (from r in _entities.GRH_Documento where r.IdDocumento == idDocumento select r).FirstOrDefault();
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
            var error = string.Empty;
            if (idPersona == 0)
                idPersona = StartPersona();

            _entities = new GRH_Entities();
            if (idDocumento == 0)
            {
                //verifica que no exista el documento
                var doc = (from r in _entities.GRH_Documento
                           where
                               r.IdTipoDocumento == idTipoDocumento &&
                               r.NumeroDocumento == numeroDocumento
                           select r).FirstOrDefault();
                if (doc == null)
                {
                    var docper = (from r in _entities.GRH_Documento
                                  where
                                      r.IdTipoDocumento == idTipoDocumento &&
                                      r.IdPersona == idPersona
                                  select r).FirstOrDefault();
                    if (docper == null)
                    {
                        var documento = new GRH_Documento
                        {
                            IdPersona = idPersona,
                            IdTipoDocumento = idTipoDocumento,
                            NumeroDocumento = numeroDocumento
                        };
                        _entities.AddToGRH_Documento(documento);
                        _entities.SaveChanges();
                        idDocumento = documento.IdDocumento;
                        resultado = true;
                    }
                    else
                    {
                        error = "La persona tiene registrado el tipo de documento.";
                        resultado = false;
                    }
                }
                else
                {
                    error = "El documento fue registrado previamente";
                    resultado = false;
                }
            }
            else
            {
                var res = (from r in _entities.GRH_Documento where r.IdDocumento == idDocumento select r).FirstOrDefault();
                if (res != null)
                {
                    res.IdPersona = idPersona;
                    res.IdTipoDocumento = idTipoDocumento;
                    res.NumeroDocumento = numeroDocumento;
                    _entities.SaveChanges();
                    resultado = true;
                }
                else
                {
                    error = "No se encontro el registro a actualizar";
                    resultado = false;
                }
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = resultado, Persona = idPersona, Documento = idDocumento, Error = error },
                        behavior: JsonRequestBehavior.AllowGet);
            // ReSharper restore RedundantArgumentName
        }
        #endregion

        #region Telefono
        public virtual ActionResult DelTelefono(int idTelefono)
        {
            _entities = new GRH_Entities();
            var res = (from r in _entities.GRH_Telefono where r.IdTelefono == idTelefono select r).FirstOrDefault();
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
                    IdPersona = idPersona,
                    NumeroTelefono = numeroTelefono
                };
                _entities.AddToGRH_Telefono(documento);
                _entities.SaveChanges();
                idTelefono = documento.IdTelefono;
                resultado = true;
            }
            else
            {
                var res = (from r in _entities.GRH_Telefono where r.IdTelefono == idTelefono select r).FirstOrDefault();
                if (res != null)
                {
                    res.IdPersona = idPersona;
                    res.NumeroTelefono = numeroTelefono;
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
            var res = (from r in _entities.GRH_Correo where r.IdCorreo == idCorreo select r).FirstOrDefault();
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
                    IdPersona = idPersona,
                    CuentaCorreo = cuentaCorreo
                };
                _entities.AddToGRH_Correo(documento);
                _entities.SaveChanges();
                idCorreo = documento.IdCorreo;
                resultado = true;
            }
            else
            {
                var res = (from r in _entities.GRH_Correo where r.IdCorreo == idCorreo select r).FirstOrDefault();
                if (res != null)
                {
                    res.IdPersona = idPersona;
                    res.CuentaCorreo = cuentaCorreo;
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
            var res = (from r in _entities.GRH_IdiomaPersona where r.IdIdiomaPersona == idIdiomaPersona select r).FirstOrDefault();
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
                    IdPersona = idPersona,
                    IdIdioma = idIdioma,
                    Nativo = nativo
                };
                if (idNivelIdioma == 0)
                    idioma.IdNivelIdioma = null;
                else
                    idioma.IdNivelIdioma = idNivelIdioma;

                _entities.AddToGRH_IdiomaPersona(idioma);
                _entities.SaveChanges();
                idIdiomaPersona = idioma.IdIdiomaPersona;
                resultado = true;
            }
            else
            {
                var res = (from r in _entities.GRH_IdiomaPersona where r.IdIdiomaPersona == idIdiomaPersona select r).FirstOrDefault();
                if (res != null)
                {
                    res.IdPersona = idPersona;
                    res.IdIdioma = idIdioma;
                    if (idNivelIdioma == 0)
                        res.IdNivelIdioma = null;
                    else
                        res.IdNivelIdioma = idNivelIdioma;

                    res.Nativo = nativo;
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
            var res = (from r in _entities.GRH_ExperienciaLaboral where r.IdExperienciaLaboral == idExperienciaLaboral select r).FirstOrDefault();
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
                    IdPersona = idPersona,
                    Conocimientos = conocimientos,
                    Cargo = cargo,
                    Empresa = empresa
                };
                if (!string.IsNullOrEmpty(fechaInicio))
                    experienciaLaboral.FechaInicio = new DateTime(Convert.ToInt32(fechaInicio.Substring(0, 4)),
                                                                  Convert.ToInt32(fechaInicio.Substring(5, 2)),
                                                                  Convert.ToInt32(fechaInicio.Substring(8, 2)));
                if (!string.IsNullOrEmpty(fechaFin))
                    experienciaLaboral.FechaFin = new DateTime(Convert.ToInt32(fechaFin.Substring(0, 4)),
                                            Convert.ToInt32(fechaFin.Substring(5, 2)),
                                            Convert.ToInt32(fechaFin.Substring(8, 2)));

                _entities.AddToGRH_ExperienciaLaboral(experienciaLaboral);
                _entities.SaveChanges();
                idExperienciaLaboral = experienciaLaboral.IdExperienciaLaboral;
                resultado = true;
            }
            else
            {
                var res = (from r in _entities.GRH_ExperienciaLaboral where r.IdExperienciaLaboral == idExperienciaLaboral select r).FirstOrDefault();
                if (res != null)
                {
                    res.IdPersona = idPersona;
                    if (!string.IsNullOrEmpty(fechaInicio))
                        res.FechaInicio = new DateTime(Convert.ToInt32(fechaInicio.Substring(0, 4)),
                                                       Convert.ToInt32(fechaInicio.Substring(5, 2)),
                                                       Convert.ToInt32(fechaInicio.Substring(8, 2)));
                    if (!string.IsNullOrEmpty(fechaFin))
                        res.FechaFin = new DateTime(Convert.ToInt32(fechaFin.Substring(0, 4)),
                                                    Convert.ToInt32(fechaFin.Substring(5, 2)),
                                                    Convert.ToInt32(fechaFin.Substring(8, 2)));
                    res.Conocimientos = conocimientos;
                    res.Cargo = cargo;
                    res.Empresa = empresa;
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
            var res = (from r in _entities.GRH_EstudioRealizado where r.IdEstudioRealizado == idEstudioRealizado select r).FirstOrDefault();
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

        public virtual ActionResult SetEstudioRealizado(int idPersona, int idEstudioRealizado, int idEspecialidad, int idNivel, int idSituacion, string centroEstudio, string fechaInicio, string fechaFin, string nombreEstudio)
        {
            bool resultado;
            if (idPersona == 0)
                idPersona = StartPersona();

            _entities = new GRH_Entities();
            if (idEstudioRealizado == 0)
            {
                var estudioRealizado = new GRH_EstudioRealizado
                {
                    IdPersona = idPersona,
                    IdEspecialidad = idEspecialidad,
                    IdNivelEducativo = idNivel,
                    IdSituacionEstudio = idSituacion,
                    CentroEstudio = centroEstudio,
                    NombreEstudio = nombreEstudio
                };
                if (!string.IsNullOrEmpty(fechaInicio))
                    estudioRealizado.FechaInicio = new DateTime(Convert.ToInt32(fechaInicio.Substring(0, 4)),
                                                                  Convert.ToInt32(fechaInicio.Substring(5, 2)),
                                                                  Convert.ToInt32(fechaInicio.Substring(8, 2)));
                if (!string.IsNullOrEmpty(fechaFin))
                    estudioRealizado.FechaFin = new DateTime(Convert.ToInt32(fechaFin.Substring(0, 4)),
                                            Convert.ToInt32(fechaFin.Substring(5, 2)),
                                            Convert.ToInt32(fechaFin.Substring(8, 2)));

                _entities.AddToGRH_EstudioRealizado(estudioRealizado);
                _entities.SaveChanges();
                idEstudioRealizado = estudioRealizado.IdEstudioRealizado;
                resultado = true;
            }
            else
            {
                var res = (from r in _entities.GRH_EstudioRealizado where r.IdEstudioRealizado == idEstudioRealizado select r).FirstOrDefault();
                if (res != null)
                {
                    res.IdPersona = idPersona;
                    res.IdEspecialidad = idEspecialidad;
                    res.IdNivelEducativo = idNivel;
                    res.IdSituacionEstudio = idSituacion;
                    res.CentroEstudio = centroEstudio;
                    res.NombreEstudio = nombreEstudio;
                    if (!string.IsNullOrEmpty(fechaInicio))
                        res.FechaInicio = new DateTime(Convert.ToInt32(fechaInicio.Substring(0, 4)),
                                                       Convert.ToInt32(fechaInicio.Substring(5, 2)),
                                                       Convert.ToInt32(fechaInicio.Substring(8, 2)));
                    else
                        res.FechaInicio = null;

                    if (!string.IsNullOrEmpty(fechaFin))
                        res.FechaFin = new DateTime(Convert.ToInt32(fechaFin.Substring(0, 4)),
                                                    Convert.ToInt32(fechaFin.Substring(5, 2)),
                                                    Convert.ToInt32(fechaFin.Substring(8, 2)));
                    else
                        res.FechaFin = null;

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

        public virtual ActionResult SetPersona(int idPersona, string nombre, string apellidoPaterno, string apellidoMaterno, int idEstadoCivil, bool sexo,
            string direccion, int idPaisR, string fechaNacimiento, int idPaisN, string disponibilidad)
        {
            bool resultado;
            _entities = new GRH_Entities();

            if (idPersona == 0)
            {
                var persona = new GRH_Persona
                {
                    Nombre = nombre,
                    ApellidoPaterno = apellidoPaterno,
                    ApellidoMaterno = apellidoMaterno,
                    IdEstadoCivil = idEstadoCivil,
                    Sexo = sexo,
                    Direccion = direccion,
                    IdPaisResidencia = idPaisR,
                    IdPaisNacionalidad = idPaisN
                };
                if (!string.IsNullOrEmpty(fechaNacimiento))
                    persona.FechaNacimiento = new DateTime(Convert.ToInt32(fechaNacimiento.Substring(0, 4)),
                                                           Convert.ToInt32(fechaNacimiento.Substring(5, 2)),
                                                           Convert.ToInt32(fechaNacimiento.Substring(8, 2)));
                else
                    persona.FechaNacimiento = null;

                _entities.AddToGRH_Persona(persona);
                _entities.SaveChanges();
                idPersona = persona.IdPersona;

                var postulante = new GRH_Postulante
                    {
                        IdPersona = idPersona,
                        Disponibilidad = disponibilidad,
                        Aprobado = false
                    };
                _entities.AddToGRH_Postulante(postulante);
                _entities.SaveChanges();

                resultado = true;
            }
            else
            {
                var res = (from r in _entities.GRH_Persona where r.IdPersona == idPersona select r).FirstOrDefault();
                if (res != null)
                {
                    res.Nombre = nombre;
                    res.ApellidoPaterno = apellidoPaterno;
                    res.ApellidoMaterno = apellidoMaterno;
                    res.IdEstadoCivil = idEstadoCivil;
                    res.Sexo = sexo;
                    res.Direccion = direccion;
                    res.IdPaisNacionalidad = idPaisN;
                    res.IdPaisResidencia = idPaisR;
                    if (!string.IsNullOrEmpty(fechaNacimiento))
                        res.FechaNacimiento = new DateTime(Convert.ToInt32(fechaNacimiento.Substring(0, 4)),
                                                               Convert.ToInt32(fechaNacimiento.Substring(5, 2)),
                                                               Convert.ToInt32(fechaNacimiento.Substring(8, 2)));
                    else
                        res.FechaNacimiento = null;

                    var firstOrDefault = res.GRH_Postulante.FirstOrDefault();
                    if (firstOrDefault != null)
                        firstOrDefault.Disponibilidad = disponibilidad;

                    _entities.SaveChanges();
                    resultado = true;
                }
                else
                {
                    resultado = false;
                }
            }

            // ReSharper disable RedundantArgumentName
            return Json(data: new { result = resultado, Persona = idPersona },
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

        private IEnumerable EstadoCivil()
        {

            var resultado = CargaInicial();

            var lista = (from r in _entities.GRH_EstadoCivil select r);

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.IdEstadoCivil + string.Empty, Text = item.Descripcion };
                resultado.Add(selListItem);
            }

            return resultado;
        }

        private IEnumerable Pais()
        {

            var resultado = CargaInicial();

            var lista = (from r in _entities.GRH_Pais select r);


            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.IdPais + string.Empty, Text = item.Descripcion };
                resultado.Add(selListItem);
            }

            return resultado;
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

        private IEnumerable Especialidad()
        {

            var resultado = CargaInicial();

            var lista = (from r in _entities.GRH_Especialidad select r);

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.IdEspecialidad + string.Empty, Text = item.Descripcion };
                resultado.Add(selListItem);
            }

            return resultado;
        }

        private IEnumerable NivelEducativo()
        {

            var resultado = CargaInicial();

            var lista = (from r in _entities.GRH_NivelEducativo select r);

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.IdNivelEducativo + string.Empty, Text = item.Descripcion };
                resultado.Add(selListItem);
            }

            return resultado;
        }

        private IEnumerable SituacionEstudio()
        {

            var resultado = CargaInicial();

            var lista = (from r in _entities.GRH_SituacionEstudio select r);

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.IdSituacionEstudio + string.Empty, Text = item.Descripcion };
                resultado.Add(selListItem);
            }

            return resultado;
        }

        private IEnumerable NivelIdioma()
        {

            var resultado = CargaInicial();

            var lista = (from r in _entities.GRH_NivelIdioma select r);

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.IdNivelIdioma + string.Empty, Text = item.Descripcion };
                resultado.Add(selListItem);
            }

            return resultado;
        }

        private IEnumerable Idioma()
        {

            var resultado = CargaInicial();

            var lista = (from r in _entities.GRH_Idioma select r);

            foreach (var item in lista)
            {
                var selListItem = new SelectListItem { Value = item.IdIdioma + string.Empty, Text = item.Descripcion };
                resultado.Add(selListItem);
            }

            return resultado;
        }
        #endregion
    }
}
