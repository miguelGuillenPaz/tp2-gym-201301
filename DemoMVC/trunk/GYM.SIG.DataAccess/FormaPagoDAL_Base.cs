using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GYM.SIG.DataAccess
{
    public class FormaPagodalc : Singleton<FormaPagodalc>
    {
        private const String nombreprocedimiento = "pa_GSC_FormaPago";
        private const String NombreTabla = "FormaPago";
        private Database db = DatabaseFactory.CreateDatabase();


        public List<FormaPago> listartodos()
        {
            try
            {
                var coleccion = new List<FormaPago>();
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 2);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new FormaPago
                        {
                            codFormPag = lector.GetInt32(lector.GetOrdinal("IdFormaPago")),
                            desFormPag = lector.IsDBNull(lector.GetOrdinal("DescripFormPag")) ? default(String) : lector.GetString(lector.GetOrdinal("DescripFormPag"))

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



        public List<FormaPago> Getcoleccion(string wheresql, string orderbysql)
        {
            int totalRecordCount = -1;
            return Getcoleccion(wheresql, orderbysql, 0, int.MaxValue, totalRecordCount);
        }


        public virtual List<FormaPago> Getcoleccion(string wheresql, string orderbysql, int startIndex, int length, int totalRecordCount)
        {
            try
            {
                var coleccion = new List<FormaPago>();
                DbCommand SQL = db.GetSqlStringCommand(CreateGetCommand(wheresql, orderbysql));
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new FormaPago
                        {
                            codFormPag = lector.GetInt32(lector.GetOrdinal("IdFormaPago")),
                            desFormPag = lector.IsDBNull(lector.GetOrdinal("DescripFormPag")) ? default(String) : lector.GetString(lector.GetOrdinal("DescripFormPag"))

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


        public virtual FormaPago GetByPrimaryKey(Int32 codFormPag)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 3);
                db.AddInParameter(SQL, "IdFormaPago", DbType.Int32, codFormPag);
                var FormaPago = default(FormaPago);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        FormaPago = new FormaPago
                        {
                            codFormPag = lector.GetInt32(lector.GetOrdinal("IdFormaPago")),
                            desFormPag = lector.IsDBNull(lector.GetOrdinal("DescripFormPag")) ? default(String) : lector.GetString(lector.GetOrdinal("DescripFormPag"))

                        };
                    }
                }
                SQL.Dispose();
                return FormaPago;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }



        protected virtual string CreateGetCommand(string whereSql, string orderBySql)
        {
            string sql = "SELECT * FROM [dbo].[FormaPago]";
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

        public virtual int Insert(FormaPago FormaPago)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "IdFormaPago", DbType.Int32, FormaPago.codFormPag);
                db.AddInParameter(SQL, "DescripFormPag", DbType.String, FormaPago.desFormPag);
                db.AddInParameter(SQL, "TipoConsulta", DbType.String, 4);
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


        public virtual void Update(FormaPago FormaPago)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "IdFormaPago", DbType.Int32, FormaPago.codFormPag);
                db.AddInParameter(SQL, "DescripFormPag", DbType.String, FormaPago.desFormPag);
                db.AddInParameter(SQL, "TipoConsulta", DbType.String, 1);
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


        public virtual bool DeleteByPrimaryKey(Int32 codFormPag)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "IdFormaPago", DbType.Int32, codFormPag);
                db.AddInParameter(SQL, "TipoConsulta", DbType.String, 5);
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
                db.AddInParameter(SQL, "TipoConsulta", DbType.String, 6);
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
