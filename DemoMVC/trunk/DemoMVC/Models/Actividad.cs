using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMVC.Models
{
    public class Actividad
    {
        public Actividad() 
        { 
        
        }

	    public int codAct { get; set; }
	    public int corAct { get; set; }
        public int codEnt { get; set; }
        public int codPlaPro { get; set; }
	    public string desAct { get; set; }
	    public string feciniAct { get; set; }
	    public string fecfinAct { get; set; }
	    public string preAct { get; set; }
	    public string tipAct { get; set; }

        public string descripcionEntregable { get; set; }

        public int duracion
        {
            get
            {

                DateTime fechaInicio = new DateTime(int.Parse(feciniAct.Substring(6, 4)),
                                                    int.Parse(feciniAct.Substring(3, 2)),
                                                    int.Parse(feciniAct.Substring(0, 2)));

                DateTime fechaFin = new DateTime(int.Parse(fecfinAct.Substring(6, 4)),
                                                 int.Parse(fecfinAct.Substring(3, 2)),
                                                 int.Parse(fecfinAct.Substring(0, 2)));

                return (int)fechaFin.Subtract(fechaInicio).TotalDays;

            }
        }



        public string estado
        {
            get
            {

                if (tipAct != null)
                {

                    switch (tipAct.Trim())
                    {
                        case "0": return "Pendiente";
                        case "1": return "Cerrado";
                        default: return "Sin asignar";
                    }

                }
                else
                {
                    return "Sin asignar";

                }


            }

        }

    }
}