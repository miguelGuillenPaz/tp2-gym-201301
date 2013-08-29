using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DemoMVC;

namespace GYM.SIC.GPC.Repositories.S10Repository
{
    public class S10PartidaRespository
    {
        S10Entities contexto = new S10Entities();

        public IQueryable<S10Partida> Partidas
        {
            get
            {
                return contexto.S10Partida;
            }
        }

        public IQueryable<S10DetallePartida> DetallePartidas
        {
            get
            {
                return contexto.S10DetallePartida;
            }
        }

        public IQueryable<S10Categoria> Categorias
        {
            get
            {
                return contexto.S10Categoria;
            }
        }

        public IQueryable<S10APU> APUs
        {
            get
            {
                return contexto.S10APU;
            }
        }
    }
}