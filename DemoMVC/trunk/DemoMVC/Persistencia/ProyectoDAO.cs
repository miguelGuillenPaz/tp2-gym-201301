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
    public class ProyectoDAO
    {

        //Actualizar estado de proyecto para indicar que ya se asociaron las actividades
        public int actualizarProyecto(int codPro, string estPro)
        {
            string sql = "update dbo.GPP_Proyecto set Estado=@estPro where IdProyecto=@codPro";
            int totUpd = 0;

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                try
                {
                    SqlCommand cmdUpd = new SqlCommand(sql, con);
                    cmdUpd.Parameters.AddWithValue("@codPro", codPro);
                    cmdUpd.Parameters.AddWithValue("@estPro", estPro);
                    con.Open();
                    totUpd = Convert.ToInt32(cmdUpd.ExecuteScalar());
                    con.Close();
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.ToString(), ex);
                }
            }
            return totUpd;
        }

        //Listado de proyectos
        public List<Proyecto> obtenerProyectoPorFiltro(int tipoFiltro, int codProy, string statusProy)
        {
            List<Proyecto> listadoProyectos = null;
            Proyecto proyecto = null;
            string sql = "";

            if (tipoFiltro == 0) {
                //sql = "select * from dbo.GPP_Proyecto where IdProyecto=@codPro";
                sql = "select proy.*, tipProy.NombreTipoProy, preProy.ImporteTotal, ubigeo.NombreDep, ubigeo.NombreProv, ubigeo.NombreDist from dbo.GPP_Proyecto proy ";
                sql = sql + "inner join dbo.GPP_TipoProyecto tipProy on tipProy.IdTipoProyecto = proy.IdTipoProyecto ";
                sql = sql + "inner join dbo.GPP_Presupuesto preProy on preProy.IdProyecto = proy.IdProyecto ";
                sql = sql + "inner join dbo.GPP_Ubigeo ubigeo on ubigeo.IdUbigeo = proy.IdUbigeo ";
                sql = sql + "where proy.IdProyecto=@codPro";
            }
            if (tipoFiltro == 1) {
                sql = "select proy.*, tipProy.NombreTipoProy, preProy.ImporteTotal, ubigeo.NombreDep, ubigeo.NombreProv, ubigeo.NombreDist from dbo.GPP_Proyecto proy ";
                sql = sql + "inner join dbo.GPP_TipoProyecto tipProy on tipProy.IdTipoProyecto = proy.IdTipoProyecto ";
                sql = sql + "inner join dbo.GPP_Presupuesto preProy on preProy.IdProyecto = proy.IdProyecto ";
                sql = sql + "inner join dbo.GPP_Ubigeo ubigeo on ubigeo.IdUbigeo = proy.IdUbigeo ";
                sql = sql + "where proy.Estado=@estPro";
            }
            if (tipoFiltro == 2) 
            {
                sql = "select proy.*, tipProy.NombreTipoProy, preProy.ImporteTotal, ubigeo.NombreDep, ubigeo.NombreProv, ubigeo.NombreDist from dbo.GPP_Proyecto proy ";
                sql = sql + "inner join dbo.GPP_TipoProyecto tipProy on tipProy.IdTipoProyecto = proy.IdTipoProyecto ";
                sql = sql + "inner join dbo.GPP_Presupuesto preProy on preProy.IdProyecto = proy.IdProyecto ";
                sql = sql + "inner join dbo.GPP_Ubigeo ubigeo on ubigeo.IdUbigeo = proy.IdUbigeo ";
                sql = sql + "where proy.IdProyecto=@codPro and proy.Estado=@estPro";
            } 

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena)) {
                con.Open();
                using (SqlCommand com = new SqlCommand(sql, con)) {
                    if (tipoFiltro == 0) {
                        com.Parameters.Add(new SqlParameter("@codPro", codProy));
                    }
                    if (tipoFiltro == 1)
                    {
                        com.Parameters.Add(new SqlParameter("@estPro", statusProy));
                    }
                    if (tipoFiltro == 2)
                    {
                        com.Parameters.Add(new SqlParameter("@codPro", codProy));
                        com.Parameters.Add(new SqlParameter("@estPro", statusProy));
                    }
                    if (tipoFiltro == 3)
                    {
                        sql = "select proy.IdProyecto, proy.Nombre ";
                        sql = sql + "from dbo.GPP_Proyecto proy ";
                        sql = sql + "where proy.Estado=@Estado";
                    }

                    using (SqlDataReader resultado = com.ExecuteReader())
                    {
                        if (resultado.HasRows)
                        {
                            //Obtenemos uno por uno
                            listadoProyectos = new List<Proyecto>();
                            while (resultado.Read())
                            {
                                //Recorremos objeto por objeto y anadimos
                                proyecto = new Proyecto
                                {
                                    codPro = (int)resultado["IdProyecto"],
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
                                    nrohojenvPro = (string)resultado["NroHojaEnvio"],
                                    fechojenvPro = (string)resultado["FechaHojaEnvio"],
                                    estPro = (string)resultado["Estado"],
                                    rucfacPro = (string)resultado["Ruc"],
                                    tipoProyecto = (string)resultado["NombreTipoProy"],
                                    presupuesto = (double)resultado["ImporteTotal"],
                                    nomUbiDep = (string)resultado["NombreDep"],
                                    nomUbiProv = (string)resultado["NombreProv"],
                                    nomUbiDist = (string)resultado["NombreDist"],
                                };
                                listadoProyectos.Add(proyecto);
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
            return listadoProyectos;
        }

    }
}