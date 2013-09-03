using System;

namespace GYM.SIG.Entity
{
    [Serializable]
    public class Cotizacion
    {
        public Int32 codCotizacion { get; set; }
        public DateTime fechaInicio { get; set; }
        public DateTime fechaFin { get; set; }
        public Decimal monto { get; set; }
        public Decimal igv { get; set; }
        public Decimal Total { get; set; }
        public String Comentarios { get; set; }
        public String pdfCotizacion { get; set; }
        public Int32 codMoneda { get; set; }
        public Int32 codSolCotizacion { get; set; }
        public Int32 codProv { get; set; }
        public Int32 codTServ { get; set; }
        public String estado { get; set; }
        public Int32 codFormPag { get; set; }
        public Int32 codEstado { get; set; }


        public String estadoActual { get; set; }
        public Boolean eliminarDetalle { get; set; }
        public Int32 numero { get; set; }
        public String descTServ { get; set; }
        public String abrvMon { get; set; }
        public String descMon { get; set; }
        public String razsocPro { get; set; }
        public String fCotizacion
        {
            get
            {
                if (default(DateTime) == fechaInicio) return ""; else return fechaInicio.ToString("dd/MM/yyy");
            }
        }

        public String fValidez
        {
            get
            {
                if (default(DateTime) == fechaFin) return ""; else return fechaFin.ToString("dd/MM/yyy");
            }
        }
    }
}
