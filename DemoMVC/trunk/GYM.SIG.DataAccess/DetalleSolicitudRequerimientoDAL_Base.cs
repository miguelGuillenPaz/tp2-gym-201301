using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GYM.SIG.DataAccess
{
    public class DetalleSolicitudRequerimientodalc : Singleton<DetalleSolicitudRequerimientodalc>
    {
        private const String nombreprocedimiento = "pa_GSC_DetalleSolicitudRequerimiento";
        private const String NombreTabla = "DetalleSolicitudRequerimiento";
        private Database db = DatabaseFactory.CreateDatabase();


        public List<DetalleSolicitudRequerimiento> listartodos()
        {
            try
            {
                var coleccion = new List<DetalleSolicitudRequerimiento>();
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 2);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleSolicitudRequerimiento
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("codSolCotizacion")),
                            codSolDet = lector.GetInt32(lector.GetOrdinal("codSolDet")),
                            desSolDet = lector.IsDBNull(lector.GetOrdinal("desSolDet")) ? default(String) : lector.GetString(lector.GetOrdinal("desSolDet")),
                            fecSolDet = lector.IsDBNull(lector.GetOrdinal("fecSolDet")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecSolDet")),
                            codPro = lector.IsDBNull(lector.GetOrdinal("codPro")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codPro")),
                            codReq = lector.IsDBNull(lector.GetOrdinal("codReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codReq")),
                            codcorDetReq = lector.IsDBNull(lector.GetOrdinal("codcorDetReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codcorDetReq")),

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



        public List<DetalleSolicitudRequerimiento> Getcoleccion(string wheresql, string orderbysql)
        {
            int totalRecordCount = -1;
            return Getcoleccion(wheresql, orderbysql, 0, int.MaxValue, totalRecordCount);
        }


        public virtual List<DetalleSolicitudRequerimiento> Getcoleccion(string wheresql, string orderbysql, int startIndex, int length, int totalRecordCount)
        {
            try
            {
                var coleccion = new List<DetalleSolicitudRequerimiento>();
                DbCommand SQL = db.GetSqlStringCommand(CreateGetCommand(wheresql, orderbysql));
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleSolicitudRequerimiento
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("codSolCotizacion")),
                            codSolDet = lector.GetInt32(lector.GetOrdinal("codSolDet")),
                            desSolDet = lector.IsDBNull(lector.GetOrdinal("desSolDet")) ? default(String) : lector.GetString(lector.GetOrdinal("desSolDet")),
                            fecSolDet = lector.IsDBNull(lector.GetOrdinal("fecSolDet")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecSolDet")),
                            codPro = lector.IsDBNull(lector.GetOrdinal("codPro")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codPro")),
                            codReq = lector.IsDBNull(lector.GetOrdinal("codReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codReq")),
                            codcorDetReq = lector.IsDBNull(lector.GetOrdinal("codcorDetReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codcorDetReq")),

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

        public List<DetalleSolicitudRequerimiento> ObtenerPorcodSolCotizacion(Int32 codSolCotizacion, int codCotizacion)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 7);
                db.AddInParameter(SQL, "codSolCotizacion", DbType.Int32, codSolCotizacion);
                db.AddInParameter(SQL, "codCotizacion", DbType.Int32, codCotizacion);
                var coleccion = new List<DetalleSolicitudRequerimiento>();
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleSolicitudRequerimiento
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("codSolCotizacion")),
                            codSolDet = lector.GetInt32(lector.GetOrdinal("codSolDet")),
                            desSolDet = lector.IsDBNull(lector.GetOrdinal("desSolDet")) ? "" : lector.GetString(lector.GetOrdinal("desSolDet")),
                            fecSolDet = lector.IsDBNull(lector.GetOrdinal("fecSolDet")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecSolDet")),
                            codPro = lector.IsDBNull(lector.GetOrdinal("codPro")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codPro")),
                            nomPro = lector.IsDBNull(lector.GetOrdinal("nomPro")) ? "" : lector.GetString(lector.GetOrdinal("nomPro")),
                            codReq = lector.IsDBNull(lector.GetOrdinal("codReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codReq")),
                            codcorDetReq = lector.IsDBNull(lector.GetOrdinal("codcorDetReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codcorDetReq")),
                            desReq = lector.IsDBNull(lector.GetOrdinal("desReq")) ? "" : lector.GetString(lector.GetOrdinal("desReq")),
                            desServicio = lector.IsDBNull(lector.GetOrdinal("desServicio")) ? "" : lector.GetString(lector.GetOrdinal("desServicio")),

                            codUM = lector.IsDBNull(lector.GetOrdinal("codUM")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codUM")),
                            descUM = lector.IsDBNull(lector.GetOrdinal("descUM")) ? "" : lector.GetString(lector.GetOrdinal("descUM")),

                            canDetReq = lector.IsDBNull(lector.GetOrdinal("canDetReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("canDetReq")),
                            precio = lector.IsDBNull(lector.GetOrdinal("precio")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("precio")),
                            importe = lector.IsDBNull(lector.GetOrdinal("importe")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("importe")),
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
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 6);
                db.AddInParameter(SQL, "codSolCotizacion", DbType.Int32, codSolCotizacion);
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

        public List<DetalleSolicitudRequerimiento> ObtenerPorcodPro(Int32 codPro)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 8);
                db.AddInParameter(SQL, "codPro", DbType.Int32, codPro);
                var coleccion = new List<DetalleSolicitudRequerimiento>();
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleSolicitudRequerimiento
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("codSolCotizacion")),
                            codSolDet = lector.GetInt32(lector.GetOrdinal("codSolDet")),
                            desSolDet = lector.IsDBNull(lector.GetOrdinal("desSolDet")) ? default(String) : lector.GetString(lector.GetOrdinal("desSolDet")),
                            fecSolDet = lector.IsDBNull(lector.GetOrdinal("fecSolDet")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecSolDet")),
                            codPro = lector.IsDBNull(lector.GetOrdinal("codPro")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codPro")),
                            codReq = lector.IsDBNull(lector.GetOrdinal("codReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codReq")),
                            codcorDetReq = lector.IsDBNull(lector.GetOrdinal("codcorDetReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codcorDetReq")),

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



        public virtual bool EliminarPorcodPro(Int32 codPro)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 6);
                db.AddInParameter(SQL, "codPro", DbType.Int32);
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

        public List<DetalleSolicitudRequerimiento> ObtenerPorcodReq(Int32 codReq)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 10);
                db.AddInParameter(SQL, "codReq", DbType.Int32);
                var coleccion = new List<DetalleSolicitudRequerimiento>();
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleSolicitudRequerimiento
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("codSolCotizacion")),
                            codSolDet = lector.GetInt32(lector.GetOrdinal("codSolDet")),
                            desSolDet = lector.IsDBNull(lector.GetOrdinal("desSolDet")) ? default(String) : lector.GetString(lector.GetOrdinal("desSolDet")),
                            fecSolDet = lector.IsDBNull(lector.GetOrdinal("fecSolDet")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecSolDet")),
                            codPro = lector.IsDBNull(lector.GetOrdinal("codPro")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codPro")),
                            codReq = lector.IsDBNull(lector.GetOrdinal("codReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codReq")),
                            codcorDetReq = lector.IsDBNull(lector.GetOrdinal("codcorDetReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codcorDetReq")),

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



        public virtual bool EliminarPorcodReq(Int32 codReq)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 6);
                db.AddInParameter(SQL, "codReq", DbType.Int32);
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

        public List<DetalleSolicitudRequerimiento> ObtenerPorcodcorDetReq(Int32 codcorDetReq)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 10);
                db.AddInParameter(SQL, "codcorDetReq", DbType.Int32);
                var coleccion = new List<DetalleSolicitudRequerimiento>();
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleSolicitudRequerimiento
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("codSolCotizacion")),
                            codSolDet = lector.GetInt32(lector.GetOrdinal("codSolDet")),
                            desSolDet = lector.IsDBNull(lector.GetOrdinal("desSolDet")) ? default(String) : lector.GetString(lector.GetOrdinal("desSolDet")),
                            fecSolDet = lector.IsDBNull(lector.GetOrdinal("fecSolDet")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecSolDet")),
                            codPro = lector.IsDBNull(lector.GetOrdinal("codPro")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codPro")),
                            codReq = lector.IsDBNull(lector.GetOrdinal("codReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codReq")),
                            codcorDetReq = lector.IsDBNull(lector.GetOrdinal("codcorDetReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codcorDetReq")),

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



        public virtual bool EliminarPorcodcorDetReq(Int32 codcorDetReq)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 6);
                db.AddInParameter(SQL, "codcorDetReq", DbType.Int32);
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

        public List<DetalleSolicitudRequerimiento> ObtenerPorcodCotizacion(Int32 codCotizacion)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 10);
                db.AddInParameter(SQL, "codCotizacion", DbType.Int32);
                var coleccion = new List<DetalleSolicitudRequerimiento>();
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleSolicitudRequerimiento
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("codSolCotizacion")),
                            codSolDet = lector.GetInt32(lector.GetOrdinal("codSolDet")),
                            desSolDet = lector.IsDBNull(lector.GetOrdinal("desSolDet")) ? default(String) : lector.GetString(lector.GetOrdinal("desSolDet")),
                            fecSolDet = lector.IsDBNull(lector.GetOrdinal("fecSolDet")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecSolDet")),
                            codPro = lector.IsDBNull(lector.GetOrdinal("codPro")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codPro")),
                            codReq = lector.IsDBNull(lector.GetOrdinal("codReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codReq")),
                            codcorDetReq = lector.IsDBNull(lector.GetOrdinal("codcorDetReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codcorDetReq")),

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



        public virtual bool EliminarPorcodCotizacion(Int32 codCotizacion)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 6);
                db.AddInParameter(SQL, "codCotizacion", DbType.Int32);
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

        public List<DetalleSolicitudRequerimiento> ObtenerPorcodCotDet(Int32 codCotDet)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 10);
                db.AddInParameter(SQL, "codCotDet", DbType.Int32);
                var coleccion = new List<DetalleSolicitudRequerimiento>();
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleSolicitudRequerimiento
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("codSolCotizacion")),
                            codSolDet = lector.GetInt32(lector.GetOrdinal("codSolDet")),
                            desSolDet = lector.IsDBNull(lector.GetOrdinal("desSolDet")) ? default(String) : lector.GetString(lector.GetOrdinal("desSolDet")),
                            fecSolDet = lector.IsDBNull(lector.GetOrdinal("fecSolDet")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecSolDet")),
                            codPro = lector.IsDBNull(lector.GetOrdinal("codPro")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codPro")),
                            codReq = lector.IsDBNull(lector.GetOrdinal("codReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codReq")),
                            codcorDetReq = lector.IsDBNull(lector.GetOrdinal("codcorDetReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codcorDetReq")),

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



        public virtual bool EliminarPorcodCotDet(Int32 codCotDet)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 6);
                db.AddInParameter(SQL, "codCotDet", DbType.Int32);
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

        public virtual DetalleSolicitudRequerimiento GetByPrimaryKey(Int32 codSolCotizacion, Int32 codSolDet)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 3);
                db.AddInParameter(SQL, "codSolCotizacion", DbType.Int32, codSolCotizacion);
                db.AddInParameter(SQL, "codSolDet", DbType.Int32, codSolDet);
                var DetalleSolicitudRequerimiento = default(DetalleSolicitudRequerimiento);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        DetalleSolicitudRequerimiento = new DetalleSolicitudRequerimiento
                        {
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("codSolCotizacion")),
                            codSolDet = lector.GetInt32(lector.GetOrdinal("codSolDet")),
                            desSolDet = lector.IsDBNull(lector.GetOrdinal("desSolDet")) ? default(String) : lector.GetString(lector.GetOrdinal("desSolDet")),
                            fecSolDet = lector.IsDBNull(lector.GetOrdinal("fecSolDet")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecSolDet")),
                            codPro = lector.IsDBNull(lector.GetOrdinal("codPro")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codPro")),
                            codReq = lector.IsDBNull(lector.GetOrdinal("codReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codReq")),
                            codcorDetReq = lector.IsDBNull(lector.GetOrdinal("codcorDetReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codcorDetReq")),

                        };
                    }
                }
                SQL.Dispose();
                return DetalleSolicitudRequerimiento;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }



        protected virtual string CreateGetCommand(string whereSql, string orderBySql)
        {
            string sql = "SELECT * FROM [dbo].[DetalleSolicitudRequerimiento]";
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

        public virtual int Insert(DetalleSolicitudRequerimiento DetalleSolicitudRequerimiento, DbTransaction tran = null)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codSolCotizacion", DbType.Int32, DetalleSolicitudRequerimiento.codSolCotizacion);
                db.AddInParameter(SQL, "desSolDet", DbType.String, DetalleSolicitudRequerimiento.desSolDet);
                db.AddInParameter(SQL, "codPro", DbType.Int32, DetalleSolicitudRequerimiento.codPro);
                db.AddInParameter(SQL, "codReq", DbType.Int32, DetalleSolicitudRequerimiento.codReq);
                db.AddInParameter(SQL, "codcorDetReq", DbType.Int32, DetalleSolicitudRequerimiento.codcorDetReq);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 4);
                int huboexito;
                if (tran != null) huboexito = db.ExecuteNonQuery(SQL, tran);
                else huboexito = db.ExecuteNonQuery(SQL);
                if (huboexito == 0)
                {
                    throw new Exception("Error al agregar al detalle del requerimiento de la cotización");
                }
                //var numerogenerado = (int)db.GetParameterValue(SQL, "codSolDet");
                SQL.Dispose();
                //return numerogenerado;
                return huboexito;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        public virtual void Update(DetalleSolicitudRequerimiento DetalleSolicitudRequerimiento, DbTransaction tran = null)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codSolCotizacion", DbType.Int32, DetalleSolicitudRequerimiento.codSolCotizacion);
                db.AddInParameter(SQL, "codSolDet", DbType.Int32, DetalleSolicitudRequerimiento.codSolDet);
                db.AddInParameter(SQL, "desSolDet", DbType.String, DetalleSolicitudRequerimiento.desSolDet);
                db.AddInParameter(SQL, "fecSolDet", DbType.DateTime, DetalleSolicitudRequerimiento.fecSolDet);
                db.AddInParameter(SQL, "codPro", DbType.Int32, DetalleSolicitudRequerimiento.codPro);
                db.AddInParameter(SQL, "codReq", DbType.Int32, DetalleSolicitudRequerimiento.codReq);
                db.AddInParameter(SQL, "codcorDetReq", DbType.Int32, DetalleSolicitudRequerimiento.codcorDetReq);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 1);
                int huboexito;
                if (tran != null) huboexito = db.ExecuteNonQuery(SQL, tran);
                else huboexito = db.ExecuteNonQuery(SQL);

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


        public virtual bool DeleteByPrimaryKey(Int32 codSolCotizacion, Int32 codSolDet)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codSolCotizacion", DbType.Int32, codSolCotizacion);
                db.AddInParameter(SQL, "codSolDet", DbType.Int32, codSolDet);
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
