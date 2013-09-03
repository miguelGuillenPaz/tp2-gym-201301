using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GYM.SIG.Entity
{
    [Serializable]
    public class DetalleCotizacion
    {
        public Int32 numero { get; set; }
        public Int32 codReq { get; set; }

        public Int32 codCotizacion { get; set; }
        public Int32 codCotDet { get; set; }
        public String descripcion { get; set; }
        public Decimal cantidad { get; set; }
        public Decimal precio { get; set; }
        public Decimal importe { get; set; }
        public Int32 codUM { get; set; }

        public Int32 codSolCotizacion { get; set; }
        public Int32 codSolDet { get; set; }

        public String desEstado { get; set; }

    }
}
