using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCHistoricoAprobacionesRepository
    {
        Entities contexto = new Entities();

        public IQueryable<HistoricoAprobaciones> HistoricoAprobaciones
        {
            get
            {
                return contexto.HistoricoAprobaciones;
            }
        }

        public void ActualizarHistoricoAprobaciones(HistoricoAprobaciones HistoricoAprobaciones)
        {
            if (HistoricoAprobaciones.ID == 0)
            {
                contexto.HistoricoAprobaciones.AddObject(HistoricoAprobaciones);
            }
            contexto.SaveChanges();
        } 

    }
}