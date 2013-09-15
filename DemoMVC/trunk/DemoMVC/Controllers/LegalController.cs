using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using System.Net.Mail;
using System.Globalization;
using System.Web.Script.Serialization;
using DemoMVC.Models;
using DemoMVC.Persistencia;
using DemoMVC.HelperClass;

namespace DemoMVC.Controllers
{
    public class LegalController : Controller
    {
        //
        // GET: /Legal/

        public ActionResult Requerimientos()
        {
            return View();
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Registrar()
        {
            Session["bEsConfirmacion"] = false;

            ProyectoDAO proye = new ProyectoDAO();

            /*SelectListItem item = new SelectListItem();
            item.Text = "--seleccione--";
            item.Value = "0";

            Proyecto oProy = new Proyecto();
            oProy.idProyecto = 0;
            oProy.nombreProyecto = "--seleccione--";

            IList<Proyecto> listaProyectos = new List<Proyecto>();
            listaProyectos.Add(oProy);

            SelectList selectListaProyectos = new SelectList(proye.obtenerProyectoPorFiltro(3, 0, "PR").ToList(), "IdProyecto", "nombreProyecto");*/

            ViewData["Proyectos"] = new SelectList(proye.obtenerProyectoPorFiltro(1, 0, "PR").ToList(), "codPro", "nomPro");
            return View();
        }

        public ActionResult Confirmacion(int idPro, string desc, string arrVecinos)
        {
            Session["bInsertSuccess"] = false;
            Session["bEsConfirmacion"] = true;

            //Insertar Req Legal CN
            LegalRequerimiento legalReq = new LegalRequerimiento();
            legalReq.idReqLegalTipo = 1;
            legalReq.idProyecto = idPro;
            legalReq.cDescripcion = desc;

            LegalDAO legalDAO = new LegalDAO();
            int nuevoIdReqLegal = legalDAO.insertarRequerimientoLegal(legalReq);

            //Insertar Vecinos
            var jsSer = new JavaScriptSerializer();
            var vecinos = (object[])jsSer.DeserializeObject(arrVecinos);
            var totVecIns = 0;

            if (vecinos != null)
            {
                foreach (Dictionary<string, object> itemsJson in vecinos)
                {
                    //LegalVecinoColindante legalVecino = new LegalVecinoColindante();
                    //me sale error, no encuentra la clase LegalRequerimientoCN
                    legalReq.objLegalCN = new LegalRequerimientoCN();
                    bool e;
                    int codUbiDist;
                    legalReq.objLegalCN.idReqLegal = nuevoIdReqLegal;
                    legalReq.objLegalCN.cNombreVecino = (string)itemsJson["cNombre"];
                    legalReq.objLegalCN.cApellidoVecino = (string)itemsJson["cApellido"];
                    legalReq.objLegalCN.cDireccion = (string)itemsJson["cDireccion"];
                    legalReq.objLegalCN.idDocIdentidadTipo = 1;
                    legalReq.objLegalCN.cNroDocIdentidad = (string)itemsJson["cNroDocIdentidad"];
                    e = int.TryParse((string)itemsJson["idDist"], out codUbiDist);
                    if (e) legalReq.objLegalCN.idDistrito = codUbiDist;
                    //legalReq.objLegalCN.idDistrito = (int)itemsJson["idDist"];
                    legalReq.objLegalCN.idDepartamento = (int)itemsJson["idDep"];
                    legalReq.objLegalCN.idProvincia = (int)itemsJson["idProv"];
                    legalReq.objLegalCN.cTipoEdificacion = (string)itemsJson["cTipoEdificacion"];
                    legalReq.objLegalCN.cNombreCondominio = (string)itemsJson["cNombreCondominio"];

                    totVecIns += legalDAO.insertarRequerimientoLegalVecinos(legalReq.objLegalCN);
                }
            }

            if (nuevoIdReqLegal > 0 && totVecIns > 0)
            {
                Session["bInsertSuccess"] = true;
                //EnviarMail(nuevoIdReqLegal);
                //Utils.ShowMessage(ViewData, "Se registró el requerimiento exitosamente.", Url.Action("Registrar", "Legal", new { id = 0 }));
            }
            else
            {
                Session["bInsertSuccess"] = false;
                //Utils.ShowMessage(ViewData, "ERROR. No se pudo registrar el requerimiento.", Url.Action("Registrar", "Legal", new { id = 0 }));
            }

            ProyectoDAO proye = new ProyectoDAO();
            ViewData["Proyectos"] = new SelectList(proye.obtenerProyectoPorFiltro(1, 0, "PR").ToList(), "codPro", "nomPro");
            return View("Registrar");
        }

        public void EnviarMail(int idReq)
        {
            //var fromAddress = new MailAddress("gemini.cal@gmail.com", "Carlos Pérez Betancour");
            var fromAddress = new MailAddress(System.Configuration.ConfigurationManager.AppSettings["userFrom"], "Carlos Pérez Betancour");
            var toAddress = new MailAddress("u201021077@upc.edu.pe", "Usuario Solicitante");
            //string fromPassword = System.Configuration.ConfigurationManager.AppSettings["Correo_CredentialPassword"];
            string fromPassword = System.Configuration.ConfigurationManager.AppSettings["userPassword"];
            const string subject = "Área Legal - se registró su requerimiento legal";
            string body = "<p>Su solicitud de requerimiento legal con ID:" + idReq + " ha sido registrado y queda en estado Pendiente de Atención.</p><p>Atentamente</p><p>Área Legal<br />GyM</p>";

            var smtp = new SmtpClient
            {
                //Host = "smtp.gmail.com",
                Host = System.Configuration.ConfigurationManager.AppSettings["smtpServer"],
                //Port = 587,
                Port = Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings["smtpPort"]),
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new System.Net.NetworkCredential(fromAddress.Address, fromPassword)
            };
            using (var message = new MailMessage(fromAddress, toAddress)
            {
                Subject = subject,
                Body = body,
                IsBodyHtml = true
            })
            {
                smtp.Send(message);
            }

        }

