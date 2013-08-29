using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DemoMVC;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCCronogramaRepository
    {
        GPCEntities contexto = new GPCEntities();

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