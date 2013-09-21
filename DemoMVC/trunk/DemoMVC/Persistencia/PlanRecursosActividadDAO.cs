using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Collections;
using DemoMVC.Models;

namespace DemoMVC.Persistencia
{
    public class PlanRecursosActividadDAO
    {




        public int EliminarPlanRecursosPorActividad(int IdActividad, int IdRecurso)
        {

            string sql = "delete from GPP_PlanRecursosActividad where IdActividad = @IdActividad and IdRecurso = @IdRecurso";

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                try
                {
                    // @IdRecurso, @Cantidad, @Horas
                    SqlCommand cmdIns = new SqlCommand(sql, con);
                    cmdIns.Parameters.Add(new SqlParameter("@IdActividad", IdActividad));
                    cmdIns.Parameters.Add(new SqlParameter("@IdRecurso", IdRecurso));                               
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

    
        public int RegistrarPlanRecursosPorActividad(int IdActividad, int IdRecurso, int Cantidad, double Horas)
        {

            string sql = "insert into GPP_PlanRecursosActividad (IdActividad, IdRecurso, Cantidad, Horas) values (@IdActividad, @IdRecurso, @Cantidad, @Horas)";

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                try
                {
                    // @IdRecurso, @Cantidad, @Horas
                    SqlCommand cmdIns = new SqlCommand(sql, con);
                    cmdIns.Parameters.Add(new SqlParameter("@IdActividad", IdActividad));
                    cmdIns.Parameters.Add(new SqlParameter("@IdRecurso", IdRecurso));
                    cmdIns.Parameters.Add(new SqlParameter("@Cantidad", Cantidad));
                    cmdIns.Parameters.Add(new SqlParameter("@Horas", Horas));              
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

        

        //Listado de actividades por recurso
        public List<PlanRecursosActividad> obtenerPlanRecursosPorActividad(int Actividad) {

            List<PlanRecursosActividad> listadoRecAct = null;
            PlanRecursosActividad recPorActividad = null;
            string sql = "";

            sql = "select PlanRecAct.IdActividad, act.Descripcion, PlanRecAct.IdRecurso, rec.IdTipoRecurso idTipoRecurso, rec.Descripcion as DescRec, planRecAct.Cantidad, planRecAct.Horas ";
            sql = sql + "from dbo.GPP_PlanRecursosActividad PlanRecAct ";
            sql = sql + "inner join dbo.GPP_Actividad act on act.IdActividad = PlanRecAct.IdActividad ";
            sql = sql + "inner join dbo.GPP_Recurso rec on rec.IdRecurso = PlanRecAct.IdRecurso ";
            sql = sql + "where PlanRecAct.IdActividad = @IdActividad";

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                con.Open();
                using (SqlCommand com = new SqlCommand(sql, con))
                {
                    com.Parameters.Add(new SqlParameter("@IdActividad", Actividad));

                    using (SqlDataReader resultado = com.ExecuteReader())
                    {
                        if (resultado.HasRows)
                        {
                            //Obtenemos uno por uno
                            listadoRecAct = new List<PlanRecursosActividad>();
                            while (resultado.Read())
                            {
                                //Recorremos objeto por objeto y anadimos
                                recPorActividad = new PlanRecursosActividad
                                {
                                    IdActividad = (int)resultado["IdActividad"],
                                    Descripcion = (string)resultado["Descripcion"],
                                    IdRecurso = (int)resultado["IdRecurso"],
                                    DescRec = (string)resultado["DescRec"],
                                    Cantidad = (Int16)resultado["Cantidad"],
                                    Horas = (double)resultado["Horas"],
                                    idTipoRecurso = (int)resultado["idTipoRecurso"],
                                };
                                /*
                                recPorActividad = new PlanRecursosActividad
                                {
                                    IdActividad = (int)resultado["IdActividad"],
                                    Descripcion = "",
                                    IdRecurso = 1,
                                    DescRec = "",
                                    Cantidad = 1,
                                    Horas = 1
                                };*/
                                listadoRecAct.Add(recPorActividad);
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
            return listadoRecAct;
        
        }

    }

}