        public ActionResult ConfirmacionPlantillaContrato(
            int idPro,
            int tipoContrato,
            string desc,
            //Plazo Indeterminado
            string nombreTrab,
            string dniTrab,
            string cargoTrab,
            string laborDesempenar,
            string horaIniLabor,
            string horaFinLabor,
            string horaIniRefri,
            string horaFinRefri,
            string periodoPrueba,
            //Prestación Servicios
            string outsourcing,
            string ruc,
            string domicilio,
            string representante,
            string dniRepresentante,
            string fichaPJ,
            string objetoSocial,
            string servicios,
            string duracion,
            string juez,
            //Sujeto a Modalidad
            string nomSM,
            string dniSM,
            string modalidad,
            string duracionSM,
            string iniLabSM,
            string finLabSM,
            string iniRefriSM,
            string finRefriSM,
            string juezMod,
            //
            string arrClausulas)
        {
            Session["bInsertSuccess"] = false;
            Session["bEsConfirmacion"] = true;

            LegalRequerimiento legalReq = new LegalRequerimiento();
            legalReq.idReqLegalTipo = 2;
            legalReq.idProyecto = idPro;
            legalReq.cDescripcion = desc;

            legalReq.objLegalPC = new LegalRequerimientoPlantillaContrato();
            legalReq.objLegalPC.idContratoLegalTipo = tipoContrato;
            //Plazo Indeterminado
            legalReq.objLegalPC.NombreTrabajador = nombreTrab;
            legalReq.objLegalPC.DniTrabajador = dniTrab;
            legalReq.objLegalPC.Cargo = cargoTrab;
            legalReq.objLegalPC.LaborDesempenar = laborDesempenar;
            legalReq.objLegalPC.HoraInicioLabor = horaIniLabor;
            legalReq.objLegalPC.HoraFinLabor = horaFinLabor;
            legalReq.objLegalPC.HoraInicioRefrigerio = horaIniRefri;
            legalReq.objLegalPC.HoraFinRefrigerio = horaFinRefri;
            legalReq.objLegalPC.PeriodoPrueba = periodoPrueba;
            //Prestación Servicios
            legalReq.objLegalPC.EmpresaOutsourcing = outsourcing;
            legalReq.objLegalPC.Ruc = ruc;
            legalReq.objLegalPC.Domicilio = domicilio;
            legalReq.objLegalPC.RepresentanteLegal = representante;
            legalReq.objLegalPC.DniRepresentanteLegal = dniRepresentante;
            legalReq.objLegalPC.FichaPoderJudicial = fichaPJ;
            legalReq.objLegalPC.ObjetoSocialOutsourcing = objetoSocial;
            legalReq.objLegalPC.ServicioBrindar = servicios;
            legalReq.objLegalPC.DuracionContrato = duracion;
            legalReq.objLegalPC.JuezControversia = juez;
            //Sujeto a Modalidad
            legalReq.objLegalPC.NombreTrabajadorSM = nomSM;
            legalReq.objLegalPC.DniTrabajadorSM = dniSM;
            legalReq.objLegalPC.ModalidadContrato = modalidad;
            legalReq.objLegalPC.Duracion = duracionSM;
            legalReq.objLegalPC.HoraInicioLaborSM = iniLabSM;
            legalReq.objLegalPC.HoraFinLaborSM = finLabSM;
            legalReq.objLegalPC.HoraInicioRefrigerioSM = iniRefriSM;
            legalReq.objLegalPC.HoraFinRefrigerioSM = finRefriSM;
            legalReq.objLegalPC.JuezControversiaSM = juezMod;

            LegalDAO legalDAO = new LegalDAO();
            int nuevoIdReqLegal = legalDAO.insertarRequerimientoLegal(legalReq);

            legalReq.objLegalPC.idReqLegal = nuevoIdReqLegal;

            //Insertar Plantilla y contrato, con sus cláusulas adicionales (si hubieran)
            var jsSer = new JavaScriptSerializer();
            var clausulas = (object[])jsSer.DeserializeObject(arrClausulas);
            bool exitoClausulasIns = false;

            if (clausulas != null)
            {

                var strClausulas = "";

                foreach (Dictionary<string, object> itemsJson in clausulas)
                {

                    if (strClausulas == "")
                    {
                        strClausulas += (string)itemsJson["DescripcionClausula"];
                    }
                    else
                    {
                        strClausulas += "|" + (string)itemsJson["DescripcionClausula"];
                    }
                                        
                }

                if (strClausulas != "") legalReq.objLegalPC.TieneClausulaAdicional = true; else legalReq.objLegalPC.TieneClausulaAdicional = false;

                string aux = strClausulas;
                string[] arr = null;
                int i = 0;
                string var_XML = null;

                arr = aux.Split('|');

                var_XML = "";

                if (arr.Length > 0)
                {
                    var_XML += "<Clausulas>";
                    for (i = 0; i <= arr.Length - 1; i++)
                    {
                        var_XML += "<Clausula>" + arr[i] + "</Clausula>";
                    }
                    var_XML += "</Clausulas>";
                }

                legalReq.objLegalPC.DescripcionClausula = var_XML;

            }

            exitoClausulasIns = legalDAO.insertarRequerimientoLegalPlantillaContrato(legalReq.objLegalPC);

            if (nuevoIdReqLegal > 0)
            {
                if (exitoClausulasIns)
                {
                    Session["bInsertSuccess"] = true;
                }
                else
                {
                    Session["bInsertSuccess"] = false;
                }
            }
            else
            {
                Session["bInsertSuccess"] = false;
            }

            ProyectoDAO proye = new ProyectoDAO();
            ViewData["Proyectos"] = new SelectList(proye.obtenerProyectoPorFiltro(1, 0, "PR").ToList(), "codPro", "nomPro");
            return View("RegistrarContratos");
        }

