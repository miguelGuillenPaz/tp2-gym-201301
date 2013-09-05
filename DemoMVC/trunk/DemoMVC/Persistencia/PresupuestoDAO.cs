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
    public class PresupuestoDAO
    {

        //Listado de presupuestos
        public List<Presupuesto> obtenerPresupuestoPorFiltro(int tipoFiltro, int codProy, string codPre)
        {
            List<Presupuesto> listadoPresupuestos = null;
            Presupuesto Presupuesto = null;
            string sql = "";

            if (tipoFiltro == 0) sql = "select * from dbo.GPP_Presupuesto where IdProyecto=@codPro";

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                con.Open();
                using (SqlCommand com = new SqlCommand(sql, con))
                {
                    if (tipoFiltro == 0)
                    {
                        com.Parameters.Add(new SqlParameter("@codPro", codProy));
                    }

                    using (SqlDataReader resultado = com.ExecuteReader())
                    {
                        if (resultado.HasRows)
                        {
                            //Obtenemos uno por uno
                            listadoPresupuestos = new List<Presupuesto>();
                            while (resultado.Read())
                            {
                                //Recorremos objeto por objeto y anadimos
                                Presupuesto = new Presupuesto
                                {
                                    codPre = (int)resultado["IdPresupuesto"],
                                    codPro = (int)resultado["IdProyecto"],
                                    codTipMon = (int)resultado["IdMoneda"],
                                    verPre = (int)resultado["NroVersion"],
                                    fecPre = (string)resultado["Fecha"],
                                    monPre = (double)resultado["Moneda"],
                                    impPre = (double)resultado["ImporteTotal"],
                                    estPre = (string)resultado["Estado"],
                                    impconPre = (double)resultado["ImporteAsignado"],
                                };
                                //Adicionamos al arreglo el objeto
                                listadoPresupuestos.Add(Presupuesto);
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
            return listadoPresupuestos;
        }



    }
}