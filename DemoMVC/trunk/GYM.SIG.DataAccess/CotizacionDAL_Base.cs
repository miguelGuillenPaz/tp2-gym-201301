using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GYM.SIG.DataAccess
{
    public class Cotizaciondalc : Singleton<Cotizaciondalc>
    {
        private const String nombreprocedimiento = "pa_Cotizacion";
        private const String NombreTabla = "Cotizacion";
        private Database db = DatabaseFactory.CreateDatabase();

        public List<Cotizacion> ObtenerCotizaciones(String tipoFecha, DateTime fechaInicio, DateTime fechaFin, int codPro, int codTServ, int codEstado, int codSolCotizacion, int codProv, int codCotizacion)
        {
            try
            {
                var coleccion = new List<Cotizacion>();
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

                db.AddInParameter(SQL, "codEstado", DbType.Int32, codEstado);
                db.AddInParameter(SQL, "codTServ", DbType.Int32, codTServ);
                db.AddInParameter(SQL, "codPro", DbType.Int32, codPro);
                db.AddInParameter(SQL, "codProv", DbType.Int32, codProv);
                db.AddInParameter(SQL, "codSolCotizacion", DbType.Int32, codSolCotizacion);
                db.AddInParameter(SQL, "codCotizacion", DbType.Int32, codCotizacion);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Cotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("codCotizacion")),
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("codSolCotizacion")),
                            fechaInicio = lector.IsDBNull(lector.GetOrdinal("fechaInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fechaInicio")),
                            fechaFin = lector.IsDBNull(lector.GetOrdinal("fechaFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fechaFin")),
                            descTServ = lector.IsDBNull(lector.GetOrdinal("descTServ")) ? "" : lector.GetString(lector.GetOrdinal("descTServ")),

                            codFormPag = lector.IsDBNull(lector.GetOrdinal("codFormPag")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codFormPag")),
                            codMoneda = lector.IsDBNull(lector.GetOrdinal("codMoneda")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codMoneda")),

                            codTServ = lector.IsDBNull(lector.GetOrdinal("codTServ")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codTServ")),
                            monto = lector.IsDBNull(lector.GetOrdinal("monto")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("monto")),
                            razsocPro = lector.IsDBNull(lector.GetOrdinal("razsocPro")) ? "" : lector.GetString(lector.GetOrdinal("razsocPro")),
                            codProv = lector.IsDBNull(lector.GetOrdinal("codProv")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codProv")),
                            descMon = lector.IsDBNull(lector.GetOrdinal("descMon")) ? "" : lector.GetString(lector.GetOrdinal("descMon")),
                            abrvMon = lector.IsDBNull(lector.GetOrdinal("abrvMon")) ? "" : lector.GetString(lector.GetOrdinal("abrvMon")),
                            estado = lector.IsDBNull(lector.GetOrdinal("estado")) ? "" : lector.GetString(lector.GetOrdinal("estado")),
                            Comentarios = lector.IsDBNull(lector.GetOrdinal("Comentarios")) ? "" : lector.GetString(lector.GetOrdinal("Comentarios")),
                            pdfCotizacion = lector.IsDBNull(lector.GetOrdinal("pdfCotizacion")) ? "" : lector.GetString(lector.GetOrdinal("pdfCotizacion")),
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

        public List<Cotizacion> listartodos()
        {
            try
            {
                var coleccion = new List<Cotizacion>();
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 2);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Cotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("codCotizacion")),
                            fechaInicio = lector.IsDBNull(lector.GetOrdinal("fechaInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fechaInicio")),
                            fechaFin = lector.IsDBNull(lector.GetOrdinal("fechaFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fechaFin")),
                            monto = lector.IsDBNull(lector.GetOrdinal("monto")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("monto")),
                            igv = lector.IsDBNull(lector.GetOrdinal("igv")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("igv")),
                            Total = lector.IsDBNull(lector.GetOrdinal("Total")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Total")),
                            Comentarios = lector.IsDBNull(lector.GetOrdinal("Comentarios")) ? default(String) : lector.GetString(lector.GetOrdinal("Comentarios")),
                            pdfCotizacion = lector.IsDBNull(lector.GetOrdinal("pdfCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("pdfCotizacion")),
                            codMoneda = lector.IsDBNull(lector.GetOrdinal("codMoneda")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codMoneda")),
                            codSolCotizacion = lector.IsDBNull(lector.GetOrdinal("codSolCotizacion")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codSolCotizacion")),
                            codProv = lector.IsDBNull(lector.GetOrdinal("codProv")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codProv")),
                            codTServ = lector.IsDBNull(lector.GetOrdinal("codTServ")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codTServ"))

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

        public List<Cotizacion> Getcoleccion(string wheresql, string orderbysql)
        {
            int totalRecordCount = -1;
            return Getcoleccion(wheresql, orderbysql, 0, int.MaxValue, totalRecordCount);
        }


        public virtual List<Cotizacion> Getcoleccion(string wheresql, string orderbysql, int startIndex, int length, int totalRecordCount)
        {
            try
            {
                var coleccion = new List<Cotizacion>();
                DbCommand SQL = db.GetSqlStringCommand(CreateGetCommand(wheresql, orderbysql));
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Cotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("codCotizacion")),
                            fechaInicio = lector.IsDBNull(lector.GetOrdinal("fechaInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fechaInicio")),
                            fechaFin = lector.IsDBNull(lector.GetOrdinal("fechaFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fechaFin")),
                            monto = lector.IsDBNull(lector.GetOrdinal("monto")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("monto")),
                            igv = lector.IsDBNull(lector.GetOrdinal("igv")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("igv")),
                            Total = lector.IsDBNull(lector.GetOrdinal("Total")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Total")),
                            Comentarios = lector.IsDBNull(lector.GetOrdinal("Comentarios")) ? default(String) : lector.GetString(lector.GetOrdinal("Comentarios")),
                            pdfCotizacion = lector.IsDBNull(lector.GetOrdinal("pdfCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("pdfCotizacion")),
                            codMoneda = lector.IsDBNull(lector.GetOrdinal("codMoneda")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codMoneda")),
                            codSolCotizacion = lector.IsDBNull(lector.GetOrdinal("codSolCotizacion")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codSolCotizacion")),
                            codProv = lector.IsDBNull(lector.GetOrdinal("codProv")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codProv")),
                            codTServ = lector.IsDBNull(lector.GetOrdinal("codTServ")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codTServ"))

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

        public virtual bool EliminarPorcodMoneda(Int32 codMoneda)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 6);
                db.AddInParameter(SQL, "codMoneda", DbType.Int32);
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

        public List<Cotizacion> ObtenerPorcodSolCotizacion(Int32 codSolCotizacion)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 10);
                db.AddInParameter(SQL, "codSolCotizacion", DbType.Int32);
                var coleccion = new List<Cotizacion>();
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Cotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("codCotizacion")),
                            fechaInicio = lector.IsDBNull(lector.GetOrdinal("fechaInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fechaInicio")),
                            fechaFin = lector.IsDBNull(lector.GetOrdinal("fechaFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fechaFin")),
                            monto = lector.IsDBNull(lector.GetOrdinal("monto")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("monto")),
                            igv = lector.IsDBNull(lector.GetOrdinal("igv")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("igv")),
                            Total = lector.IsDBNull(lector.GetOrdinal("Total")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Total")),
                            Comentarios = lector.IsDBNull(lector.GetOrdinal("Comentarios")) ? default(String) : lector.GetString(lector.GetOrdinal("Comentarios")),
                            pdfCotizacion = lector.IsDBNull(lector.GetOrdinal("pdfCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("pdfCotizacion")),
                            codMoneda = lector.IsDBNull(lector.GetOrdinal("codMoneda")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codMoneda")),
                            codSolCotizacion = lector.IsDBNull(lector.GetOrdinal("codSolCotizacion")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codSolCotizacion")),
                            codProv = lector.IsDBNull(lector.GetOrdinal("codProv")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codProv")),
                            codTServ = lector.IsDBNull(lector.GetOrdinal("codTServ")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codTServ"))

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
                db.AddInParameter(SQL, "codSolCotizacion", DbType.Int32);
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

        public List<Cotizacion> ObtenerPorcodPro(Int32 codPro)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 10);
                db.AddInParameter(SQL, "codPro", DbType.Int32);
                var coleccion = new List<Cotizacion>();
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Cotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("codCotizacion")),
                            fechaInicio = lector.IsDBNull(lector.GetOrdinal("fechaInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fechaInicio")),
                            fechaFin = lector.IsDBNull(lector.GetOrdinal("fechaFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fechaFin")),
                            monto = lector.IsDBNull(lector.GetOrdinal("monto")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("monto")),
                            igv = lector.IsDBNull(lector.GetOrdinal("igv")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("igv")),
                            Total = lector.IsDBNull(lector.GetOrdinal("Total")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Total")),
                            Comentarios = lector.IsDBNull(lector.GetOrdinal("Comentarios")) ? default(String) : lector.GetString(lector.GetOrdinal("Comentarios")),
                            pdfCotizacion = lector.IsDBNull(lector.GetOrdinal("pdfCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("pdfCotizacion")),
                            codMoneda = lector.IsDBNull(lector.GetOrdinal("codMoneda")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codMoneda")),
                            codSolCotizacion = lector.IsDBNull(lector.GetOrdinal("codSolCotizacion")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codSolCotizacion")),
                            codProv = lector.IsDBNull(lector.GetOrdinal("codProv")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codProv")),
                            codTServ = lector.IsDBNull(lector.GetOrdinal("codTServ")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codTServ"))

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

        public List<Cotizacion> ObtenerPorcodTServ(Int32 codTServ)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 10);
                db.AddInParameter(SQL, "codTServ", DbType.Int32);
                var coleccion = new List<Cotizacion>();
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Cotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("codCotizacion")),
                            fechaInicio = lector.IsDBNull(lector.GetOrdinal("fechaInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fechaInicio")),
                            fechaFin = lector.IsDBNull(lector.GetOrdinal("fechaFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fechaFin")),
                            monto = lector.IsDBNull(lector.GetOrdinal("monto")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("monto")),
                            igv = lector.IsDBNull(lector.GetOrdinal("igv")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("igv")),
                            Total = lector.IsDBNull(lector.GetOrdinal("Total")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Total")),
                            Comentarios = lector.IsDBNull(lector.GetOrdinal("Comentarios")) ? default(String) : lector.GetString(lector.GetOrdinal("Comentarios")),
                            pdfCotizacion = lector.IsDBNull(lector.GetOrdinal("pdfCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("pdfCotizacion")),
                            codMoneda = lector.IsDBNull(lector.GetOrdinal("codMoneda")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codMoneda")),
                            codSolCotizacion = lector.IsDBNull(lector.GetOrdinal("codSolCotizacion")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codSolCotizacion")),
                            codProv = lector.IsDBNull(lector.GetOrdinal("codProv")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codProv")),
                            codTServ = lector.IsDBNull(lector.GetOrdinal("codTServ")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codTServ"))

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
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 6);
                db.AddInParameter(SQL, "codTServ", DbType.Int32);
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

        public virtual Cotizacion GetByPrimaryKey(Int32 codCotizacion)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 3);
                db.AddInParameter(SQL, "codCotizacion", DbType.Int32, codCotizacion);
                var Cotizacion = default(Cotizacion);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        Cotizacion = new Cotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("codCotizacion")),
                            fechaInicio = lector.IsDBNull(lector.GetOrdinal("fechaInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fechaInicio")),
                            fechaFin = lector.IsDBNull(lector.GetOrdinal("fechaFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fechaFin")),
                            monto = lector.IsDBNull(lector.GetOrdinal("monto")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("monto")),
                            igv = lector.IsDBNull(lector.GetOrdinal("igv")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("igv")),
                            Total = lector.IsDBNull(lector.GetOrdinal("Total")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Total")),
                            Comentarios = lector.IsDBNull(lector.GetOrdinal("Comentarios")) ? default(String) : lector.GetString(lector.GetOrdinal("Comentarios")),
                            pdfCotizacion = lector.IsDBNull(lector.GetOrdinal("pdfCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("pdfCotizacion")),
                            codMoneda = lector.IsDBNull(lector.GetOrdinal("codMoneda")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codMoneda")),
                            codSolCotizacion = lector.IsDBNull(lector.GetOrdinal("codSolCotizacion")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codSolCotizacion")),
                            codProv = lector.IsDBNull(lector.GetOrdinal("codProv")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codProv")),
                            codTServ = lector.IsDBNull(lector.GetOrdinal("codTServ")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codTServ")),
                            codFormPag = lector.IsDBNull(lector.GetOrdinal("codFormPag")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codFormPag")),
                            codEstado = lector.IsDBNull(lector.GetOrdinal("codEstado")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("codEstado")),
                        };
                    }
                }
                SQL.Dispose();
                return Cotizacion;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        protected virtual string CreateGetCommand(string whereSql, string orderBySql)
        {
            string sql = "SELECT * FROM [dbo].[Cotizacion]";
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

        public virtual int Grabar(Cotizacion cotizacion, List<DetalleCotizacion> detalles)
        {
            DbConnection cnn = db.CreateConnection();
            cnn.Open();
            DbTransaction tran = cnn.BeginTransaction();
            try
            {
                if (cotizacion.codCotizacion == 0) cotizacion.codCotizacion = this.Insert(cotizacion, tran);
                else this.Update(cotizacion, tran);

                foreach (var item in detalles)
                {
                    item.codCotizacion = cotizacion.codCotizacion;
                    DetalleCotizaciondalc.Instancia.Insert(item, tran);
                }

                tran.Commit();
                return cotizacion.codCotizacion;
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

        public virtual int Insert(Cotizacion Cotizacion, DbTransaction tran = null)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddOutParameter(SQL, "codCotizacion", DbType.Int32, 0);
                db.AddInParameter(SQL, "fechaInicio", DbType.DateTime, Cotizacion.fechaInicio);
                db.AddInParameter(SQL, "fechaFin", DbType.DateTime, Cotizacion.fechaFin);
                db.AddInParameter(SQL, "monto", DbType.Decimal, Cotizacion.monto);
                db.AddInParameter(SQL, "igv", DbType.Decimal, Cotizacion.igv);
                db.AddInParameter(SQL, "Total", DbType.Decimal, Cotizacion.Total);
                db.AddInParameter(SQL, "Comentarios", DbType.String, Cotizacion.Comentarios);
                db.AddInParameter(SQL, "pdfCotizacion", DbType.String, Cotizacion.pdfCotizacion);
                db.AddInParameter(SQL, "codMoneda", DbType.Int32, Cotizacion.codMoneda);
                db.AddInParameter(SQL, "codSolCotizacion", DbType.Int32, Cotizacion.codSolCotizacion);
                db.AddInParameter(SQL, "codProv", DbType.Int32, Cotizacion.codProv);
                db.AddInParameter(SQL, "codFormPag", DbType.Int32, Cotizacion.codFormPag);
                db.AddInParameter(SQL, "codTServ", DbType.Int32, Cotizacion.codTServ);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 4);
                int huboexito;
                if (tran != null) huboexito = db.ExecuteNonQuery(SQL, tran);
                else huboexito = db.ExecuteNonQuery(SQL);

                if (huboexito == 0)
                {
                    throw new Exception("Error al agregar al");
                }
                var numerogenerado = (int)db.GetParameterValue(SQL, "codCotizacion");
                SQL.Dispose();
                return numerogenerado;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual void CambiarEstado(int codCotizacion, int codEstado, DbTransaction tran = null)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codCotizacion", DbType.Int32, codCotizacion);
                db.AddInParameter(SQL, "codEstado", DbType.Int32, codEstado);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 5);
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

        public virtual void Update(Cotizacion Cotizacion, DbTransaction tran = null)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codCotizacion", DbType.Int32, Cotizacion.codCotizacion);
                db.AddInParameter(SQL, "fechaInicio", DbType.DateTime, Cotizacion.fechaInicio);
                db.AddInParameter(SQL, "fechaFin", DbType.DateTime, Cotizacion.fechaFin);
                db.AddInParameter(SQL, "monto", DbType.Decimal, Cotizacion.monto);
                db.AddInParameter(SQL, "igv", DbType.Decimal, Cotizacion.igv);
                db.AddInParameter(SQL, "Total", DbType.Decimal, Cotizacion.Total);
                db.AddInParameter(SQL, "Comentarios", DbType.String, Cotizacion.Comentarios);
                db.AddInParameter(SQL, "pdfCotizacion", DbType.String, Cotizacion.pdfCotizacion);
                db.AddInParameter(SQL, "codMoneda", DbType.Int32, Cotizacion.codMoneda);
                db.AddInParameter(SQL, "codSolCotizacion", DbType.Int32, Cotizacion.codSolCotizacion);
                db.AddInParameter(SQL, "codProv", DbType.Int32, Cotizacion.codProv);
                db.AddInParameter(SQL, "codTServ", DbType.Int32, Cotizacion.codTServ);
                db.AddInParameter(SQL, "codFormPag", DbType.Int32, Cotizacion.codFormPag);

                db.AddInParameter(SQL, "eliminarDetalle", DbType.Boolean, Cotizacion.eliminarDetalle);
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

        public virtual bool DeleteByPrimaryKey(Int32 codCotizacion)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codCotizacion", DbType.Int32, codCotizacion);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 5);
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
