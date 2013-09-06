using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GYM.SIG.DataAccess
{
    public class SolicitudProveedorTipoServiciodalc : Singleton<SolicitudProveedorTipoServiciodalc>
    {
        private const String nombreprocedimiento = "pa_GSC_SolicitudProveedorTipoServicio";
        private const String NombreTabla = "SolicitudProveedorTipoServicio";
        private Database db = DatabaseFactory.CreateDatabase();

        public List<SolicitudProveedorTipoServicio> listarporSolicitud(int codSolCotizacion, int codTServ, int codProv)
        {
            try
            {
                var coleccion = new List<SolicitudProveedorTipoServicio>();
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 9);
                db.AddInParameter(SQL, "IdSolicitudCotizacion", DbType.Int32, codSolCotizacion);
                db.AddInParameter(SQL, "IdTipoServicio", DbType.Int32, codTServ);
                db.AddInParameter(SQL, "IdProveedor", DbType.Int32, codProv);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new SolicitudProveedorTipoServicio
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("IdSolicitudCotizacion")),
                            codProv = lector.GetInt32(lector.GetOrdinal("IdProveedor")),
                            codTServ = lector.GetInt32(lector.GetOrdinal("IdTipoServicio")),
                            fechaSolProTServ = lector.IsDBNull(lector.GetOrdinal("FechaSolProTServ")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaSolProTServ")),

                            fecSolCotizacino = lector.IsDBNull(lector.GetOrdinal("fecSolCotizacino")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecSolCotizacino")),
                            razsocPro = lector.IsDBNull(lector.GetOrdinal("razsocPro")) ? "" : lector.GetString(lector.GetOrdinal("razsocPro")),
                            descTServ = lector.IsDBNull(lector.GetOrdinal("descTServ")) ? "" : lector.GetString(lector.GetOrdinal("descTServ")),
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

        public List<SolicitudProveedorTipoServicio> listartodos()
        {
            try
            {
                var coleccion = new List<SolicitudProveedorTipoServicio>();
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 2);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new SolicitudProveedorTipoServicio
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("IdSolicitudCotizacion")),
                            codProv = lector.GetInt32(lector.GetOrdinal("IdProveedor")),
                            codTServ = lector.GetInt32(lector.GetOrdinal("IdTipoServicio")),
                            fechaSolProTServ = lector.IsDBNull(lector.GetOrdinal("FechaSolProTServ")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaSolProTServ"))

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



        public List<SolicitudProveedorTipoServicio> Getcoleccion(string wheresql, string orderbysql)
        {
            int totalRecordCount = -1;
            return Getcoleccion(wheresql, orderbysql, 0, int.MaxValue, totalRecordCount);
        }


        public virtual List<SolicitudProveedorTipoServicio> Getcoleccion(string wheresql, string orderbysql, int startIndex, int length, int totalRecordCount)
        {
            try
            {
                var coleccion = new List<SolicitudProveedorTipoServicio>();
                DbCommand SQL = db.GetSqlStringCommand(CreateGetCommand(wheresql, orderbysql));
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new SolicitudProveedorTipoServicio
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("IdSolicitudCotizacion")),
                            codProv = lector.GetInt32(lector.GetOrdinal("IdProveedor")),
                            codTServ = lector.GetInt32(lector.GetOrdinal("IdTipoServicio")),
                            fechaSolProTServ = lector.IsDBNull(lector.GetOrdinal("FechaSolProTServ")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaSolProTServ"))

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


        public List<SolicitudProveedorTipoServicio> ObtenerPorcodSolCotizacion(Int32 codSolCotizacion)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 10);
                db.AddInParameter(SQL, "IdSolicitudCotizacion", DbType.Int32);
                var coleccion = new List<SolicitudProveedorTipoServicio>();
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new SolicitudProveedorTipoServicio
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("IdSolicitudCotizacion")),
                            codProv = lector.GetInt32(lector.GetOrdinal("IdProveedor")),
                            codTServ = lector.GetInt32(lector.GetOrdinal("IdTipoServicio")),
                            fechaSolProTServ = lector.IsDBNull(lector.GetOrdinal("FechaSolProTServ")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaSolProTServ"))

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



        public virtual bool EliminarPorcodSolCotizacion(Int32 codSolCotizacion)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 6);
                db.AddInParameter(SQL, "IdSolicitudCotizacion", DbType.Int32);
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

        public List<SolicitudProveedorTipoServicio> ObtenerPorcodProv(Int32 codProv)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 10);
                db.AddInParameter(SQL, "IdProveedor", DbType.Int32);
                var coleccion = new List<SolicitudProveedorTipoServicio>();
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new SolicitudProveedorTipoServicio
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("IdSolicitudCotizacion")),
                            codProv = lector.GetInt32(lector.GetOrdinal("IdProveedor")),
                            codTServ = lector.GetInt32(lector.GetOrdinal("IdTipoServicio")),
                            fechaSolProTServ = lector.IsDBNull(lector.GetOrdinal("FechaSolProTServ")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaSolProTServ"))

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

        public virtual bool EliminarPorcodProv(Int32 codProv)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 6);
                db.AddInParameter(SQL, "IdProveedor", DbType.Int32);
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

        public List<SolicitudProveedorTipoServicio> ObtenerPorcodTServ(Int32 codTServ)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 10);
                db.AddInParameter(SQL, "IdTipoServicio", DbType.Int32);
                var coleccion = new List<SolicitudProveedorTipoServicio>();
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new SolicitudProveedorTipoServicio
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("IdSolicitudCotizacion")),
                            codProv = lector.GetInt32(lector.GetOrdinal("IdProveedor")),
                            codTServ = lector.GetInt32(lector.GetOrdinal("IdTipoServicio")),
                            fechaSolProTServ = lector.IsDBNull(lector.GetOrdinal("FechaSolProTServ")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaSolProTServ"))

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

        public virtual bool EliminarPorcodTServ(Int32 codTServ)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 6);
                db.AddInParameter(SQL, "IdTipoServicio", DbType.Int32);
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

        public virtual SolicitudProveedorTipoServicio GetByPrimaryKey(Int32 codSolCotizacion, Int32 codProv, Int32 codTServ)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 3);
                db.AddInParameter(SQL, "IdSolicitudCotizacion", DbType.Int32, codSolCotizacion);
                db.AddInParameter(SQL, "IdProveedor", DbType.Int32, codProv);
                db.AddInParameter(SQL, "IdTipoServicio", DbType.Int32, codTServ);
                var SolicitudProveedorTipoServicio = default(SolicitudProveedorTipoServicio);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        SolicitudProveedorTipoServicio = new SolicitudProveedorTipoServicio
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("IdSolicitudCotizacion")),
                            codProv = lector.GetInt32(lector.GetOrdinal("IdProveedor")),
                            codTServ = lector.GetInt32(lector.GetOrdinal("IdTipoServicio")),
                            fechaSolProTServ = lector.IsDBNull(lector.GetOrdinal("FechaSolProTServ")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaSolProTServ"))

                        };
                    }
                }
                SQL.Dispose();
                return SolicitudProveedorTipoServicio;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        protected virtual string CreateGetCommand(string whereSql, string orderBySql)
        {
            string sql = "SELECT * FROM [dbo].[SolicitudProveedorTipoServicio]";
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

        public virtual int Insert(SolicitudProveedorTipoServicio SolicitudProveedorTipoServicio, DbTransaction tran = null)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "IdSolicitudCotizacion", DbType.Int32, SolicitudProveedorTipoServicio.codSolCotizacion);
                db.AddInParameter(SQL, "IdProveedor", DbType.Int32, SolicitudProveedorTipoServicio.codProv);
                db.AddInParameter(SQL, "IdTipoServicio", DbType.Int32, SolicitudProveedorTipoServicio.codTServ);
                //db.AddInParameter(SQL, "FechaSolProTServ", DbType.DateTime, SolicitudProveedorTipoServicio.fechaSolProTServ);
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 4);
                int huboexito;
                if (tran != null) huboexito = db.ExecuteNonQuery(SQL, tran);
                else huboexito = db.ExecuteNonQuery(SQL);
                if (huboexito == 0)
                {
                    throw new Exception("Error al agregar al");
                }

                SQL.Dispose();
                return huboexito;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        public virtual void Update(SolicitudProveedorTipoServicio SolicitudProveedorTipoServicio)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "IdSolicitudCotizacion", DbType.Int32, SolicitudProveedorTipoServicio.codSolCotizacion);
                db.AddInParameter(SQL, "IdProveedor", DbType.Int32, SolicitudProveedorTipoServicio.codProv);
                db.AddInParameter(SQL, "IdTipoServicio", DbType.Int32, SolicitudProveedorTipoServicio.codTServ);
                db.AddInParameter(SQL, "FechaSolProTServ", DbType.DateTime, SolicitudProveedorTipoServicio.fechaSolProTServ);
                db.AddInParameter(SQL, "TipoConsulta", DbType.String, 1);
                int huboexito = db.ExecuteNonQuery(SQL);
                if (huboexito == 0)
                {
                    throw new Exception("Error");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        public virtual bool DeleteByPrimaryKey(Int32 codSolCotizacion, Int32 codProv, Int32 codTServ)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "IdSolicitudCotizacion", DbType.Int32, codSolCotizacion);
                db.AddInParameter(SQL, "IdProveedor", DbType.Int32, codProv);
                db.AddInParameter(SQL, "IdTipoServicio", DbType.Int32, codTServ);
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
