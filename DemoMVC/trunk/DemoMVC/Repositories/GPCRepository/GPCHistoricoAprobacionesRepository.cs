using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCHistoricoAprobacionesRepository
    {
        GPC_Entities contexto = new GPC_Entities();

        public IQueryable<GPC_HistoricoAprobacion> HistoricoAprobaciones
        {
            get
            {
                return contexto.GPC_HistoricoAprobacion;
            }
        }

        public void ActualizarHistoricoAprobaciones(GPC_HistoricoAprobacion HistoricoAprobaciones)
        {
            if (HistoricoAprobaciones.IDHistoricoAprobacion == 0)
            {
                contexto.GPC_HistoricoAprobacion.AddObject(HistoricoAprobaciones);
            }
            contexto.SaveChanges();
        } 

    }
}