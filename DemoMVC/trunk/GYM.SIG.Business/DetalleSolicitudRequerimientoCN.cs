using System;
using System.Collections.Generic;
using GYM.SIG.DataAccess;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;

namespace GYM.SIG.Business
{
    public class DetalleSolicitudRequerimientoCN : Singleton<DetalleSolicitudRequerimientoCN>
    {

        public List<DetalleSolicitudRequerimiento> ObtenerPorcodSolCotizacion(Int32 codSolCotizacion, int codCotizacion)
        {
            try
            {
                var detalles = DetalleSolicitudRequerimientodalc.Instancia.ObtenerPorcodSolCotizacion(codSolCotizacion, codCotizacion);
                detalles.ForEach(de => de.importe = de.precio * de.canDetReq);
                return detalles;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<DetalleSolicitudRequerimiento> listartodos()
        {
            try
            {
                return DetalleSolicitudRequerimientodalc.Instancia.listartodos();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual DetalleSolicitudRequerimiento GetByPrimaryKey(Int32 codSolCotizacion, Int32 codSolDet)
        {
            try
            {
                return DetalleSolicitudRequerimientodalc.Instancia.GetByPrimaryKey(codSolCotizacion, codSolDet);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<DetalleSolicitudRequerimiento> Getcoleccion(string wheresql, string orderbysql)
        {
            try
            {
                return DetalleSolicitudRequerimientodalc.Instancia.Getcoleccion(wheresql, orderbysql);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual int Insert(DetalleSolicitudRequerimiento DetalleSolicitudRequerimiento)
        {
            try
            {
                return DetalleSolicitudRequerimientodalc.Instancia.Insert(DetalleSolicitudRequerimiento);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual void Update(DetalleSolicitudRequerimiento DetalleSolicitudRequerimiento)
        {
            try
            {
                DetalleSolicitudRequerimientodalc.Instancia.Update(DetalleSolicitudRequerimiento);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

    }
}
