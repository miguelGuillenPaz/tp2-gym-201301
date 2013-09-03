using System;
using System.Collections.Generic;
using GYM.SIG.DataAccess;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;

namespace GYM.SIG.Business
{
    public class SolicitudCotizacionCN : Singleton<SolicitudCotizacionCN>
    {

        public virtual int GrabarSolicitud(SolicitudCotizacion SolicitudCotizacion, List<SolicitudProveedorTipoServicio> proveedoresSolicitud, List<DetalleSolicitudRequerimiento> requerimientosSolicitud)
        {
            try
            {
                return SolicitudCotizaciondalc.Instancia.GrabarSolicitud(SolicitudCotizacion, proveedoresSolicitud, requerimientosSolicitud);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<SolicitudCotizacion> ObtenerSolicitudes(String tipoFecha, DateTime fechaInicio, DateTime fechaFin, int codPro, int codTServ, int codEstado, int codSolCotizacion, int codReq, int filtrarEstado = -1)
        {
            try
            {
                return SolicitudCotizaciondalc.Instancia.ObtenerSolicitudes(tipoFecha, fechaInicio, fechaFin, codPro, codTServ, codEstado, codSolCotizacion, codReq, filtrarEstado);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<SolicitudCotizacion> listartodos()
        {
            try
            {
                return SolicitudCotizaciondalc.Instancia.listartodos();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual SolicitudCotizacion GetByPrimaryKey(Int32 codSolCotizacion)
        {
            try
            {
                return SolicitudCotizaciondalc.Instancia.GetByPrimaryKey(codSolCotizacion);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<SolicitudCotizacion> Getcoleccion(string wheresql, string orderbysql)
        {
            try
            {
                return SolicitudCotizaciondalc.Instancia.Getcoleccion(wheresql, orderbysql);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual int Insert(SolicitudCotizacion SolicitudCotizacion)
        {
            try
            {
                return SolicitudCotizaciondalc.Instancia.Insert(SolicitudCotizacion);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual bool CambiarEstado(int codSolCotizacion, int codEstado)
        {
            try
            {
                return SolicitudCotizaciondalc.Instancia.CambiarEstado(codSolCotizacion, codEstado);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual int Update(SolicitudCotizacion SolicitudCotizacion)
        {
            try
            {
                return SolicitudCotizaciondalc.Instancia.Update(SolicitudCotizacion);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

    }
}
