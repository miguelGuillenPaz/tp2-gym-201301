using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GYM.SIG.Entity
{
    [Serializable]
    public class DetalleRequerimiento
    {
        public Int32 numero { get; set; }

        public Int32 codPro { get; set; }
        public Int32 codReq { get; set; }        
        public Int32 codcorDetReq { get; set; }
        public Int32 canDetReq { get; set; }
        public DateTime fecInicio { get; set; }
        public DateTime fecFin { get; set; }
        public String desServicio { get; set; }
        public String actServicio { get; set; }
        public Int32 codUM { get; set; }
        public String descUM { get; set; }

        public String desReq { get; set; }
        public String nomPro { get; set; }


        //
        public int codSolCotizacion { get; set; }
        public int codSolDet { get; set; }
    }
}
