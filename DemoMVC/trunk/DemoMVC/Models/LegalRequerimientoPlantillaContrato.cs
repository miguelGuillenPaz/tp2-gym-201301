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
        public string xmlClausulasVarchar { get; set; } //para enviar como xml las clausulas adicionadas

        //Campos plazo indeterminado
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

        //Campos prestación de servicios
        public string EmpresaOutsourcing { get; set; }
        public string Ruc { get; set; }
        public string Domicilio { get; set; }
        public string RepresentanteLegal { get; set; }
        public string DniRepresentanteLegal { get; set; }
        public string FichaPoderJudicial { get; set; }
        public string ObjetoSocialOutsourcing { get; set; }
        public string ServicioBrindar { get; set; }
        public string DuracionContrato { get; set; }
        public string JuezControversia { get; set; }

        //Sujeto modalidad
        public string NombreTrabajadorSM { get; set; }
        public string DniTrabajadorSM { get; set; }
        public string ModalidadContrato { get; set; }
        public string Duracion { get; set; }
        public string HoraInicioLaborSM { get; set; }
        public string HoraFinLaborSM { get; set; }
        public string HoraInicioRefrigerioSM { get; set; }
        public string HoraFinRefrigerioSM { get; set; }
        public string JuezControversiaSM { get; set; }

        //Clausulas
        public string DescripcionClausula { get; set; }

    }
}