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
        private const String NombreProcedimiento = "pa_GSC_DetalleCotizacion";
        //private const String NombreTabla = "DetalleCotizacion";
        private readonly Database _db = DatabaseFactory.CreateDatabase();


        public List<DetalleCotizacion> ListarTodos()
        {
            try
            {
                var coleccion = new List<DetalleCotizacion>();
                DbCommand SQL = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 2);
                using (var lector = _db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleCotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("IdCotizacion")),
                            codCotDet = lector.GetInt32(lector.GetOrdinal("IdCotDet")),
                            descripcion = lector.IsDBNull(lector.GetOrdinal("Descripcion")) ? default(String) : lector.GetString(lector.GetOrdinal("Descripcion")),
                            cantidad = lector.IsDBNull(lector.GetOrdinal("Cantidad")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Cantidad")),
                            precio = lector.IsDBNull(lector.GetOrdinal("Precio")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Precio")),
                            importe = lector.IsDBNull(lector.GetOrdinal("Importe")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Importe")),
                            codUM = lector.IsDBNull(lector.GetOrdinal("IdUnidadMedida")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdUnidadMedida"))
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
                DbCommand SQL = _db.GetSqlStringCommand(CreateGetCommand(wheresql, orderbysql));
                using (var lector = _db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleCotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("IdCotizacion")),
                            codCotDet = lector.GetInt32(lector.GetOrdinal("IdCotDet")),
                            descripcion = lector.IsDBNull(lector.GetOrdinal("Descripcion")) ? default(String) : lector.GetString(lector.GetOrdinal("Descripcion")),
                            cantidad = lector.IsDBNull(lector.GetOrdinal("Cantidad")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Cantidad")),
                            precio = lector.IsDBNull(lector.GetOrdinal("Precio")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Precio")),
                            importe = lector.IsDBNull(lector.GetOrdinal("Importe")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Importe")),
                            codUM = lector.IsDBNull(lector.GetOrdinal("IdUnidadMedida")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdUnidadMedida"))

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
                DbCommand SQL = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 10);
                _db.AddInParameter(SQL, "IdCotizacion", DbType.Int32);
                var coleccion = new List<DetalleCotizacion>();
                using (var lector = _db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleCotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("IdCotizacion")),
                            codCotDet = lector.GetInt32(lector.GetOrdinal("IdCotDet")),
                            descripcion = lector.IsDBNull(lector.GetOrdinal("Descripcion")) ? default(String) : lector.GetString(lector.GetOrdinal("Descripcion")),
                            cantidad = lector.IsDBNull(lector.GetOrdinal("Cantidad")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Cantidad")),
                            precio = lector.IsDBNull(lector.GetOrdinal("Precio")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Precio")),
                            importe = lector.IsDBNull(lector.GetOrdinal("Importe")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Importe")),
                            codUM = lector.IsDBNull(lector.GetOrdinal("IdUnidadMedida")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdUnidadMedida"))

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
                DbCommand SQL = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 6);
                _db.AddInParameter(SQL, "IdCotizacion", DbType.Int32);
                int huboexito = _db.ExecuteNonQuery(SQL);
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
                DbCommand SQL = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 10);
                _db.AddInParameter(SQL, "IdUnidadMedida", DbType.Int32);
                var coleccion = new List<DetalleCotizacion>();
                using (var lector = _db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new DetalleCotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("IdCotizacion")),
                            codCotDet = lector.GetInt32(lector.GetOrdinal("IdCotDet")),
                            descripcion = lector.IsDBNull(lector.GetOrdinal("Descripcion")) ? default(String) : lector.GetString(lector.GetOrdinal("Descripcion")),
                            cantidad = lector.IsDBNull(lector.GetOrdinal("Cantidad")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Cantidad")),
                            precio = lector.IsDBNull(lector.GetOrdinal("Precio")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Precio")),
                            importe = lector.IsDBNull(lector.GetOrdinal("Importe")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Importe")),
                            codUM = lector.IsDBNull(lector.GetOrdinal("IdUnidadMedida")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdUnidadMedida"))

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
                DbCommand SQL = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 6);
                _db.AddInParameter(SQL, "IdUnidadMedida", DbType.Int32);
                int huboexito = _db.ExecuteNonQuery(SQL);
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
                DbCommand SQL = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 7);
                _db.AddInParameter(SQL, "IdSolicitudCotizacion", DbType.Int32, codSolCotizacion);
                _db.AddInParameter(SQL, "IdSolicitudDetalle", DbType.Int32, codSolDet);
                var DetalleCotizacion = default(DetalleCotizacion);
                using (var lector = _db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        DetalleCotizacion = new DetalleCotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("IdCotizacion")),
                            codCotDet = lector.GetInt32(lector.GetOrdinal("IdCotDet")),
                            descripcion = lector.IsDBNull(lector.GetOrdinal("Descripcion")) ? default(String) : lector.GetString(lector.GetOrdinal("Descripcion")),
                            cantidad = lector.IsDBNull(lector.GetOrdinal("Cantidad")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Cantidad")),
                            precio = lector.IsDBNull(lector.GetOrdinal("Precio")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Precio")),
                            importe = lector.IsDBNull(lector.GetOrdinal("Importe")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Importe")),
                            codUM = lector.IsDBNull(lector.GetOrdinal("IdUnidadMedida")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdUnidadMedida")),
                            desEstado = lector.IsDBNull(lector.GetOrdinal("DescripEstado")) ? "" : lector.GetString(lector.GetOrdinal("DescripEstado")),
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
                DbCommand SQL = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 3);
                _db.AddInParameter(SQL, "IdCotizacion", DbType.Int32, codCotizacion);
                _db.AddInParameter(SQL, "IdCotDet", DbType.Int32, codCotDet);
                var DetalleCotizacion = default(DetalleCotizacion);
                using (var lector = _db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        DetalleCotizacion = new DetalleCotizacion
                        {
                            codCotizacion = lector.GetInt32(lector.GetOrdinal("IdCotizacion")),
                            codCotDet = lector.GetInt32(lector.GetOrdinal("IdCotDet")),
                            descripcion = lector.IsDBNull(lector.GetOrdinal("Descripcion")) ? default(String) : lector.GetString(lector.GetOrdinal("Descripcion")),
                            cantidad = lector.IsDBNull(lector.GetOrdinal("Cantidad")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Cantidad")),
                            precio = lector.IsDBNull(lector.GetOrdinal("Precio")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Precio")),
                            importe = lector.IsDBNull(lector.GetOrdinal("Importe")) ? default(Decimal) : lector.GetDecimal(lector.GetOrdinal("Importe")),
                            codUM = lector.IsDBNull(lector.GetOrdinal("IdUnidadMedida")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("IdUnidadMedida"))

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
            string sql = "SELECT * FROM [dbo].[GSC_DetalleCotizacion]";
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
                DbCommand SQL = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddOutParameter(SQL, "IdCotDet", DbType.Int32, 0);
                _db.AddInParameter(SQL, "IdCotizacion", DbType.Int32, DetalleCotizacion.codCotizacion);
                _db.AddInParameter(SQL, "Descripcion", DbType.String, DetalleCotizacion.descripcion);
                _db.AddInParameter(SQL, "Cantidad", DbType.Decimal, DetalleCotizacion.cantidad);
                _db.AddInParameter(SQL, "Precio", DbType.Decimal, DetalleCotizacion.precio);
                _db.AddInParameter(SQL, "Importe", DbType.Decimal, DetalleCotizacion.importe);
                _db.AddInParameter(SQL, "IdUnidadMedida", DbType.Int32, DetalleCotizacion.codUM);
                _db.AddInParameter(SQL, "IdSolicitudCotizacion", DbType.Int32, DetalleCotizacion.codSolCotizacion);
                _db.AddInParameter(SQL, "IdSolicitudDetalle", DbType.Int32, DetalleCotizacion.codSolDet);
                _db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 4);
                int huboexito;
                if (tran != null) huboexito = _db.ExecuteNonQuery(SQL, tran);
                else huboexito = _db.ExecuteNonQuery(SQL);

                if (huboexito == 0)
                {
                    throw new Exception("Error al agregar al");
                }
                var numerogenerado = (int)_db.GetParameterValue(SQL, "IdCotDet");
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
                DbCommand SQL = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(SQL, "IdCotizacion", DbType.Int32, DetalleCotizacion.codCotizacion);
                _db.AddInParameter(SQL, "IdCotDet", DbType.Int32, DetalleCotizacion.codCotDet);
                _db.AddInParameter(SQL, "Descripcion", DbType.String, DetalleCotizacion.descripcion);
                _db.AddInParameter(SQL, "Cantidad", DbType.Decimal, DetalleCotizacion.cantidad);
                _db.AddInParameter(SQL, "Precio", DbType.Decimal, DetalleCotizacion.precio);
                _db.AddInParameter(SQL, "Importe", DbType.Decimal, DetalleCotizacion.importe);
                _db.AddInParameter(SQL, "IdUnidadMedida", DbType.Int32, DetalleCotizacion.codUM);
                _db.AddInParameter(SQL, "IdSolicitudCotizacion", DbType.Int32, DetalleCotizacion.codSolCotizacion);
                _db.AddInParameter(SQL, "IdSolicitudDetalle", DbType.Int32, DetalleCotizacion.codSolDet);
                _db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 1);
                int huboexito;
                if (tran != null) huboexito = _db.ExecuteNonQuery(SQL, tran);
                else huboexito = _db.ExecuteNonQuery(SQL);
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
                DbCommand SQL = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(SQL, "IdCotizacion", DbType.Int32, codCotizacion);
                _db.AddInParameter(SQL, "IdCotDet", DbType.Int32, codCotDet);
                _db.AddInParameter(SQL, "TipoConsulta", DbType.String, 5);
                int huboexito = _db.ExecuteNonQuery(SQL);
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
                DbCommand SQL = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(SQL, "TipoConsulta", DbType.String, 6);
                int huboexito = _db.ExecuteNonQuery(SQL);
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
