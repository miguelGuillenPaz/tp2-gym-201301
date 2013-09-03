using System;
using System.Collections.Generic;
using GYM.SIG.DataAccess;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;

namespace GYM.SIG.Business
{
    public class ProyectoCN : Singleton<ProyectoCN>
    {

        public List<Proyecto> listartodos(bool seleccione = false)
        {
            try
            {
                var lista = Proyectodalc.Instancia.listartodos();
                if (seleccione)
                {
                    lista.Insert(0, new Proyecto { codPro = 0, nomPro = "- Seleccione -" });
                }
                return lista;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual Proyecto GetByPrimaryKey(int codPro)
        {
            try
            {
                return Proyectodalc.Instancia.GetByPrimaryKey(codPro);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<Proyecto> Getcoleccion(string wheresql, string orderbysql)
        {
            try
            {
                return Proyectodalc.Instancia.Getcoleccion(wheresql, orderbysql);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual int Insert(Proyecto Proyecto)
        {
            try
            {
                return Proyectodalc.Instancia.Insert(Proyecto);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual void Update(Proyecto Proyecto)
        {
            try
            {
                Proyectodalc.Instancia.Update(Proyecto);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

    }
}
