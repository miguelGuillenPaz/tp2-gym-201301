using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DemoMVC;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCNotificacionesRepository
    {
        GPC_Entities contexto = new GPC_Entities();

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