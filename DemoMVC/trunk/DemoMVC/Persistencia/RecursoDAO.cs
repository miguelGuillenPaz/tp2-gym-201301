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
    public class RecursoDAO
    {
        //Listado de recursos
        //Listado de actividades
        public List<Recurso> obtenerRecurso(int tipRec)
        {
            List<Recurso> listadoRecurso = null;
            Recurso recurso = null;
            string sql = "select * from dbo.GPP_Recurso where IdTipoRecurso=@tipRec";

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                con.Open();
                using (SqlCommand com = new SqlCommand(sql, con))
                {
                    com.Parameters.Add(new SqlParameter("@tipRec", tipRec));
                    using (SqlDataReader resultado = com.ExecuteReader())
                    {
                        if (resultado.HasRows)
                        {
                            //Obtenemos uno por uno
                            listadoRecurso = new List<Recurso>();
                            while (resultado.Read())
                            {
                                //Recorremos objeto por objeto y anadimos
                                recurso = new Recurso
                                {
                                    IdRecurso = (int)resultado["IdRecurso"],
                                    Descripcion = (string)resultado["Descripcion"],
                                    Precio = (double)resultado["Precio"],
                                    IdTipoRecurso = (int)resultado["IdTipoRecurso"],
                                };
                                //Añadimos al listado
                                listadoRecurso.Add(recurso);
                            }
                        }
                        else
                        {
                            Debug.WriteLine("No retornó registros");
                        }
                    }
                }
                con.Close();
            }
            return listadoRecurso;
        }

    }
}