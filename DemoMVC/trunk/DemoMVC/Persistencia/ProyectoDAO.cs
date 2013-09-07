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
                    /*if (tipoFiltro == 3)
                    {
                        sql = "select proy.IdProyecto, proy.Nombre ";
                        sql = sql + "from dbo.GPP_Proyecto proy ";
                        sql = sql + "where proy.Estado=@Estado";
                    }*/

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
                                    //LINEAS ABAJO ESTA LO MISMO, PERO VALIDANDO QUE SI SON NULLS DEVUELVAN VACÍOS O CERO
                                    /*nomPro = (string)resultado["Nombre"],
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
                                     */
                                    nomPro = (System.DBNull.Value.Equals(resultado["Nombre"]) ? "" : resultado["Nombre"].ToString()),
                                    feciniplaPro = (System.DBNull.Value.Equals(resultado["FechaInicioPlaneada"]) ? "" : resultado["FechaInicioPlaneada"].ToString()),
                                    fecfinplaPro = (System.DBNull.Value.Equals(resultado["FechaFinPlaneada"]) ? "" : resultado["FechaFinPlaneada"].ToString()),
                                    fecinireaPro = (System.DBNull.Value.Equals(resultado["FechaInicioReal"]) ? "" : resultado["FechaInicioReal"].ToString()),
                                    fecfinreaPro = (System.DBNull.Value.Equals(resultado["FechaFinReal"]) ? "" : resultado["FechaFinReal"].ToString()),
                                    priPro = (System.DBNull.Value.Equals(resultado["Prioridad"]) ? 0 : Convert.ToInt32(resultado["Prioridad"])),
                                    desPro = (System.DBNull.Value.Equals(resultado["Descripcion"]) ? "" : resultado["Descripcion"].ToString()),
                                    razsocfacPro = (System.DBNull.Value.Equals(resultado["RazonSocial"]) ? "" : resultado["RazonSocial"].ToString()),
                                    conpagPro = (System.DBNull.Value.Equals(resultado["CondicionPago"]) ? "" : resultado["CondicionPago"].ToString()),
                                    monfacPro = (System.DBNull.Value.Equals(resultado["MontoFacturado"]) ? "" : resultado["MontoFacturado"].ToString()),
                                    nrohojenvPro = (System.DBNull.Value.Equals(resultado["NroHojaEnvio"]) ? "" : resultado["NroHojaEnvio"].ToString()),
                                    fechojenvPro = (System.DBNull.Value.Equals(resultado["FechaHojaEnvio"]) ? "" : resultado["FechaHojaEnvio"].ToString()),
                                    estPro = (System.DBNull.Value.Equals(resultado["Estado"]) ? "" : resultado["Estado"].ToString()),
                                    rucfacPro = (System.DBNull.Value.Equals(resultado["Ruc"]) ? "" : resultado["Ruc"].ToString()),
                                    tipoProyecto = (System.DBNull.Value.Equals(resultado["NombreTipoProy"]) ? "" : resultado["NombreTipoProy"].ToString()),
                                    presupuesto = (System.DBNull.Value.Equals(resultado["ImporteTotal"]) ? 0.0 : Convert.ToDouble(resultado["ImporteTotal"])),
                                    nomUbiDep = (System.DBNull.Value.Equals(resultado["NombreDep"]) ? "" : resultado["NombreDep"].ToString()),
                                    nomUbiProv = (System.DBNull.Value.Equals(resultado["NombreProv"]) ? "" : resultado["NombreProv"].ToString()),
                                    nomUbiDist = (System.DBNull.Value.Equals(resultado["NombreDist"]) ? "" : resultado["NombreDist"].ToString()),
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