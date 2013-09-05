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
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 8);
                db.AddInParameter(SQL, "IdSolicitudCotizacion", DbType.Int32, codSolCotizacion);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Proveedor
                        {
                            codProv = lector.GetInt32(lector.GetOrdinal("IdProveedor")),
                            rucPro = lector.GetString(lector.GetOrdinal("RucProv")),
                            razsocPro = lector.GetString(lector.GetOrdinal("RazonSocialProv")),
                            dirPro = lector.IsDBNull(lector.GetOrdinal("DireccionProv")) ? "" : lector.GetString(lector.GetOrdinal("DireccionProv")),
                            emailPro = lector.IsDBNull(lector.GetOrdinal("EmailProv")) ? "" : lector.GetString(lector.GetOrdinal("EmailProv")),
                            estadoPro = lector.IsDBNull(lector.GetOrdinal("EstadoProv")) ? "" : lector.GetString(lector.GetOrdinal("EstadoProv")),
                            calificacion = lector.IsDBNull(lector.GetOrdinal("calificacion")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("calificacion")),
                            contactoProTServ = lector.IsDBNull(lector.GetOrdinal("ContactoProvTipoServ")) ? "" : lector.GetString(lector.GetOrdinal("ContactoProvTipoServ")),
                            emailProTServ = lector.IsDBNull(lector.GetOrdinal("EmailProvTipoServ")) ? "" : lector.GetString(lector.GetOrdinal("EmailProvTipoServ")),
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
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 7);
                db.AddInParameter(SQL, "TipoBusqueda", DbType.String, tipoBusqueda);
                db.AddInParameter(SQL, "expresion", DbType.String, expresion);
                db.AddInParameter(SQL, "IdTipoServicio", DbType.Int32, codTServ);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Proveedor
                        {
                            codProv = lector.GetInt32(lector.GetOrdinal("IdProveedor")),
                            rucPro = lector.GetString(lector.GetOrdinal("RucProv")),
                            razsocPro = lector.GetString(lector.GetOrdinal("RazonSocialProv")),
                            dirPro = lector.IsDBNull(lector.GetOrdinal("DireccionProv")) ? "" : lector.GetString(lector.GetOrdinal("DireccionProv")),
                            emailPro = lector.IsDBNull(lector.GetOrdinal("EmailProv")) ? "" : lector.GetString(lector.GetOrdinal("EmailProv")),
                            estadoPro = lector.IsDBNull(lector.GetOrdinal("EstadoProv")) ? "" : lector.GetString(lector.GetOrdinal("EstadoProv")),
                            calificacion = lector.IsDBNull(lector.GetOrdinal("calificacion")) ? default(Int32) : lector.GetInt32(lector.GetOrdinal("calificacion")),
                            contactoProTServ = lector.IsDBNull(lector.GetOrdinal("ContactoProvTipoServ")) ? "" : lector.GetString(lector.GetOrdinal("ContactoProvTipoServ")),
                            emailProTServ = lector.IsDBNull(lector.GetOrdinal("EmailProvTipoServ")) ? "" : lector.GetString(lector.GetOrdinal("EmailProvTipoServ")),
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
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 2);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new Proveedor
                        {
                            codProv = lector.GetInt32(lector.GetOrdinal("IdProveedor")),
                            rucPro = lector.GetString(lector.GetOrdinal("RucProv")),
                            razsocPro = lector.GetString(lector.GetOrdinal("RazonSocialProv")),
                            dirPro = lector.IsDBNull(lector.GetOrdinal("DireccionProv")) ? "" : lector.GetString(lector.GetOrdinal("DireccionProv")),
                            emailPro = lector.IsDBNull(lector.GetOrdinal("EmailProv")) ? "" : lector.GetString(lector.GetOrdinal("EmailProv")),
                            estadoPro = lector.IsDBNull(lector.GetOrdinal("EstadoProv")) ? "" : lector.GetString(lector.GetOrdinal("EstadoProv")),
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
                            codProv = lector.GetInt32(lector.GetOrdinal("IdProveedor")),
                            rucPro = lector.GetString(lector.GetOrdinal("RucProv")),
                            razsocPro = lector.GetString(lector.GetOrdinal("RazonSocialProv")),
                            dirPro = lector.IsDBNull(lector.GetOrdinal("DireccionProv")) ? "" : lector.GetString(lector.GetOrdinal("DireccionProv")),
                            emailPro = lector.IsDBNull(lector.GetOrdinal("EmailProv")) ? "" : lector.GetString(lector.GetOrdinal("EmailProv"))

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
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 3);
                db.AddInParameter(SQL, "IdProveedor", DbType.Int32, codProv);
                var Proveedor = default(Proveedor);
                using (var lector = db.ExecuteReader(SQL))
                {
                    while (lector.Read())
                    {
                        Proveedor = new Proveedor
                        {
                            codProv = lector.GetInt32(lector.GetOrdinal("IdProveedor")),
                            rucPro = lector.GetString(lector.GetOrdinal("RucProv")),
                            razsocPro = lector.GetString(lector.GetOrdinal("RazonSocialProv")),
                            dirPro = lector.IsDBNull(lector.GetOrdinal("DireccionProv")) ? "" : lector.GetString(lector.GetOrdinal("DireccionProv")),
                            emailPro = lector.IsDBNull(lector.GetOrdinal("EmailProv")) ? "" : lector.GetString(lector.GetOrdinal("EmailProv"))

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
                db.AddInParameter(SQL, "IdProveedor", DbType.Int32, Proveedor.codProv);
                db.AddInParameter(SQL, "RucProv", DbType.String, Proveedor.rucPro);
                db.AddInParameter(SQL, "RazonSocialProv", DbType.String, Proveedor.razsocPro);
                db.AddInParameter(SQL, "DireccionProv", DbType.String, Proveedor.dirPro);
                db.AddInParameter(SQL, "EmailProv", DbType.String, Proveedor.emailPro);
                db.AddInParameter(SQL, "TipoConsulta", DbType.Byte, 4);
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
                db.AddInParameter(SQL, "IdProveedor", DbType.Int32, Proveedor.codProv);
                db.AddInParameter(SQL, "RucProv", DbType.String, Proveedor.rucPro);
                db.AddInParameter(SQL, "RazonSocialProv", DbType.String, Proveedor.razsocPro);
                db.AddInParameter(SQL, "DireccionProv", DbType.String, Proveedor.dirPro);
                db.AddInParameter(SQL, "EmailProv", DbType.String, Proveedor.emailPro);
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


        public virtual bool DeleteByPrimaryKey(Int32 codProv)
        {
            try
            {
                DbCommand SQL = db.GetStoredProcCommand(nombreprocedimiento);
                db.AddInParameter(SQL, "IdProveedor", DbType.Int32, codProv);
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
