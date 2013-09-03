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
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 8);

                db.AddInParameter(SQL, "tipoFecha", DbType.String, tipoFecha);
                if (tipoFecha.Equals("todos"))
                {
                    db.AddInParameter(SQL, "fechaInicio", DbType.DateTime, null);
                    db.AddInParameter(SQL, "fechaFin", DbType.DateTime, null);
                }
                else
                {
                    db.AddInParameter(SQL, "fechaInicio", DbType.DateTime, fechaInicio);
                    db.AddInParameter(SQL, "fechaFin", DbType.DateTime, fechaFin);
                }

                db.AddInParameter(SQL, "codPro", DbType.Int32, codPro);
                db.AddInParameter(SQL, "codTServ", DbType.Int32, codTServ);
                db.AddInParameter(SQL, "codEstado", DbType.Int32, codEstado);
                db.AddInParameter(SQL, "codSolCotizacion", DbType.Int32, codSolCotizacion);
                db.AddInParameter(SQL, "codReq", DbType.Int32, codReq);

                db.AddInParameter(SQL, "filtrarEstado", DbType.Int32, filtrarEstado);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new SolicitudCotizacion
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("codSolCotizacion")),
                            descSolCotizacion = lector.IsDBNull(lector.GetOrdinal("descSolCotizacion")) ? "" : lector.GetString(lector.GetOrdinal("descSolCotizacion")),
                            fecSolCotizacino = lector.IsDBNull(lector.GetOrdinal("fecSolCotizacino")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecSolCotizacino")),
                            fechaVencimiento = lector.IsDBNull(lector.GetOrdinal("fechaVencimiento")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fechaVencimiento")),

                            Observaciones = lector.IsDBNull(lector.GetOrdinal("Observaciones")) ? "" : lector.GetString(lector.GetOrdinal("Observaciones")),
                            desEstado = lector.IsDBNull(lector.GetOrdinal("desEstado")) ? "" : lector.GetString(lector.GetOrdinal("desEstado")),
                            descTServ = lector.IsDBNull(lector.GetOrdinal("descTServ")) ? "" : lector.GetString(lector.GetOrdinal("descTServ")),
                            codTServ = lector.IsDBNull(lector.GetOrdinal("codTServ")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codTServ")),
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
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 2);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new SolicitudCotizacion
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("codSolCotizacion")),
                            descSolCotizacion = lector.IsDBNull(lector.GetOrdinal("descSolCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("descSolCotizacion")),
                            fecSolCotizacino = lector.IsDBNull(lector.GetOrdinal("fecSolCotizacino")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecSolCotizacino")),
                            Observaciones = lector.IsDBNull(lector.GetOrdinal("Observaciones")) ? default(String) : lector.GetString(lector.GetOrdinal("Observaciones")),
                            desEstado = lector.IsDBNull(lector.GetOrdinal("desEstado")) ? default(String) : lector.GetString(lector.GetOrdinal("desEstado"))

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
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("codSolCotizacion")),
                            descSolCotizacion = lector.IsDBNull(lector.GetOrdinal("descSolCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("descSolCotizacion")),
                            fecSolCotizacino = lector.IsDBNull(lector.GetOrdinal("fecSolCotizacino")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecSolCotizacino")),
                            Observaciones = lector.IsDBNull(lector.GetOrdinal("Observaciones")) ? default(String) : lector.GetString(lector.GetOrdinal("Observaciones")),
                            desEstado = lector.IsDBNull(lector.GetOrdinal("desEstado")) ? default(String) : lector.GetString(lector.GetOrdinal("desEstado")),

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
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 3);
                db.AddInParameter(SQL, "codSolCotizacion", DbType.Int32, codSolCotizacion);
                var SolicitudCotizacion = default(SolicitudCotizacion);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        SolicitudCotizacion = new SolicitudCotizacion
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("codSolCotizacion")),
                            descSolCotizacion = lector.IsDBNull(lector.GetOrdinal("descSolCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("descSolCotizacion")),
                            fecSolCotizacino = lector.IsDBNull(lector.GetOrdinal("fecSolCotizacino")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecSolCotizacino")),
                            Observaciones = lector.IsDBNull(lector.GetOrdinal("Observaciones")) ? default(String) : lector.GetString(lector.GetOrdinal("Observaciones")),
                            desEstado = lector.IsDBNull(lector.GetOrdinal("desEstado")) ? default(String) : lector.GetString(lector.GetOrdinal("desEstado")),

                            nomPro = "",
                            codPro = 0,
                            descTServ = lector.IsDBNull(lector.GetOrdinal("descTServ")) ? "" : lector.GetString(lector.GetOrdinal("descTServ")),
                            codTServ = lector.IsDBNull(lector.GetOrdinal("codTServ")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codTServ")),
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
                db.AddOutParameter(SQL, "codSolCotizacion", DbType.Int32, 0);
                db.AddInParameter(SQL, "codTServ", DbType.Int32, SolicitudCotizacion.codTServ);
                db.AddInParameter(SQL, "descSolCotizacion", DbType.String, SolicitudCotizacion.descSolCotizacion);
                db.AddInParameter(SQL, "fecSolCotizacino", DbType.DateTime, SolicitudCotizacion.fecSolCotizacino);
                db.AddInParameter(SQL, "fechaVencimiento", DbType.DateTime, SolicitudCotizacion.fechaVencimiento);
                db.AddInParameter(SQL, "Observaciones", DbType.String, SolicitudCotizacion.Observaciones);
                db.AddInParameter(SQL, "codEstado", DbType.String, SolicitudCotizacion.codEstado);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 4);
                int huboexito;
                if (tran != null) huboexito = db.ExecuteNonQuery(SQL, tran);
                else huboexito = db.ExecuteNonQuery(SQL);
                if (huboexito == 0)
                {
                    throw new Exception("Error al agregar la solicitud de cotización");
                }
                var numerogenerado = (int)db.GetParameterValue(SQL, "codSolCotizacion");
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
            db.AddInParameter(SQL, "codSolCotizacion", DbType.Int32, codSolCotizacion);
            db.AddInParameter(SQL, "codEstado", DbType.Int32, codEstado);
            db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 7);
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
                db.AddInParameter(SQL, "codSolCotizacion", DbType.Int32, SolicitudCotizacion.codSolCotizacion);
                db.AddInParameter(SQL, "codTServ", DbType.Int32, SolicitudCotizacion.codTServ);
                db.AddInParameter(SQL, "descSolCotizacion", DbType.String, SolicitudCotizacion.descSolCotizacion);
                db.AddInParameter(SQL, "fecSolCotizacino", DbType.DateTime, SolicitudCotizacion.fecSolCotizacino);
                db.AddInParameter(SQL, "fechaVencimiento", DbType.DateTime, SolicitudCotizacion.fechaVencimiento);
                db.AddInParameter(SQL, "Observaciones", DbType.String, SolicitudCotizacion.Observaciones);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 1);
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
                db.AddInParameter(SQL, "codSolCotizacion", DbType.Int32, codSolCotizacion);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.String, 5);
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
                db.AddInParameter(SQL, "Tipoconsulta", DbType.String, 6);
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
