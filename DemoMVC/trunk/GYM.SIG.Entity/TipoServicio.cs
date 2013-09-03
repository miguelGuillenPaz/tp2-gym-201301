using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GYM.SIG.Entity
{
    [Serializable]
    public class TipoServicio
    {
        public Int32 codTServ { get; set; }
        public String descTServ { get; set; }
        public DateTime fecActualizacion { get; set; }

    }
}
