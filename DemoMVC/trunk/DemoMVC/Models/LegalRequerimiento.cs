using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMVC.Models
{
    public class LegalRequerimiento
    {
        public LegalRequerimiento()
        {
        }
        
        //Campos BD TP3 (algunos campos se mantienen igual -comentados-, entonces están en el listado de campos de TP2)
        //public int idReqLegal { get; set; }
        public short idReqLegalTipo { get; set; }
        public int idAsesorLegal { get; set; }
        public int idUsuario { get; set; }
        public string cFechaRegistro { get; set; }
        public string cFechaAsignacion { get; set; }
        public string cFechaAtencion { get; set; }
        public string cFechaCierre { get; set; }
        public short idReqLegalEstado { get; set; }
        public int idProyecto { get; set; }
        //public string cDescripcion { get; set; }
        //public string cPrioridadAtencion { get; set; } //char(3) --> 'ALT', 'MED', 'BAJ' (alta, media, baja)

        //Documento Identidad
        public short idDocIdentidadTipo { get; set; }
        public string cDescripcionDocIdentidad { get; set; }

        //Tipo Requerimiento
        public string cDescripcionReqLegalTipo { get; set; }

        //Estado Requerimiento
        public string cDescripcionReqLegalEstado { get; set; }

        //public bool bActivo { get; set; }
        public string nomProyecto { get; set; }
        //me sale error, no encuentra la clase LegalRequerimientoCN
        public LegalRequerimientoCN objLegalCN { get; set; }



        //----------------------------------------------------------------------------------
        //Campos BD TP2
        public int idReqLegal { get; set; }
        public int codPro { get; set; }
        public string nomPro { get; set; }
        public short idTipoReqLegal { get; set; }
        public int codUsuario { get; set; }
        public string cDescripcion { get; set; }
        public string dFechaRegistro { get; set; }
        public string dFechaAsignacion { get; set; }
        public string cPrioridadAtencion { get; set; } //char(3) --> 'ALT', 'MED', 'BAJ' (alta, media, baja)

        //Tipo Requerimiento
        public string cDescripcionTipo { get; set; }
        public bool bActivo { get; set; }

    }
}