using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GYM.SIG.DataAccess
{
    public class Estadodalc : Singleton<Estadodalc>
    {
        private const String NombreProcedimiento = "pa_GSC_Estado";
/*
        private const String NombreTabla = "Estado";
*/
        private readonly Database _db = DatabaseFactory.CreateDatabase();


        public List<Estado> ListarTodos(String flag)
        {
            try
            {
                var coleccion = new List<Estado>();
                DbCommand sql = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(sql, "TipoConsulta", DbType.Byte, 2);
                _db.AddInParameter(sql, "flag", DbType.String, flag);
                using (var lector = _db.ExecuteReader(sql))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Estado
                        {
                            codEstado = lector.GetInt32(lector.GetOrdinal("IdEstado")),
                            desEstado = lector.IsDBNull(lector.GetOrdinal("DescripEstado")) ? default(String) : lector.GetString(lector.GetOrdinal("DescripEstado")),
                            flagSolCotizacion = lector.IsDBNull(lector.GetOrdinal("FlagSolCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("FlagSolCotizacion")),
                            flagCotizacion = lector.IsDBNull(lector.GetOrdinal("FlagCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("FlagCotizacion"))

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



        public List<Estado> Getcoleccion(string wheresql, string orderbysql)
        {
            const int totalRecordCount = -1;
            return Getcoleccion(wheresql, orderbysql, 0, int.MaxValue, totalRecordCount);
        }


        public virtual List<Estado> Getcoleccion(string wheresql, string orderbysql, int startIndex, int length, int totalRecordCount)
        {
            try
            {
                var coleccion = new List<Estado>();
                DbCommand sql = _db.GetSqlStringCommand(CreateGetCommand(wheresql, orderbysql));
                using (var lector = _db.ExecuteReader(sql))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Estado
                        {
                            codEstado = lector.GetInt32(lector.GetOrdinal("IdEstado")),
                            desEstado = lector.IsDBNull(lector.GetOrdinal("DescripEstado")) ? default(String) : lector.GetString(lector.GetOrdinal("DescripEstado")),
                            flagSolCotizacion = lector.IsDBNull(lector.GetOrdinal("FlagSolCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("FlagSolCotizacion")),
                            flagCotizacion = lector.IsDBNull(lector.GetOrdinal("FlagCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("FlagCotizacion"))

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


        public virtual Estado GetByPrimaryKey(Int32 codEstado)
        {
            try
            {
                var sql = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(sql, "TipoConsulta", DbType.Byte, 3);
                _db.AddInParameter(sql, "IdEstado", DbType.Int32, codEstado);
                var estado = default(Estado);
                using (var lector = _db.ExecuteReader(sql))
                {
                    while (lector.Read())
                    {
                        estado = new Estado
                        {
                            codEstado = lector.GetInt32(lector.GetOrdinal("IdEstado")),
                            desEstado = lector.IsDBNull(lector.GetOrdinal("DescripEstado")) ? default(String) : lector.GetString(lector.GetOrdinal("DescripEstado")),
                            flagSolCotizacion = lector.IsDBNull(lector.GetOrdinal("FlagSolCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("FlagSolCotizacion")),
                            flagCotizacion = lector.IsDBNull(lector.GetOrdinal("FlagCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("FlagCotizacion"))

                        };
                    }
                }
                sql.Dispose();
                return estado;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }



        protected virtual string CreateGetCommand(string whereSql, string orderBySql)
        {
            string sql = "SELECT * FROM [dbo].[Estado]";
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

        public virtual int Insert(Estado estado)
        {
            try
            {
                DbCommand sql = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(sql, "IdEstado", DbType.Int32, estado.codEstado);
                _db.AddInParameter(sql, "DescripEstado", DbType.String, estado.desEstado);
                _db.AddInParameter(sql, "FlagSolCotizacion", DbType.String, estado.flagSolCotizacion);
                _db.AddInParameter(sql, "FlagCotizacion", DbType.String, estado.flagCotizacion);
                _db.AddInParameter(sql, "TipoConsulta", DbType.String, 4);
                int huboexito = _db.ExecuteNonQuery(sql);
                if (huboexito == 0)
                {
                    throw new Exception("Error al agregar al");
                }
                var numerogenerado = (int)_db.GetParameterValue(sql, "");
                sql.Dispose();
                return numerogenerado;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        public virtual void Update(Estado estado)
        {
            try
            {
                var sql = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(sql, "IdEstado", DbType.Int32, estado.codEstado);
                _db.AddInParameter(sql, "DescripEstado", DbType.String, estado.desEstado);
                _db.AddInParameter(sql, "FlagSolCotizacion", DbType.String, estado.flagSolCotizacion);
                _db.AddInParameter(sql, "FlagCotizacion", DbType.String, estado.flagCotizacion);
                _db.AddInParameter(sql, "TipoConsulta", DbType.String, 1);
                int huboexito = _db.ExecuteNonQuery(sql);
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


        public virtual bool DeleteByPrimaryKey(Int32 codEstado)
        {
            try
            {
                var sql = _db.GetStoredProcCommand(NombreProcedimiento);
                _db.AddInParameter(sql, "IdEstado", DbType.Int32, codEstado);
                _db.AddInParameter(sql, "TipoConsulta", DbType.String, 5);
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
