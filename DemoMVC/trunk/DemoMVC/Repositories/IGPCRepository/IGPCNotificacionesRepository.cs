using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public interface IGPCNotificacionesRepository
    {
        IQueryable<GPC_Notificacion> Notificaciones { get; }
        void ActualizarNotificaciones(GPC_Notificacion Notificaciones);  
    }
}