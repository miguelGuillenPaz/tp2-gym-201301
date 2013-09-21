﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Collections;
using DemoMVC.Models;

namespace DemoMVC.Persistencia
{
    public class ActividadDAO
    {

        public List<Actividad> obtenerActividad2(int codPlanPro)
        {
            List<Actividad> listadoAct = null;
            Actividad actividad = null;
            string sql = "select IdActividad, Correlativo, a.Descripcion, e.Descripcion DescripcionEntregable, FechaInicio, FechaFin, Tipo from  GPP_Actividad a inner join GPP_Entregable e on a.IdEntregable = e.IdEntregable where IdPlanProyecto=@codPlaPro";

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                con.Open();
                using (SqlCommand com = new SqlCommand(sql, con))
                {
                    com.Parameters.Add(new SqlParameter("@codPlaPro", codPlanPro));
                    using (SqlDataReader resultado = com.ExecuteReader())
                    {
                        if (resultado.HasRows)
                        {
                            //Obtenemos uno por uno
                            listadoAct = new List<Actividad>();
                            while (resultado.Read())
                            {
                                //Recorremos objeto por objeto y anadimos
                                actividad = new Actividad
                                {
                                    codAct = (int)resultado["IdActividad"],
                                    corAct = (int)resultado["Correlativo"],
                                    desAct = (string)resultado["Descripcion"],
                                    feciniAct = (string)resultado["FechaInicio"],
                                    fecfinAct = (string)resultado["FechaFin"],
                                    //preAct = (string)resultado["Predecesor"],
                                    tipAct = (string)resultado["Tipo"],
                                    //codEnt = (int)resultado["IdEntregable"],
                                    //codPlaPro = (int)resultado["IdPlanProyecto"], 
                                    descripcionEntregable = (string)resultado["DescripcionEntregable"]

                                };
                                //Añadimos al listado
                                listadoAct.Add(actividad);
                            }
                        }
                        else
                        {
                            Debug.WriteLine("No retornó registros");
                        }
                    }
                }
                con.Close();
            }
            return listadoAct;
        }

