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
        private const String nombreprocedimiento = "pa_GSC_Estado";
        private const String NombreTabla = "Estado";
        private Database db = DatabaseFactory.CreateDatabase();


        public List<Estado> listartodos(String flag)
        {
            try
            {
                var coleccion = new List<Estado>();
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 2);
                db.AddInParameter(SQL, "flag", DbType.String, flag);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Estado
                        {
                            codEstado = lector.GetInt32(lector.GetOrdinal("codEstado")),
                            desEstado = lector.IsDBNull(lector.GetOrdinal("desEstado")) ? default(String) : lector.GetString(lector.GetOrdinal("desEstado")),
                            flagSolCotizacion = lector.IsDBNull(lector.GetOrdinal("flagSolCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("flagSolCotizacion")),
                            flagCotizacion = lector.IsDBNull(lector.GetOrdinal("flagCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("flagCotizacion"))

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



        public List<Estado> Getcoleccion(string wheresql, string orderbysql)
        {
            int totalRecordCount = -1;
            return Getcoleccion(wheresql, orderbysql, 0, int.MaxValue, totalRecordCount);
        }


        public virtual List<Estado> Getcoleccion(string wheresql, string orderbysql, int startIndex, int length, int totalRecordCount)
        {
            try
            {
                var coleccion = new List<Estado>();
                DbCommand SQL = db.GetSqlStringCommand(CreateGetCommand(wheresql, orderbysql));
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Estado
                        {
                            codEstado = lector.GetInt32(lector.GetOrdinal("codEstado")),
                            desEstado = lector.IsDBNull(lector.GetOrdinal("desEstado")) ? default(String) : lector.GetString(lector.GetOrdinal("desEstado")),
                            flagSolCotizacion = lector.IsDBNull(lector.GetOrdinal("flagSolCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("flagSolCotizacion")),
                            flagCotizacion = lector.IsDBNull(lector.GetOrdinal("flagCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("flagCotizacion"))

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


        public virtual Estado GetByPrimaryKey(Int32 codEstado)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 3);
                db.AddInParameter(SQL, "codEstado", DbType.Int32, codEstado);
                var Estado = default(Estado);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        Estado = new Estado
                        {
                            codEstado = lector.GetInt32(lector.GetOrdinal("codEstado")),
                            desEstado = lector.IsDBNull(lector.GetOrdinal("desEstado")) ? default(String) : lector.GetString(lector.GetOrdinal("desEstado")),
                            flagSolCotizacion = lector.IsDBNull(lector.GetOrdinal("flagSolCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("flagSolCotizacion")),
                            flagCotizacion = lector.IsDBNull(lector.GetOrdinal("flagCotizacion")) ? default(String) : lector.GetString(lector.GetOrdinal("flagCotizacion"))

                        };
                    }
                }
                SQL.Dispose();
                return Estado;
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

        public virtual int Insert(Estado Estado)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codEstado", DbType.Int32, Estado.codEstado);
                db.AddInParameter(SQL, "desEstado", DbType.String, Estado.desEstado);
                db.AddInParameter(SQL, "flagSolCotizacion", DbType.String, Estado.flagSolCotizacion);
                db.AddInParameter(SQL, "flagCotizacion", DbType.String, Estado.flagCotizacion);
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


        public virtual void Update(Estado Estado)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codEstado", DbType.Int32, Estado.codEstado);
                db.AddInParameter(SQL, "desEstado", DbType.String, Estado.desEstado);
                db.AddInParameter(SQL, "flagSolCotizacion", DbType.String, Estado.flagSolCotizacion);
                db.AddInParameter(SQL, "flagCotizacion", DbType.String, Estado.flagCotizacion);
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


        public virtual bool DeleteByPrimaryKey(Int32 codEstado)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codEstado", DbType.Int32, codEstado);
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
