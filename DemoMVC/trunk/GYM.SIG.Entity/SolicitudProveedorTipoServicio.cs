using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GYM.SIG.Entity
{
    [Serializable]
    public class SolicitudProveedorTipoServicio
    {
        public Int32 codSolCotizacion { get; set; }
        public Int32 codProv { get; set; }
        public Int32 codTServ { get; set; }
        public DateTime fechaSolProTServ { get; set; }


        public int numero { get; set; }
        public DateTime fecSolCotizacino { get; set; }
        public String fechaSolicitud
        {
            get
            {
                if (default(DateTime) == fecSolCotizacino) return ""; else return fecSolCotizacino.ToString("dd/MM/yyy");
            }
        }
        public String descTServ { get; set; }
        public String razsocPro { get; set; }

    }
}