        public ActionResult listarRequerimientos()
        {
            LegalDAO proye = new LegalDAO();
            ProyectoDAO proyecto = new ProyectoDAO();

            ViewData["Proyectos"] = new SelectList(proyecto.obtenerProyectoPorFiltro(1, 0, "PR"), "codPro", "nomPro");

            ViewData["TipoReq"] = new SelectList(proye.listarTipoRequerimiento().ToList(), "idTipoReq", "descripcion");

            ViewData["Estado"] = new SelectList(proye.listarEstadoRequerimiento().ToList(), "idEstadoReq", "descripcion");
            
            List<Requerimiento> listadoRequerimiento = null;


            return View(listadoRequerimiento);
        }

        [HttpPost]
        public ActionResult listarRequerimientos(FormCollection formCollection)
        {


            LegalDAO proye = new LegalDAO();
            ProyectoDAO proyecto = new ProyectoDAO();

            List<Requerimiento> listadoRequerimiento = null;

            try
            {
                
                String txtFecIni = formCollection["txtFecIni"];
                String txtFecFin = formCollection["txtFecFin"];
                String txtCodSolicitud = formCollection["txtCodSolicitud"].ToString();
                String txtCodPro = formCollection["codPro"].ToString();
                String txtTipoReq = formCollection["codTipoReq"].ToString();
                string txtEstado = formCollection["codEstado"].ToString();

                ViewData["Proyectos"] = new SelectList(proyecto.obtenerProyectoPorFiltro(1, 0, "PR").ToList(), "codPro", "nomPro",txtCodPro);
                ViewData["TipoReq"] = new SelectList(proye.listarTipoRequerimiento().ToList(), "idTipoReq", "descripcion",txtTipoReq);
                ViewData["Estado"] = new SelectList(proye.listarEstadoRequerimiento().ToList(), "idEstadoReq", "descripcion",txtEstado);

                if (txtCodSolicitud == "")
                {
                    txtCodSolicitud = "0";
                }
                if (txtCodPro == "")
                {
                    txtCodPro = "0";
                }
                listadoRequerimiento = proye.listarRequerimiento(Convert.ToInt16(txtCodSolicitud), Convert.ToInt16(txtCodPro), Convert.ToInt16(txtTipoReq), Convert.ToInt16(txtEstado), Convert.ToDateTime(txtFecIni), Convert.ToDateTime(txtFecFin));

                if (listadoRequerimiento == null)
                {
                    Utils.ShowMessage(ViewData, "No existen datos", Url.Action("listarRequerimientos", "Legal", new { id = 0 }));
                }
            }
            catch (Exception e)
            {
                Utils.ShowMessage(ViewData, "Datos Incorrectos", Url.Action("listarRequerimientos", "Legal", new { id = 0 }));
            }


            return View(listadoRequerimiento);
        }

