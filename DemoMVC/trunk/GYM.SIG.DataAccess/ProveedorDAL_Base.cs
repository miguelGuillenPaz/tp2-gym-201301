using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GYM.SIG.DataAccess
{
    public class Proveedordalc : Singleton<Proveedordalc>
    {
        private const String nombreprocedimiento = "pa_GSC_Proveedor";
        private const String NombreTabla = "Proveedor";
        private Database db = DatabaseFactory.CreateDatabase();

        public List<Proveedor> listaporSolicitud(int codSolCotizacion)
        {
            try
            {
                var coleccion = new List<Proveedor>();
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 8);
                db.AddInParameter(SQL, "codSolCotizacion", DbType.Int32, codSolCotizacion);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Proveedor
                        {
                            codProv = lector.GetInt32(lector.GetOrdinal("codProv")),
                            rucPro = lector.GetString(lector.GetOrdinal("rucPro")),
                            razsocPro = lector.GetString(lector.GetOrdinal("razsocPro")),
                            dirPro = lector.IsDBNull(lector.GetOrdinal("dirPro")) ? "" : lector.GetString(lector.GetOrdinal("dirPro")),
                            emailPro = lector.IsDBNull(lector.GetOrdinal("emailPro")) ? "" : lector.GetString(lector.GetOrdinal("emailPro")),
                            estadoPro = lector.IsDBNull(lector.GetOrdinal("estadoPro")) ? "" : lector.GetString(lector.GetOrdinal("estadoPro")),
                            calificacion = lector.IsDBNull(lector.GetOrdinal("calificacion")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("calificacion")),
                            contactoProTServ = lector.IsDBNull(lector.GetOrdinal("contactoProTServ")) ? "" : lector.GetString(lector.GetOrdinal("contactoProTServ")),
                            emailProTServ = lector.IsDBNull(lector.GetOrdinal("emailProTServ")) ? "" : lector.GetString(lector.GetOrdinal("emailProTServ")),
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

        public List<Proveedor> listaporServicio(String tipoBusqueda, String expresion, int codTServ)
        {
            try
            {
                var coleccion = new List<Proveedor>();
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 7);
                db.AddInParameter(SQL, "tipoBusqueda", DbType.String, tipoBusqueda);
                db.AddInParameter(SQL, "expresion", DbType.String, expresion);
                db.AddInParameter(SQL, "codTServ", DbType.Int32, codTServ);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Proveedor
                        {
                            codProv = lector.GetInt32(lector.GetOrdinal("codProv")),
                            rucPro = lector.GetString(lector.GetOrdinal("rucPro")),
                            razsocPro = lector.GetString(lector.GetOrdinal("razsocPro")),
                            dirPro = lector.IsDBNull(lector.GetOrdinal("dirPro")) ? "" : lector.GetString(lector.GetOrdinal("dirPro")),
                            emailPro = lector.IsDBNull(lector.GetOrdinal("emailPro")) ? "" : lector.GetString(lector.GetOrdinal("emailPro")),
                            estadoPro = lector.IsDBNull(lector.GetOrdinal("estadoPro")) ? "" : lector.GetString(lector.GetOrdinal("estadoPro")),
                            calificacion = lector.IsDBNull(lector.GetOrdinal("calificacion")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("calificacion")),
                            contactoProTServ = lector.IsDBNull(lector.GetOrdinal("contactoProTServ")) ? "" : lector.GetString(lector.GetOrdinal("contactoProTServ")),
                            emailProTServ = lector.IsDBNull(lector.GetOrdinal("emailProTServ")) ? "" : lector.GetString(lector.GetOrdinal("emailProTServ")),
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

        public List<Proveedor> listartodos()
        {
            try
            {
                var coleccion = new List<Proveedor>();
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 2);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Proveedor
                        {
                            codProv = lector.GetInt32(lector.GetOrdinal("codProv")),
                            rucPro = lector.GetString(lector.GetOrdinal("rucPro")),
                            razsocPro = lector.GetString(lector.GetOrdinal("razsocPro")),
                            dirPro = lector.IsDBNull(lector.GetOrdinal("dirPro")) ? "" : lector.GetString(lector.GetOrdinal("dirPro")),
                            emailPro = lector.IsDBNull(lector.GetOrdinal("emailPro")) ? "" : lector.GetString(lector.GetOrdinal("emailPro")),
                            estadoPro = lector.IsDBNull(lector.GetOrdinal("estadoPro")) ? "" : lector.GetString(lector.GetOrdinal("estadoPro")),
                            contactoProTServ = "",
                            emailProTServ = "",
                            calificacion = 0,
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

        public List<Proveedor> Getcoleccion(string wheresql, string orderbysql)
        {
            int totalRecordCount = -1;
            return Getcoleccion(wheresql, orderbysql, 0, int.MaxValue, totalRecordCount);
        }


        public virtual List<Proveedor> Getcoleccion(string wheresql, string orderbysql, int startIndex, int length, int totalRecordCount)
        {
            try
            {
                var coleccion = new List<Proveedor>();
                DbCommand SQL = db.GetSqlStringCommand(CreateGetCommand(wheresql, orderbysql));
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Proveedor
                        {
                            codProv = lector.GetInt32(lector.GetOrdinal("codProv")),
                            rucPro = lector.GetString(lector.GetOrdinal("rucPro")),
                            razsocPro = lector.GetString(lector.GetOrdinal("razsocPro")),
                            dirPro = lector.IsDBNull(lector.GetOrdinal("dirPro")) ? "" : lector.GetString(lector.GetOrdinal("dirPro")),
                            emailPro = lector.IsDBNull(lector.GetOrdinal("emailPro")) ? "" : lector.GetString(lector.GetOrdinal("emailPro"))

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


        public virtual Proveedor GetByPrimaryKey(Int32 codProv)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 3);
                db.AddInParameter(SQL, "codProv", DbType.Int32, codProv);
                var Proveedor = default(Proveedor);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        Proveedor = new Proveedor
                        {
                            codProv = lector.GetInt32(lector.GetOrdinal("codProv")),
                            rucPro = lector.GetString(lector.GetOrdinal("rucPro")),
                            razsocPro = lector.GetString(lector.GetOrdinal("razsocPro")),
                            dirPro = lector.IsDBNull(lector.GetOrdinal("dirPro")) ? "" : lector.GetString(lector.GetOrdinal("dirPro")),
                            emailPro = lector.IsDBNull(lector.GetOrdinal("emailPro")) ? "" : lector.GetString(lector.GetOrdinal("emailPro"))

                        };
                    }
                }
                SQL.Dispose();
                return Proveedor;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }



        protected virtual string CreateGetCommand(string whereSql, string orderBySql)
        {
            string sql = "SELECT * FROM [dbo].[Proveedor]";
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

        public virtual int Insert(Proveedor Proveedor)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codProv", DbType.Int32, Proveedor.codProv);
                db.AddInParameter(SQL, "rucPro", DbType.String, Proveedor.rucPro);
                db.AddInParameter(SQL, "razsocPro", DbType.String, Proveedor.razsocPro);
                db.AddInParameter(SQL, "dirPro", DbType.String, Proveedor.dirPro);
                db.AddInParameter(SQL, "emailPro", DbType.String, Proveedor.emailPro);
                db.AddInParameter(SQL, "Tipoconsulta", DbType.Byte, 4);
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


        public virtual void Update(Proveedor Proveedor)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codProv", DbType.Int32, Proveedor.codProv);
                db.AddInParameter(SQL, "rucPro", DbType.String, Proveedor.rucPro);
                db.AddInParameter(SQL, "razsocPro", DbType.String, Proveedor.razsocPro);
                db.AddInParameter(SQL, "dirPro", DbType.String, Proveedor.dirPro);
                db.AddInParameter(SQL, "emailPro", DbType.String, Proveedor.emailPro);
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


        public virtual bool DeleteByPrimaryKey(Int32 codProv)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "codProv", DbType.Int32, codProv);
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
