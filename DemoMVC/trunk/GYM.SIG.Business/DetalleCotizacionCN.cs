using System;
using System.Collections.Generic;
using GYM.SIG.DataAccess;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;

namespace GYM.SIG.Business
{
    public class DetalleCotizacionCN : Singleton<DetalleCotizacionCN>
    {

        public List<DetalleCotizacion> listartodos()
        {
            try
            {
                return DetalleCotizaciondalc.Instancia.ListarTodos();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual DetalleCotizacion ObtenerPorSolicitud(int codSolCotizacion, int codSolDet)
        {
            try
            {
                return DetalleCotizaciondalc.Instancia.GetByPrimaryKey(codSolCotizacion, codSolDet);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual DetalleCotizacion GetByPrimaryKey(Int32 codCotizacion, Int32 codCotDet)
        {
            try
            {
                return DetalleCotizaciondalc.Instancia.GetByPrimaryKey(codCotizacion, codCotDet);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<DetalleCotizacion> Getcoleccion(string wheresql, string orderbysql)
        {
            try
            {
                return DetalleCotizaciondalc.Instancia.Getcoleccion(wheresql, orderbysql);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual int Insert(DetalleCotizacion DetalleCotizacion)
        {
            try
            {
                return DetalleCotizaciondalc.Instancia.Insert(DetalleCotizacion);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual void Update(DetalleCotizacion DetalleCotizacion)
        {
            try
            {
                DetalleCotizaciondalc.Instancia.Update(DetalleCotizacion);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

    }
}