        //Listado de actividades
        public List<Actividad> obtenerActividad(int codPlanPro, int codAct)
        {
            List<Actividad> listadoAct = null;
            Actividad actividad = null;
            string sql = "";
            if (codAct != 0)
            {
                sql = "select a.*, e.Descripcion descripcionEntregable from dbo.GPP_Actividad a inner join GPP_Entregable e on a.IdEntregable = e.IdEntregable  where a.IdPlanProyecto=@codPlaPro and a.IdActividad=@codAct";
            }
            else {
                sql = "select a.*, e.Descripcion descripcionEntregable from dbo.GPP_Actividad a inner join GPP_Entregable e on a.IdEntregable = e.IdEntregable  where a.IdPlanProyecto=@codPlaPro";
            }

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                con.Open();
                using (SqlCommand com = new SqlCommand(sql, con))
                {
                    com.Parameters.Add(new SqlParameter("@codPlaPro", codPlanPro));
                    if (codAct != 0) {
                        com.Parameters.Add(new SqlParameter("@codAct", codAct));
                    }
                    using (SqlDataReader resultado = com.ExecuteReader())
                    {
                        if (resultado.HasRows)
                        {
                            //Obtenemos uno por uno
                            listadoAct = new List<Actividad>();
                            while (resultado.Read())
                            {
                                //Recorremos objeto por objeto y anadimos
                                actividad = new Actividad
                                {
                                    codAct = (int)resultado["IdActividad"],
                                    corAct = (int)resultado["Correlativo"],
                                    desAct = (string)resultado["Descripcion"],
                                    feciniAct = (string)resultado["FechaInicio"],
                                    fecfinAct = (string)resultado["FechaFin"],
                                    preAct = (string)resultado["Predecesor"],
                                    tipAct = (string)resultado["Tipo"],
                                    codEnt = (int)resultado["IdEntregable"],
                                    codPlaPro = (int)resultado["IdPlanProyecto"],
                                    descripcionEntregable = (string)resultado["descripcionEntregable"],
                                };
                                //Añadimos al listado
                                listadoAct.Add(actividad);
                            }
                        }
                        else
                        {
                            Debug.WriteLine("No retornó registros");
                        }
                    }
                }
                con.Close();
            }
            return listadoAct;
        }

        //Total registros
        public int totalRegistros(int tipo, int codPlaPro)
        {

            string sql = "";
            int totReg = 0;

            //Dependiendo el tipo, vemos el total de actividades en general para el ID único o el total correlativo
            if (tipo == 0)
            {
                sql = "select count(*) from dbo.GPP_Actividad";
            }
            else 
            {
                if (tipo == 1)
                {
                    sql = "select count(*) from dbo.GPP_Actividad where IdPlanProyecto=@codPlaPro";
                }
                else {
                    sql = "select top 1 IdActividad from dbo.GPP_Actividad ORDER BY IdActividad desc";
                }
            }

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand(sql, con);
                    con.Open();
                    //Solo para el caso de tipo == 1 colocar parametro
                    if (tipo == 1) cmd.Parameters.Add(new SqlParameter("@codPlaPro", codPlaPro));
                    totReg = Convert.ToInt32(cmd.ExecuteScalar());
                    con.Close();
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.ToString(), ex);
                }
            }

            return totReg;
        }

        //Insertar actividad
        public int insertarActividad(Actividad actividad)
        {

            string sql = "insert into dbo.GPP_Actividad values (@codAct,@corAct,@desAct,@feciniAct,@fecfinAct,@preAct,@tipAct,@codEnt,@codPlaPro)";
            int totIns = 0;

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                try
                {
                    SqlCommand cmdIns = new SqlCommand(sql, con);
                    cmdIns.Parameters.AddWithValue("@codAct", actividad.codAct);
                    cmdIns.Parameters.AddWithValue("@corAct", actividad.corAct);
                    cmdIns.Parameters.AddWithValue("@desAct", actividad.desAct);
                    cmdIns.Parameters.AddWithValue("@feciniAct", actividad.feciniAct);
                    cmdIns.Parameters.AddWithValue("@fecfinAct", actividad.fecfinAct);
                    cmdIns.Parameters.AddWithValue("@preAct", actividad.preAct);
                    cmdIns.Parameters.AddWithValue("@tipAct", actividad.tipAct);
                    cmdIns.Parameters.AddWithValue("@codEnt", actividad.codEnt);
                    cmdIns.Parameters.AddWithValue("@codPlaPro", actividad.codPlaPro);
                    con.Open();
                    totIns = Convert.ToInt32(cmdIns.ExecuteScalar());
                    con.Close();
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.ToString(), ex);
                }
            }

            return totIns;

        }

        //Actualizar actividad
        public int actualizarActividad(Actividad actividad)
        {

            string sql = "update dbo.GPP_Actividad set Descripcion=@desAct, FechaInicio=@feciniAct, FechaFin=@fecfinAct, Predecesor=@preAct where IdPlanProyecto=@codPlaPro and Correlativo=@corAct";
            int totUpd = 0;

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                try
                {
                    SqlCommand cmdUpd = new SqlCommand(sql, con);
                    cmdUpd.Parameters.AddWithValue("@corAct", actividad.corAct);
                    cmdUpd.Parameters.AddWithValue("@desAct", actividad.desAct);
                    cmdUpd.Parameters.AddWithValue("@feciniAct", actividad.feciniAct);
                    cmdUpd.Parameters.AddWithValue("@fecfinAct", actividad.fecfinAct);
                    cmdUpd.Parameters.AddWithValue("@preAct", actividad.preAct);
                    cmdUpd.Parameters.AddWithValue("@codPlaPro", actividad.codPlaPro);
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

        //Eliminar actividad
        public void eliminarActividad(int tipo, int codAct, int codPlaPro) 
        {
            string sql = "";
            if (tipo == 0) {
                sql = "delete from dbo.GPP_Actividad where IdActividad=@codAct";
            }
            if (tipo == 1) {
                sql = "delete from dbo.GPP_Actividad where IdPlanProyecto=@codPlaPro";
            }
            
            try
            {
                using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
                {
                    SqlCommand cmd = new SqlCommand(sql, con);
                    if (tipo == 0) cmd.Parameters.AddWithValue("@codAct", codAct);
                    if (tipo == 1) cmd.Parameters.AddWithValue("@codPlaPro", codPlaPro);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }            
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString(), ex);
            }

        }

    }
}