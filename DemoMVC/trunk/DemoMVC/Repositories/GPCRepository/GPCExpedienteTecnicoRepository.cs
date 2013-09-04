using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCExpedienteTecnicoRepository
    {
         Entities contexto = new Entities();

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
