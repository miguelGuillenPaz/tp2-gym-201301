using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DemoMVC;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.S10Repository
{
    public class S10PresupuestoRepository
    {
        S10_Entities contexto = new S10_Entities();

        public IQueryable<S10Presupuesto> Presupuestos
        {
            get
            {
                return contexto.S10Presupuesto;
            }
        }

        public void ActualizarPresupuesto(S10Presupuesto Presupuesto)
        {
            if (Presupuesto.ID == 0)
            {
                contexto.S10Presupuesto.AddObject(Presupuesto);
            }
            contexto.SaveChanges();
        }

        public IQueryable<S10Obra> Obras
        {
            get
            {
                return contexto.S10Obra;
            }
        }

        public IQueryable<S10Cliente> Clientes
        {
            get
            {
                return contexto.S10Cliente;
            }
        }

    }
}