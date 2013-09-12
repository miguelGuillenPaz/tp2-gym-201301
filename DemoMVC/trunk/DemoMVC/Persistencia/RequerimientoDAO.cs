using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using DemoMVC.Models;

namespace DemoMVC.Persistencia
{
    public class RequerimientoDAO
    {
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
            if (requerimiento != null)
            {                
                requerimiento.ListaDetalleRequerimiento = ListarDetalleRequerimiento(id);          
            }
            return requerimiento;
        }

        private static List<DetalleRequerimiento> ListarDetalleRequerimiento(int id)
        {
            List<DetalleRequerimiento> listarDetalleRequerimiento = null;
            const string sql = "select d.IdCorDetReq,d.DesServicio,d.IdUnidadMedida,u.AbrviaUMedi,d.CanDetReq,d.IdTipoServicio,t.DescripTServicio " +
                               "from GPP_DetalleRequerimiento d inner join " +
                               "GSC_UnidadMedida u on d.IdUnidadMedida=u.IdUnidadMedida " +
                               "inner join GSC_TipoServicio t on d.IdTipoServicio=t.IdTipoServicio " +
                               "where d.IdRequerimiento=@id";                               

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
                            //Obtenemos uno por uno
                            listarDetalleRequerimiento = new List<DetalleRequerimiento>();
                            while (resultado.Read())
                            {
                                //Recorremos objeto por objeto y anadimos
                                var detalleRequerimiento = new DetalleRequerimiento
                                {                                    
                                    codcorDetReq = (int)resultado["IdCorDetReq"],
                                    desReq = resultado["DesServicio"].ToString(),
                                    codUM = (int)resultado["IdUnidadMedida"],
                                    descUM = resultado["AbrviaUMedi"].ToString(),
                                    canDetReq = (int)resultado["CanDetReq"],
                                    codTipoServ = (int)resultado["IdTipoServicio"],
                                    descTipoServ = resultado["DescripTServicio"].ToString()
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