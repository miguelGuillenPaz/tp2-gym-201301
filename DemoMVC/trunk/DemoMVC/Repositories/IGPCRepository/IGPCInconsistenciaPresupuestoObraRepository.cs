using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public interface IGPCInconsistenciaPresupuestoObraRepository
    {
        IQueryable<GPC_InconsistenciaPresupuestoObra> Inconsistencias { get; }
        void ActualizarInconsistencias(GPC_InconsistenciaPresupuestoObra Inconsistencias);  
    }
}