﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DemoMVC.Models;
using DemoMVC.Persistencia;

using System.IO;
using NPOI.HSSF.UserModel;
using NPOI.HPSF;
using NPOI.POIFS.FileSystem;


namespace DemoMVC.Controllers
{
    [HandleError]
    public class PlanificacionController : Controller
    {
        //
        // GET: /Planificacion/
        public List<Actividad> listadoActividadesTemp = new List<Actividad>();

        public ActionResult Index()
        {
            return View();
        }

        //Muestra pantalla principal para asignacion de recursos
        [HttpGet]
        public ActionResult AsignarRecursos()
        {

            //Listado Proyecto - combo
            List<Proyecto> listadoProyectos = null;
            ProyectoDAO Proyecto = new ProyectoDAO();
            int totalProy = 0;

            //Listado Actividades
            List<Actividad> listadoActividades = null;
            ActividadDAO Actividad = new ActividadDAO();

            listadoProyectos = Proyecto.obtenerProyectoPorFiltro(1, 0, "SR");
            listadoProyectos.Insert(0, new Models.Proyecto() { codPro = 0, nomPro = "-- Escoja el proyecto --" });

            //<option value='prueba'>-- Escoja el proyecto --</option>

            //Si acción = 1 (mostrar las actividades)
            //listadoActividades = 

            //Adjuntamos listados en objeto formulario para ser llamado en la estimacion rapida
            AsignarRecursoForm parametros = new AsignarRecursoForm();
            parametros.ListadoActividad = null;
            parametros.ListadoProyecto = listadoProyectos;

            if (listadoProyectos.Count != null) totalProy = listadoProyectos.Count;

            ViewData["totReg"] = 0;
            ViewData["accion"] = "0";
            ViewData["codProyIns"] = "0";

            return View(parametros);

        }

        //Muestra pantalla principal - pero con datos de formulario
        [HttpPost]
        public ActionResult AsignarRecursos(FormCollection formCollection)
        {
            string accion = formCollection["submitButton"].ToString();

            //Obtenemos código de proyecto
            String txtCodigo = formCollection["selProy"].ToString();

            //Adjuntamos listados en objeto formulario para ser llamado en la estimacion rapida
            AsignarRecursoForm parametros = new AsignarRecursoForm();

            if (accion.Equals("Buscar"))
            {
                if (!txtCodigo.Equals("0"))
                {
                    //Listado Actividades
                    List<Actividad> listadoActividades = null;
                    ActividadDAO Actividad = new ActividadDAO();

                    listadoActividades = Actividad.obtenerActividad2(Convert.ToInt32(txtCodigo));

                    parametros.ListadoActividad = listadoActividades;

                    ViewData["totReg"] = listadoActividades.Count;
                    ViewData["accion"] = "0";
                    ViewData["codProyIns"] = txtCodigo;

                    ViewData["idProyecto"] = "" + int.Parse(txtCodigo);

                }

                ProyectoDAO Proyecto = new ProyectoDAO();
                List<Proyecto> listadoProyectos = null;
                listadoProyectos = Proyecto.obtenerProyectoPorFiltro(1, 0, "SR");
                listadoProyectos.Insert(0, new Models.Proyecto() { codPro = 0, nomPro = "-- Escoja el proyecto --" });

                


                parametros.ListadoProyecto = listadoProyectos;

                return View(parametros);

            }
            else
            {
                // accion.Equals("Exportar a Excel")

                string proyecto = formCollection["idProyecto"].ToString();
                int idProyecto = int.Parse(proyecto);

                List<Actividad> listadoActividades = null;
                ActividadDAO Actividad = new ActividadDAO();

                listadoActividades = Actividad.obtenerActividad2(idProyecto);

                FileStream fs = new FileStream(AppDomain.CurrentDomain.SetupInformation.ApplicationBase + "\\Content\\reports\\AsignarRecursosPlantilla.xls", FileMode.Open, FileAccess.Read);
                HSSFWorkbook templateWorkbook = new HSSFWorkbook(fs, true);
                HSSFSheet sheet = templateWorkbook.GetSheet("Actividades");

                int indice = 1;

                foreach (Actividad item in listadoActividades)
                {
                    sheet.GetRow(indice).GetCell(0).SetCellValue("" + item.corAct);
                    sheet.GetRow(indice).GetCell(1).SetCellValue("" + item.desAct);
                    sheet.GetRow(indice).GetCell(2).SetCellValue("" + item.descripcionEntregable);
                    sheet.GetRow(indice).GetCell(3).SetCellValue("" + item.duracion);
                    sheet.GetRow(indice).GetCell(4).SetCellValue("" + item.feciniAct);
                    sheet.GetRow(indice).GetCell(5).SetCellValue("" + item.fecfinAct);
                    sheet.GetRow(indice).GetCell(6).SetCellValue("" + item.estado);
                    indice++;
                }

                MemoryStream ms = new MemoryStream();
                templateWorkbook.Write(ms);

                return File(ms.ToArray(), "application/vnd.ms-excel", "Asignar_Actividad_" + idProyecto);

            }

        }

