using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GYM.SIC.GPC.Models;
using GYM.SIC.GPC.Repositories.S10Repository;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public interface IGPCPresupuestoRepository
    {
        IQueryable<GPC_PresupuestoObra> Presupuestos { get; }
        void ActualizarPresupuesto(GPC_PresupuestoObra Presupuesto);
        GPC_PresupuestoObra PresupuestoObraPorID(int IDPresupuestoObra); 
    }
}