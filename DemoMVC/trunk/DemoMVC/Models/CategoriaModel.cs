using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GYM.SIC.GPC.Models
{
    public class CategoriaModel
    {
        public int ID  { get; set; }
        public string Nombre { get; set; }

        public List<DetallePartidaModel> DetallePartidasModel { get; set; }
    }
}