using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using DemoMVC.Models;

namespace DemoMVC.Persistencia
{
    public class RequerimientoDAO
    {

        public int Registrar(int proyecto, int tipoRecurso , string descripcion, int prioridad)
        {
            
            string sql = "insert into GPP_Requerimiento (IdProyecto, DescripReq, PriReq, IdTipoRecurso, FechaReq, IdRequerimiento) values (@IdProyecto, @DescripReq, @PriReq, @IdTipoRecurso, @FechaReq, (select max(IdRequerimiento)+1 from GPP_Requerimiento) )";

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                try
                {
                    // @IdRecurso, @Cantidad, @Horas
                    SqlCommand cmdIns = new SqlCommand(sql, con);
                    cmdIns.Parameters.Add(new SqlParameter("@IdProyecto", proyecto));
                    cmdIns.Parameters.Add(new SqlParameter("@DescripReq", descripcion));
                    cmdIns.Parameters.Add(new SqlParameter("@PriReq", prioridad));
                    cmdIns.Parameters.Add(new SqlParameter("@IdTipoRecurso", tipoRecurso));
                    cmdIns.Parameters.Add(new SqlParameter("@FechaReq", DateTime.Now));
                    con.Open();
                    return cmdIns.ExecuteNonQuery();
                    con.Close();
                }
                catch (Exception ex)
                {
                    return 0;
                }
            }
        }

        public List<TipoRequerimiento> ListarTipoRecurso()
        {
            List<TipoRequerimiento> listarTipoRecurso = null;
            const string sql = "select * from GPP_TipoRecurso";

            using (var con = new SqlConnection(ConexionUtil.Cadena))
            {
                con.Open();
                using (var com = new SqlCommand(sql, con))
                {
                    using (var resultado = com.ExecuteReader())
                    {
                        if (resultado.HasRows)
                        {
                            //Obtenemos uno por uno
                            listarTipoRecurso = new List<TipoRequerimiento>();
                            while (resultado.Read())
                            {
                                //Recorremos objeto por objeto y anadimos
                                var tipoRequerimiento = new TipoRequerimiento
                                {
                                    idTipoReq = (int)resultado["IdTipoRecurso"],
                                    descripcion = resultado["Nombre"].ToString()                                    
                                };
                                listarTipoRecurso.Add(tipoRequerimiento);
                            }
                        }
                        else
                        {
                            Debug.WriteLine("No retornó registros");
                        }
                    }
                    con.Close();
                }
            }
            return listarTipoRecurso;
        }

        public List<Requerimiento> ListarRequerimiento()
        {
            List<Requerimiento> listaRequerimiento = null;
            const string sql = "select r.IdRequerimiento,r.DescripReq,r.IdProyecto,p.Nombre Proyecto," +
                               "r.FechaReq,r.IdTipoRecurso,t.Nombre TipoRecurso,r.PriReq from GPP_Requerimiento r " +
                               "INNER JOIN GPP_Proyecto p ON r.IdProyecto = p.IdProyecto " +
                               "INNER JOIN GPP_TipoRecurso t ON r.IdTipoRecurso = t.IdTipoRecurso";

            using (var con = new SqlConnection(ConexionUtil.Cadena))
            {
                con.Open();
                using (var com = new SqlCommand(sql, con))
                { 
                    using (var resultado = com.ExecuteReader())
                    {
                        if (resultado.HasRows)
                        {
                            //Obtenemos uno por uno
                            listaRequerimiento = new List<Requerimiento>();
                            while (resultado.Read())
                            {
                                //Recorremos objeto por objeto y anadimos
                                var requerimiento = new Requerimiento
                                    {
                                        idReq = (int)resultado["IdRequerimiento"],
                                        descripcion = resultado["DescripReq"].ToString(),
                                        idProyecto = (int)resultado["IdProyecto"],
                                        desProyecto = resultado["Proyecto"].ToString(),
                                        fecha = (DateTime)resultado["FechaReq"],
                                        idTipoRequerimiento = (int)resultado["IdTipoRecurso"],
                                        descTipoReq = resultado["TipoRecurso"].ToString()
                                    };
                                listaRequerimiento.Add(requerimiento);
                            }
                        }
                        else
                        {
                            Debug.WriteLine("No retornó registros");
                        }
                    }
                    con.Close();
                }
            }
            return listaRequerimiento;
        }

