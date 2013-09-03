using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DemoMVC;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCExpedienteTecnicoRepository
    {
        GPC_Entities contexto = new GPC_Entities();

         public IQueryable<ExpedienteTecnico> ExpedienteTecnico
        {
            get
            {
                return contexto.ExpedienteTecnico;
            }
        }

         public void ActualizarExpedienteTecnico(ExpedienteTecnico ExpedienteTecnico)
         {
             if (ExpedienteTecnico.ID == 0)
             {
                 contexto.ExpedienteTecnico.AddObject(ExpedienteTecnico);
             }
             contexto.SaveChanges();
         }
 
    }
}