        //Muestra pantalla detalle para asignacion de recursos
        [HttpGet]
        public ActionResult DetalleAsignarRecursos(string codAct, string txtCodigo)
        {

            //Listado Actividades
            List<Actividad> listadoActividades = null;
            ActividadDAO Actividad = new ActividadDAO();
            listadoActividades = Actividad.obtenerActividad(Convert.ToInt32(txtCodigo), Convert.ToInt32(codAct));

            //Recursos por Cargo
            List<Cargo> listadoCargo = null;
            CargoDAO Cargo = new CargoDAO();
            listadoCargo = Cargo.obtenerCargo();

            //Recursos por Equipo
            List<Recurso> listadoEquipos = null;
            RecursoDAO Equipo = new RecursoDAO();
            listadoEquipos = Equipo.obtenerRecurso(1);

            //Recursos por Materiales
            List<Recurso> listadoMateriales = null;
            RecursoDAO Materiales = new RecursoDAO();
            listadoMateriales = Materiales.obtenerRecurso(2);

            //Recursos por Empleados
            List<Recurso> listadoEmpleados = null;
            RecursoDAO Empleados = new RecursoDAO();
            listadoEmpleados = Empleados.obtenerRecurso(3);

            //TABLA DE RECURSOS POR ACTIVIDAD
            List<PlanRecursosActividad> listadoRecAct = null;
            PlanRecursosActividadDAO recursosAct = new PlanRecursosActividadDAO();
            listadoRecAct = recursosAct.obtenerPlanRecursosPorActividad(Convert.ToInt32(codAct));

            //Adjuntamos listados en objeto formulario para ser llamado en la estimacion rapida
            AsignarRecursoForm parametros = new AsignarRecursoForm();
            parametros.ListadoActividad = listadoActividades;
            parametros.ListadoCargo = listadoCargo;
            parametros.ListadoEquipos = listadoEquipos;
            parametros.ListadoMateriales = listadoMateriales;
            parametros.ListadoEmpleados = listadoEmpleados;
            parametros.ListadoRecursoActividad = listadoRecAct;
            ViewData["tipoRecursos"] = "0";
            ViewData["codProyIns"] = txtCodigo;
            ViewData["codAct"] = codAct;

            return View(parametros);       

        }

        //Muestra pantalla detalle para asignacion de recursos - post
        [HttpPost]
        public ActionResult DetalleAsignarRecursos(FormCollection formCollection)
        {
            int cantidad = int.Parse(formCollection["cantidad"]);
            double horas = 8;


            int codProyIns = int.Parse(formCollection["codProyIns"]);
            int idActividad = int.Parse(formCollection["codAct"]);

            int idRecurso = 0;

            if (formCollection["selRecCargo"] != null)
            {
                idRecurso = int.Parse(formCollection["selRecCargo"]);
            }
            else 
            {
                if (formCollection["selRecEquipo"] != null)
                {
                    idRecurso = int.Parse(formCollection["selRecEquipo"]);
                }
                else 
                {
                    if (formCollection["selRecMaterial"] != null) 
                    {
                        idRecurso = int.Parse(formCollection["selRecMaterial"]);
                    }
                }
            }

            PlanRecursosActividadDAO objPlanRecursosActividadDAO = new PlanRecursosActividadDAO();

            objPlanRecursosActividadDAO.RegistrarPlanRecursosPorActividad(idActividad, idRecurso, cantidad, horas);


            return DetalleAsignarRecursos("" + idActividad, "" + codProyIns);

            ////Listado Actividades
            //List<Actividad> listadoActividades = null;
            //ActividadDAO Actividad = new ActividadDAO();
            //listadoActividades = Actividad.obtenerActividad(idActividad, codProyIns);

            ////Recursos por Cargo
            //List<Cargo> listadoCargo = null;
            //CargoDAO Cargo = new CargoDAO();
            //listadoCargo = Cargo.obtenerCargo();

            ////Recursos por Equipo
            //List<Recurso> listadoEquipos = null;
            //RecursoDAO Equipo = new RecursoDAO();
            //listadoEquipos = Equipo.obtenerRecurso(1);

            ////Recursos por Materiales
            //List<Recurso> listadoMateriales = null;
            //RecursoDAO Materiales = new RecursoDAO();
            //listadoMateriales = Materiales.obtenerRecurso(2);

            ////Recursos por Empleados
            //List<Recurso> listadoEmpleados = null;
            //RecursoDAO Empleados = new RecursoDAO();
            //listadoEmpleados = Empleados.obtenerRecurso(3);

            ////TABLA DE RECURSOS POR ACTIVIDAD
            //List<PlanRecursosActividad> listadoRecAct = null;
            //PlanRecursosActividadDAO recursosAct = new PlanRecursosActividadDAO();
            //listadoRecAct = recursosAct.obtenerPlanRecursosPorActividad(idActividad);

            ////Adjuntamos listados en objeto formulario para ser llamado en la estimacion rapida
            //AsignarRecursoForm parametros = new AsignarRecursoForm();
            //parametros.ListadoActividad = listadoActividades;
            //parametros.ListadoCargo = listadoCargo;
            //parametros.ListadoEquipos = listadoEquipos;
            //parametros.ListadoMateriales = listadoMateriales;
            //parametros.ListadoEmpleados = listadoEmpleados;
            //parametros.ListadoRecursoActividad = listadoRecAct;
            //ViewData["tipoRecursos"] = "0";
            //ViewData["codProyIns"] = codProyIns;
            //ViewData["codAct"] = idActividad;


            //return View(parametros);





        }


