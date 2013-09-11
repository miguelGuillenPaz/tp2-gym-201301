using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GYM.SIC.GPC.Models;
using GYM.SIC.GPC.Repositories.S10Repository;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCDetallePartidaRepository : IGPCDetallePartidaRepository
    {
        GPC_Entities contexto = new GPC_Entities();

        public IQueryable<GPC_DetallePartida> DetallesPartida
        {
            get
            {
                return contexto.GPC_DetallePartida;
            }
        }

        public IQueryable<GetDetallesPartida_Result> DetallePartida(string strFechaAvance)
        {                            
            return contexto.GetDetallesPartida_Result(strFechaAvance).AsQueryable();            
        }

        public IQueryable<GetUsuarios_Result> Usuarios()
        {
            return contexto.GetUsuarios_Result().AsQueryable();
        }

        public IQueryable<GPC_AvancePartida> AvancePartida
        {
            get
            {
                return contexto.GPC_AvancePartida;
            }
        }

        public void CrearAvancePartida(GPC_AvancePartida AvancePartida)
        {
            if (AvancePartida.IDAvancePartida == 0)
            contexto.GPC_AvancePartida.AddObject(AvancePartida);
            else
            {
                GPC_AvancePartida c = contexto.GPC_AvancePartida.First(i => i.IDAvancePartida == AvancePartida.IDAvancePartida);
                c.IDAvancePartida = AvancePartida.IDAvancePartida;
                c.IDEstado = AvancePartida.IDEstado;
                c.IDUsuarioEmisor = AvancePartida.IDUsuarioEmisor;
                c.IDUsuarioDestinatario = AvancePartida.IDUsuarioDestinatario;
                c.FechaRegistro = AvancePartida.FechaRegistro;
                c.CantidadEjecutada = AvancePartida.CantidadEjecutada;
                c.Observacion = AvancePartida.Observacion;
                c.FechaEjecucion = AvancePartida.FechaEjecucion;
            }
            
            contexto.SaveChanges();
        }
        
        public IQueryable<GetInconsistenciaPartida_Result> InconsistenciaPartida(int idPartida, string fecha)
        {
            return contexto.GetInconsistenciaPartida_Result(idPartida, fecha).AsQueryable();
        }

        public IQueryable<GPC_InconsistenciaAvancePartida> InconsistenciaAvancePartida
        {
            get
            {
                return contexto.GPC_InconsistenciaAvancePartida;
            }
        }

        public GPC_InconsistenciaAvancePartida GetInconsistenciaAvancePartida(int idAvancePartida)
        {
            GPC_InconsistenciaAvancePartida c = contexto.GPC_InconsistenciaAvancePartida.FirstOrDefault(i => i.IDAvancePartida == idAvancePartida);

            return c;
        }

        public void ActualizarInconsistenciaPartida(GPC_InconsistenciaAvancePartida InconsistenciaPartida)
        {
            if (InconsistenciaPartida.IDInconsistenciaAvancePartida == 0)
                contexto.GPC_InconsistenciaAvancePartida.AddObject(InconsistenciaPartida);
            else
            {
                GPC_InconsistenciaAvancePartida c = contexto.GPC_InconsistenciaAvancePartida.First(i => i.IDInconsistenciaAvancePartida == InconsistenciaPartida.IDInconsistenciaAvancePartida);                
                c.IDUsuarioJustifica = InconsistenciaPartida.IDUsuarioJustifica;                
                c.Justificacion = InconsistenciaPartida.Justificacion;
            }

            contexto.SaveChanges();
        }

    }
}