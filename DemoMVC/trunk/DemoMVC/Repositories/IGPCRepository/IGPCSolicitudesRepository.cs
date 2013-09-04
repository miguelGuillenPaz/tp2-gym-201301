using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public interface IGPCSolicitudesRepository
    {
        IQueryable<GPC_Solicitud> Solicitudes { get; } 
        void ActualizarSolicitudes(GPC_Solicitud Solicitudes); 
    }
}