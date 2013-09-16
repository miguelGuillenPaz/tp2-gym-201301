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
                            idFirma = AplicarFirmaDigital(upload.FileName);
                        }
                        model.RutaFisica = upload.FileName;
                        //model.RutaFisica = Path.GetFullPath(upload.FileName);
                        //model.RutaFisica = System.IO.Path.GetDirectoryName(upload.FileName);
                        //model.RutaFisica = new FileInfo(upload.FileName).Directory.FullName;
                        //model.RutaFisica = Request.MapPath(Request.Form["upload"]);
                        db.GD_Documento.AddObject(model);
                        db.SaveChanges();                       
                        
                        model.Clave = idFirma;
                        // guardando el historial del documento
                        var histDoc = new GD_DocumentoHistorial
                        {
                            IdDocumento = model.IdDocumento,
                            IdEstado = estadoCodigo,
                            FechaAcceso = DateTime.Now,
                            IdUsuarioPerfil = 4
                        };
                        db.GD_DocumentoHistorial.AddObject(histDoc);

                        msg = "El documento se guardó satisfactoriamente." + idFirma;

                        #endregion
                    }
                    else
                    {
                        #region Edit

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
                            doc.Clave = model.Clave;
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
                        var filePath = Path.Combine(HttpContext.Server.MapPath("\\App_Data\\"),
                                                    model.IdDocumento.ToString(CultureInfo.InvariantCulture) + Path.GetExtension(upload.FileName));
                        upload.SaveAs(filePath);
                        var filePath2 = Path.Combine(HttpContext.Server.MapPath("\\Content\\"),
                                                    model.IdDocumento.ToString(CultureInfo.InvariantCulture) + Path.GetExtension(upload.FileName));
                        upload.SaveAs(filePath2);
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
            //ViewData["hola"] = "Monjurul Habib";
            return View(model);
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
            if (doc.Clave != null) ViewData["firma"] = "1";
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
            doc.IdEstado = 4;
            db.SaveChanges();

            var hist = new GD_DocumentoHistorial
            {
                Descripcion = collection["descripcion"],
                IdDocumento = doc.IdDocumento,
                IdEstado = doc.IdEstado,
                FechaAcceso = DateTime.Now
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
        private String AplicarFirmaDigital(String filename)        
        {
            Inicializar();
            Viafirma.ViafirmaClient clienteViaFirma;
            clienteViaFirma = new ViafirmaClient();
            
            
                 
            String ALIAS = "xnoccio";
            //Pass del certificado instalado en servidor
            String PASS_CERT = "12345";
            var idFirma = "";
            clienteViaFirma = ViafirmaClientFactory.GetInstance();
            
            //colocamos pdf de prueba

            String pdfprueba = @"C:\Users\Administrator\Desktop\pruebas\GuiaRefFrameworkDNIeCsharp12.pdf";
            FileStream fs = System.IO.File.OpenRead(pdfprueba);
            //enviamos un arreglos de bytes
            byte[] datos_a_firmar = new byte[fs.Length];
            fs.Read(datos_a_firmar, 0, datos_a_firmar.Length);

            //recuperaos imagen:
            String ruta_imagen = @"C:\Users\Administrator\Desktop\pruebas\gdoc.png";
            FileStream fs_img = System.IO.File.OpenRead(ruta_imagen);
            //enviamos un arreglos de bytes
            byte[] imagen = new byte[fs_img.Length];
            fs.Read(imagen, 0, imagen.Length);

            //Creamos el rectangle donde se posicionará el sello
            rectangle _rectangle = new rectangle();
            _rectangle.height = 50;
            _rectangle.width = 100;
            _rectangle.x = 200;
            _rectangle.y = 100;

            System.Console.Write(clienteViaFirma.ping("Prueba Conexión") + "\n");
            try
            {
            // Enviamos a firmar el documento al servidor y obtenemos el identificador final de la firma.
            idFirma = clienteViaFirma.signByServerPDFWithImageStamp("FicheroEjemploServer.pdf", datos_a_firmar, ALIAS, PASS_CERT, _rectangle, imagen);
            
            //recuperar archivo firmado:
            System.IO.Stream stream = null;
            Viafirma.ViafirmaClient clienteViafirma = Viafirma.ViafirmaClientFactory.GetInstance();
//            String id = (string)Session["idFirma"];
            byte[] documento = clienteViafirma.getDocumentoCustodiado(idFirma);

                // Open the file into a stream. 
                stream = new System.IO.MemoryStream(documento);
                // Total bytes to read: 
                long bytesToRead = stream.Length;
                Response.Clear();
                Response.ContentType = "application/octet-stream";
                Response.AddHeader("Content-Disposition", "attachment; filename=" + filename+"");
                //var filePath2 = Path.Combine(HttpContext.Server.MapPath("\\Content\\"),
                //                                    model.IdDocumento.ToString(CultureInfo.InvariantCulture) + Path.GetExtension(filename));
                // upload.SaveAs(filePath2);
                Response.Buffer = true;
                ((System.IO.MemoryStream)stream).WriteTo(Response.OutputStream);
                Response.End();
            }    
            catch (Exception ex)
            {
                Response.Write(ex.Message);
                // An error occurred.. 
            }
            return idFirma;
        }
        private void Inicializar()
        {
            String URL_VIAFIRMA = "http://services.viafirma.com/viafirma";
            //String URL_WS_VIAFIRMA = "http://testservices.viafirma.com/viafirma";
            String URL_WS_VIAFIRMA = "http://services.viafirma.com/viafirma"; 
            ViafirmaClientFactory.Init(URL_VIAFIRMA, URL_WS_VIAFIRMA, "ViafirmaDotNetClientWebExample", "WKGLMRX439ETZF49DLMRXMR9Y29DE");
        }
        #endregion

    }
}
