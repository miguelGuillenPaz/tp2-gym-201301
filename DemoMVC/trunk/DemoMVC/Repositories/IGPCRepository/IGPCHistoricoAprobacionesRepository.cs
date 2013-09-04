using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public interface IGPCHistoricoAprobacionesRepository
    {
        IQueryable<GPC_HistoricoAprobacion> HistoricoAprobaciones { get; }
        void ActualizarHistoricoAprobaciones(GPC_HistoricoAprobacion HistoricoAprobaciones);   
    }
}