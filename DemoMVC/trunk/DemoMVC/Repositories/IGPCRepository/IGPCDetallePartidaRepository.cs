using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GYM.SIC.GPC.Models;
using GYM.SIC.GPC.Repositories.S10Repository;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public interface IGPCDetallePartidaRepository
    {
        IQueryable<GPC_DetallePartida> DetallesPartida { get; }
        IQueryable<GetDetallesPartida_Result> DetallePartida(string strFechaAvance);
        IQueryable<GetUsuarios_Result> Usuarios();
        IQueryable<GPC_AvancePartida> AvancePartida { get; }
        IQueryable<GetInconsistenciaPartida_Result> InconsistenciaPartida(int idPartida, string fecha);
        IQueryable<GPC_InconsistenciaAvancePartida> InconsistenciaAvancePartida { get; }
        GPC_InconsistenciaAvancePartida GetInconsistenciaAvancePartida(int idAvancePartida);

        void CrearAvancePartida(GPC_AvancePartida AvancePartida);
        void ActualizarInconsistenciaPartida(GPC_InconsistenciaAvancePartida InconsistenciaPartida);
    }
}