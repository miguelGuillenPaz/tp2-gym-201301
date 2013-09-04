using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCCronogramaRepository
    {
        GPC_Entities contexto = new GPC_Entities();

        public IQueryable<GPC_CronogramaObra> Cronogramas
        {
            get
            {
                return contexto.GPC_CronogramaObra;
            }
        }

        public IQueryable<GPC_ActividadObra> Actividades
        {
            get
            {
                return contexto.GPC_ActividadObra;
            }
        }
    }
}