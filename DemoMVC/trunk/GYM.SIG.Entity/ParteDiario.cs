using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GYM.SIG.Entity
{
    [Serializable]
    public class ParteDiario
    {
        public int IdParteDiario { get; set; }
        public int IdProyecto { get; set; }
        public int IdRequerimiento { get; set; }
        public int IdCorDetReq    { get; set; }
        public DateTime Fecha { get; set; }
        public DateTime? HoraInicio { get; set; }
        public DateTime? HoraFin { get; set; }
        public string Observacion { get; set; }
        public string DescripTServicio { get; set; }
        public string DescripSolDetalle { get; set; }
        public string DescripProyecto { get; set; }
        public string DescripEstado { get; set; }
    }
}
