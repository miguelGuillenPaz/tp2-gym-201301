using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GYM.SIC.GPC.Models
{
    public class PartidasModel
    {    
        public int ID { get; set; }
        public string Nombre { get; set; }

        public List<CategoriaModel> CategoriasModel { get; set; }
    }
}