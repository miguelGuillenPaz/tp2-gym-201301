using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GYM.SIC.GPC.Models
{
    public class ActividadModel
    {
        public int ID { get; set; }
        public string Nombre { get; set; }
        public DateTime? Fecha { get; set; }
        public string Responsable { get; set; }
        public string Hito { get; set; }
    }
}