        [HttpGet]
        public ActionResult DetalleRequerimiento(Int16 idRequerimiento)
        {
            LegalDAO legal = new LegalDAO();

            List<Requerimiento> listadoRequerimiento = null;

            listadoRequerimiento = legal.listarRequerimiento(idRequerimiento, 0, 0, 0, Convert.ToDateTime("2013-01-01"), Convert.ToDateTime("2013-12-31"));

            int idReq = 0;
            String nomProy = "";
            String tipoRequerimiento = "";
            String estado = "";
            String Descripcion = "";

            foreach (Requerimiento req in listadoRequerimiento)
            {
                idReq = req.idReq;
                nomProy = req.desProyecto;
                tipoRequerimiento = req.descTipoReq;
                estado = req.desEstado;
                Descripcion = req.descripcion;
            }

            ViewData["idReq"] = idReq;
            ViewData["Proyecto"] = nomProy;
            ViewData["tipoReq"] = tipoRequerimiento;
            ViewData["estado"] = estado;
            ViewData["descripcion"] = Descripcion;

            return View();
        }

        //Plantilla Contratos
        public ActionResult RegistrarContratos()
        {
            Session["bEsConfirmacion"] = false;

            ProyectoDAO proye = new ProyectoDAO();
            ViewData["Proyectos"] = new SelectList(proye.obtenerProyectoPorFiltro(1, 0, "PR").ToList(), "codPro", "nomPro");
            return View();
        }

