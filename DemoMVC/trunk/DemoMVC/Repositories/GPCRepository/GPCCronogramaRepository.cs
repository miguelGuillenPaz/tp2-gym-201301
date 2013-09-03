using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DemoMVC;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCCronogramaRepository
    {
        GPC_Entities contexto = new GPC_Entities();

        public IQueryable<Cronograma> Cronogramas
        {
            get
            {
                return contexto.Cronograma;
            }
        }

        public IQueryable<ActividadObra> Actividades
        {
            get
            {
                return contexto.ActividadObra;
            }
        }
    }
}