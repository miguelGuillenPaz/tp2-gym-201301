using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GYM.SIC.GPC.Parameters
{
    public static class EstadosParameters
    {
        public const int Pendiente_de_Aprobacion_por_el_Jefe_de_Obra = 1;
        public const int Pendiente_de_Aprobacion_por_el_Asesor_del_Cliente = 2;
        public const int Rechazado = 3;
        public const int En_Solicitud_de_Anulacion = 4;
        public const int Anulado = 5;
        public const int Aprobado = 6;
        public const int Con_Expediente_Tecnico = 7;
        public const int Pendiente_de_Cierre_por_el_Supervisor_de_Presupuesto = 8;
        public const int Cerrado_por_el_Supervisor_de_Presupuesto = 9;
        
    }
}