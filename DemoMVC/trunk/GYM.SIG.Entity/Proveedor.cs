using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GYM.SIG.Entity
{
    [Serializable]
    public class Proveedor
    {
        public int numero { get; set; }

        public Int32 codProv { get; set; }
        public String rucPro { get; set; }
        public String razsocPro { get; set; }
        public String dirPro { get; set; }
        public String emailPro { get; set; }
        public String estadoPro { get; set; }

        public String situacion { get { if (this.estadoPro.Equals("HA")) return "Hábil"; else return "No Hábil"; } }

        public String emailProTServ { get; set; }
        public String contactoProTServ { get; set; }
        public int calificacion { get; set; }

    }
}
