using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GYM.SIG.DataAccess
{
    public class Monedadalc : Singleton<Monedadalc>
    {
        private const String nombreprocedimiento = "pa_GSC_Moneda";
        private const String NombreTabla = "Moneda";
        private Database db = DatabaseFactory.CreateDatabase();


        public List<Moneda> listartodos()
        {
            try
            {
                var coleccion = new List<Moneda>();
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 2);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Moneda
                        {
                            codMoneda = lector.GetInt32(lector.GetOrdinal("codMoneda")),
                            descMon = lector.IsDBNull(lector.GetOrdinal("descMon")) ? default(String) : lector.GetString(lector.GetOrdinal("descMon")),
                            abrvMon = lector.IsDBNull(lector.GetOrdinal("abrvMon")) ? default(String) : lector.GetString(lector.GetOrdinal("abrvMon"))

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



        public List<Moneda> Getcoleccion(string wheresql, string orderbysql)
        {
            int totalRecordCount = -1;
            return Getcoleccion(wheresql, orderbysql, 0, int.MaxValue, totalRecordCount);
        }


        public virtual List<Moneda> Getcoleccion(string wheresql, string orderbysql, int startIndex, int length, int totalRecordCount)
        {
            try
            {
                var coleccion = new List<Moneda>();
                DbCommand SQL = db.GetSqlStringCommand(CreateGetCommand(wheresql, orderbysql));
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Moneda
                        {
                            codMoneda = lector.GetInt32(lector.GetOrdinal("codMoneda")),
                            descMon = lector.IsDBNull(lector.GetOrdinal("descMon")) ? default(String) : lector.GetString(lector.GetOrdinal("descMon")),
                            abrvMon = lector.IsDBNull(lector.GetOrdinal("abrvMon")) ? default(String) : lector.GetString(lector.GetOrdinal("abrvMon"))

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


        public virtual Moneda GetByPrimaryKey(Int32 codMoneda)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 3);
                db.AddInParameter(SQL, "codMoneda", DbType.Int32, codMoneda);
                var Moneda = default(Moneda);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        Moneda = new Moneda
                        {
                            codMoneda = lector.GetInt32(lector.GetOrdinal("codMoneda")),
                            descMon = lector.IsDBNull(lector.GetOrdinal("descMon")) ? default(String) : lector.GetString(lector.GetOrdinal("descMon")),
                            abrvMon = lector.IsDBNull(lector.GetOrdinal("abrvMon")) ? default(String) : lector.GetString(lector.GetOrdinal("abrvMon"))

                        };
                    }
                }
                SQL.Dispose();
                return Moneda;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }



        protected virtual string CreateGetCommand(string whereSql, string orderBySql)
        {
            string sql = "SELECT * FROM [dbo].[Moneda]";
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

        public virtual int Insert(Moneda Moneda)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codMoneda", DbType.Int32, Moneda.codMoneda);
                db.AddInParameter(SQL, "descMon", DbType.String, Moneda.descMon);
                db.AddInParameter(SQL, "abrvMon", DbType.String, Moneda.abrvMon);
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


        public virtual void Update(Moneda Moneda)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codMoneda", DbType.Int32, Moneda.codMoneda);
                db.AddInParameter(SQL, "descMon", DbType.String, Moneda.descMon);
                db.AddInParameter(SQL, "abrvMon", DbType.String, Moneda.abrvMon);
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


        public virtual bool DeleteByPrimaryKey(Int32 codMoneda)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codMoneda", DbType.Int32, codMoneda);
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
