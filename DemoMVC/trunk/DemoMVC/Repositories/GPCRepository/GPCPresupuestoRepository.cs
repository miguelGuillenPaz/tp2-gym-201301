using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GYM.SIC.GPC.Models;
using GYM.SIC.GPC.Repositories.S10Repository;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCPresupuestoRepository : IGPCPresupuestoRepository
    {
        GPC_Entities contexto = new GPC_Entities();

        public IQueryable<GPC_PresupuestoObra> Presupuestos
        {
            get
            {
                return contexto.GPC_PresupuestoObra;
            }
        }

        public void ActualizarPresupuesto(GPC_PresupuestoObra Presupuesto)
        {
            if (Presupuesto.IDPresupuestoObra == 0)
            {
                contexto.GPC_PresupuestoObra.AddObject(Presupuesto);
            }
            contexto.SaveChanges();
        }

        public GPC_PresupuestoObra PresupuestoObraPorID(int ID)
        {
            return Presupuestos.Where(x => x.IDPresupuestoObra == ID).ToList().FirstOrDefault();
        }
    }
}