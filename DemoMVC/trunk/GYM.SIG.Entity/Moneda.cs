using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GYM.SIG.Entity
{
    [Serializable]
    public class Moneda
    {
        public Int32 codMoneda { get; set; }
        public String descMon { get; set; }
        public String abrvMon { get; set; }
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
