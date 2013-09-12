using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMVC.Models
{
    public class TipoRequerimiento
    {
        public TipoRequerimiento()
        {

        }
        public int idTipoReq { get; set; }
        public string descripcion { get; set; }
    }
}