        //Plantilla de declaración de fábrica
        public ActionResult RegistrarDeclaracionFabrica()
        {
            ProyectoDAO proye = new ProyectoDAO();
            ViewData["Proyectos"] = new SelectList(proye.obtenerProyectoPorFiltro(1, 0, "PR").ToList(), "codPro", "nomPro");


            return View();
        }

        [HttpPost]
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult RegistrarDeclaracionFabrica(HttpPostedFileBase file1, FormCollection formCollection)
        {
            if (ModelState.IsValid)
            {
                Boolean valida = new Boolean();
                valida = false;
                ProyectoDAO proye = new ProyectoDAO();
                ViewData["Proyectos"] = new SelectList(proye.obtenerProyectoPorFiltro(1, 0, "PR").ToList(), "codPro", "nomPro");

                if (formCollection["file1"] == null)
                {
                    Utils.ShowMessage(ViewData, "Cargar el archivo de declaración de fábrica", Url.Action("RegistrarDeclaracionFabrica", "Legal", new { id = 0 }));
                    valida = true;
                }
                               
                if (formCollection["file2"] == null)
                {
                    Utils.ShowMessage(ViewData, "Cargar el archivo de Planos", Url.Action("RegistrarDeclaracionFabrica", "Legal", new { id = 0 }));
                    valida = true;
                }
                if (formCollection["file3"] == null)
                {
                    Utils.ShowMessage(ViewData, "Cargar el archivo de verificación técnica", Url.Action("RegistrarDeclaracionFabrica", "Legal", new { id = 0 }));
                    valida = true;
                }
                if (formCollection["txtDescripcion"].ToString().Trim() == "")
                {
                    Utils.ShowMessage(ViewData, "Registrar descripción del requerimiento", Url.Action("RegistrarDeclaracionFabrica", "Legal", new { id = 0 }));
                    valida = true;
                }
                if (formCollection["idProyecto"] == "")
                {
                    Utils.ShowMessage(ViewData, "Seleccionar un proyecto", Url.Action("RegistrarDeclaracionFabrica", "Legal", new { id = 0 }));
                    valida = true;                
                }
                
                if (valida == true){

                }
                else
                {

                    String idProyecto = formCollection["idProyecto"];

                    LegalRequerimiento legalReq = new LegalRequerimiento();
                    legalReq.idReqLegalTipo = 3;
                    legalReq.idProyecto = Convert.ToInt16(idProyecto);
                    legalReq.cDescripcion = formCollection["txtDescripcion"];

                    LegalDAO legalDAO = new LegalDAO();
                    int nuevoIdReqLegal = legalDAO.insertarRequerimientoLegal(legalReq);

                    LegalRequerimientoDeclaracionFabrica legalReqDec = new LegalRequerimientoDeclaracionFabrica();
                    legalReqDec.idReqDecFab = nuevoIdReqLegal;
                    legalReqDec.DeclaracionFabrica = 1234;

                    legalDAO.insertarRequerimientoDeclaracionFabrica(legalReqDec);

                    LegalDeclaracionFabricaDocumento legalDoc = new LegalDeclaracionFabricaDocumento();
                    legalDoc.idDeclaracionFabricaDocumento = nuevoIdReqLegal;
                    legalDoc.idDeclaracionFabricaTipo = 1;
                    legalDoc.descripcionDocumento = "Declaración de fábrica";
                    legalDoc.ruta = formCollection["file1"].ToString();

                    legalDAO.insertarRequerimientoDeclaracionFabricaDocumento(legalDoc);

                    LegalDeclaracionFabricaDocumento legaldoc2 = new LegalDeclaracionFabricaDocumento();
                    legaldoc2.idDeclaracionFabricaDocumento = nuevoIdReqLegal;
                    legaldoc2.idDeclaracionFabricaTipo = 2;
                    legaldoc2.descripcionDocumento = "Planos";
                    legaldoc2.ruta = formCollection["file2"].ToString();

                    legalDAO.insertarRequerimientoDeclaracionFabricaDocumento(legaldoc2);

                    LegalDeclaracionFabricaDocumento legaldoc3 = new LegalDeclaracionFabricaDocumento();
                    legaldoc3.idDeclaracionFabricaDocumento = nuevoIdReqLegal;
                    legaldoc3.idDeclaracionFabricaTipo = 2;
                    legaldoc3.descripcionDocumento = "Informe de verificación técnica";
                    legaldoc3.ruta = formCollection["file3"].ToString();

                    legalDAO.insertarRequerimientoDeclaracionFabricaDocumento(legaldoc2);

                    Utils.ShowMessage(ViewData, "Registro exitoso", Url.Action("RegistrarDeclaracionFabrica", "Legal", new { id = 0 }));
                }
            }

            return View();
        }
        
