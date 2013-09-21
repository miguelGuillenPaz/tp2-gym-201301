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
    public class CargoDAO
    {

        //Listado de actividades
        public List<Cargo> obtenerCargo() {

            List<Cargo> listadoCargo = null;
            Cargo cargo = null;
            string sql = "select * from dbo.GRH_Cargo";

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                con.Open();
                using (SqlCommand com = new SqlCommand(sql, con))
                {
                    using (SqlDataReader resultado = com.ExecuteReader())
                    {
                        if (resultado.HasRows)
                        {
                            //Obtenemos uno por uno
                            listadoCargo = new List<Cargo>();
                            while (resultado.Read())
                            {
                                //Recorremos objeto por objeto y anadimos
                                cargo = new Cargo
                                {
                                    IdCargo = (int)resultado["IdCargo"],
                                    Descripcion = (string)resultado["Descripcion"],                                    
                                };
                                //Adicionamos al arreglo del objeto
                                listadoCargo.Add(cargo);
                            }
                        }
                    }
                }
                con.Close();
            }

            return listadoCargo;

        }

    }
}