using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GYM.SIG.DataAccess
{
    public class DetalleCotizaciondalc : Singleton<DetalleCotizaciondalc>
    {
        private const String nombreprocedimiento = "pa_GSC_DetalleCotizacion";
        private const String NombreTabla = "DetalleCotizacion";
        private Database db = DatabaseFactory.CreateDatabase();


        public List<DetalleCotizacion> listartodos()
        {
            try
            {
                var coleccion = new List<DetalleCotizacion>();
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 2);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleCotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("codCotizacion")),
                            codCotDet = lector.GetInt32(lector.GetOrdinal("codCotDet")),
                            descripcion = lector.IsDBNull(lector.GetOrdinal("descripcion")) ? default(String) : lector.GetString(lector.GetOrdinal("descripcion")),
                            cantidad = lector.IsDBNull(lector.GetOrdinal("cantidad")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("cantidad")),
                            precio = lector.IsDBNull(lector.GetOrdinal("precio")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("precio")),
                            importe = lector.IsDBNull(lector.GetOrdinal("importe")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("importe")),
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



        public List<DetalleCotizacion> Getcoleccion(string wheresql, string orderbysql)
        {
            int totalRecordCount = -1;
            return Getcoleccion(wheresql, orderbysql, 0, int.MaxValue, totalRecordCount);
        }


        public virtual List<DetalleCotizacion> Getcoleccion(string wheresql, string orderbysql, int startIndex, int length, int totalRecordCount)
        {
            try
            {
                var coleccion = new List<DetalleCotizacion>();
                DbCommand SQL = db.GetSqlStringCommand(CreateGetCommand(wheresql, orderbysql));
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleCotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("codCotizacion")),
                            codCotDet = lector.GetInt32(lector.GetOrdinal("codCotDet")),
                            descripcion = lector.IsDBNull(lector.GetOrdinal("descripcion")) ? default(String) : lector.GetString(lector.GetOrdinal("descripcion")),
                            cantidad = lector.IsDBNull(lector.GetOrdinal("cantidad")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("cantidad")),
                            precio = lector.IsDBNull(lector.GetOrdinal("precio")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("precio")),
                            importe = lector.IsDBNull(lector.GetOrdinal("importe")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("importe")),
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


        public List<DetalleCotizacion> ObtenerPorcodCotizacion(Int32 codCotizacion)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 10);
                db.AddInParameter(SQL, "codCotizacion", DbType.Int32);
                var coleccion = new List<DetalleCotizacion>();
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleCotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("codCotizacion")),
                            codCotDet = lector.GetInt32(lector.GetOrdinal("codCotDet")),
                            descripcion = lector.IsDBNull(lector.GetOrdinal("descripcion")) ? default(String) : lector.GetString(lector.GetOrdinal("descripcion")),
                            cantidad = lector.IsDBNull(lector.GetOrdinal("cantidad")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("cantidad")),
                            precio = lector.IsDBNull(lector.GetOrdinal("precio")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("precio")),
                            importe = lector.IsDBNull(lector.GetOrdinal("importe")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("importe")),
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

        public List<DetalleCotizacion> ObtenerPorcodUM(Int32 codUM)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 10);
                db.AddInParameter(SQL, "codUM", DbType.Int32);
                var coleccion = new List<DetalleCotizacion>();
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleCotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("codCotizacion")),
                            codCotDet = lector.GetInt32(lector.GetOrdinal("codCotDet")),
                            descripcion = lector.IsDBNull(lector.GetOrdinal("descripcion")) ? default(String) : lector.GetString(lector.GetOrdinal("descripcion")),
                            cantidad = lector.IsDBNull(lector.GetOrdinal("cantidad")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("cantidad")),
                            precio = lector.IsDBNull(lector.GetOrdinal("precio")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("precio")),
                            importe = lector.IsDBNull(lector.GetOrdinal("importe")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("importe")),
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



        public virtual bool EliminarPorcodUM(Int32 codUM)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 6);
                db.AddInParameter(SQL, "codUM", DbType.Int32);
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

        public virtual DetalleCotizacion ObtenerPorSolicitud(int codSolCotizacion, int codSolDet)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 7);
                db.AddInParameter(SQL, "codSolCotizacion", DbType.Int32, codSolCotizacion);
                db.AddInParameter(SQL, "codSolDet", DbType.Int32, codSolDet);
                var DetalleCotizacion = default(DetalleCotizacion);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        DetalleCotizacion = new DetalleCotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("codCotizacion")),
                            codCotDet = lector.GetInt32(lector.GetOrdinal("codCotDet")),
                            descripcion = lector.IsDBNull(lector.GetOrdinal("descripcion")) ? default(String) : lector.GetString(lector.GetOrdinal("descripcion")),
                            cantidad = lector.IsDBNull(lector.GetOrdinal("cantidad")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("cantidad")),
                            precio = lector.IsDBNull(lector.GetOrdinal("precio")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("precio")),
                            importe = lector.IsDBNull(lector.GetOrdinal("importe")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("importe")),
                            codUM = lector.IsDBNull(lector.GetOrdinal("codUM")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codUM")),
                            desEstado = lector.IsDBNull(lector.GetOrdinal("desEstado")) ? "" : lector.GetString(lector.GetOrdinal("desEstado")),
                        };
                    }
                }
                SQL.Dispose();
                return DetalleCotizacion;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual DetalleCotizacion GetByPrimaryKey(Int32 codCotizacion, Int32 codCotDet)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 3);
                db.AddInParameter(SQL, "codCotizacion", DbType.Int32, codCotizacion);
                db.AddInParameter(SQL, "codCotDet", DbType.Int32, codCotDet);
                var DetalleCotizacion = default(DetalleCotizacion);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        DetalleCotizacion = new DetalleCotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("codCotizacion")),
                            codCotDet = lector.GetInt32(lector.GetOrdinal("codCotDet")),
                            descripcion = lector.IsDBNull(lector.GetOrdinal("descripcion")) ? default(String) : lector.GetString(lector.GetOrdinal("descripcion")),
                            cantidad = lector.IsDBNull(lector.GetOrdinal("cantidad")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("cantidad")),
                            precio = lector.IsDBNull(lector.GetOrdinal("precio")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("precio")),
                            importe = lector.IsDBNull(lector.GetOrdinal("importe")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("importe")),
                            codUM = lector.IsDBNull(lector.GetOrdinal("codUM")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codUM"))

                        };
                    }
                }
                SQL.Dispose();
                return DetalleCotizacion;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }



        protected virtual string CreateGetCommand(string whereSql, string orderBySql)
        {
            string sql = "SELECT * FROM [dbo].[DetalleCotizacion]";
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

        public virtual int Insert(DetalleCotizacion DetalleCotizacion, DbTransaction tran = null)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddOutParameter(SQL, "codCotDet", DbType.Int32, 0);
                db.AddInParameter(SQL, "codCotizacion", DbType.Int32, DetalleCotizacion.codCotizacion);
                db.AddInParameter(SQL, "descripcion", DbType.String, DetalleCotizacion.descripcion);
                db.AddInParameter(SQL, "cantidad", DbType.Decimal, DetalleCotizacion.cantidad);
                db.AddInParameter(SQL, "precio", DbType.Decimal, DetalleCotizacion.precio);
                db.AddInParameter(SQL, "importe", DbType.Decimal, DetalleCotizacion.importe);
                db.AddInParameter(SQL, "codUM", DbType.Int32, DetalleCotizacion.codUM);
                db.AddInParameter(SQL, "codSolCotizacion", DbType.Int32, DetalleCotizacion.codSolCotizacion);
                db.AddInParameter(SQL, "codSolDet", DbType.Int32, DetalleCotizacion.codSolDet);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 4);
                int huboexito;
                if (tran != null) huboexito = db.ExecuteNonQuery(SQL, tran);
                else huboexito = db.ExecuteNonQuery(SQL);

                if (huboexito == 0)
                {
                    throw new Exception("Error al agregar al");
                }
                var numerogenerado = (int)db.GetParameterValue(SQL, "codCotDet");
                SQL.Dispose();
                return numerogenerado;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        public virtual void Update(DetalleCotizacion DetalleCotizacion, DbTransaction tran = null)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codCotizacion", DbType.Int32, DetalleCotizacion.codCotizacion);
                db.AddInParameter(SQL, "codCotDet", DbType.Int32, DetalleCotizacion.codCotDet);
                db.AddInParameter(SQL, "descripcion", DbType.String, DetalleCotizacion.descripcion);
                db.AddInParameter(SQL, "cantidad", DbType.Decimal, DetalleCotizacion.cantidad);
                db.AddInParameter(SQL, "precio", DbType.Decimal, DetalleCotizacion.precio);
                db.AddInParameter(SQL, "importe", DbType.Decimal, DetalleCotizacion.importe);
                db.AddInParameter(SQL, "codUM", DbType.Int32, DetalleCotizacion.codUM);
                db.AddInParameter(SQL, "codSolCotizacion", DbType.Int32, DetalleCotizacion.codSolCotizacion);
                db.AddInParameter(SQL, "codSolDet", DbType.Int32, DetalleCotizacion.codSolDet);
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


        public virtual bool DeleteByPrimaryKey(Int32 codCotizacion, Int32 codCotDet)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codCotizacion", DbType.Int32, codCotizacion);
                db.AddInParameter(SQL, "codCotDet", DbType.Int32, codCotDet);
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
