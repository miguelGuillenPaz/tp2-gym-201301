using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GYM.SIG.DataAccess
{
    public class SolicitudCotizaciondalc : Singleton<SolicitudCotizaciondalc>
    {
        private const String nombreprocedimiento = "pa_GSC_SolicitudCotizacion";
        private const String NombreTabla = "SolicitudCotizacion";
        private Database db = DatabaseFactory.CreateDatabase();

        public List<SolicitudCotizacion> ObtenerSolicitudes(String tipoFecha, DateTime fechaInicio, DateTime fechaFin, int codPro, int codTServ, int codEstado, int codSolCotizacion, int codReq, int filtrarEstado)
        {
            try
            {
                var coleccion = new List<SolicitudCotizacion>();
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 8);

                db.AddInParameter(SQL, "TipoFecha", DbType.String, tipoFecha);
                if (tipoFecha.Equals("todos"))
                {
                    db.AddInParameter(SQL, "FechaInicio", DbType.DateTime, null);
                    db.AddInParameter(SQL, "FechaFin", DbType.DateTime, null);
                }
                else
                {
                    db.AddInParameter(SQL, "FechaInicio", DbType.DateTime, fechaInicio);
                    db.AddInParameter(SQL, "FechaFin", DbType.DateTime, fechaFin);
                }

                db.AddInParameter(SQL, "IdProyecto", DbType.Int32, codPro);
                db.AddInParameter(SQL, "IdTipoServicio", DbType.Int32, codTServ);
                db.AddInParameter(SQL, "IdEstado", DbType.Int32, codEstado);
                db.AddInParameter(SQL, "IdSolicitudCotizacion", DbType.Int32, codSolCotizacion);
                db.AddInParameter(SQL, "IdRequerimiento", DbType.Int32, codReq);

                db.AddInParameter(SQL, "FiltrarEstado", DbType.Int32, filtrarEstado);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new SolicitudCotizacion
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("IdSolicitudCotizacion")),
                            descSolCotizacion = lector.IsDBNull(lector.GetOrdinal("DescripSolCotizacion")) ? "" : lector.GetString(lector.GetOrdinal("DescripSolCotizacion")),
                            fecSolCotizacino = lector.IsDBNull(lector.GetOrdinal("FecSolCotizacion")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FecSolCotizacion")),
                            fechaVencimiento = lector.IsDBNull(lector.GetOrdinal("FechaVencimiento")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaVencimiento")),

                            Observaciones = lector.IsDBNull(lector.GetOrdinal("Observaciones")) ? "" : lector.GetString(lector.GetOrdinal("Observaciones")),
                            desEstado = lector.IsDBNull(lector.GetOrdinal("DescripEstado")) ? "" : lector.GetString(lector.GetOrdinal("DescripEstado")),
                            descTServ = lector.IsDBNull(lector.GetOrdinal("DescripTServicio")) ? "" : lector.GetString(lector.GetOrdinal("DescripTServicio")),
                            codTServ = lector.IsDBNull(lector.GetOrdinal("IdTipoServicio")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdTipoServicio")),
                            nomPro = "",
                        });
                    }
                }
                SQL.Dispose();
                return coleccion;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<SolicitudCotizacion> listartodos()
        {
            try
            {
                var coleccion = new List<SolicitudCotizacion>();
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 2);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new SolicitudCotizacion
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("IdSolicitudCotizacion")),
                            descSolCotizacion = lector.IsDBNull(lector.GetOrdinal("DescripSolCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("DescripSolCotizacion")),
                            fecSolCotizacino = lector.IsDBNull(lector.GetOrdinal("FecSolCotizacion")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FecSolCotizacion")),
                            Observaciones = lector.IsDBNull(lector.GetOrdinal("Observaciones")) ? default(String) : lector.GetString(lector.GetOrdinal("Observaciones")),
                            desEstado = lector.IsDBNull(lector.GetOrdinal("DescripEstado")) ? default(String) : lector.GetString(lector.GetOrdinal("DescripEstado"))

                        });
                    }
                }
                SQL.Dispose();
                return coleccion;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<SolicitudCotizacion> Getcoleccion(string wheresql, string orderbysql)
        {
            int totalRecordCount = -1;
            return Getcoleccion(wheresql, orderbysql, 0, int.MaxValue, totalRecordCount);
        }


        public virtual List<SolicitudCotizacion> Getcoleccion(string wheresql, string orderbysql, int startIndex, int length, int totalRecordCount)
        {
            try
            {
                var coleccion = new List<SolicitudCotizacion>();
                DbCommand SQL = db.GetSqlStringCommand(CreateGetCommand(wheresql, orderbysql));
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new SolicitudCotizacion
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("IdSolicitudCotizacion")),
                            descSolCotizacion = lector.IsDBNull(lector.GetOrdinal("DescripSolCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("DescripSolCotizacion")),
                            fecSolCotizacino = lector.IsDBNull(lector.GetOrdinal("FecSolCotizacion")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FecSolCotizacion")),
                            Observaciones = lector.IsDBNull(lector.GetOrdinal("Observaciones")) ? default(String) : lector.GetString(lector.GetOrdinal("Observaciones")),
                            desEstado = lector.IsDBNull(lector.GetOrdinal("DescripEstado")) ? default(String) : lector.GetString(lector.GetOrdinal("DescripEstado")),

                        });
                    }
                }
                SQL.Dispose();
                return coleccion;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        public virtual SolicitudCotizacion GetByPrimaryKey(Int32 codSolCotizacion)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 3);
                db.AddInParameter(SQL, "IdSolicitudCotizacion", DbType.Int32, codSolCotizacion);
                var SolicitudCotizacion = default(SolicitudCotizacion);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        SolicitudCotizacion = new SolicitudCotizacion
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("IdSolicitudCotizacion")),
                            descSolCotizacion = lector.IsDBNull(lector.GetOrdinal("DescripSolCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("DescripSolCotizacion")),
                            fecSolCotizacino = lector.IsDBNull(lector.GetOrdinal("FecSolCotizacion")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FecSolCotizacion")),
                            Observaciones = lector.IsDBNull(lector.GetOrdinal("Observaciones")) ? default(String) : lector.GetString(lector.GetOrdinal("Observaciones")),
                            desEstado = lector.IsDBNull(lector.GetOrdinal("DescripEstado")) ? default(String) : lector.GetString(lector.GetOrdinal("DescripEstado")),

                            nomPro = "",
                            codPro = 0,
                            descTServ = lector.IsDBNull(lector.GetOrdinal("DescripTServicio")) ? "" : lector.GetString(lector.GetOrdinal("DescripTServicio")),
                            codTServ = lector.IsDBNull(lector.GetOrdinal("IdTipoServicio")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdTipoServicio")),
                        };
                    }
                }
                SQL.Dispose();
                return SolicitudCotizacion;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        protected virtual string CreateGetCommand(string whereSql, string orderBySql)
        {
            string sql = "SELECT * FROM [dbo].[SolicitudCotizacion]";
            if ((whereSql != null) && (whereSql.Trim().Length > 0))
            {
                sql += " WHERE " + whereSql;
            }
            if ((orderBySql != null) && (orderBySql.Trim().Length > 0))
            {
                sql += " ORDER BY " + orderBySql;
            }
            return sql;
        }

        public virtual int GrabarSolicitud(SolicitudCotizacion SolicitudCotizacion, List<SolicitudProveedorTipoServicio> proveedoresSolicitud, List<DetalleSolicitudRequerimiento> requerimientosSolicitud)
        {
            DbConnection cnn = db.CreateConnection();
            cnn.Open();
            DbTransaction tran = cnn.BeginTransaction();
            try
            {
                if (SolicitudCotizacion.codSolCotizacion == 0) SolicitudCotizacion.codSolCotizacion = this.Insert(SolicitudCotizacion, tran);
                else this.Update(SolicitudCotizacion, tran);

                foreach (var proveedoreSolicitud in proveedoresSolicitud)
                {
                    proveedoreSolicitud.codSolCotizacion = SolicitudCotizacion.codSolCotizacion;
                    SolicitudProveedorTipoServiciodalc.Instancia.Insert(proveedoreSolicitud, tran);
                }

                foreach (var requerimientoSolicitud in requerimientosSolicitud)
                {
                    requerimientoSolicitud.codSolCotizacion = SolicitudCotizacion.codSolCotizacion;
                    DetalleSolicitudRequerimientodalc.Instancia.Insert(requerimientoSolicitud, tran);
                }

                tran.Commit();
                return SolicitudCotizacion.codSolCotizacion;
            }
            catch (Exception ex)
            {
                tran.Rollback();
                throw new Exception(ex.ToString());
            }
            finally
            {
                cnn.Close();
            }
        }

        public virtual int Insert(SolicitudCotizacion SolicitudCotizacion, DbTransaction tran = null)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddOutParameter(SQL, "IdSolicitudCotizacion", DbType.Int32, 0);
                db.AddInParameter(SQL, "IdTipoServicio", DbType.Int32, SolicitudCotizacion.codTServ);
                db.AddInParameter(SQL, "DescripSolCotizacion", DbType.String, SolicitudCotizacion.descSolCotizacion);
                db.AddInParameter(SQL, "FecSolCotizacion", DbType.DateTime, SolicitudCotizacion.fecSolCotizacino);
                db.AddInParameter(SQL, "FechaVencimiento", DbType.DateTime, SolicitudCotizacion.fechaVencimiento);
                db.AddInParameter(SQL, "Observaciones", DbType.String, SolicitudCotizacion.Observaciones);
                db.AddInParameter(SQL, "IdEstado", DbType.String, SolicitudCotizacion.codEstado);
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 4);
                int huboexito;
                if (tran != null) huboexito = db.ExecuteNonQuery(SQL, tran);
                else huboexito = db.ExecuteNonQuery(SQL);
                if (huboexito == 0)
                {
                    throw new Exception("Error al agregar la solicitud de cotización");
                }
                var numerogenerado = (int)db.GetParameterValue(SQL, "IdSolicitudCotizacion");
                SQL.Dispose();
                return numerogenerado;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual bool CambiarEstado(int codSolCotizacion, int codEstado)
        {
            DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
            db.AddInParameter(SQL, "IdSolicitudCotizacion", DbType.Int32, codSolCotizacion);
            db.AddInParameter(SQL, "IdEstado", DbType.Int32, codEstado);
            db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 7);
            int huboexito = db.ExecuteNonQuery(SQL);
            if (huboexito == 0)
            {
                throw new Exception("Error");
            }
            return true;
        }

        public virtual int Update(SolicitudCotizacion SolicitudCotizacion, DbTransaction tran = null)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "IdSolicitudCotizacion", DbType.Int32, SolicitudCotizacion.codSolCotizacion);
                db.AddInParameter(SQL, "IdTipoServicio", DbType.Int32, SolicitudCotizacion.codTServ);
                db.AddInParameter(SQL, "DescripSolCotizacion", DbType.String, SolicitudCotizacion.descSolCotizacion);
                db.AddInParameter(SQL, "FecSolCotizacion", DbType.DateTime, SolicitudCotizacion.fecSolCotizacino);
                db.AddInParameter(SQL, "FechaVencimiento", DbType.DateTime, SolicitudCotizacion.fechaVencimiento);
                db.AddInParameter(SQL, "Observaciones", DbType.String, SolicitudCotizacion.Observaciones);
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 1);
                int huboexito;
                if (tran != null) huboexito = db.ExecuteNonQuery(SQL, tran);
                else huboexito = db.ExecuteNonQuery(SQL);
                if (huboexito == 0)
                {
                    throw new Exception("Error");
                }
                return huboexito;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        public virtual bool DeleteByPrimaryKey(Int32 codSolCotizacion)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "IdSolicitudCotizacion", DbType.Int32, codSolCotizacion);
                db.AddInParameter(SQL, "TipoConsulta", DbType.String, 5);
                int huboexito = db.ExecuteNonQuery(SQL);
                if (huboexito == 0)
                {
                    throw new Exception("Error");
                }
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        public virtual bool DeleteAll()
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "TipoConsulta", DbType.String, 6);
                int huboexito = db.ExecuteNonQuery(SQL);
                if (huboexito == 0)
                {
                    throw new Exception("Error");
                }
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


    }
}
