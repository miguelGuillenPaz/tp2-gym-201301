using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GYM.SIC.GPC.Models
{
    public class PresupuestoModel
    {
        public int ID { get; set; }
        public int? IDEstado { get; set; }
        public string Numero { get; set; }
        public string Nombre { get; set; }
        public string Cliente { get; set; }
        public string Direccion { get; set; }
        public string UsuarioCambioEstado { get; set; }
        public DateTime? FechaInicio { get; set; }
        public DateTime? FechaFin { get; set; }
        public DateTime? FechaRegistro { get; set; }
        public DateTime? FechaCambioEstado { get; set; }
        public decimal? TotalPresupuestado { get; set; }
    }
}