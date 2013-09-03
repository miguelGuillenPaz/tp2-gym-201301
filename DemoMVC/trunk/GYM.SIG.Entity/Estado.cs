using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GYM.SIG.Entity
{
    [Serializable]
    public class Estado
    {
        public Int32 codEstado { get; set; }
        public String desEstado { get; set; }
        public String flagSolCotizacion { get; set; }
        public String flagCotizacion { get; set; }
        /*
        public string NombreCompleto
        {
        get{ return string.Format("{0},{1}",Propiedad1,Propiedad2);}
        }
        public override string ToString()
        {
        return string.IsNullOrEmpty(propiedad1) ? propiedad1:Propiedad2;
        }
        */
    }
}
