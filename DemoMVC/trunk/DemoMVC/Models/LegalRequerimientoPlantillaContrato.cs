using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMVC.Models
{
    public class LegalRequerimientoPlantillaContrato
    {

        public LegalRequerimientoPlantillaContrato()
        {
        }

        public int idReqLegal { get; set; }
        public int idContratoLegalTipo { get; set; }
        public bool TieneClausulaAdicional { get; set; }
        public string xmlClausulasVarchar { get; set; }
        public string NombreTrabajador {get; set;}
		public string DniTrabajador {get; set;}
		public string Cargo {get; set;}
		public string LaborDesempenar {get; set;}
		public string HoraInicioLabor {get; set;}
		public string HoraFinLabor {get; set;}
		public string HoraInicioRefrigerio {get; set;}
		public string HoraFinRefrigerio {get; set;}
        public string PeriodoPrueba { get; set; }
        public string xmlClausulas { get; set; }

        //Clausulas
        public string DescripcionClausula { get; set; }

    }
}