        public ActionResult listarSolicitudes()
        {
            LegalDAO proye = new LegalDAO();
            ProyectoDAO proyecto = new ProyectoDAO();

            ViewData["Proyectos"] = new SelectList(proyecto.obtenerProyectoPorFiltro(1, 0, "PR"), "codPro", "nomPro");

            ViewData["TipoReq"] = new SelectList(proye.listarTipoRequerimiento().ToList(), "idTipoReq", "descripcion");

            ViewData["Estado"] = new SelectList(proye.listarEstadoRequerimiento().ToList(), "idEstadoReq", "descripcion");
            
            List<Requerimiento> listadoRequerimiento = null;

            return View(listadoRequerimiento);
        }

        [HttpPost]
        public ActionResult listarSolicitudes(FormCollection formCollection)
        {

            LegalDAO proye = new LegalDAO();
            ProyectoDAO proyecto = new ProyectoDAO();

            List<Requerimiento> listadoRequerimiento = null;

            try
            {

                String txtFecIni = formCollection["txtFecIni"];
                String txtFecFin = formCollection["txtFecFin"];
                String txtCodSolicitud = formCollection["txtCodSolicitud"].ToString();
                String txtCodPro = formCollection["codPro"].ToString();
                String txtTipoReq = formCollection["codTipoReq"].ToString();
                string txtEstado = formCollection["codEstado"].ToString();

                ViewData["Proyectos"] = new SelectList(proyecto.obtenerProyectoPorFiltro(1, 0, "PR").ToList(), "codPro", "nomPro", txtCodPro);
                ViewData["TipoReq"] = new SelectList(proye.listarTipoRequerimiento().ToList(), "idTipoReq", "descripcion", txtTipoReq);
                ViewData["Estado"] = new SelectList(proye.listarEstadoRequerimiento().ToList(), "idEstadoReq", "descripcion", txtEstado);

                if (txtCodSolicitud == "")
                {
                    txtCodSolicitud = "0";
                }
                if (txtCodPro == "")
                {
                    txtCodPro = "0";
                }
                listadoRequerimiento = proye.listarRequerimiento(Convert.ToInt16(txtCodSolicitud), Convert.ToInt16(txtCodPro), Convert.ToInt16(txtTipoReq), Convert.ToInt16(txtEstado), Convert.ToDateTime(txtFecIni), Convert.ToDateTime(txtFecFin));

                if (listadoRequerimiento == null)
                {
                    Utils.ShowMessage(ViewData, "No existen datos", Url.Action("listarRequerimientos", "Legal", new { id = 0 }));
                }
            }
            catch (Exception e)
            {
                Utils.ShowMessage(ViewData, "Datos Incorrectos", Url.Action("listarRequerimientos", "Legal", new { id = 0 }));
            }


            return View(listadoRequerimiento);
        }

