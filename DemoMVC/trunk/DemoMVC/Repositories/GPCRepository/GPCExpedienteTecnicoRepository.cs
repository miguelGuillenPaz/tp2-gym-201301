using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCExpedienteTecnicoRepository : IGPCExpedienteTecnicoRepository
    {
        GPC_Entities contexto = new GPC_Entities();

        public IQueryable<GPC_ExpedienteTecnico> ExpedienteTecnico
        {
            get
            {
                return contexto.GPC_ExpedienteTecnico;
            }
        }

        public void ActualizarExpedienteTecnico(GPC_ExpedienteTecnico ExpedienteTecnico)
         {
             if (ExpedienteTecnico.IDExpedienteTecnico == 0)
             {
                 contexto.GPC_ExpedienteTecnico.AddObject(ExpedienteTecnico);
             }
             contexto.SaveChanges();
         }
 
    }
}
