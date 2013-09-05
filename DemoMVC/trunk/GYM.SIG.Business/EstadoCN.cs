using System;
using System.Collections.Generic;
using GYM.SIG.DataAccess;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;

namespace GYM.SIG.Business
{
    public class EstadoCN : Singleton<EstadoCN>
    {

        public List<Estado> listartodos(String flag, bool todos = false)
        {
            try
            {
                var lista = Estadodalc.Instancia.ListarTodos(flag);
                if (todos)
                {
                    lista.Insert(0, new Estado { codEstado = 0, desEstado = "- Seleccione -" });
                }
                return lista;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual Estado GetByPrimaryKey(Int32 codEstado)
        {
            try
            {
                return Estadodalc.Instancia.GetByPrimaryKey(codEstado);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<Estado> Getcoleccion(string wheresql, string orderbysql)
        {
            try
            {
                return Estadodalc.Instancia.Getcoleccion(wheresql, orderbysql);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual int Insert(Estado Estado)
        {
            try
            {
                return Estadodalc.Instancia.Insert(Estado);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual void Update(Estado Estado)
        {
            try
            {
                Estadodalc.Instancia.Update(Estado);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

    }
}
