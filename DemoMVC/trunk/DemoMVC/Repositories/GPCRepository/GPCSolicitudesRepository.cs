using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DemoMVC;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCSolicitudesRepository
    {
        GPC_Entities contexto = new GPC_Entities();

        public IQueryable<Solicitudes> Solicitudes
        {
            get
            {
                return contexto.Solicitudes;
            }
        }

        public void ActualizarSolicitudes(Solicitudes Solicitudes)
        {
            if (Solicitudes.ID == 0)
            {
                contexto.Solicitudes.AddObject(Solicitudes);
            }
            contexto.SaveChanges();
        } 

    }
}