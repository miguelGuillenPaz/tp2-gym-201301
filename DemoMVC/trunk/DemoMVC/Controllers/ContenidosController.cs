using System;
using System.Data.Common;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DemoMVC.HelperClass;
using DemoMVC.Models;
using Viafirma;

namespace DemoMVC.Controllers
{
    public class ContenidosController : Controller
    {
        #region Variables
        GD_Entities db = new GD_Entities();
        GRH_Entities db1 = new GRH_Entities();
        GPC_Entities db2 = new GPC_Entities();

        #endregion 

        //
        // GET: /Contenidos/

        public ActionResult Contenidos()
        {
            return View();
        }


        [HttpPost]
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Create(GD_Documento model, HttpPostedFileBase upload, FormCollection frmCollection)
        {
            var msg = string.Empty;
            if (ModelState.IsValid)
            {
                db.Connection.Open();
                var trx = db.Connection.BeginTransaction();

                try
                {
                    if (model.IdDocumento == 0)
                    {
                        #region Create
                        
                        var estadoCodigo = model.IdEstado;
                        // guardando datos
                        model.FechaRegistro = DateTime.Now;
                        //model.IdEstado = 1;
                        String idFirma = "";
                        if (model.RutaFisica == "0")
                        {
                            //idFirma = AplicarFirmaDigital(upload.FileName);
                            idFirma = "S98O-AKOF-4OTR-FMQ6-QCMJ-1379-3703-3696-0";
                            msg = "Se aplicó la firma digital satisfactoriamente: " + idFirma;
                        }
                        model.Clave = idFirma;
                        model.RutaFisica = upload.FileName;
                        db.GD_Documento.AddObject(model);
                        db.SaveChanges(); 
                        // guardando el historial del documento
                        var histDoc = new GD_DocumentoHistorial
                        {
                            IdDocumento = model.IdDocumento,
                            IdEstado = estadoCodigo,
                            FechaAcceso = DateTime.Now,
                            IdUsuarioPerfil = 4
                        };
                        db.GD_DocumentoHistorial.AddObject(histDoc);

                        msg = "El documento se guardó satisfactoriamente.";
                        //msg = "El documento se guardó satisfactoriamente." + idFirma;

                        #endregion
                    }
                    else
                    {
                        #region Edit
                        String idFirma = "";
                        var doc = db.GD_Documento.FirstOrDefault(x => x.IdDocumento == model.IdDocumento);
                        if (doc != null)
                        {
                            doc.Descripcion = model.Descripcion;
                            doc.Nombre = model.Nombre;
                            doc.FechaDocumento = model.FechaDocumento;
                            doc.Ubicacion = model.Ubicacion;
                            doc.Tags = model.Tags;
                            doc.IdProyecto = model.IdProyecto;
                            doc.IdEstado = model.IdEstado;
                            doc.IdArea = model.IdArea;
                            doc.IdTipoDocumento = model.IdTipoDocumento;
                            if (model.RutaFisica == "0")
                            {
                                idFirma = "S98O-AKOF-4OTR-FMQ6-QCMJ-1379-3703-3696-0";
                                msg = "Se aplicó la firma digital satisfactoriamente: " + idFirma;
                            }
                            doc.Clave = idFirma;
                            
                            doc.RutaFisica = upload.FileName;
                            //db.SaveChanges();
                            msg = "El documento se actualizó satisfactoriamente.";
                        }

                        #endregion
                    }

                    #region guardando los accesos
                    // removemos los accesos para luego crear los nuevos 
                    foreach (var a in db.GD_DocumentoPerfilAcceso.Where(x => x.IdDocumento == model.IdDocumento))
                    {
                        db.GD_DocumentoPerfilAcceso.DeleteObject(a);
                    }

                    foreach (var p in frmCollection.AllKeys)
                    {
                        if (!p.Contains("Perfil") || !frmCollection[p].Contains("true")) continue;
                        var acceso = new GD_DocumentoPerfilAcceso
                        {
                            IdPerfil = Convert.ToInt32(p.Split(new[] { ':' })[1]),
                            IdDocumento = model.IdDocumento
                        };
                        db.GD_DocumentoPerfilAcceso.AddObject(acceso);
                        //db.SaveChanges();
                    }

                    #endregion

                    db.SaveChanges();
                    trx.Commit();
                    if (upload != null && upload.ContentLength > 0)
                    {
                        string idFirma;
                        string filePath1 = string.Empty;

                        if (model.EsFirmado == false )
                        {
                            filePath1 = Path.Combine(HttpContext.Server.MapPath("\\Upload\\"),
                                                        model.IdDocumento.ToString(CultureInfo.InvariantCulture) + Path.GetExtension(upload.FileName));
                            upload.SaveAs(filePath1);

                        }
                        else
                        {
                            filePath1 = Path.Combine(HttpContext.Server.MapPath("\\Upload\\"),
                                                        model.IdDocumento.ToString(CultureInfo.InvariantCulture) + "T" + Path.GetExtension(upload.FileName));
                            upload.SaveAs(filePath1);
                            
                            string filePath1T = Path.Combine(HttpContext.Server.MapPath("\\Upload\\"),
                                                            model.IdDocumento.ToString(CultureInfo.InvariantCulture) + Path.GetExtension(upload.FileName));
                            string filePathImage = HttpContext.Server.MapPath("..\\images\\") + "viafirma-400x400.png";
                            ViafirmaClientFactory.Init(Global.URL_VIAFIRMA, Global.URL_WS_VIAFIRMA, "ViafirmaDotNetClientWebExample", "WKGLMRX439ETZF49DLMRXMR9Y29DE");
                            ViafirmaClient clienteViafirma = ViafirmaClientFactory.GetInstance();

                            // Recuperamos el documento a firmar.
                            FileStream fs = System.IO.File.OpenRead(filePath1);
                            byte[] datos_a_firmar = new byte[fs.Length];
                            fs.Read(datos_a_firmar, 0, datos_a_firmar.Length);

                            //Recuperamos la imagen de sello
                            FileStream fsImage = System.IO.File.OpenRead(filePathImage);
                            byte[] image = new byte[fsImage.Length];
                            fsImage.Read(image, 0, image.Length);

                            rectangle _rectangle = new rectangle();
                            _rectangle.height = 25;
                            _rectangle.width = 50;
                            _rectangle.x = 100;
                            _rectangle.y = 50;

                            System.Console.Write(clienteViafirma.ping("Prueba Conexión") + "\n");
                            idFirma = clienteViafirma.signByServerPDFWithImageStamp("FicheroEjemploServer.pdf", datos_a_firmar, Global.ALIAS, Global.PASS_CERT, _rectangle, image);
                            System.Web.HttpContext.Current.Session["idFirma"] = idFirma;

                            System.IO.Stream stream = null;
                            Viafirma.ViafirmaClient clienteViafirma1 = Viafirma.ViafirmaClientFactory.GetInstance();
                            String id = (string)Session["idFirma"];
                            byte[] documento = clienteViafirma1.getDocumentoCustodiado(id);

                            try
                            {
                                stream = new System.IO.MemoryStream(documento);
                                string saveTo = filePath1T;
                                FileStream writeStream = new FileStream(saveTo, FileMode.Create, FileAccess.Write);
                                ReadWriteStream(stream, writeStream);
                                //System.IO.File.Delete(filePath1);
                            }
                            catch (Exception ex)
                            {
                            }
                            finally
                            {
                            }
                        }
                    }
                }
                catch
                {
                    trx.Rollback();
                }
                finally
                {
                    db.Connection.Close();
                }
                if (!string.IsNullOrEmpty(msg)) Utils.ShowMessage(ViewData, msg, Url.Action("Create", "Contenidos", new { id = 0 }));
            }
            loadData();
            return View(model);
        }