        public ActionResult EliminarPlanRecurso(int idActividad, int idProyecto, int idRecurso)
        {
            
            PlanRecursosActividadDAO objPlanRecursosActividadDAO = new PlanRecursosActividadDAO();

            objPlanRecursosActividadDAO.EliminarPlanRecursosPorActividad(idActividad, idRecurso);


            return RedirectToAction("DetalleAsignarRecursos", new { codAct = idActividad, txtCodigo = idProyecto }); 
            
            //return DetalleAsignarRecursos("" + idActividad, "" + idProyecto);
        }



        //Muestra pantalla principal para informe de requerimientos
        public ActionResult InformesReq()
        {
            return View();
        }

        //Muestra plan de proyecto detalle y lo crea
        [HttpGet]
        public ActionResult CrearPlan(string codProy)
        {
            //Obtener Proyecto 
            List<Proyecto> listadoProyectos = null;
            ProyectoDAO ProyectoDAO = new ProyectoDAO();
            
            string nomProy = "";
            string monProy = "";
            string fecIniP = "";
            string fecFinP = "";
            string desProy = "";
            string tipProy = "";
            string priProy = "";
            string ubiProyDpto = "";
            string ubiProyProv = "";
            string ubiProyDist = "";
            double presupuesto = 0;

            listadoProyectos = ProyectoDAO.obtenerProyectoPorFiltro(0, Convert.ToInt32(codProy), "");
            
            foreach (Proyecto proy in listadoProyectos) {
                nomProy = proy.nomPro;
                monProy = proy.monfacPro;
                fecIniP = proy.feciniplaPro;
                fecFinP = proy.fecfinplaPro;
                desProy = proy.desPro;
                tipProy = proy.tipoProyecto;
                priProy = proy.priPro.ToString();
                ubiProyDpto = proy.nomUbiDep;
                ubiProyProv = proy.nomUbiProv;
                ubiProyDist = proy.nomUbiDist;
                presupuesto = proy.presupuesto;
            }

            //Hallamos presupuesto
            List<Presupuesto> listadoPresupuestos = null;
            PresupuestoDAO presupuestoDAO = new PresupuestoDAO();
            listadoPresupuestos = presupuestoDAO.obtenerPresupuestoPorFiltro(0, Convert.ToInt32(codProy), "");
            int codPre = 0; 

            foreach (Presupuesto pres in listadoPresupuestos) {
                codPre = pres.codPre;
            }

            //Hallamos detalle del presupuesto
            List<DetallePresupuesto> listadoPresDet = null;
            DetallePresupuestoDAO detPresDAO = new DetallePresupuestoDAO();
            listadoPresDet = detPresDAO.obtenerDetallePresupuestoPorFiltro(0, codPre);

            //Enviar valores de detalle del proyecto:
            ViewData["nomProy"] = nomProy;
            ViewData["preProy"] = monProy + " " + presupuesto;
            ViewData["fecIniP"] = fecIniP;
            ViewData["fecFinP"] = fecFinP;
            ViewData["desProy"] = desProy;
            ViewData["tipProy"] = tipProy;
            ViewData["priProy"] = priProy;
            ViewData["ubiProy"] = ubiProyDpto + ", " + ubiProyProv + ", " + ubiProyDist;

            //Enviar detalle de asignacion de presupuesto (listado):

            ViewData["codProy"] = codProy;
            return View(listadoPresDet);
        }

        //Muestra plan de proyecto detalle y lo crea
        [HttpPost]
        public ActionResult CrearPlan(FormCollection formCollection)
        {
            //txtCodProyAct
            String txtCodigo = formCollection["txtCodProyAct"].ToString();

            //Si antes ya se le grabó un plan de proyecto, no insertar
            //Verificar total de planes de proyecto
            PlanProyectoDAO planProyDAO = new PlanProyectoDAO();
            int totReg = planProyDAO.totalRegistros(Convert.ToInt32(txtCodigo));

            //Insertar plan de proyecto (sólo si no se ha ingresado ninguna actividad precedente)
            if (totReg == 0) {
                PlanProyecto planProy = new PlanProyecto();
                planProy.codFluCaj = 1;
                planProy.codPlaPro = Convert.ToInt32(txtCodigo);
                planProy.desPlaPro = "Plan de Proyecto " + (Convert.ToInt32(txtCodigo));
                planProy.codPro = Convert.ToInt32(txtCodigo);
                int codPlanProy = planProyDAO.insertarPlanProyecto(planProy);
            }

            //Derivamos a tercera pantalla
            return RedirectToAction("IngresoActividades", "Planificacion", new { codProy = txtCodigo, codPlanProy = txtCodigo });            
        }

