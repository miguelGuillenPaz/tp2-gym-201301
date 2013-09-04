using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public interface IGPCCronogramaRepository
    {
        IQueryable<GPC_CronogramaObra> Cronogramas { get; }
        IQueryable<GPC_ActividadObra> Actividades { get; }  
    }
}