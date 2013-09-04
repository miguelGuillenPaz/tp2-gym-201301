using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GYM.SIC.GPC.Models
{
    public class CronogramaModel
    {
        public int ID { get; set; }
        public string Nombre { get; set; }
        public DateTime? Fecha { get; set; }
        public DateTime? FechaInicio { get; set; }
        public DateTime? FechaFin { get; set; }
        public string Responsable { get; set; }

        public List<ActividadModel> ActividadesModel { get; set; }
    }
}