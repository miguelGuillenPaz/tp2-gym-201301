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
        private const String NombreProcedimiento = "pa_GSC_Cotizacion";
        //private const String NombreTabla = "Cotizacion";
        private readonly Database _db = DatabaseFactory.CreateDatabase();

        public List<Cotizacion> ObtenerCotizaciones(String tipoFecha, DateTime fechaInicio, DateTime fechaFin, int codPro, int codTServ, int codEstado, int codSolCotizacion, int codProv, int codCotizacion)
        {
            try
            {
                var coleccion = new List<Cotizacion>();
                var sql = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(sql, "TipoConsulta", DbType.Byte, 8);

                _db.AddInParameter(sql, "TipoFecha", DbType.String, tipoFecha);
                if (tipoFecha.Equals("todos"))
                {
                    _db.AddInParameter(sql, "FechaInicio", DbType.DateTime, null);
                    _db.AddInParameter(sql, "FechaFin", DbType.DateTime, null);
                }
                else
                {
                    _db.AddInParameter(sql, "FechaInicio", DbType.DateTime, fechaInicio);
                    _db.AddInParameter(sql, "FechaFin", DbType.DateTime, fechaFin);
                }

                _db.AddInParameter(sql, "IdEstado", DbType.Int32, codEstado);
                _db.AddInParameter(sql, "IdTipoServicio", DbType.Int32, codTServ);
                _db.AddInParameter(sql, "IdProyecto", DbType.Int32, codPro);
                _db.AddInParameter(sql, "IdProveedor", DbType.Int32, codProv);
                _db.AddInParameter(sql, "IdSolicitudCotizacion", DbType.Int32, codSolCotizacion);
                _db.AddInParameter(sql, "IdCotizacion", DbType.Int32, codCotizacion);
                using (var lector = _db.ExecuteReader(sql))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Cotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("IdCotizacion")),
                            codSolCotizacion = lector.GetInt32(lector.GetOrdinal("IdSolicitudCotizacion")),
                            fechaInicio = lector.IsDBNull(lector.GetOrdinal("FechaInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaInicio")),
                            fechaFin = lector.IsDBNull(lector.GetOrdinal("FechaFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaFin")),
                            descTServ = lector.IsDBNull(lector.GetOrdinal("DescripTServicio")) ? "" : lector.GetString(lector.GetOrdinal("DescripTServicio")),

                            codFormPag = lector.IsDBNull(lector.GetOrdinal("IdFormaPago")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdFormaPago")),
                            codMoneda = lector.IsDBNull(lector.GetOrdinal("IdMoneda")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdMoneda")),

                            codTServ = lector.IsDBNull(lector.GetOrdinal("IdTipoServicio")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdTipoServicio")),
                            monto = lector.IsDBNull(lector.GetOrdinal("Monto")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Monto")),
                            razsocPro = lector.IsDBNull(lector.GetOrdinal("RazonSocialProv")) ? "" : lector.GetString(lector.GetOrdinal("RazonSocialProv")),
                            codProv = lector.IsDBNull(lector.GetOrdinal("IdProveedor")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdProveedor")),
                            descMon = lector.IsDBNull(lector.GetOrdinal("DescripMoned")) ? "" : lector.GetString(lector.GetOrdinal("DescripMoned")),
                            abrvMon = lector.IsDBNull(lector.GetOrdinal("AbreviaMoned")) ? "" : lector.GetString(lector.GetOrdinal("AbreviaMoned")),
                            estado = lector.IsDBNull(lector.GetOrdinal("estado")) ? "" : lector.GetString(lector.GetOrdinal("estado")),
                            Comentarios = lector.IsDBNull(lector.GetOrdinal("Comentarios")) ? "" : lector.GetString(lector.GetOrdinal("Comentarios")),
                            pdfCotizacion = lector.IsDBNull(lector.GetOrdinal("PdfCotizacion")) ? "" : lector.GetString(lector.GetOrdinal("PdfCotizacion")),
                        });
                    }
                }
                sql.Dispose();
                return coleccion;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<Cotizacion> ListarTodos()
        {
            try
            {
                var coleccion = new List<Cotizacion>();
                var sql = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(sql, "TipoConsulta", DbType.Byte, 2);
                using (var lector = _db.ExecuteReader(sql))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Cotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("IdCotizacion")),
                            fechaInicio = lector.IsDBNull(lector.GetOrdinal("FechaInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaInicio")),
                            fechaFin = lector.IsDBNull(lector.GetOrdinal("FechaFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaFin")),
                            monto = lector.IsDBNull(lector.GetOrdinal("Monto")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Monto")),
                            igv = lector.IsDBNull(lector.GetOrdinal("Igv")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Igv")),
                            Total = lector.IsDBNull(lector.GetOrdinal("Total")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Total")),
                            Comentarios = lector.IsDBNull(lector.GetOrdinal("Comentarios")) ? default(String) : lector.GetString(lector.GetOrdinal("Comentarios")),
                            pdfCotizacion = lector.IsDBNull(lector.GetOrdinal("PdfCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("PdfCotizacion")),
                            codMoneda = lector.IsDBNull(lector.GetOrdinal("IdMoneda")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdMoneda")),
                            codSolCotizacion = lector.IsDBNull(lector.GetOrdinal("IdSolicitudCotizacion")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdSolicitudCotizacion")),
                            codProv = lector.IsDBNull(lector.GetOrdinal("IdProveedor")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdProveedor")),
                            codTServ = lector.IsDBNull(lector.GetOrdinal("IdTipoServicio")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdTipoServicio"))

                        });
                    }
                }
                sql.Dispose();
                return coleccion;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<Cotizacion> Getcoleccion(string wheresql, string orderbysql)
        {
            const int totalRecordCount = -1;
            return Getcoleccion(wheresql, orderbysql, 0, int.MaxValue, totalRecordCount);
        }


        public virtual List<Cotizacion> Getcoleccion(string wheresql, string orderbysql, int startIndex, int length, int totalRecordCount)
        {
            try
            {
                var coleccion = new List<Cotizacion>();
                var sql = _db.GetSqlStringCommand(CreateGetCommand(wheresql, orderbysql));
                using (var lector = _db.ExecuteReader(sql))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Cotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("IdCotizacion")),
                            fechaInicio = lector.IsDBNull(lector.GetOrdinal("FechaInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaInicio")),
                            fechaFin = lector.IsDBNull(lector.GetOrdinal("FechaFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaFin")),
                            monto = lector.IsDBNull(lector.GetOrdinal("Monto")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Monto")),
                            igv = lector.IsDBNull(lector.GetOrdinal("Igv")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Igv")),
                            Total = lector.IsDBNull(lector.GetOrdinal("Total")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Total")),
                            Comentarios = lector.IsDBNull(lector.GetOrdinal("Comentarios")) ? default(String) : lector.GetString(lector.GetOrdinal("Comentarios")),
                            pdfCotizacion = lector.IsDBNull(lector.GetOrdinal("PdfCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("PdfCotizacion")),
                            codMoneda = lector.IsDBNull(lector.GetOrdinal("IdMoneda")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdMoneda")),
                            codSolCotizacion = lector.IsDBNull(lector.GetOrdinal("IdSolicitudCotizacion")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdSolicitudCotizacion")),
                            codProv = lector.IsDBNull(lector.GetOrdinal("IdProveedor")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdProveedor")),
                            codTServ = lector.IsDBNull(lector.GetOrdinal("IdTipoServicio")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdTipoServicio"))

                        });
                    }
                }
                sql.Dispose();
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
                var sql = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(sql, "TipoConsulta", DbType.Byte, 6);
                _db.AddInParameter(sql, "IdMoneda", DbType.Int32);
                int huboexito = _db.ExecuteNonQuery(sql);
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
                var sql = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(sql, "TipoConsulta", DbType.Byte, 10);
                _db.AddInParameter(sql, "IdSolicitudCotizacion", DbType.Int32);
                var coleccion = new List<Cotizacion>();
                using (var lector = _db.ExecuteReader(sql))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Cotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("IdCotizacion")),
                            fechaInicio = lector.IsDBNull(lector.GetOrdinal("FechaInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaInicio")),
                            fechaFin = lector.IsDBNull(lector.GetOrdinal("FechaFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaFin")),
                            monto = lector.IsDBNull(lector.GetOrdinal("Monto")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Monto")),
                            igv = lector.IsDBNull(lector.GetOrdinal("Igv")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Igv")),
                            Total = lector.IsDBNull(lector.GetOrdinal("Total")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Total")),
                            Comentarios = lector.IsDBNull(lector.GetOrdinal("Comentarios")) ? default(String) : lector.GetString(lector.GetOrdinal("Comentarios")),
                            pdfCotizacion = lector.IsDBNull(lector.GetOrdinal("PdfCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("PdfCotizacion")),
                            codMoneda = lector.IsDBNull(lector.GetOrdinal("IdMoneda")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdMoneda")),
                            codSolCotizacion = lector.IsDBNull(lector.GetOrdinal("IdSolicitudCotizacion")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdSolicitudCotizacion")),
                            codProv = lector.IsDBNull(lector.GetOrdinal("IdProveedor")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdProveedor")),
                            codTServ = lector.IsDBNull(lector.GetOrdinal("IdTipoServicio")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdTipoServicio"))

                        });
                    }
                }
                sql.Dispose();
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
                var sql = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(sql, "TipoConsulta", DbType.Byte, 6);
                _db.AddInParameter(sql, "IdSolicitudCotizacion", DbType.Int32);
                var huboexito = _db.ExecuteNonQuery(sql);
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
                var sql = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(sql, "TipoConsulta", DbType.Byte, 10);
                _db.AddInParameter(sql, "IdProyecto", DbType.Int32);
                var coleccion = new List<Cotizacion>();
                using (var lector = _db.ExecuteReader(sql))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Cotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("IdCotizacion")),
                            fechaInicio = lector.IsDBNull(lector.GetOrdinal("FechaInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaInicio")),
                            fechaFin = lector.IsDBNull(lector.GetOrdinal("FechaFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaFin")),
                            monto = lector.IsDBNull(lector.GetOrdinal("Monto")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Monto")),
                            igv = lector.IsDBNull(lector.GetOrdinal("Igv")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Igv")),
                            Total = lector.IsDBNull(lector.GetOrdinal("Total")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Total")),
                            Comentarios = lector.IsDBNull(lector.GetOrdinal("Comentarios")) ? default(String) : lector.GetString(lector.GetOrdinal("Comentarios")),
                            pdfCotizacion = lector.IsDBNull(lector.GetOrdinal("PdfCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("PdfCotizacion")),
                            codMoneda = lector.IsDBNull(lector.GetOrdinal("IdMoneda")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdMoneda")),
                            codSolCotizacion = lector.IsDBNull(lector.GetOrdinal("IdSolicitudCotizacion")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdSolicitudCotizacion")),
                            codProv = lector.IsDBNull(lector.GetOrdinal("IdProveedor")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdProveedor")),
                            codTServ = lector.IsDBNull(lector.GetOrdinal("IdTipoServicio")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdTipoServicio"))

                        });
                    }
                }
                sql.Dispose();
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
                var sql = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(sql, "TipoConsulta", DbType.Byte, 6);
                _db.AddInParameter(sql, "IdProyecto", DbType.Int32);
                int huboexito = _db.ExecuteNonQuery(sql);
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
                var sql = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(sql, "TipoConsulta", DbType.Byte, 10);
                _db.AddInParameter(sql, "IdTipoServicio", DbType.Int32);
                var coleccion = new List<Cotizacion>();
                using (var lector = _db.ExecuteReader(sql))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Cotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("IdCotizacion")),
                            fechaInicio = lector.IsDBNull(lector.GetOrdinal("FechaInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaInicio")),
                            fechaFin = lector.IsDBNull(lector.GetOrdinal("FechaFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaFin")),
                            monto = lector.IsDBNull(lector.GetOrdinal("Monto")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Monto")),
                            igv = lector.IsDBNull(lector.GetOrdinal("Igv")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Igv")),
                            Total = lector.IsDBNull(lector.GetOrdinal("Total")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Total")),
                            Comentarios = lector.IsDBNull(lector.GetOrdinal("Comentarios")) ? default(String) : lector.GetString(lector.GetOrdinal("Comentarios")),
                            pdfCotizacion = lector.IsDBNull(lector.GetOrdinal("PdfCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("PdfCotizacion")),
                            codMoneda = lector.IsDBNull(lector.GetOrdinal("IdMoneda")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdMoneda")),
                            codSolCotizacion = lector.IsDBNull(lector.GetOrdinal("IdSolicitudCotizacion")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdSolicitudCotizacion")),
                            codProv = lector.IsDBNull(lector.GetOrdinal("IdProveedor")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdProveedor")),
                            codTServ = lector.IsDBNull(lector.GetOrdinal("IdTipoServicio")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdTipoServicio"))

                        });
                    }
                }
                sql.Dispose();
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
                var sql = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(sql, "TipoConsulta", DbType.Byte, 6);
                _db.AddInParameter(sql, "IdTipoServicio", DbType.Int32);
                int huboexito = _db.ExecuteNonQuery(sql);
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
                var sql = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(sql, "TipoConsulta", DbType.Byte, 3);
                _db.AddInParameter(sql, "IdCotizacion", DbType.Int32, codCotizacion);
                var cotizacion = default(Cotizacion);
                using (var lector = _db.ExecuteReader(sql))
                {
                    while (lector.Read())
                    {
                        cotizacion = new Cotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("IdCotizacion")),
                            fechaInicio = lector.IsDBNull(lector.GetOrdinal("FechaInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaInicio")),
                            fechaFin = lector.IsDBNull(lector.GetOrdinal("FechaFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaFin")),
                            monto = lector.IsDBNull(lector.GetOrdinal("Monto")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Monto")),
                            igv = lector.IsDBNull(lector.GetOrdinal("Igv")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Igv")),
                            Total = lector.IsDBNull(lector.GetOrdinal("Total")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Total")),
                            Comentarios = lector.IsDBNull(lector.GetOrdinal("Comentarios")) ? default(String) : lector.GetString(lector.GetOrdinal("Comentarios")),
                            pdfCotizacion = lector.IsDBNull(lector.GetOrdinal("PdfCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("PdfCotizacion")),
                            codMoneda = lector.IsDBNull(lector.GetOrdinal("IdMoneda")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdMoneda")),
                            codSolCotizacion = lector.IsDBNull(lector.GetOrdinal("IdSolicitudCotizacion")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdSolicitudCotizacion")),
                            codProv = lector.IsDBNull(lector.GetOrdinal("IdProveedor")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdProveedor")),
                            codTServ = lector.IsDBNull(lector.GetOrdinal("IdTipoServicio")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdTipoServicio")),
                            codFormPag = lector.IsDBNull(lector.GetOrdinal("IdFormaPago")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdFormaPago")),
                            codEstado = lector.IsDBNull(lector.GetOrdinal("IdEstado")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdEstado")),
                        };
                    }
                }
                sql.Dispose();
                return cotizacion;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        protected virtual string CreateGetCommand(string whereSql, string orderBySql)
        {
            var sql = "SELECT * FROM [dbo].[GSC_Cotizacion]";
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
            var cnn = _db.CreateConnection();
            cnn.Open();
            var tran = cnn.BeginTransaction();
            try
            {
                if (cotizacion.codCotizacion == 0) cotizacion.codCotizacion = Insert(cotizacion, tran);
                else Update(cotizacion, tran);

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

        public virtual int Insert(Cotizacion cotizacion, DbTransaction tran = null)
        {
            try
            {
                var sql = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddOutParameter(sql, "IdCotizacion", DbType.Int32, 0);
                _db.AddInParameter(sql, "FechaInicio", DbType.DateTime, cotizacion.fechaInicio);
                _db.AddInParameter(sql, "FechaFin", DbType.DateTime, cotizacion.fechaFin);
                _db.AddInParameter(sql, "Monto", DbType.Decimal, cotizacion.monto);
                _db.AddInParameter(sql, "Igv", DbType.Decimal, cotizacion.igv);
                _db.AddInParameter(sql, "Total", DbType.Decimal, cotizacion.Total);
                _db.AddInParameter(sql, "Comentarios", DbType.String, cotizacion.Comentarios);
                _db.AddInParameter(sql, "PdfCotizacion", DbType.String, cotizacion.pdfCotizacion);
                _db.AddInParameter(sql, "IdMoneda", DbType.Int32, cotizacion.codMoneda);
                _db.AddInParameter(sql, "IdSolicitudCotizacion", DbType.Int32, cotizacion.codSolCotizacion);
                _db.AddInParameter(sql, "IdProveedor", DbType.Int32, cotizacion.codProv);
                _db.AddInParameter(sql, "IdFormaPago", DbType.Int32, cotizacion.codFormPag);
                _db.AddInParameter(sql, "IdTipoServicio", DbType.Int32, cotizacion.codTServ);
                _db.AddInParameter(sql, "TipoConsulta", DbType.Byte, 4);

                var huboexito = tran != null ? _db.ExecuteNonQuery(sql, tran) : _db.ExecuteNonQuery(sql);

                if (huboexito == 0)
                {
                    throw new Exception("Error al agregar al");
                }
                var numerogenerado = (int)_db.GetParameterValue(sql, "IdCotizacion");
                sql.Dispose();
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
                var sql = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(sql, "IdCotizacion", DbType.Int32, codCotizacion);
                _db.AddInParameter(sql, "IdEstado", DbType.Int32, codEstado);
                _db.AddInParameter(sql, "TipoConsulta", DbType.Byte, 5);
                var huboexito = tran != null ? _db.ExecuteNonQuery(sql, tran) : _db.ExecuteNonQuery(sql);

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

        public virtual void Update(Cotizacion cotizacion, DbTransaction tran = null)
        {
            try
            {
                var sql = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(sql, "IdCotizacion", DbType.Int32, cotizacion.codCotizacion);
                _db.AddInParameter(sql, "FechaInicio", DbType.DateTime, cotizacion.fechaInicio);
                _db.AddInParameter(sql, "FechaFin", DbType.DateTime, cotizacion.fechaFin);
                _db.AddInParameter(sql, "Monto", DbType.Decimal, cotizacion.monto);
                _db.AddInParameter(sql, "Igv", DbType.Decimal, cotizacion.igv);
                _db.AddInParameter(sql, "Total", DbType.Decimal, cotizacion.Total);
                _db.AddInParameter(sql, "Comentarios", DbType.String, cotizacion.Comentarios);
                _db.AddInParameter(sql, "PdfCotizacion", DbType.String, cotizacion.pdfCotizacion);
                _db.AddInParameter(sql, "IdMoneda", DbType.Int32, cotizacion.codMoneda);
                _db.AddInParameter(sql, "IdSolicitudCotizacion", DbType.Int32, cotizacion.codSolCotizacion);
                _db.AddInParameter(sql, "IdProveedor", DbType.Int32, cotizacion.codProv);
                _db.AddInParameter(sql, "IdTipoServicio", DbType.Int32, cotizacion.codTServ);
                _db.AddInParameter(sql, "IdFormaPago", DbType.Int32, cotizacion.codFormPag);

                _db.AddInParameter(sql, "eliminarDetalle", DbType.Boolean, cotizacion.eliminarDetalle);
                _db.AddInParameter(sql, "TipoConsulta", DbType.Byte, 1);
                var huboexito = tran != null ? _db.ExecuteNonQuery(sql, tran) : _db.ExecuteNonQuery(sql);

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
                var sql = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(sql, "IdCotizacion", DbType.Int32, codCotizacion);
                _db.AddInParameter(sql, "TipoConsulta", DbType.Byte, 5);
                int huboexito = _db.ExecuteNonQuery(sql);
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
                var sql = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(sql, "TipoConsulta", DbType.String, 6);
                int huboexito = _db.ExecuteNonQuery(sql);
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
