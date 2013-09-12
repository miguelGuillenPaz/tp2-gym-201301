using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCInconsistenciaPresupuestoObraRepository : IGPCInconsistenciaPresupuestoObraRepository
    {
        GPC_Entities contexto = new GPC_Entities();

        public IQueryable<GPC_InconsistenciaPresupuestoObra> Inconsistencias
        {
            get
            {
                return contexto.GPC_InconsistenciaPresupuestoObra;
            }
        }

        public void ActualizarInconsistencias(GPC_InconsistenciaPresupuestoObra Inconsistencias)
        {
            if (Inconsistencias.IDInconsistenciaPresupuesto == 0)
            {
                contexto.GPC_InconsistenciaPresupuestoObra.AddObject(Inconsistencias);
            }
            contexto.SaveChanges();
        } 
    }
}