        //Listado de proyectos pre-aprobados
        public ActionResult ListadoProyPlan()
        {
            //Listado Proyecto 
            List<Proyecto> listadoProyectos = null;
            ProyectoDAO Proyecto = new ProyectoDAO();

            listadoProyectos = Proyecto.obtenerProyectoPorFiltro(1,0,"PR");

            ViewData["totReg"] = listadoProyectos != null ? listadoProyectos.Count() : 0;
            //Caso error: no hay registros (msgErr)
            ViewData["msgErr"] = "";

            return View(listadoProyectos);
        }

        //Listado de proyectos pre-aprobados
        public ActionResult ListadoProyPlan2()
        {
            //Listado Proyecto 
            List<Proyecto> listadoProyectos = null;
            ProyectoDAO Proyecto = new ProyectoDAO();

            listadoProyectos = Proyecto.obtenerProyectoPorFiltro(1, 0, "PR");

            return View(listadoProyectos);
        }

        //Post
        [HttpPost]
        public ActionResult ListadoProyPlan(FormCollection formCollection)
        {
            //Listado Proyecto 
            List<Proyecto> listadoProyectos = null;
            ProyectoDAO Proyecto = new ProyectoDAO();
            String txtCodigo = formCollection["txtCodProy"].ToString();

            //Si es vacío, mostrar msg de error
            if (txtCodigo.Equals(""))
            {
                ViewData["msgErr"] = "Valores vacíos. Por favor, ingrese un código válido para la búsqueda";
            }
            else 
            {
                int codPro = 0;
                bool result = int.TryParse(txtCodigo,out codPro);

                if (codPro == 0)
                {
                    ViewData["msgErr"] = "Valores incorrectos. Por favor, ingrese un código válido para la búsqueda";
                }
                else 
                {
                    codPro = Convert.ToInt32(txtCodigo);

                    listadoProyectos = Proyecto.obtenerProyectoPorFiltro(2, codPro, "PR");

                    if (listadoProyectos != null)
                    {
                        ViewData["msgErr"] = "";
                        ViewData["totReg"] = listadoProyectos.Count;
                    }
                    else
                    {
                        ViewData["msgErr"] = "No se encontraron registros para su búsqueda";
                    }                           
                }
 
            }
            return View(listadoProyectos);
        }

        //Ingreso de Actividades
        [HttpGet]
        public ActionResult IngresoActividades(string codProy, string codPlanProy)
        {
            ViewData["codProy"] = codProy;
            ViewData["codPlanProy"] = codPlanProy;

            //Obtener datos del proyecto
            string fechIniProy = "";
            string fechIniFin = "";
            ProyectoDAO proyDAO = new ProyectoDAO();
            List<Proyecto> listadoProy = new List<Proyecto>();

            listadoProy = proyDAO.obtenerProyectoPorFiltro(2, Convert.ToInt32(codProy), "PR");

            foreach (Proyecto proyecto in listadoProy)
            {
                fechIniProy = proyecto.feciniplaPro;
                fechIniFin = proyecto.fecfinplaPro;
            }

            //Solo si hay elementos dentro de las actividades
            //Verificar total de planes de proyecto
            PlanProyectoDAO planProyDAO = new PlanProyectoDAO();
            int totReg = planProyDAO.totalRegistros(Convert.ToInt32(codPlanProy));
            int totRegAct = 0;

            if (totReg > 0) {
                //Si es que ya se agrego por planificación rápida, mostrar:
                ActividadDAO actividadDAO = new ActividadDAO();
                listadoActividadesTemp = actividadDAO.obtenerActividad(Convert.ToInt32(codProy),0);
                if (listadoActividadesTemp != null) totRegAct = listadoActividadesTemp.Count;                
            }            

            ViewData["fechIniProy"] = fechIniProy;
            ViewData["fechIniFin"] = fechIniFin;
            ViewData["duracionProy"] = "6";
            ViewData["totReg"] = totRegAct;
            ViewData["accion"] = "0";

            return View(listadoActividadesTemp);
        }

