using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMVC.Models
{
    public class PlanRecursosActividad
    {

        public PlanRecursosActividad() 
        { 
        
        }

        public int IdActividad { get; set; }
        public String Descripcion { get; set; }
        public int IdRecurso { get; set; }
        public String DescRec { get; set; }
        public Int16 Cantidad { get; set; }
        public double Horas { get; set; }
        public int idTipoRecurso { get; set; }

        public string tipoRecurso 
        {
            get 
            {
                switch (idTipoRecurso) 
                {
                    case 1: return "Maquinarias";
                    case 2: return "Materiales";
                    case 3: return "Empleados";
                    default: return "Sin asignar";
                
                }
            }
        
        }

    }
}