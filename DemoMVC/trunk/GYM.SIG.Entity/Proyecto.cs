using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GYM.SIG.Entity
{
    [Serializable]
    public class Proyecto
    {
        public Int32 codPro { get; set; }
        public String nomPro { get; set; }
        public String desPro { get; set; }
        public DateTime feciniplPro { get; set; }
        public DateTime fefinplanPro { get; set; }
    }
}