        //Ingreso de Actividades - Post
        [HttpPost]
        public ActionResult IngresoActividades(FormCollection formCollection)
        {
            String codProy = formCollection["txtCodPro"].ToString();
            String codPlanProy = formCollection["txtCodPlaPro"].ToString();
            String fechIniProy = formCollection["txtFecIniPro"].ToString();
            String fechIniFin = formCollection["txtFecFinPro"].ToString();
            String accion = formCollection["txtAccion"].ToString();
            String message = "";


            string nombreBoton = formCollection["submitButton"].ToString();

            int accionAct = Convert.ToInt32(accion);



            //List<Actividad> listadoActividades = new List<Actividad>();
            ActividadDAO actividadDAO = new ActividadDAO();
            Actividad actividad = new Actividad();

            ViewData["codProy"] = codProy;
            ViewData["codPlanProy"] = codPlanProy;
            ViewData["fechIniProy"] = fechIniProy;
            ViewData["fechIniFin"] = fechIniFin;

            //Solo si hay elementos dentro de las actividades
            //Verificar total de planes de proyecto
            int totReg = Convert.ToInt32(formCollection["txtTotReg"].ToString());
            //actividadDAO.totalRegistros(1, Convert.ToInt32(codPlanProy));

            //if (totReg > 0)
            //{
                //Si es que ya se agrego por planificación rápida, mostrar:
            //    listadoActividadesTemp = actividadDAO.obtenerActividad(Convert.ToInt32(codProy),0);
            //}            

            //Segun el tipo de accion, hace algunas cosas:
            if (nombreBoton.Equals("     1      "))
            {
                //????                
            }


            if (nombreBoton.Equals("Guardar Cambios"))
            {
                //Insertamos nuevo registro pero buscamos actividad ultima correlativa
                int totRegCorr = 0;
                totRegCorr = actividadDAO.totalRegistros(0, 0);

                //Solo si totRegCorr es mayor a 0 se puede obtener el último valor:
                if (totRegCorr > 0) {
                    totRegCorr = actividadDAO.totalRegistros(2, 0);
                }

                //Luego, eliminamos todas las actividades de un plan para ingresarlas nuevamente
                actividadDAO.eliminarActividad(1, 0, Convert.ToInt32(codPlanProy));

                //Guardamos cambios dentro de la tabla. Si se quiere cambiar mas tarde, ahí están
                for (int i = 1; i <= totReg; i++)
                {
                    //Obtenemos el valor de cada objeto seleccionado:
                    string valEli = formCollection["chk_Eli" + i];
                    if (valEli == null)
                    {
                        valEli = "ok";
                    }
                    else {
                        valEli = formCollection["chk_Eli" + i].ToString();
                    }

                    //En caso de que se elimine, no agregar actividad
                    if (valEli.Equals("ok")) {

                        string codEnt = formCollection["sel_Ent" + i].ToString();
                        string descAct = formCollection["txt_nomAct_" + i].ToString();
                        string fecIniAct = formCollection["txt_fecIni" + i].ToString();
                        string fecFinAct = formCollection["txt_fecFin" + i].ToString();
                        string predecAct = formCollection["txt_Pred" + i].ToString();

                        //Adicionamos a un objeto actividad
                        actividad.codAct = (totRegCorr + 1);
                        actividad.corAct = i;
                        actividad.codEnt = Convert.ToInt32(codEnt);

                        if (actividad.codEnt == 1) ViewData["entSel1"] = "selected";
                        if (actividad.codEnt == 2) ViewData["entSel2"] = "selected";
                        if (actividad.codEnt == 3) ViewData["entSel3"] = "selected";
                        actividad.codPlaPro = Convert.ToInt32(codPlanProy);
                        actividad.desAct = descAct;
                        actividad.feciniAct = fecIniAct;
                        actividad.fecfinAct = fecFinAct;
                        actividad.preAct = predecAct;
                        actividad.tipAct = "0";
                        int ins = 0;
                        ins = actividadDAO.insertarActividad(actividad);
                        totRegCorr = totRegCorr + 1;
                        //Caso modificar
                        //int upd = 0;
                        //actividad.corAct = i;
                        //actividad.codPlaPro = Convert.ToInt32(codPlanProy);
                        //actividad.desAct = descAct;
                        //actividad.feciniAct = fecIniAct;
                        //actividad.fecfinAct = fecFinAct;
                        //actividad.preAct = predecAct;
                        //upd = actividadDAO.actualizarActividad(actividad);

                    }
                    
                };
                listadoActividadesTemp = null;
                listadoActividadesTemp = actividadDAO.obtenerActividad(Convert.ToInt32(codProy),0);
                message = "Se guardaron las actividades seleccionadas";

                ViewData["Message"] = message;
                ViewData["totReg"] = totReg;
                ViewData["accion"] = "0";

                return View(listadoActividadesTemp);

            }

            if (nombreBoton.Equals("    3       "))
            { 
                //Eliminamos actividades
            }

            
            if (nombreBoton.Equals("Crear Plan"))
            {
                //Se da por finalizada la planificacion. Se graba el proyecto con status "SRE" (Planificado-actividades)
                ProyectoDAO proyDAO = new ProyectoDAO();
                int estatusProy = 0;

                estatusProy = proyDAO.actualizarProyecto(Convert.ToInt32(codProy), "SR");

                listadoActividadesTemp = null;
                listadoActividadesTemp = actividadDAO.obtenerActividad(Convert.ToInt32(codProy),0);
                
                message = "El Plan de Proyecto ha sido creado satisfactoriamente";

                ViewData["Message"] = message;
                ViewData["totReg"] = totReg;
                ViewData["accion"] = "0";

                return View(listadoActividadesTemp);

            }
            
            if (nombreBoton.Equals("Exportar a Excel"))
            {
                int idProyecto = int.Parse(codProy);

                List<Actividad> listadoActividades = null;
                ActividadDAO Actividad = new ActividadDAO();

                listadoActividades = Actividad.obtenerActividad(idProyecto, 0);
                listadoActividadesTemp = listadoActividades;

                FileStream fs = new FileStream(AppDomain.CurrentDomain.SetupInformation.ApplicationBase + "\\Content\\reports\\AsignarActividadesPlantilla.xls", FileMode.Open, FileAccess.Read);
                HSSFWorkbook templateWorkbook = new HSSFWorkbook(fs, true);
                HSSFSheet sheet = templateWorkbook.GetSheet("Actividades");

                int indice = 1;

                foreach (Actividad item in listadoActividades)
                {
                    sheet.GetRow(indice).GetCell(0).SetCellValue("" + item.corAct);
                    sheet.GetRow(indice).GetCell(1).SetCellValue("" + item.descripcionEntregable);
                    sheet.GetRow(indice).GetCell(2).SetCellValue("" + item.desAct);
                    sheet.GetRow(indice).GetCell(3).SetCellValue("" + item.feciniAct);
                    sheet.GetRow(indice).GetCell(4).SetCellValue("" + item.fecfinAct);
                    sheet.GetRow(indice).GetCell(5).SetCellValue("" + item.preAct);
                    indice++;
                }

                MemoryStream ms = new MemoryStream();
                templateWorkbook.Write(ms);

                return File(ms.ToArray(), "application/vnd.ms-excel", "Asignar_Actividad_" + idProyecto);            

            }

            ViewData["Message"] = message;
            ViewData["totReg"] = totReg;
            ViewData["accion"] = "0";

            return View(listadoActividadesTemp);
        }

