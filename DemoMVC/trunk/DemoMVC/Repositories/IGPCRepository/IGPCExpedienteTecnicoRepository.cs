using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public interface IGPCExpedienteTecnicoRepository
    {
        IQueryable<GPC_ExpedienteTecnico> ExpedienteTecnico { get; }
        void ActualizarExpedienteTecnico(GPC_ExpedienteTecnico ExpedienteTecnico);   
    }
}