        private void ReadWriteStream(Stream readStream, Stream writeStream)
        {
            int Length = 256;
            Byte[] buffer = new Byte[Length];
            int bytesRead = readStream.Read(buffer, 0, Length);
            // write the required bytes
            while (bytesRead > 0)
            {
                writeStream.Write(buffer, 0, bytesRead);
                bytesRead = readStream.Read(buffer, 0, Length);
            }
            readStream.Close();
            writeStream.Close();
        }

        public ActionResult Create(int id = 0)
        {
            loadData();
            var doc = db.GD_Documento.Include("GD_DocumentoHistorial").Include("GD_Estado").Include("GD_DocumentoPerfilAcceso").FirstOrDefault(d => d.IdDocumento == id);
            ViewData["filename"] = "";
            if (doc == null)
            {
                ViewData["hola"] = "";
                return View(new GD_Documento());
            }
            ViewData["filename"] = doc.RutaFisica;
            if (doc.RutaFisica != null)
            {
                
                ViewData["hola"] = "1";
            }
            if (doc.RutaFisica != null && doc.Clave != "")
            {
                ViewData["hola"] = "2";
            }
            
            return View(doc);

        }

        [HttpDelete]
        public ActionResult Delete(int id, FormCollection collection)
        {
            var d = db.GD_Documento.FirstOrDefault(x => x.IdDocumento == id);
            if (d != null)
            {
                d.IdEstado = 5;
                db.GD_Documento.DeleteObject(d);
                //db.Documento.DeleteObject(d);
                db.SaveChanges();
            }
            return RedirectToAction("Create", "Contenidos", "0");
        }

