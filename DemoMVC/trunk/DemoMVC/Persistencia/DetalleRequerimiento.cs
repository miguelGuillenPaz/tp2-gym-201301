using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMVC.Models
{
    public class DetalleRequerimiento
    {
        public DetalleRequerimiento()
        {
        }
        public int numero { get; set; }

        public int codPro { get; set; }
        public int codReq { get; set; }
        public int codcorDetReq { get; set; }
        public int canDetReq { get; set; }
        public DateTime fecInicio { get; set; }
        public DateTime fecFin { get; set; }
        public string desServicio { get; set; }
        public string actServicio { get; set; }
        public int codUM { get; set; }
        public string descUM { get; set; }

        public int codTipoServ { get; set; }
        public string descTipoServ { get; set; }

        public string desReq { get; set; }
        public string nomPro { get; set; }


        //
        public int codSolCotizacion { get; set; }
        public int codSolDet { get; set; }
    }
}