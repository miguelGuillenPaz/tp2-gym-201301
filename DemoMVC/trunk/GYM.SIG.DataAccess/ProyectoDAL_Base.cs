using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GYM.SIG.DataAccess
{
    public class Proyectodalc : Singleton<Proyectodalc>
    {
        private const String nombreprocedimiento = "pa_GPP_Proyecto";
        private const String NombreTabla = "Proyecto";
        private Database db = DatabaseFactory.CreateDatabase();

        public List<Proyecto> listartodos()
        {
            try
            {
                var coleccion = new List<Proyecto>();
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 2);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Proyecto
                        {
                            codPro = lector.GetInt32(lector.GetOrdinal("codPro")),
                            nomPro = lector.IsDBNull(lector.GetOrdinal("nomPro")) ? default(String) : lector.GetString(lector.GetOrdinal("nomPro")),
                            desPro = lector.IsDBNull(lector.GetOrdinal("desPro")) ? default(String) : lector.GetString(lector.GetOrdinal("desPro")),
                            feciniplPro = lector.IsDBNull(lector.GetOrdinal("feciniplPro")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("feciniplPro")),
                            fefinplanPro = lector.IsDBNull(lector.GetOrdinal("fefinplanPro")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fefinplanPro"))

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

        public List<Proyecto> Getcoleccion(string wheresql, string orderbysql)
        {
            int totalRecordCount = -1;
            return Getcoleccion(wheresql, orderbysql, 0, int.MaxValue, totalRecordCount);
        }


        public virtual List<Proyecto> Getcoleccion(string wheresql, string orderbysql, int startIndex, int length, int totalRecordCount)
        {
            try
            {
                var coleccion = new List<Proyecto>();
                DbCommand SQL = db.GetSqlStringCommand(CreateGetCommand(wheresql, orderbysql));
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Proyecto
                        {
                            codPro = lector.GetInt32(lector.GetOrdinal("codPro")),
                            nomPro = lector.IsDBNull(lector.GetOrdinal("nomPro")) ? default(String) : lector.GetString(lector.GetOrdinal("nomPro")),
                            desPro = lector.IsDBNull(lector.GetOrdinal("desPro")) ? default(String) : lector.GetString(lector.GetOrdinal("desPro")),
                            feciniplPro = lector.IsDBNull(lector.GetOrdinal("feciniplPro")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("feciniplPro")),
                            fefinplanPro = lector.IsDBNull(lector.GetOrdinal("fefinplanPro")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fefinplanPro"))

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


        public virtual Proyecto GetByPrimaryKey(Int32 codPro)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 3);
                db.AddInParameter(SQL, "codPro", DbType.Int32, codPro);
                var Proyecto = default(Proyecto);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        Proyecto = new Proyecto
                        {
                            codPro = lector.GetInt32(lector.GetOrdinal("codPro")),
                            nomPro = lector.IsDBNull(lector.GetOrdinal("nomPro")) ? default(String) : lector.GetString(lector.GetOrdinal("nomPro")),
                            desPro = lector.IsDBNull(lector.GetOrdinal("desPro")) ? default(String) : lector.GetString(lector.GetOrdinal("desPro")),
                            feciniplPro = lector.IsDBNull(lector.GetOrdinal("feciniplPro")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("feciniplPro")),
                            fefinplanPro = lector.IsDBNull(lector.GetOrdinal("fefinplanPro")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("fefinplanPro"))

                        };
                    }
                }
                SQL.Dispose();
                return Proyecto;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }



        protected virtual string CreateGetCommand(string whereSql, string orderBySql)
        {
            string sql = "SELECT * FROM [dbo].[Proyecto]";
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

        public virtual int Insert(Proyecto Proyecto)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codPro", DbType.Int32, Proyecto.codPro);
                db.AddInParameter(SQL, "nomPro", DbType.String, Proyecto.nomPro);
                db.AddInParameter(SQL, "desPro", DbType.String, Proyecto.desPro);
                db.AddInParameter(SQL, "feciniplPro", DbType.DateTime, Proyecto.feciniplPro);
                db.AddInParameter(SQL, "fefinplanPro", DbType.DateTime, Proyecto.fefinplanPro);
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


        public virtual void Update(Proyecto Proyecto)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codPro", DbType.Int32, Proyecto.codPro);
                db.AddInParameter(SQL, "nomPro", DbType.String, Proyecto.nomPro);
                db.AddInParameter(SQL, "desPro", DbType.String, Proyecto.desPro);
                db.AddInParameter(SQL, "feciniplPro", DbType.DateTime, Proyecto.feciniplPro);
                db.AddInParameter(SQL, "fefinplanPro", DbType.DateTime, Proyecto.fefinplanPro);
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


        public virtual bool DeleteByPrimaryKey(Int32 codPro)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codPro", DbType.Int32, codPro);
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
