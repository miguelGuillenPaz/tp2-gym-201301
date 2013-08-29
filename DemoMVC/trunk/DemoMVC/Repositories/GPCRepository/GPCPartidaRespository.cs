using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DemoMVC;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCPartidaRespository
    {
        GPCEntities contexto = new GPCEntities();

        public IQueryable<Partida> Partidas
        {
            get
            {
                return contexto.Partida;
            }
        }

        public IQueryable<DetallePartida> DetallePartidas
        {
            get
            {
                return contexto.DetallePartida;
            }
        }

        public IQueryable<Categoria> Categorias
        {
            get
            {
                return contexto.Categoria;
            }
        }

        public IQueryable<APU> APUs
        {
            get
            {
                return contexto.APU;
            }
        }
    }
}