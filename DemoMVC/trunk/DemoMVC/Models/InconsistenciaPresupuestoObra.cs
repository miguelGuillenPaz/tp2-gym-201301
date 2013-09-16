using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GYM.SIC.GPC.Models
{
    public class InconsistenciaPresupuestoObra
    {
        public string Observacion { get; set; }
        public DateTime? FechaRegistro { get; set; }
        public string Justificacion { get; set; }
        public DateTime? FechaJustificacion { get; set; }
    }
}