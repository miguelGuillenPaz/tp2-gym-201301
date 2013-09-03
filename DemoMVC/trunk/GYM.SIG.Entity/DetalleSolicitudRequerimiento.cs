using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GYM.SIG.Entity
{
    [Serializable]
    public class DetalleSolicitudRequerimiento
    {
        public Int32 numero { get; set; }

        public Int32 codSolCotizacion { get; set; }
        public Int32 codSolDet { get; set; }
        public String desSolDet { get; set; }
        public DateTime fecSolDet { get; set; }
        public Int32 codPro { get; set; }
        public Int32 codReq { get; set; }
        public Int32 codcorDetReq { get; set; }

        public String desServicio { get; set; }
        public Int32 codUM { get; set; }
        public String descUM { get; set; }
        public int canDetReq { get; set; }

        public Decimal precio { get; set; }
        public Decimal importe { get; set; }
        public String nomPro { get; set; }
        public String desReq { get; set; }
    }
}
