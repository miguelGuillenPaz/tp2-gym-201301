using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public interface IGPCPartidaRespository
    {
        IQueryable<GPC_Partida> Partidas { get; }
        IQueryable<GPC_DetallePartida> DetallePartidas { get; }
        IQueryable<GPC_Categoria> Categorias { get; }
        IQueryable<GPC_APU> APUs { get; }

        GPC_Partida PartidaPorID(int ID);    
    }
}