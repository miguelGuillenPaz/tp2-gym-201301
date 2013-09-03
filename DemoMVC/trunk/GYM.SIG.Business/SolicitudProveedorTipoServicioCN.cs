using System;
using System.Collections.Generic;
using GYM.SIG.DataAccess;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;

namespace GYM.SIG.Business
{
    public class SolicitudProveedorTipoServicioCN : Singleton<SolicitudProveedorTipoServicioCN>
    {

        public List<SolicitudProveedorTipoServicio> listarporSolicitud(int codSolCotizacion, int codTServ, int codProv)
        {
            try
            {
                return SolicitudProveedorTipoServiciodalc.Instancia.listarporSolicitud(codSolCotizacion, codTServ, codProv);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<SolicitudProveedorTipoServicio> listartodos()
        {
            try
            {
                return SolicitudProveedorTipoServiciodalc.Instancia.listartodos();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual SolicitudProveedorTipoServicio GetByPrimaryKey(Int32 codSolCotizacion, Int32 codProv, Int32 codTServ)
        {
            try
            {
                return SolicitudProveedorTipoServiciodalc.Instancia.GetByPrimaryKey(codSolCotizacion, codProv, codTServ);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<SolicitudProveedorTipoServicio> Getcoleccion(string wheresql, string orderbysql)
        {
            try
            {
                return SolicitudProveedorTipoServiciodalc.Instancia.Getcoleccion(wheresql, orderbysql);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual int Insert(SolicitudProveedorTipoServicio SolicitudProveedorTipoServicio)
        {
            try
            {
                return SolicitudProveedorTipoServiciodalc.Instancia.Insert(SolicitudProveedorTipoServicio);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual void Update(SolicitudProveedorTipoServicio SolicitudProveedorTipoServicio)
        {
            try
            {
                SolicitudProveedorTipoServiciodalc.Instancia.Update(SolicitudProveedorTipoServicio);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

    }
}
