using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCPartidaRespository
    {
        GPC_Entities contexto = new GPC_Entities();

        public IQueryable<GPC_Partida> Partidas
        {
            get
            {
                return contexto.GPC_Partida;
            }
        }

        public IQueryable<GPC_DetallePartida> DetallePartidas
        {
            get
            {
                return contexto.GPC_DetallePartida;
            }
        }

        public IQueryable<GPC_Categoria> Categorias
        {
            get
            {
                return contexto.GPC_Categoria;
            }
        }

        public IQueryable<GPC_APU> APUs
        {
            get
            {
                return contexto.GPC_APU;
            }
        }
    }
}