        //Estimado Rapido (Get)
        [HttpGet]
        public ActionResult EstimadoRapido(String txtCodigo)
        {
            ViewData["codProy"] = txtCodigo;

            //Listado Tipos Proyecto 
            List<TipoProyecto> listadoTipoProyectos = null;
            TipoProyectoDAO TipoProyecto = new TipoProyectoDAO();
            listadoTipoProyectos = TipoProyecto.obtenerTipoProyecto();

            //Listado de Proyectos historicos a escoger
            List<ProyectoHist> listadoProyectoHist = null;
            ProyectoHistDAO proyHistDAO = new ProyectoHistDAO();
            listadoProyectoHist = proyHistDAO.obtenerProyectoHistPorFiltro(1,1,"FN",0,"",0,0,0);

            //Adjuntamos listado de ubigeos (Departamento)
            UbigeoDAO ubigeoDAO = new UbigeoDAO();
            List<Ubigeo> listadoUbigeoDep = null;
            listadoUbigeoDep = ubigeoDAO.obtenerUbigeo(0,14,1,0);

            //Adjuntamos listado de ubigeos (Provincia)
            List<Ubigeo> listadoUbigeoProv = null;
            listadoUbigeoProv = ubigeoDAO.obtenerUbigeo(1, 14, 1, 0);

            //Adjuntamos listado de ubigeos (Distrito)
            List<Ubigeo> listadoUbigeoDist = null;
            listadoUbigeoDist = ubigeoDAO.obtenerUbigeo(2,14,1,0);

            //Adjuntamos listados en objeto formulario para ser llamado en la estimacion rapida
            EstimadoRapidoForm parametros = new EstimadoRapidoForm();
            parametros.ListadoTipoProyecto = listadoTipoProyectos;
            parametros.ListadoProyectoHist = listadoProyectoHist;
            parametros.ListadoUbigeoDep = listadoUbigeoDep;
            parametros.ListadoUbigeoProv = listadoUbigeoProv;
            parametros.ListadoUbigeoDist = listadoUbigeoDist;

            ViewData["totReg"] = listadoProyectoHist.Count;
            ViewData["accion"] = "0";

            return View(parametros);
        }

