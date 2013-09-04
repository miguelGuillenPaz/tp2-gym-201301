using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCNotificacionesRepository
    {
        Entities contexto = new Entities();

        public IQueryable<Notificaciones> Notificaciones
        {
            get
            {
                return contexto.Notificaciones;
            }
        }
        
        public void ActualizarNotificaciones(Notificaciones Notificaciones)
        {
            if (Notificaciones.ID == 0)
            {
                contexto.Notificaciones.AddObject(Notificaciones);
            }
            contexto.SaveChanges();
        } 

    }
}