        public Requerimiento ObtenerRequerimiento(int id)
        {            
            const string sql = "select r.IdRequerimiento,r.DescripReq,r.IdProyecto,p.Nombre Proyecto," +
                               "r.FechaReq,r.IdTipoRecurso,t.Nombre TipoRecurso,r.PriReq from GPP_Requerimiento r " +
                               "INNER JOIN GPP_Proyecto p ON r.IdProyecto = p.IdProyecto " +
                               "INNER JOIN GPP_TipoRecurso t ON r.IdTipoRecurso = t.IdTipoRecurso WHERE r.IdRequerimiento = @id";
            Requerimiento requerimiento = null;
            using (var con = new SqlConnection(ConexionUtil.Cadena))
            {
                con.Open();
                using (var com = new SqlCommand(sql, con))
                {                    
                    com.Parameters.Add(new SqlParameter("@id", id));    
                
                    using (var resultado = com.ExecuteReader())
                    {
                        if (resultado.HasRows)
                        {                                                        
                            while (resultado.Read())
                            {
                                //Recorremos objeto por objeto y anadimos
                                requerimiento = new Requerimiento
                                {
                                    idReq = (int)resultado["IdRequerimiento"],
                                    descripcion = resultado["DescripReq"].ToString(),
                                    idProyecto = (int)resultado["IdProyecto"],
                                    desProyecto = resultado["Proyecto"].ToString(),
                                    fecha = (DateTime)resultado["FechaReq"],
                                    idTipoRequerimiento = (int)resultado["IdTipoRecurso"],
                                    descTipoReq = resultado["TipoRecurso"].ToString(),
                                    prioridad = Convert.ToInt32(resultado["PriReq"].ToString())
                                };                                
                            }
                        }
                        else
                        {
                            Debug.WriteLine("No retornó registros");
                        }
                    }
                    con.Close();
                }
            }            
            //if (requerimiento != null)
            //{                
            //    requerimiento.ListaDetalleRequerimiento = ListarDetalleRequerimiento(id);          
            //}
            return requerimiento;
        }


        public List<DetalleRequerimiento> ListarDetalleRequerimiento(int id)
        {
            List<DetalleRequerimiento> listarDetalleRequerimiento = null;
            //const string sql = "select d.IdCorDetReq,d.DesServicio,d.IdUnidadMedida,u.AbrviaUMedi,d.CanDetReq,d.IdTipoServicio,t.DescripTServicio " +
            //                   "from GPP_DetalleRequerimiento d inner join " +
            //                   "GSC_UnidadMedida u on d.IdUnidadMedida=u.IdUnidadMedida " +
            //                   "inner join GSC_TipoServicio t on d.IdTipoServicio=t.IdTipoServicio " +
            //                   "where d.IdRequerimiento=@id";
            
            string sql = "select dr.idDetalleRequerimiento, dr.Cantidad, dr.idEmpleado, dr.idRequerimientoPlanProy, dr.IdRecurso, r.Descripcion from GPP_DetalleRequerimiento dr inner join GPP_Recurso r on dr.IdRecurso = r.IdRecurso where idRequerimientoPlanProy = @idRequerimientoPlanProy";
            
            using (var con = new SqlConnection(ConexionUtil.Cadena))
            {
                con.Open();
                using (var com = new SqlCommand(sql, con))
                {
                    com.Parameters.Add(new SqlParameter("@idRequerimientoPlanProy", id));
                    using (var resultado = com.ExecuteReader())
                    {
                        if (resultado.HasRows)
                        {
                            //Obtenemos uno por uno
                            listarDetalleRequerimiento = new List<DetalleRequerimiento>();
                            while (resultado.Read())
                            {
                                //Recorremos objeto por objeto y anadimos
                                var detalleRequerimiento = new DetalleRequerimiento
                                {
                                    idDetalleRequerimiento = (int)resultado["idDetalleRequerimiento"],
                                    canDetReq = (int)resultado["Cantidad"],
                                    desServicio = (string)resultado["Descripcion"],

                                };
                                listarDetalleRequerimiento.Add(detalleRequerimiento);
                            }
                        }
                        else
                        {
                            Debug.WriteLine("No retornó registros");
                        }
                    }
                    con.Close();
                }
            }
            return listarDetalleRequerimiento;
        }


    }
}