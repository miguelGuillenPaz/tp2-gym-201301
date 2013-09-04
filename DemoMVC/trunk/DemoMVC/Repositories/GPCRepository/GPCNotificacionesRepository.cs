using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCNotificacionesRepository : IGPCNotificacionesRepository
    {
        GPC_Entities contexto = new GPC_Entities();
        
        public IQueryable<GPC_Notificacion> Notificaciones
        {
            get
            {
                return contexto.GPC_Notificacion;
            }
        }

        public void ActualizarNotificaciones(GPC_Notificacion Notificaciones)
        {
            if (Notificaciones.IDNotificacion == 0)
            {
                contexto.GPC_Notificacion.AddObject(Notificaciones);
            }
            contexto.SaveChanges();
        } 

    }
}