﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Collections;

using DemoMVC.Models;

namespace DemoMVC.Persistencia
{
    public class LegalDAO
    {
        //Solicitud Requerimiento Legal
        public int insertarRequerimientoLegal(LegalRequerimiento reqLegal)
        {
            int nuevoIdReqLegal = 0;

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                SqlTransaction sqlTransaction = null;
                try
                {
                    SqlCommand cmdIns = new SqlCommand("pa_GJ_RequerimientoLegal_Insertar", con);
                    cmdIns.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();
                    sqlTransaction = con.BeginTransaction();

                    cmdIns.Parameters.Add(new SqlParameter("@idProyecto", reqLegal.idProyecto));
                    cmdIns.Parameters.Add(new SqlParameter("@idReqLegalTipo", reqLegal.idReqLegalTipo));
                    cmdIns.Parameters.Add(new SqlParameter("@cDescripcion", reqLegal.cDescripcion));

                    cmdIns.Transaction = sqlTransaction;
                    //totIns = cmdIns.ExecuteNonQuery();
                    nuevoIdReqLegal = Convert.ToInt32(cmdIns.ExecuteScalar());
                    sqlTransaction.Commit();

                    con.Close();

                }
                catch (Exception ex)
                {
                    if (sqlTransaction != null) sqlTransaction.Rollback();
                    throw new Exception(ex.ToString(), ex);
                }
                finally
                {
                    if (con.State == ConnectionState.Open) con.Close();
                    sqlTransaction.Dispose();
                }
            }

            return nuevoIdReqLegal;
        }

        //Solicitud Requerimiento Legal - Listado de Vecinos
        //me sale error, no encuentra la clase LegalRequerimientoCN
        public int insertarRequerimientoLegalVecinos(LegalRequerimientoCN vecinoColLegal)
        {
            int totIns = 0;

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                SqlTransaction sqlTransaction = null;
                try
                {
                    SqlCommand cmdIns = new SqlCommand("pa_GJ_RequerimientoLegalCN_InsertarVecino", con);
                    cmdIns.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();
                    sqlTransaction = con.BeginTransaction();

                    cmdIns.Parameters.Add(new SqlParameter("@idReqLegal", vecinoColLegal.idReqLegal));
                    cmdIns.Parameters.Add(new SqlParameter("@cNombreVecino", vecinoColLegal.cNombreVecino));
                    cmdIns.Parameters.Add(new SqlParameter("@cApellidoVecino", vecinoColLegal.cApellidoVecino));
                    cmdIns.Parameters.Add(new SqlParameter("@idDocIdentidadTipo", vecinoColLegal.idDocIdentidadTipo));
                    cmdIns.Parameters.Add(new SqlParameter("@cNroDocIdentidad", vecinoColLegal.cNroDocIdentidad));
                    cmdIns.Parameters.Add(new SqlParameter("@cTipoEdificacion", vecinoColLegal.cTipoEdificacion));
                    cmdIns.Parameters.Add(new SqlParameter("@cNombreCondominio", vecinoColLegal.cNombreCondominio));
                    cmdIns.Parameters.Add(new SqlParameter("@cDireccion", vecinoColLegal.cDireccion));
                    cmdIns.Parameters.Add(new SqlParameter("@idDepartamento", vecinoColLegal.idDepartamento));
                    cmdIns.Parameters.Add(new SqlParameter("@idProvincia", vecinoColLegal.idProvincia));
                    cmdIns.Parameters.Add(new SqlParameter("@idDistrito", vecinoColLegal.idDistrito));

                    cmdIns.Transaction = sqlTransaction;
                    totIns = cmdIns.ExecuteNonQuery();
                    sqlTransaction.Commit();

                    con.Close();

                }
                catch (Exception ex)
                {
                    if (sqlTransaction != null) sqlTransaction.Rollback();
                    throw new Exception(ex.ToString(), ex);
                }
                finally
                {
                    if (con.State == ConnectionState.Open) con.Close();
                    sqlTransaction.Dispose();
                }
            }

