using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMVC.Models
{
    public class LegalRequerimientoCN
    {

        public LegalRequerimientoCN()
        {
        }

        //Req Legal CN
        public int idReqLegalCN { get; set; }
        public int idReqLegal { get; set; }
        public int idCNVecino { get; set; }
        public string cTipoEdificacion { get; set; }
        public string cNombreCondominio { get; set; }
        public string cDireccion { get; set; }
        public int idDepartamento { get; set; }
        public int idProvincia { get; set; }
        public int idDistrito { get; set; }
        public bool bVisitado { get; set; }
        public string cFechaVisita { get; set; }

        //CN Vecino Colindante
        public string cNombreVecino { get; set; }
        public string cApellidoVecino { get; set; }
        public short idDocIdentidadTipo { get; set; }
        public string cNroDocIdentidad { get; set; }

        //Carta Notarial
        public int idCN { get; set; }
        public string cFechaRecepcion { get; set; }
        public string cFechaRespuesta { get; set; }

    }
}