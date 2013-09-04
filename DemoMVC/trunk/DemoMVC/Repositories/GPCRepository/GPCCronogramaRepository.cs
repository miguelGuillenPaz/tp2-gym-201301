using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCCronogramaRepository
    {
        Entities contexto = new Entities();

        public IQueryable<Cronograma> Cronogramas
        {
            get
            {
                return contexto.Cronograma;
            }
        }

        public IQueryable<Actividad> Actividades
        {
            get
            {
                return contexto.Actividad;
            }
        }
    }
}