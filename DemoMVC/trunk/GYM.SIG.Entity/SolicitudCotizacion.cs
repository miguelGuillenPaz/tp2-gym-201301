using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GYM.SIG.Entity
{
    [Serializable]
    public class SolicitudCotizacion
    {
        public int numero { get; set; }

        public Int32 codSolCotizacion { get; set; }
        public String descSolCotizacion { get; set; }

        public DateTime fechaVencimiento { get; set; }
        public DateTime fecSolCotizacino { get; set; }

        public String Observaciones { get; set; }
        public String desEstado { get; set; }
        public Int32 codEstado { get; set; }
        public String fechaSolicitud
        {
            get
            {
                if (default(DateTime) == fecSolCotizacino) return ""; else return fecSolCotizacino.ToString("dd/MM/yyy");
            }
        }

        public String fVencimiento
        {
            get
            {
                if (default(DateTime) == fechaVencimiento) return ""; else return fechaVencimiento.ToString("dd/MM/yyy");
            }
        }

        public Int32 codTServ { get; set; }
        public String descTServ { get; set; }

        public Int32 codPro { get; set; }
        public String nomPro { get; set; }
        public Boolean eliminarDetalle { get; set; }

    }
}
