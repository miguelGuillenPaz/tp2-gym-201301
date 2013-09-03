using System;
using System.Collections.Generic;
using GYM.SIG.DataAccess;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;

namespace GYM.SIG.Business
{
    public class MonedaCN : Singleton<MonedaCN>
    {

        public List<Moneda> listartodos()
        {
            try
            {
                return Monedadalc.Instancia.listartodos();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual Moneda GetByPrimaryKey(Int32 codMoneda)
        {
            try
            {
                return Monedadalc.Instancia.GetByPrimaryKey(codMoneda);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<Moneda> Getcoleccion(string wheresql, string orderbysql)
        {
            try
            {
                return Monedadalc.Instancia.Getcoleccion(wheresql, orderbysql);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual int Insert(Moneda Moneda)
        {
            try
            {
                return Monedadalc.Instancia.Insert(Moneda);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual void Update(Moneda Moneda)
        {
            try
            {
                Monedadalc.Instancia.Update(Moneda);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

    }
}