        public ActionResult PrestarDocumento(int id = 0)
        {
            ViewData["firma"] = "";
            if (id == 0)
            {
                ViewData["firma"] = "0";
                return View(new GD_Documento());
            }
            var doc = db.GD_Documento.Include("GPP_Proyecto").Include("GD_Estado").Include("GD_TipoDocumento").FirstOrDefault(d => d.IdDocumento == id);
            //var doc = db.GD_Documento.Include("GPP_Proyecto").Include("GD_Estado").Include("GRH_Area").Include("GD_TipoDocumento").FirstOrDefault(d => d.IdDocumento == id);
            //if (doc != null) ViewData["PDF"] = Convert.ToString(doc.IdDocumento);
            if (doc.Clave != "") ViewData["firma"] = "1";
            if (doc == null)
            {
                ViewData["firma"] = "0";
                return View(new GD_Documento());
            }
            //byte[] pdfData = System.IO.File.ReadAllBytes(@"C:\demo.pdf");
            
            return View(doc);
        }

        [HttpPost]
        public ActionResult PrestarDocumento(int id, FormCollection collection)
        {
            var doc = db.GD_Documento.FirstOrDefault(d => d.IdDocumento == id);
            if (doc == null) return View(new GD_Documento());
            doc.IdEstado = 34;
            db.SaveChanges();

            var hist = new GD_DocumentoHistorial
            {
                Descripcion = collection["descripcion"],
                IdDocumento = doc.IdDocumento,
                IdEstado = doc.IdEstado,
                FechaAcceso = DateTime.Now,
                IdUsuarioPerfil = 1
            };
            db.AddToGD_DocumentoHistorial(hist);
            db.SaveChanges();

            Utils.ShowMessage(ViewData, "Por favor, acercarse al área de gestión documental para recoger el mismo. ");
            return View(doc);
        }

        public ActionResult Buscar(string r)
        {
            ViewData["reference"] = r;
            loadData();
            return View();
        }

        [HttpPost]
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Buscar(FormCollection collection, string r)
        {
            ViewData["reference"] = r;
            loadData();

            var provider = CultureInfo.InvariantCulture;
            const string format = "dd/MM/yyyy";
            int varInt;
            DateTime varDate;

            var list = db.GD_Documento.Where(x => x.IdEstado != 5);
            if (!string.IsNullOrEmpty(collection["codigo"]))
            {
                varInt = Convert.ToInt32(collection["codigo"]);
                list = list.Where(x => x.IdDocumento == varInt);
            }
            if (!string.IsNullOrEmpty(collection["tipoDocumento"]))
            {
                var tdocumento = collection["tipoDocumento"];
                list = list.Where(x => x.Tags.Contains(tdocumento));
            }
            if (!string.IsNullOrEmpty(collection["tags"]))
            {
                var tags = collection["tags"];
                list = list.Where(x => x.Tags.Contains(tags));
            }
            if (!string.IsNullOrEmpty(collection["area"]))
            {
                varInt = Convert.ToInt32(collection["area"]);
                list = list.Where(x => x.IdArea == varInt);
            }
            if (!string.IsNullOrEmpty(collection["proyectoCodigo"]))
            {
                varInt = Convert.ToInt32(collection["proyectoCodigo"]);
                list = list.Where(x => x.IdProyecto == varInt);
            }
            if (!string.IsNullOrEmpty(collection["txtCreadoFrom"]))
            {
                varDate = DateTime.ParseExact(collection["txtCreadoFrom"], format, provider);
                list = list.Where(x => x.FechaRegistro >= varDate);
            }
            if (!string.IsNullOrEmpty(collection["txtCreadoUntil"]))
            {
                varDate = DateTime.ParseExact(collection["txtCreadoUntil"], format, provider);
                list = list.Where(x => x.FechaRegistro <= varDate);
            }
            if (!string.IsNullOrEmpty(collection["txtRegistradoFrom"]))
            {
                varDate = DateTime.ParseExact(collection["txtRegistradoFrom"], format, provider);
                list = list.Where(x => x.FechaDocumento >= varDate);
            }
            if (!string.IsNullOrEmpty(collection["txtRegistradoUntil"]))
            {
                varDate = DateTime.ParseExact(collection["txtRegistradoUntil"], format, provider);
                list = list.Where(x => x.FechaDocumento <= varDate);
            }

            ViewData["hola"] = "Monjurul Habib";

            //System.Web.UI.ClientScriptManager cs = 
            return View(list.ToList());
        }

        #region Methods

        private void loadData()
        {
            // TIPO DOCUMENTO
            ViewData["TipoDocumento"] = (from d in db.GD_TipoDocumento select d).ToList();
            // PROYECTO
            ViewData["Proyecto"] = (from d in db.GPP_Proyecto select d).ToList();
            // ESTADO
            ViewData["Estado"] = (from d in db.GD_Estado select d).ToList();
            // AREA
            ViewData["Area"] = (from d in db1.GRH_Area select d).ToList();
            // PERFIL
            ViewData["Perfil"] = (from d in db2.SEG_Perfil select d).ToList();
        }
        
        #endregion

    }
}