        //Estimado Rapido (Post)
        [HttpPost]
        public ActionResult EstimadoRapido(FormCollection formCollection)
        {
            //Obtenemos valores de formulario anterior para mostrarlos nuevamente en la pantalla
            String codProy = formCollection["txtCodProyAct"].ToString();
            String accion = formCollection["txtAccion"].ToString();
            String txtTipDur = formCollection["duracion"].ToString();
            String txtCantDur = formCollection["cantDuracion"].ToString();
            String txtTipProy = formCollection["tipo"].ToString();
            String txtPriProy = formCollection["prioridad"].ToString();
            String txtPreProy = formCollection["presupuesto"].ToString();
            List<ProyectoHist> listadoProyectoHist = null;
            int codAccion = Convert.ToInt32(accion);
            int duracion = 0;
            int tipProy = 0;
            int priProy = 0;
            int presupuesto = 0;

            //Si se ingresaron valores incorrectos
            bool result = int.TryParse(txtCantDur, out duracion);

            if (duracion == 0 && !txtCantDur.Equals(""))
            {
                ViewData["msgErr"] = "Valores incorrectos. Por favor, ingrese un código válido para la búsqueda";
            }
            else
            {
                //A partir de aca todo es permitido
                //Si no se ingresa duracion, valor = 0
                if (!txtCantDur.Equals(""))
                {
                    duracion = Convert.ToInt32(txtCantDur);
                }
                //Si no se ingresa tipo de proyecto, valor 0
                if (!txtTipProy.Equals(""))
                {
                    tipProy = Convert.ToInt32(txtTipProy);
                }
                //Si no se ingresa prioridad de proyecto valor 0
                if (!txtPriProy.Equals(""))
                {
                    priProy = Convert.ToInt32(txtPriProy);
                }
                //Si no se ingresa presupuesto valor 0
                if (!txtPreProy.Equals(""))
                {
                    presupuesto = Convert.ToInt32(txtPreProy);
                }
                int tipoAccion = 0;
                int codDpto = 0;
                int codProv = 0;
                int codDist = 0;

                if (codAccion == 0)
                {
                    //Busqueda especial (todos los filtros)
                    tipoAccion = 4;
                }
                if (codAccion == 1)
                {
                    //Muestra provincias + listado generico
                    tipoAccion = 1;
                }
                if (codAccion == 2)
                {
                    //Muestra distritos + listado generico
                } 

                //Listado de Proyectos historicos a escoger
                ProyectoHistDAO proyHistDAO = new ProyectoHistDAO();
                listadoProyectoHist = proyHistDAO.obtenerProyectoHistPorFiltro(2, 1, "FN", duracion, txtTipDur, tipProy, priProy, presupuesto);

                if (listadoProyectoHist != null)
                {
                    ViewData["msgErr"] = "";
                    ViewData["totReg"] = listadoProyectoHist.Count;
                }
                else
                {
                    ViewData["msgErr"] = "No se encontraron registros para su búsqueda";
                } 
            }

            //Listado Tipos Proyecto 
            List<TipoProyecto> listadoTipoProyectos = null;
            TipoProyectoDAO TipoProyecto = new TipoProyectoDAO();
            listadoTipoProyectos = TipoProyecto.obtenerTipoProyecto();

            //Adjuntamos listado de ubigeos (Departamento)
            List<Ubigeo> listadoUbigeoDep = null;
            UbigeoDAO ubigeoDAO = new UbigeoDAO();
            listadoUbigeoDep = ubigeoDAO.obtenerUbigeo(0, 0, 0, 0);

            //Adjuntamos listados en objeto formulario para ser llamado en la estimacion rapida
            EstimadoRapidoForm parametros = new EstimadoRapidoForm();
            parametros.ListadoTipoProyecto = listadoTipoProyectos;
            parametros.ListadoProyectoHist = listadoProyectoHist;
            parametros.ListadoUbigeoDep = listadoUbigeoDep;

            ViewData["codProy"] = codProy;
            ViewData["accion"] = "0";

            return View(parametros);
        }

        //Detalle Plan Historico
        [HttpGet]
        public ActionResult DetallePlanHistorico(int codProyAct, int codProyHist)
        {
            //Obtenemos valores de proyecto actual
            string durTotProyAct = "3";
            double presProyAct = 0;
            string monPresProyAct = "";
            string durTotProyHist = "4";
            double presProyHist = 0;
            string monPresProyHis = "";

            //Obtenemos el presupuesto total del proyecto actual
            PresupuestoDAO presupuestoDAO = new PresupuestoDAO();
            List<Presupuesto> listadoPresupuestosAct = null;
            listadoPresupuestosAct = presupuestoDAO.obtenerPresupuestoPorFiltro(0, Convert.ToInt32(codProyAct), "");

            foreach (Presupuesto pres in listadoPresupuestosAct)
            {
                presProyAct = pres.impPre;
            }

            //Obtenemos el presupuesto total del proyecto historico
            List<Presupuesto> listadoPresupuestosHist = null;
            listadoPresupuestosHist = presupuestoDAO.obtenerPresupuestoPorFiltro(0, Convert.ToInt32(codProyHist), "");

            foreach (Presupuesto pres in listadoPresupuestosHist)
            {
                presProyHist = pres.impPre;
            }

            //Obtenemos informacion del proyecto (historico)

            //Obtenemos informacion del proyecto (actual)

            ViewData["codProy"] = codProyAct;               //Codigo de proyecto actual
            ViewData["codProyHist"] = codProyHist;          //Codigo de proyecto historico
            ViewData["durProyAct"] = durTotProyAct;         //durProyAct
            ViewData["presProyAct"] = presProyAct;          //presProyAct
            ViewData["durProyHist"] = durTotProyHist;       //durProyHist
            ViewData["presProyHist"] = presProyHist;        //presProyHist

            //Obtenemos el detalle de las actividades historicas
            ActividadHistDAO actividadHistDAO = new ActividadHistDAO();
            List<ActividadHist> listadoActividadHist = null;
            listadoActividadHist = actividadHistDAO.obtenerActividadHist(0, Convert.ToInt32(codProyHist));

            return View(listadoActividadHist);
        }

