using System;
using System.Collections.Generic;
using GYM.SIG.DataAccess;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;

namespace GYM.SIG.Business
{
      public class DetalleRequerimientoCN : Singleton<DetalleRequerimientoCN>
    {
          public List<DetalleRequerimiento> RequerimientoPorProyecto(int idProyecto)
          {
              try
              {
                  return DetalleRequerimientodalc.Instancia.RequerimientoPorProyecto(idProyecto);
              }
              catch (Exception ex)
              {
                  throw new Exception(ex.Message);
              }
          }

        public List<DetalleRequerimiento> listaporSolicitud(int codSolCotizacion)
        {
            try
            {
                return DetalleRequerimientodalc.Instancia.listaporSolicitud(codSolCotizacion);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<DetalleRequerimiento> listarPendientes(int codPro, int codTServ, int codReq)
        {
            try
            {
                return DetalleRequerimientodalc.Instancia.listarPendientes(codPro, codTServ, codReq);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<DetalleRequerimiento> listartodos()
        {
            try
            {
                return DetalleRequerimientodalc.Instancia.listartodos();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual DetalleRequerimiento GetByPrimaryKey(Int32 codPro, Int32 codReq, Int32 codcorDetReq)
        {
            try
            {
                return DetalleRequerimientodalc.Instancia.GetByPrimaryKey(codPro, codReq, codcorDetReq);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<DetalleRequerimiento> Getcoleccion(string wheresql, string orderbysql)
        {
            try
            {
                return DetalleRequerimientodalc.Instancia.Getcoleccion(wheresql, orderbysql);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual int Insert(DetalleRequerimiento DetalleRequerimiento)
        {
            try
            {
                return DetalleRequerimientodalc.Instancia.Insert(DetalleRequerimiento);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual void Update(DetalleRequerimiento DetalleRequerimiento)
        {
            try
            {
                DetalleRequerimientodalc.Instancia.Update(DetalleRequerimiento);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

    }
}

