using System;
using System.Collections.Generic;
using GYM.SIG.DataAccess;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;

namespace GYM.SIG.Business
{
    public class TipoServicioCN : Singleton<TipoServicioCN>
    {

        public List<TipoServicio> ListarTipoServicioPorProyectoYRequerimiento(int idProyecto, int idRequerimiento)
        {
            try
            {                
                return TipoServiciodalc.Instancia.ListarTipoServicioPorProyectoYRequerimiento(idProyecto,idRequerimiento);;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<TipoServicio> listartodos(bool seleccione = false)
        {
            try
            {
                var lista = TipoServiciodalc.Instancia.listartodos();
                if (seleccione)
                {
                    lista.Insert(0, new TipoServicio { codTServ = 0, descTServ = "- Seleccione -" });
                }
                return lista;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual TipoServicio GetByPrimaryKey(Int32 codTServ)
        {
            try
            {
                return TipoServiciodalc.Instancia.GetByPrimaryKey(codTServ);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<TipoServicio> Getcoleccion(string wheresql, string orderbysql)
        {
            try
            {
                return TipoServiciodalc.Instancia.Getcoleccion(wheresql, orderbysql);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual int Insert(TipoServicio TipoServicio)
        {
            try
            {
                return TipoServiciodalc.Instancia.Insert(TipoServicio);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual void Update(TipoServicio TipoServicio)
        {
            try
            {
                TipoServiciodalc.Instancia.Update(TipoServicio);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

    }
}
