using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCSolicitudesRepository
    {
        Entities contexto = new Entities();

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