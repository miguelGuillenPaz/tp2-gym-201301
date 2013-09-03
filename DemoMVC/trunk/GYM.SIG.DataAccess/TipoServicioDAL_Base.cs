using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GYM.SIG.DataAccess
{
    public class TipoServiciodalc : Singleton<TipoServiciodalc>
    {
        private const String nombreprocedimiento = "pa_GSC_TipoServicio";
        private const String NombreTabla = "TipoServicio";
        private Database db = DatabaseFactory.CreateDatabase();


        public List<TipoServicio> listartodos()
        {
            try
            {
                var coleccion = new List<TipoServicio>();
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 2);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new TipoServicio
                        {
                            codTServ = lector.GetInt32(lector.GetOrdinal("codTServ")),
                            descTServ = lector.IsDBNull(lector.GetOrdinal("descTServ")) ? default(String) : lector.GetString(lector.GetOrdinal("descTServ")),
                            fecActualizacion = lector.IsDBNull(lector.GetOrdinal("fecActualizacion")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecActualizacion"))

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



        public List<TipoServicio> Getcoleccion(string wheresql, string orderbysql)
        {
            int totalRecordCount = -1;
            return Getcoleccion(wheresql, orderbysql, 0, int.MaxValue, totalRecordCount);
        }


        public virtual List<TipoServicio> Getcoleccion(string wheresql, string orderbysql, int startIndex, int length, int totalRecordCount)
        {
            try
            {
                var coleccion = new List<TipoServicio>();
                DbCommand SQL = db.GetSqlStringCommand(CreateGetCommand(wheresql, orderbysql));
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new TipoServicio
                        {
                            codTServ = lector.GetInt32(lector.GetOrdinal("codTServ")),
                            descTServ = lector.IsDBNull(lector.GetOrdinal("descTServ")) ? default(String) : lector.GetString(lector.GetOrdinal("descTServ")),
                            fecActualizacion = lector.IsDBNull(lector.GetOrdinal("fecActualizacion")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecActualizacion"))

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


        public virtual TipoServicio GetByPrimaryKey(Int32 codTServ)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 3);
                db.AddInParameter(SQL, "codTServ", DbType.Int32, codTServ);
                var TipoServicio = default(TipoServicio);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        TipoServicio = new TipoServicio
                        {
                            codTServ = lector.GetInt32(lector.GetOrdinal("codTServ")),
                            descTServ = lector.IsDBNull(lector.GetOrdinal("descTServ")) ? default(String) : lector.GetString(lector.GetOrdinal("descTServ")),
                            fecActualizacion = lector.IsDBNull(lector.GetOrdinal("fecActualizacion")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fecActualizacion"))

                        };
                    }
                }
                SQL.Dispose();
                return TipoServicio;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }



        protected virtual string CreateGetCommand(string whereSql, string orderBySql)
        {
            string sql = "SELECT * FROM [dbo].[TipoServicio]";
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

        public virtual int Insert(TipoServicio TipoServicio)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codTServ", DbType.Int32, TipoServicio.codTServ);
                db.AddInParameter(SQL, "descTServ", DbType.String, TipoServicio.descTServ);
                db.AddInParameter(SQL, "fecActualizacion", DbType.DateTime, TipoServicio.fecActualizacion);
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


        public virtual void Update(TipoServicio TipoServicio)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codTServ", DbType.Int32, TipoServicio.codTServ);
                db.AddInParameter(SQL, "descTServ", DbType.String, TipoServicio.descTServ);
                db.AddInParameter(SQL, "fecActualizacion", DbType.DateTime, TipoServicio.fecActualizacion);
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


        public virtual bool DeleteByPrimaryKey(Int32 codTServ)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codTServ", DbType.Int32, codTServ);
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
