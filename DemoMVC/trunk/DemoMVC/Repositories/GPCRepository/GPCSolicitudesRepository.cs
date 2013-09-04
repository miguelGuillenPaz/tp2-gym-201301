using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCSolicitudesRepository
    {
        GPC_Entities contexto = new GPC_Entities();

        public IQueryable<GPC_Solicitud> Solicitudes
        {
            get
            {
                return contexto.GPC_Solicitud;
            }
        }

        public void ActualizarSolicitudes(GPC_Solicitud Solicitudes)
        {
            if (Solicitudes.IDSolicitud == 0)
            {
                contexto.GPC_Solicitud.AddObject(Solicitudes);
            }
            contexto.SaveChanges();
        } 

    }
}