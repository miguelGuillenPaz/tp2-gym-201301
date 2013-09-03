using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GYM.SIG.DataAccess
{
    public class DetalleRequerimientodalc : Singleton<DetalleRequerimientodalc>
    {
        private const String nombreprocedimiento = "pa_GSC_DetalleRequerimiento";
        private const String NombreTabla = "DetalleRequerimiento";
        private Database db = DatabaseFactory.CreateDatabase();

        public List<DetalleRequerimiento> listaporSolicitud(int codSolCotizacion)
        {
            try
            {
                var coleccion = new List<DetalleRequerimiento>();
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codSolCotizacion", DbType.Int32, codSolCotizacion);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 11);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleRequerimiento
                        {
                            codPro = lector.GetInt32(lector.GetOrdinal("codPro")),
                            codReq = lector.GetInt32(lector.GetOrdinal("codReq")),
                            codcorDetReq = lector.GetInt32(lector.GetOrdinal("codcorDetReq")),
                            canDetReq = lector.IsDBNull(lector.GetOrdinal("canDetReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("canDetReq")),
                            fecInicio = lector.IsDBNull(lector.GetOrdinal("fecInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecInicio")),
                            fecFin = lector.IsDBNull(lector.GetOrdinal("fecFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecFin")),
                            desServicio = lector.IsDBNull(lector.GetOrdinal("desServicio")) ? "" : lector.GetString(lector.GetOrdinal("desServicio")),
                            actServicio = lector.IsDBNull(lector.GetOrdinal("actServicio")) ? "" : lector.GetString(lector.GetOrdinal("actServicio")),
                            codUM = lector.IsDBNull(lector.GetOrdinal("codUM")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codUM")),
                            descUM = lector.IsDBNull(lector.GetOrdinal("descUM")) ? "" : lector.GetString(lector.GetOrdinal("descUM")),

                            nomPro = lector.IsDBNull(lector.GetOrdinal("nomPro")) ? "" : lector.GetString(lector.GetOrdinal("nomPro")),
                            desReq = lector.IsDBNull(lector.GetOrdinal("desReq")) ? "" : lector.GetString(lector.GetOrdinal("desReq")),
                            codSolDet = lector.IsDBNull(lector.GetOrdinal("codSolDet")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codSolDet")),
                            codSolCotizacion = codSolCotizacion,
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

        public List<DetalleRequerimiento> listarPendientes(int codPro, int codTServ, int codReq)
        {
            try
            {
                var coleccion = new List<DetalleRequerimiento>();
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codPro", DbType.Int32, codPro);
                db.AddInParameter(SQL, "codTServ", DbType.Int32, codTServ);
                db.AddInParameter(SQL, "codReq", DbType.Int32, codReq);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 10);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleRequerimiento
                        {
                            codPro = lector.GetInt32(lector.GetOrdinal("codPro")),
                            nomPro = lector.IsDBNull(lector.GetOrdinal("nomPro")) ? "" : lector.GetString(lector.GetOrdinal("nomPro")),
                            codReq = lector.GetInt32(lector.GetOrdinal("codReq")),
                            codcorDetReq = lector.GetInt32(lector.GetOrdinal("codcorDetReq")),
                            canDetReq = lector.IsDBNull(lector.GetOrdinal("canDetReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("canDetReq")),
                            fecInicio = lector.IsDBNull(lector.GetOrdinal("fecInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecInicio")),
                            fecFin = lector.IsDBNull(lector.GetOrdinal("fecFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecFin")),
                            desReq = lector.IsDBNull(lector.GetOrdinal("desReq")) ? "" : lector.GetString(lector.GetOrdinal("desReq")),
                            desServicio = lector.IsDBNull(lector.GetOrdinal("desServicio")) ? "" : lector.GetString(lector.GetOrdinal("desServicio")),
                            actServicio = lector.IsDBNull(lector.GetOrdinal("actServicio")) ? "" : lector.GetString(lector.GetOrdinal("actServicio")),
                            codUM = lector.IsDBNull(lector.GetOrdinal("codUM")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codUM")),
                            descUM = lector.IsDBNull(lector.GetOrdinal("descUM")) ? "" : lector.GetString(lector.GetOrdinal("descUM")),
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

        public List<DetalleRequerimiento> listartodos()
        {
            try
            {
                var coleccion = new List<DetalleRequerimiento>();
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 2);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleRequerimiento
                        {
                            codPro = lector.GetInt32(lector.GetOrdinal("codPro")),
                            codReq = lector.GetInt32(lector.GetOrdinal("codReq")),
                            codcorDetReq = lector.GetInt32(lector.GetOrdinal("codcorDetReq")),
                            canDetReq = lector.IsDBNull(lector.GetOrdinal("canDetReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("canDetReq")),
                            fecInicio = lector.IsDBNull(lector.GetOrdinal("fecInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecInicio")),
                            fecFin = lector.IsDBNull(lector.GetOrdinal("fecFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecFin")),
                            desServicio = lector.IsDBNull(lector.GetOrdinal("desServicio")) ? "" : lector.GetString(lector.GetOrdinal("desServicio")),
                            actServicio = lector.IsDBNull(lector.GetOrdinal("actServicio")) ? "" : lector.GetString(lector.GetOrdinal("actServicio")),
                            codUM = lector.IsDBNull(lector.GetOrdinal("codUM")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codUM"))

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



        public List<DetalleRequerimiento> Getcoleccion(string wheresql, string orderbysql)
        {
            int totalRecordCount = -1;
            return Getcoleccion(wheresql, orderbysql, 0, int.MaxValue, totalRecordCount);
        }


        public virtual List<DetalleRequerimiento> Getcoleccion(string wheresql, string orderbysql, int startIndex, int length, int totalRecordCount)
        {
            try
            {
                var coleccion = new List<DetalleRequerimiento>();
                DbCommand SQL = db.GetSqlStringCommand(CreateGetCommand(wheresql, orderbysql));
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleRequerimiento
                        {
                            codPro = lector.GetInt32(lector.GetOrdinal("codPro")),
                            codReq = lector.GetInt32(lector.GetOrdinal("codReq")),
                            codcorDetReq = lector.GetInt32(lector.GetOrdinal("codcorDetReq")),
                            canDetReq = lector.IsDBNull(lector.GetOrdinal("canDetReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("canDetReq")),
                            fecInicio = lector.IsDBNull(lector.GetOrdinal("fecInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecInicio")),
                            fecFin = lector.IsDBNull(lector.GetOrdinal("fecFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecFin")),
                            desServicio = lector.IsDBNull(lector.GetOrdinal("desServicio")) ? "" : lector.GetString(lector.GetOrdinal("desServicio")),
                            actServicio = lector.IsDBNull(lector.GetOrdinal("actServicio")) ? "" : lector.GetString(lector.GetOrdinal("actServicio")),
                            codUM = lector.IsDBNull(lector.GetOrdinal("codUM")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codUM"))

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


        public List<DetalleRequerimiento> ObtenerPorcodPro(Int32 codPro)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 10);
                db.AddInParameter(SQL, "codPro", DbType.Int32);
                var coleccion = new List<DetalleRequerimiento>();
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleRequerimiento
                        {
                            codPro = lector.GetInt32(lector.GetOrdinal("codPro")),
                            codReq = lector.GetInt32(lector.GetOrdinal("codReq")),
                            codcorDetReq = lector.GetInt32(lector.GetOrdinal("codcorDetReq")),
                            canDetReq = lector.IsDBNull(lector.GetOrdinal("canDetReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("canDetReq")),
                            fecInicio = lector.IsDBNull(lector.GetOrdinal("fecInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecInicio")),
                            fecFin = lector.IsDBNull(lector.GetOrdinal("fecFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecFin")),
                            desServicio = lector.IsDBNull(lector.GetOrdinal("desServicio")) ? "" : lector.GetString(lector.GetOrdinal("desServicio")),
                            actServicio = lector.IsDBNull(lector.GetOrdinal("actServicio")) ? "" : lector.GetString(lector.GetOrdinal("actServicio")),
                            codUM = lector.IsDBNull(lector.GetOrdinal("codUM")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codUM"))

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

        public List<DetalleRequerimiento> ObtenerPorcodReq(Int32 codReq)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 10);
                db.AddInParameter(SQL, "codReq", DbType.Int32);
                var coleccion = new List<DetalleRequerimiento>();
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleRequerimiento
                        {
                            codPro = lector.GetInt32(lector.GetOrdinal("codPro")),
                            codReq = lector.GetInt32(lector.GetOrdinal("codReq")),
                            codcorDetReq = lector.GetInt32(lector.GetOrdinal("codcorDetReq")),
                            canDetReq = lector.IsDBNull(lector.GetOrdinal("canDetReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("canDetReq")),
                            fecInicio = lector.IsDBNull(lector.GetOrdinal("fecInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecInicio")),
                            fecFin = lector.IsDBNull(lector.GetOrdinal("fecFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecFin")),
                            desServicio = lector.IsDBNull(lector.GetOrdinal("desServicio")) ? "" : lector.GetString(lector.GetOrdinal("desServicio")),
                            actServicio = lector.IsDBNull(lector.GetOrdinal("actServicio")) ? "" : lector.GetString(lector.GetOrdinal("actServicio")),
                            codUM = lector.IsDBNull(lector.GetOrdinal("codUM")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codUM"))

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

        public List<DetalleRequerimiento> ObtenerPorcodcorDetReq(Int32 codcorDetReq)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 10);
                db.AddInParameter(SQL, "codcorDetReq", DbType.Int32);
                var coleccion = new List<DetalleRequerimiento>();
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleRequerimiento
                        {
                            codPro = lector.GetInt32(lector.GetOrdinal("codPro")),
                            codReq = lector.GetInt32(lector.GetOrdinal("codReq")),
                            codcorDetReq = lector.GetInt32(lector.GetOrdinal("codcorDetReq")),
                            canDetReq = lector.IsDBNull(lector.GetOrdinal("canDetReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("canDetReq")),
                            fecInicio = lector.IsDBNull(lector.GetOrdinal("fecInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecInicio")),
                            fecFin = lector.IsDBNull(lector.GetOrdinal("fecFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecFin")),
                            desServicio = lector.IsDBNull(lector.GetOrdinal("desServicio")) ? "" : lector.GetString(lector.GetOrdinal("desServicio")),
                            actServicio = lector.IsDBNull(lector.GetOrdinal("actServicio")) ? "" : lector.GetString(lector.GetOrdinal("actServicio")),
                            codUM = lector.IsDBNull(lector.GetOrdinal("codUM")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codUM"))

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

        public virtual DetalleRequerimiento GetByPrimaryKey(Int32 codPro, Int32 codReq, Int32 codcorDetReq)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 3);
                db.AddInParameter(SQL, "codPro", DbType.Int32, codPro);
                db.AddInParameter(SQL, "codReq", DbType.Int32, codReq);
                db.AddInParameter(SQL, "codcorDetReq", DbType.Int32, codcorDetReq);
                var DetalleRequerimiento = default(DetalleRequerimiento);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        DetalleRequerimiento = new DetalleRequerimiento
                        {
                            codPro = lector.GetInt32(lector.GetOrdinal("codPro")),
                            codReq = lector.GetInt32(lector.GetOrdinal("codReq")),
                            codcorDetReq = lector.GetInt32(lector.GetOrdinal("codcorDetReq")),
                            canDetReq = lector.IsDBNull(lector.GetOrdinal("canDetReq")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("canDetReq")),
                            fecInicio = lector.IsDBNull(lector.GetOrdinal("fecInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecInicio")),
                            fecFin = lector.IsDBNull(lector.GetOrdinal("fecFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecFin")),
                            desServicio = lector.IsDBNull(lector.GetOrdinal("desServicio")) ? "" : lector.GetString(lector.GetOrdinal("desServicio")),
                            actServicio = lector.IsDBNull(lector.GetOrdinal("actServicio")) ? "" : lector.GetString(lector.GetOrdinal("actServicio")),
                            codUM = lector.IsDBNull(lector.GetOrdinal("codUM")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codUM"))

                        };
                    }
                }
                SQL.Dispose();
                return DetalleRequerimiento;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }



        protected virtual string CreateGetCommand(string whereSql, string orderBySql)
        {
            string sql = "SELECT * FROM [dbo].[DetalleRequerimiento]";
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

        public virtual int Insert(DetalleRequerimiento DetalleRequerimiento)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codPro", DbType.Int32, DetalleRequerimiento.codPro);
                db.AddInParameter(SQL, "codReq", DbType.Int32, DetalleRequerimiento.codReq);
                db.AddInParameter(SQL, "codcorDetReq", DbType.Int32, DetalleRequerimiento.codcorDetReq);
                db.AddInParameter(SQL, "canDetReq", DbType.Int32, DetalleRequerimiento.canDetReq);
                db.AddInParameter(SQL, "fecInicio", DbType.DateTime, DetalleRequerimiento.fecInicio);
                db.AddInParameter(SQL, "fecFin", DbType.DateTime, DetalleRequerimiento.fecFin);
                db.AddInParameter(SQL, "desServicio", DbType.String, DetalleRequerimiento.desServicio);
                db.AddInParameter(SQL, "actServicio", DbType.String, DetalleRequerimiento.actServicio);
                db.AddInParameter(SQL, "codUM", DbType.Int32, DetalleRequerimiento.codUM);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.String, 4);
                int huboexito = db.ExecuteNonQuery(SQL);
                if (huboexito == 0)
                {
                    throw new Exception("Error al agregar al");
                }
                var numerogenerado = (int)db.GetParameterValue(SQL, "");
                SQL.Dispose();
                return numerogenerado;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        public virtual void Update(DetalleRequerimiento DetalleRequerimiento)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codPro", DbType.Int32, DetalleRequerimiento.codPro);
                db.AddInParameter(SQL, "codReq", DbType.Int32, DetalleRequerimiento.codReq);
                db.AddInParameter(SQL, "codcorDetReq", DbType.Int32, DetalleRequerimiento.codcorDetReq);
                db.AddInParameter(SQL, "canDetReq", DbType.Int32, DetalleRequerimiento.canDetReq);
                db.AddInParameter(SQL, "fecInicio", DbType.DateTime, DetalleRequerimiento.fecInicio);
                db.AddInParameter(SQL, "fecFin", DbType.DateTime, DetalleRequerimiento.fecFin);
                db.AddInParameter(SQL, "desServicio", DbType.String, DetalleRequerimiento.desServicio);
                db.AddInParameter(SQL, "actServicio", DbType.String, DetalleRequerimiento.actServicio);
                db.AddInParameter(SQL, "codUM", DbType.Int32, DetalleRequerimiento.codUM);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.String, 1);
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


        public virtual bool DeleteByPrimaryKey(Int32 codPro, Int32 codReq, Int32 codcorDetReq)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codPro", DbType.Int32, codPro);
                db.AddInParameter(SQL, "codReq", DbType.Int32, codReq);
                db.AddInParameter(SQL, "codcorDetReq", DbType.Int32, codcorDetReq);
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
