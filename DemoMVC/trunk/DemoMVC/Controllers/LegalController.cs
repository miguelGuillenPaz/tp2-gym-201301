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

            ProyectoDAO proye = new ProyectoDAO();
            ViewData["Proyectos"] = new SelectList(proye.obtenerProyectoPorFiltro(3, 0, "PR").ToList(), "IdProyecto", "nombreProyecto");
            return View();
        }

        public ActionResult Confirmacion(int idPro, string desc, string prioridad, string arrVecinos)
        {
            Session["bInsertSuccess"] = false;

            //Insertar Req Legal CN
            LegalRequerimiento legalReq = new LegalRequerimiento();
            legalReq.idReqLegalTipo = 1;
            legalReq.idProyecto = idPro;
            legalReq.cDescripcion = desc;
            legalReq.cPrioridadAtencion = prioridad;

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
                    //legalReq.objLegalCN = new LegalRequerimientoCN();
                    //bool e;
                    //int codUbiDist;
                    //legalReq.objLegalCN.idReqLegal = nuevoIdReqLegal;
                    //legalReq.objLegalCN.cNombreVecino = (string)itemsJson["cNombre"];
                    //legalReq.objLegalCN.cApellidoVecino = (string)itemsJson["cApellido"];
                    //legalReq.objLegalCN.cDireccion = (string)itemsJson["cDireccion"];
                    //legalReq.objLegalCN.idDocIdentidadTipo = 1;
                    //legalReq.objLegalCN.cNroDocIdentidad = (string)itemsJson["cNroDocIdentidad"];
                    //e = int.TryParse((string)itemsJson["idDist"], out codUbiDist);
                    //if (e) legalReq.objLegalCN.idDistrito = codUbiDist;
                    ////legalReq.objLegalCN.idDistrito = (int)itemsJson["idDist"];
                    //legalReq.objLegalCN.idDepartamento = (int)itemsJson["idDep"];
                    //legalReq.objLegalCN.idProvincia = (int)itemsJson["idProv"];
                    //legalReq.objLegalCN.cTipoEdificacion = (string)itemsJson["cTipoEdificacion"];
                    //legalReq.objLegalCN.cNombreCondominio = (string)itemsJson["cNombreCondominio"];

                    //totVecIns += legalDAO.insertarRequerimientoLegalVecinos(legalReq.objLegalCN);
                }
            }

            if (nuevoIdReqLegal > 0 && totVecIns > 0)
            {
                Session["bInsertSuccess"] = true;
                EnviarMail(nuevoIdReqLegal);
            }
            else
            {
                Session["bInsertSuccess"] = false;
            }

            return View("Registrar");
        }

        public void EnviarMail(int idReq)
        {
            var fromAddress = new MailAddress("gemini.cal@gmail.com", "Carlos Pérez Betancour");
            var toAddress = new MailAddress("u201021077@upc.edu.pe", "Usuario Solicitante");
            string fromPassword = System.Configuration.ConfigurationManager.AppSettings["Correo_CredentialPassword"];
            const string subject = "Área Legal - se registró su requerimiento legal";
            string body = "<p>Su solicitud de requerimiento legal con ID:" + idReq + " ha sido registrado y queda en estado Pendiente de Atención.</p><p>Atentamente</p><p>Área Legal<br />GyM</p>";

            var smtp = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
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

        public ActionResult listarRequerimientos()
        {
            LegalDAO proye = new LegalDAO();
            ProyectoDAO proyecto = new ProyectoDAO();

            //ViewData["Proyectos"] = new SelectList(proyecto.obtenerProyectoPorFiltro(1, 0, "PRE"), "codPro", "nomPro");
            ViewData["Proyectos"] = new SelectList(proyecto.obtenerProyectoPorFiltro(3, 0, "PR"), "IdProyecto", "nombreProyecto");

            ViewData["TipoReq"] = new SelectList(proye.listarTipoRequerimiento().ToList(), "idTipoReq", "descripcion");

            ViewData["Estado"] = new SelectList(proye.listarEstadoRequerimiento().ToList(), "idEstadoReq", "descripcion");
            //return View(proye);

            List<Requerimiento> listadoRequerimiento = null;

            listadoRequerimiento = proye.listarRequerimiento(0, 0, 0, 0, Convert.ToDateTime("2013-01-01"), Convert.ToDateTime("2013-08-31"));

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
                //ViewData["Proyectos"] = new SelectList(proyecto.obtenerProyectoPorFiltro(1, 0, "PRE").ToList(), "codPro", "nomPro");
                ViewData["Proyectos"] = new SelectList(proyecto.obtenerProyectoPorFiltro(3, 0, "PR").ToList(), "idProyecto", "nombreProyecto");
                ViewData["TipoReq"] = new SelectList(proye.listarTipoRequerimiento().ToList(), "idTipoReq", "descripcion");
                ViewData["Estado"] = new SelectList(proye.listarEstadoRequerimiento().ToList(), "idEstadoReq", "descripcion");

                String txtFecIni = formCollection["txtFecIni"];
                String txtFecFin = formCollection["txtFecFin"];
                String txtCodSolicitud = formCollection["txtCodSolicitud"].ToString();
                String txtCodPro = formCollection["codPro"].ToString();
                String txtTipoReq = formCollection["codTipoReq"].ToString();
                string txtEstado = formCollection["codEstado"].ToString();

                if (txtCodSolicitud == "")
                {
                    txtCodSolicitud = "0";
                }
                listadoRequerimiento = proye.listarRequerimiento(Convert.ToInt16(txtCodSolicitud), Convert.ToInt16(txtCodPro), Convert.ToInt16(txtTipoReq), Convert.ToInt16(txtEstado), Convert.ToDateTime(txtFecIni), Convert.ToDateTime(txtFecFin));

                if (listadoRequerimiento == null)
                {
                    Response.Write("<script>window.alert('No existen valores')</script>");
                }
            }
            catch (Exception e)
            {
                Response.Write("<script>window.alert('Datos incorrectos')</script>");
            }


            return View(listadoRequerimiento);
        }

        [HttpGet]
        public ActionResult DetalleRequerimiento(Int16 idRequerimiento)
        {
            LegalDAO legal = new LegalDAO();

            List<Requerimiento> listadoRequerimiento = null;

            listadoRequerimiento = legal.listarRequerimiento(idRequerimiento, 0, 0, 0, Convert.ToDateTime("2013-01-01"), Convert.ToDateTime("2013-09-01"));

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

    }
}