        //Detalle Plan Historico (asignacion final)
        [HttpPost]
        public ActionResult DetallePlanHistorico(FormCollection formCollection)
        {
            //Variables para ir trabajando
            String codProyAct = formCollection["txtCodProyAct"].ToString();
            String codProyHist = formCollection["txtCodProyHis"].ToString();

            //Obtenemos valores de proyecto actual
            string durTotProyAct = "3";
            double presProyAct = 0;
            string monPresProyAct = "";
            string durTotProyHist = "4";
            double presProyHist = 0;
            string monPresProyHis = "";

            //Obtenemos el presupuesto total del proyecto actual
            PresupuestoDAO presupuestoDAO = new PresupuestoDAO();
            List<Presupuesto> listadoPresupuestosAct = null;
            listadoPresupuestosAct = presupuestoDAO.obtenerPresupuestoPorFiltro(0, Convert.ToInt32(codProyAct), "");

            foreach (Presupuesto pres in listadoPresupuestosAct)
            {
                presProyAct = pres.impPre;
            }

            //Obtenemos el presupuesto total del proyecto historico
            List<Presupuesto> listadoPresupuestosHist = null;
            listadoPresupuestosHist = presupuestoDAO.obtenerPresupuestoPorFiltro(0, Convert.ToInt32(codProyHist), "");

            foreach (Presupuesto pres in listadoPresupuestosHist)
            {
                presProyHist = pres.impPre;
            }

            //Obtenemos informacion del proyecto (historico)

            //Obtenemos informacion del proyecto (actual)

            ViewData["codProy"] = codProyAct;               //Codigo de proyecto actual
            ViewData["codProyHist"] = codProyHist;          //Codigo de proyecto historico
            ViewData["durProyAct"] = durTotProyAct;         //durProyAct
            ViewData["presProyAct"] = presProyAct;          //presProyAct
            ViewData["durProyHist"] = durTotProyHist;       //durProyHist
            ViewData["presProyHist"] = presProyHist;        //presProyHist

            //Obtenemos el detalle de las actividades historicas
            ActividadHistDAO actividadHistDAO = new ActividadHistDAO();
            List<ActividadHist> listadoActividadHist = null;
            listadoActividadHist = actividadHistDAO.obtenerActividadHist(0, Convert.ToInt32(codProyHist));

            //Insertar plan de proyecto
            PlanProyectoDAO planProyDAO = new PlanProyectoDAO();
            PlanProyecto planProy = new PlanProyecto();
            planProy.codFluCaj = 1;
            planProy.codPlaPro = Convert.ToInt32(codProyAct);
            planProy.desPlaPro = "Plan de Proyecto " + codProyAct;
            planProy.codPro = Convert.ToInt32(codProyAct);
            int codPlanProy = planProyDAO.insertarPlanProyecto(planProy);

            //Luego de insertado el proyecto, insertar las actividades
            ActividadDAO actividadDAO = new ActividadDAO();
            Actividad actividad = null;
            int resultado = 0;

            foreach (ActividadHist actHis in listadoActividadHist)
            {
                actividad = new Actividad();
                actividad.codAct = (actividadDAO.totalRegistros(0, Convert.ToInt32(codProyAct))) + 1;
                actividad.corAct = actHis.corAct;
                actividad.desAct = actHis.desAct;
                actividad.feciniAct = actHis.feciniAct;
                actividad.fecfinAct = actHis.fecfinAct;
                actividad.preAct = actHis.preAct;
                actividad.tipAct = actHis.tipAct;
                actividad.codEnt = actHis.codEnt;
                actividad.codPlaPro = Convert.ToInt32(codProyAct);
                resultado = actividadDAO.insertarActividad(actividad);
            }

            //Si se insertaron todas las actividades al proyecto actual, mostrar mensaje OK
            ViewData["msg"] = "Las actividades asociadas al proyecto histórico " + codProyHist + " fueron asociadas al proyecto actual satisfactoriamente";

            return View(listadoActividadHist);

        }

    }
}
