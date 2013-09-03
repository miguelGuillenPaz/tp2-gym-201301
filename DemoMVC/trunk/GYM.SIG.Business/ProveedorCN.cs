using System;
using System.Collections.Generic;
using GYM.SIG.DataAccess;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;

namespace GYM.SIG.Business
{
    public class ProveedorCN : Singleton<ProveedorCN>
    {

        public List<Proveedor> listaporSolicitud(int codSolCotizacion)
        {
            try
            {
                return Proveedordalc.Instancia.listaporSolicitud(codSolCotizacion);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<Proveedor> listaporServicio(String tipoBusqueda, String expresion, int codTServ)
        {
            try
            {
                return Proveedordalc.Instancia.listaporServicio(tipoBusqueda, expresion, codTServ);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<Proveedor> listartodos()
        {
            try
            {
                return Proveedordalc.Instancia.listartodos();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual Proveedor GetByPrimaryKey(Int32 codProv)
        {
            try
            {
                return Proveedordalc.Instancia.GetByPrimaryKey(codProv);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<Proveedor> Getcoleccion(string wheresql, string orderbysql)
        {
            try
            {
                return Proveedordalc.Instancia.Getcoleccion(wheresql, orderbysql);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual int Insert(Proveedor Proveedor)
        {
            try
            {
                return Proveedordalc.Instancia.Insert(Proveedor);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual void Update(Proveedor Proveedor)
        {
            try
            {
                Proveedordalc.Instancia.Update(Proveedor);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

    }
}
