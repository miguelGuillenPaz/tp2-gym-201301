using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Collections;
using DemoMVC.Models;

namespace DemoMVC.Persistencia
{
    public class ProyectoHistDAO
    {

        //Listado de ProyectoHists
        public List<ProyectoHist> obtenerProyectoHistPorFiltro(int tipoFiltro, int codProy, string statusProy, int durProy, string tipDurProy, int codTipProy, int priProy, int presupuesto)
        {
            List<ProyectoHist> listadoProyectoHists = null;
            ProyectoHist ProyectoHist = null;
            string sql = "";

            if (tipoFiltro == 0)
            {
                //Filtro por código único de proyecto histórico
                sql = "select proy.*, tipProy.NombreTipoProy, preProy.ImporteTotal, ubigeo.NombreDep, ubigeo.NombreProv, ubigeo.NombreDist from dbo.GPP_ProyectoHist proy ";
                sql = sql + "inner join dbo.GPP_TipoProyecto tipProy on tipProy.IdTipoProyecto = proy.IdTipoProyecto ";
                sql = sql + "inner join dbo.GPP_Presupuesto preProy on preProy.IdProyecto = proy.IdProyectoHist ";
                sql = sql + "inner join dbo.GPP_Ubigeo ubigeo on ubigeo.IdUbigeo = proy.IdUbigeo ";
                sql = sql + "where proy.IdProyectoHist=@codPro";               
            }
            if (tipoFiltro == 1)
            {
                //Listado de proyectos históricos
                sql = "select proy.*, tipProy.NombreTipoProy, preProy.ImporteTotal, ubigeo.NombreDep, ubigeo.NombreProv, ubigeo.NombreDist from dbo.GPP_ProyectoHist proy ";
                sql = sql + "inner join dbo.GPP_TipoProyecto tipProy on tipProy.IdTipoProyecto = proy.IdTipoProyecto ";
                sql = sql + "inner join dbo.GPP_Presupuesto preProy on preProy.IdProyecto = proy.IdProyectoHist ";
                sql = sql + "inner join dbo.GPP_Ubigeo ubigeo on ubigeo.IdUbigeo = proy.IdUbigeo ";
                sql = sql + "where proy.Estado=@estPro";
            }
            if (tipoFiltro == 2)
            {
                sql = "select proy.*, tipProy.NombreTipoProy, preProy.ImporteTotal, ubigeo.NombreDep, ubigeo.NombreProv, ubigeo.NombreDist from dbo.GPP_ProyectoHist proy ";
                sql = sql + "inner join dbo.GPP_TipoProyecto tipProy on tipProy.IdTipoProyecto = proy.IdTipoProyecto ";
                sql = sql + "inner join dbo.GPP_Presupuesto preProy on preProy.IdProyecto = proy.IdProyectoHist ";
                sql = sql + "inner join dbo.GPP_Ubigeo ubigeo on ubigeo.IdUbigeo = proy.IdUbigeo "; 
                sql = sql + "where proy.Estado=@estPro ";
                //Listado por filtros
                //Filtro por duracion del proyecto
                if (durProy > 0)
                {
                    if (tipDurProy.Equals("d"))
                    {
                        sql = sql + "and DATEDIFF(DAY, CONVERT(DATETIME,proy.FechaInicioPlaneada), CONVERT(DATETIME,proy.FechaFinPlaneada)) = @durPro ";
                    }
                    if (tipDurProy.Equals("m"))
                    {
                        sql = sql + "and DATEDIFF(MONTH, CONVERT(DATETIME,proy.FechaInicioPlaneada), CONVERT(DATETIME,proy.FechaFinPlaneada)) = @durPro ";
                    }
                    if (tipDurProy.Equals("y"))
                    {
                        sql = sql + "and DATEDIFF(YEAR, CONVERT(DATETIME,proy.FechaInicioPlaneada), CONVERT(DATETIME,proy.FechaFinPlaneada)) = @durPro ";
                    }
                }
                //Filtro por tipo de proyecto
                if (codTipProy > 0) {
                    sql = sql + "and proy.IdTipoProyecto=@tipPro ";
                }
                //Filtro por prioridad de proyecto
                if (priProy > 0)
                {
                    sql = sql + "and proy.Prioridad=@priPro ";
                }
                //Filtro por presupuesto
                if (presupuesto > 0) {
                    if (presupuesto == 1) {
                        //Menos de 50,000.00
                        sql = sql + "and preProy.ImporteTotal between 0 and 50000 ";
                    }
                    if (presupuesto == 2) {
                        //50,001.00 - 100,000.00
                        sql = sql + "and preProy.ImporteTotal between 50001 and 100000 ";
                    }
                    if (presupuesto == 3)
                    {   //100,001.00 - 800,000.00
                        sql = sql + "and preProy.ImporteTotal between 100001 and 800000 ";    
                    }
                    if (presupuesto == 4)
                    {   //800,001.00 a más
                        sql = sql + "and preProy.ImporteTotal > 800001 ";
                    }
                }
            }

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                con.Open();
                using (SqlCommand com = new SqlCommand(sql, con))
                {
                    if (tipoFiltro == 0)
                    {
                        com.Parameters.Add(new SqlParameter("@codPro", codProy));
                    }
                    if (tipoFiltro == 1)
                    {
                        com.Parameters.Add(new SqlParameter("@estPro", statusProy));
                    }
                    if (tipoFiltro == 2)
                    {
                        com.Parameters.Add(new SqlParameter("@estPro", statusProy));
                        if (durProy > 0) {
                            com.Parameters.Add(new SqlParameter("@durPro", durProy));
                        }                        
                        if (codTipProy > 0) {
                            com.Parameters.Add(new SqlParameter("@tipPro", codTipProy));
                        }
                        if (priProy > 0)
                        {
                            com.Parameters.Add(new SqlParameter("@priPro", priProy));
                        }
                    }

                    using (SqlDataReader resultado = com.ExecuteReader())
                    {
                        if (resultado.HasRows)
                        {
                            //Obtenemos uno por uno
                            listadoProyectoHists = new List<ProyectoHist>();
                            while (resultado.Read())
                            {
                                //Recorremos objeto por objeto y anadimos
                                ProyectoHist = new ProyectoHist
                                {
                                    codPro = (int)resultado["IdProyectoHist"],
                                    codTipPro = (int)resultado["IdTipoProyecto"],
                                    nomPro = (string)resultado["Nombre"],
                                    feciniplaPro = (string)resultado["FechaInicioPlaneada"],
                                    fecfinplaPro = (string)resultado["FechaFinPlaneada"],
                                    fecinireaPro = (string)resultado["FechaInicioReal"],
                                    fecfinreaPro = (string)resultado["FechaFinReal"],
                                    priPro = (int)resultado["Prioridad"],
                                    desPro = (string)resultado["Descripcion"],
                                    razsocfacPro = (string)resultado["RazonSocial"],
                                    conpagPro = (string)resultado["CondicionPago"],
                                    monfacPro = (string)resultado["MontoFacturado"],
                                    nrohojenvPro = (int)resultado["NroHojaEnvio"],
                                    fechojenvPro = (string)resultado["FechaHojaEnvio"],
                                    estPro = (string)resultado["Estado"],
                                    rucfacPro = (string)resultado["Ruc"],
                                    tipoProyecto = (string)resultado["NombreTipoProy"],
                                    presupuesto = (double)resultado["ImporteTotal"],
                                    nomUbiDep = (string)resultado["NombreDep"],
                                    nomUbiProv = (string)resultado["NombreProv"],
                                    nomUbiDist = (string)resultado["NombreDist"],
                                };
                                listadoProyectoHists.Add(ProyectoHist);

                            }
                        }
                        else
                        {
                            Debug.WriteLine("No retornó registros");
                        }
                    }
                    con.Close();
                }
            }
            return listadoProyectoHists;
        }

    }
}