            return totIns;
        }


        public List<Requerimiento> listarRequerimiento(Int16 idRequerimiento, Int16 idProyecto, Int16 idTipo, Int16 idEstado, DateTime fecIni, DateTime fecFin)
        {
            List<Requerimiento> listaRequerimiento = null;
            Requerimiento req = null;

           string sql = "";
           sql = "select IdRequerimientoLegal, r.IdProyecto,p.Descripcion,p.Nombre,r.IdRequerimientoLegalTipo,rt.Descripcion,r.Descripcion as 'desc',r.FechaRegistro,r.IdRequerimientoLegalEstado, re.Descripcion as 'estado'  ";
           sql = sql + "from GJ_RequerimientoLegal r  ";
           sql = sql + "inner join GPP_Proyecto p on p.IdProyecto = r.IdProyecto ";
           sql = sql + "inner join dbo.GJ_RequerimientoLegalTipo rt on rt.IdRequerimientoLegalTipo = r.IdRequerimientoLegalTipo ";
           sql = sql + "inner join dbo.GJ_RequerimientoLegalEstado re on re.IdRequerimientoLegalEstado= r.IdRequerimientoLegalEstado ";
           sql = sql + "where (@idEstado is null or r.IdRequerimientoLegalEstado=@idEstado)  ";
           sql = sql + "and (@idTipo is null or r.IdRequerimientoLegalTipo =@idTipo)  ";
           sql = sql + "and (@idProyecto is null or r.IdProyecto = @idProyecto) ";
           sql = sql + "and (@idReqLegal is null or r.IdRequerimientoLegal =@idReqLegal)  ";
           sql = sql + "and r.FechaRegistro>= @fecIni  ";
           sql = sql + "and r.FechaRegistro <= @fecFin";
            

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                con.Open();
                using (SqlCommand com = new SqlCommand(sql, con))
                {
                    if (idRequerimiento == 0)
                    {
                        com.Parameters.Add(new SqlParameter("@idReqLegal", DBNull.Value));
                    }
                    else
                    {
                        com.Parameters.Add(new SqlParameter("@idReqLegal", idRequerimiento));
                    }
                    if (idProyecto == 0)
                    {
                        com.Parameters.Add(new SqlParameter("@idProyecto", DBNull.Value));
                    }
                    else
                    {
                        com.Parameters.Add(new SqlParameter("@idProyecto", idProyecto));
                    }
                    if (idEstado == 0)
                    {
                        com.Parameters.Add(new SqlParameter("@idEstado", DBNull.Value));
                    }
                    else
                    {
                        com.Parameters.Add(new SqlParameter("@idEstado", idEstado));
                    }
                    if (idTipo == 0)
                    {
                        com.Parameters.Add(new SqlParameter("@idTipo", DBNull.Value));
                    }
                    else
                    {
                        com.Parameters.Add(new SqlParameter("@idTipo", idTipo));
                    }
                    com.Parameters.Add(new SqlParameter("@fecIni", fecIni));
                    com.Parameters.Add(new SqlParameter("@fecFin", fecFin));

                    using (SqlDataReader resultado = com.ExecuteReader())
                    {
                        if (resultado.HasRows)
                        {
                            listaRequerimiento = new List<Requerimiento>();
                            while (resultado.Read())
                            {
                                
                                req = new Requerimiento()
                                {
                                    idReq = (int)resultado["idReqLegal"],
                                    descripcion = (String)resultado["desc"],
                                    descTipoReq=(String)resultado["cDescripcion"],
                                    desEstado =(String)resultado["estado"],
                                    idTipoRequerimiento = (Int16)resultado["idTipoReqLegal"],
                                    desProyecto =(String)resultado["desPro"],
                                    idProyecto = (int)resultado["codPro"],
                                    idEstado = (Int16)resultado["idEstadoReqLegal"],
                                    fecha = (DateTime)resultado["dFechaRegistro"],
                                    
                                 };
                                Proyecto pro = new Proyecto();
                                pro.codPro = (int)resultado["codPro"];
                                pro.desPro = (String)resultado["desPro"];

                                req.Proyecto = pro;
                                listaRequerimiento.Add(req);
                            }
                        }
                        else
                        {
                            Debug.WriteLine("No retornó registros");
                        }

                    }
                }
            }
            return listaRequerimiento;
        }


        public List<TipoRequerimiento> listarTipoRequerimiento()
        {
            List<TipoRequerimiento> listaTipoRequerimiento = null;
            TipoRequerimiento tipo = null;

            string sql = "";
            sql = "select IdRequerimientoLegalTipo, Descripcion from GJ_RequerimientoLegalTipo where Activo=1";

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                con.Open();
                using (SqlCommand com = new SqlCommand(sql, con))
                {

                    using (SqlDataReader resultado = com.ExecuteReader())
                    {
                        if (resultado.HasRows)
                        {
                            listaTipoRequerimiento = new List<TipoRequerimiento>();
                            tipo = new TipoRequerimiento()
                            {
                                idTipoReq=0,
                                descripcion="Todos",
                            };
                            listaTipoRequerimiento.Add(tipo);
                            while (resultado.Read())
                            {
                                tipo = new TipoRequerimiento()
                                {
                                    idTipoReq = (Int16)resultado["IdRequerimientoLegalTipo"],
                                    descripcion = (String)resultado["Descripcion"],
                                };
                                listaTipoRequerimiento.Add(tipo);
                            }
                        }
                        else
                        {
                            Debug.WriteLine("No retornó registros");
                        }

                    }
                }


            }
            return listaTipoRequerimiento;
        }

        public List<Estado> listarEstadoRequerimiento()
        {
            List<Estado> listaEstadoRequerimiento = null;
            Estado estado = null;

            string sql = "";
            sql = "select IdRequerimientoLegalEstado, Descripcion from GJ_RequerimientoLegalEstado";

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                con.Open();
                using (SqlCommand com= new SqlCommand(sql, con))
                {
                    using (SqlDataReader resultado = com.ExecuteReader())
                    {
                        if (resultado.HasRows)
                        {
                            listaEstadoRequerimiento = new List<Estado>();
                            estado= new Estado()
                            {
                                idEstadoReq = 0,
                                descripcion = "Todos",
                            };
                            listaEstadoRequerimiento.Add(estado);
                            while (resultado.Read())
                            {
                                estado = new Estado()
                            {
                                idEstadoReq = (Int16)resultado["IdRequerimientoLegalEstado"],
                                descripcion = (String)resultado["Descripcion"],
                            };
                                listaEstadoRequerimiento.Add(estado);
                            }
                        }
                        else
                        {
                            Debug.WriteLine("No retornó registros");
                        }
                    }
                }
            }
            return listaEstadoRequerimiento;
        }
        
    }
}