         [HttpGet]
        public ActionResult Recursos()
        {
            LegalDAO legal = new LegalDAO();

            List<AsesorLegal> listadoAsesores = null;

            listadoAsesores = legal.ListarAsesorLegal();

            int IdAsesorLegal = 0;
            string Apellido = "";
            string Nombre = "";
            int CasosAsignados = 0;

            foreach (AsesorLegal asesor in listadoAsesores)
            {
                IdAsesorLegal = asesor.IdAsesorLegal;
                Apellido = asesor.Apellido;
                Nombre = asesor.Nombre;
                CasosAsignados = asesor.CasosAsignados;
            }

            ViewData["IdAsesorLegal"] = IdAsesorLegal;
            ViewData["Apellido"] = Apellido;
            ViewData["Nombre"] = Nombre;
            ViewData["CasosAsignados"] = CasosAsignados;

            return View();
        }

        [HttpGet]
        public ActionResult CasosAsignados(Int32 idAsesorLegal)
        {
            LegalDAO legal = new LegalDAO();

            List<LegalRequerimiento> listadoRequerimientos = null;

            listadoRequerimientos = legal.ListarCasosAsignados(idAsesorLegal);

            int idReqLegal = 0;
            string cDescripcionReqLegalTipo = "";
            string cFechaAtencion = "";
            string nomProyecto = "";
            string cDescripcionReqLegalEstado = "";

            foreach (LegalRequerimiento req in listadoRequerimientos)
            {
                idReqLegal = req.idReqLegal;
                cDescripcionReqLegalTipo = req.cDescripcionReqLegalTipo;
                cFechaAtencion = req.cFechaAtencion;
                nomProyecto = req.nomProyecto;
                cDescripcionReqLegalEstado = req.cDescripcionReqLegalEstado;
            }

            ViewData["idReqLegal"] = idReqLegal;
            ViewData["cDescripcionReqLegalTipo"] = cDescripcionReqLegalTipo;
            ViewData["cFechaAtencion"] = cFechaAtencion;
            ViewData["nomProyecto"] = nomProyecto;
            ViewData["cDescripcionReqLegalEstado"] = cDescripcionReqLegalEstado;

            return View();
        }

        [HttpPost]
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult RegistrarAsignarAsesorLegal(FormCollection formCollection)
        {
            if (ModelState.IsValid)
            {
                bool valida = false;

                if (formCollection["optSeleccion"] == null)
                {
                    Utils.ShowMessage(ViewData, "Seleccione un Asesor Legal", Url.Action("RegistrarAsignarAsesorLegal", "Legal", new { id = 0 }));
                    valida = true;

                    if (valida == true)
                    {

                    }
                    else
                    {
                        int idReqLegal = Convert.ToInt32(formCollection["idProyecto"]);
                        int prioridad = Convert.ToInt32(formCollection["txtPrioridad"]);
                        string cPrioridadAtencion = "";
                        switch (prioridad)
                        {
                            case 1:
                                cPrioridadAtencion = "BAJ";
                                break;
                            case 2:
                                cPrioridadAtencion = "MED";
                                break;
                            case 3:
                                cPrioridadAtencion = "ALT";
                                break;
                        }

                        LegalDAO legalDAO = new LegalDAO();
                        LegalRequerimiento legalReq = new LegalRequerimiento();

                        legalReq.idReqLegal = idReqLegal;
                        legalReq.idAsesorLegal = 1;
                        legalReq.cPrioridadAtencion = cPrioridadAtencion;

                        bool insExito = legalDAO.AsignarAsesorLegal(legalReq);

                        if (insExito)
                        {
                            Utils.ShowMessage(ViewData, "Se asignó el Asesor Legal exitosamente.", Url.Action("RegistrarAsignarAsesorLegal", "Legal", new { id = 0 }));
                        }
                        else
                        {
                            Utils.ShowMessage(ViewData, "ERROR. No se pudo asignar el Asesor Legal.", Url.Action("RegistrarAsignarAsesorLegal", "Legal", new { id = 0 }));
                        }

                    }
                }

            }

            return View();
        }
    }
}
