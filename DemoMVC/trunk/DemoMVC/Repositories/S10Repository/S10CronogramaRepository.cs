using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DemoMVC;

namespace GYM.SIC.GPC.Repositories.S10Repository
{
    public class S10CronogramaRepository
    {
        S10Entities contexto = new S10Entities();

        public IQueryable<S10Cronograma> Cronogramas
        {
            get
            {
                return contexto.S10Cronograma;
            }
        }

        public IQueryable<S10Actividad> Actividades
        {
            get
            {
                return contexto.S10Actividad;
            }
        }
    }
}