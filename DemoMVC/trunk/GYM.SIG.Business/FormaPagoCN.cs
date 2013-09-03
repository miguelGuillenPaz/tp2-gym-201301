using System;
using System.Collections.Generic;
using GYM.SIG.DataAccess;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;

namespace GYM.SIG.Business
{
    public class FormaPagoCN : Singleton<FormaPagoCN>
    {

        public List<FormaPago> listartodos()
        {
            try
            {
                return FormaPagodalc.Instancia.listartodos();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual FormaPago GetByPrimaryKey(Int32 codFormPag)
        {
            try
            {
                return FormaPagodalc.Instancia.GetByPrimaryKey(codFormPag);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<FormaPago> Getcoleccion(string wheresql, string orderbysql)
        {
            try
            {
                return FormaPagodalc.Instancia.Getcoleccion(wheresql, orderbysql);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual int Insert(FormaPago FormaPago)
        {
            try
            {
                return FormaPagodalc.Instancia.Insert(FormaPago);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual void Update(FormaPago FormaPago)
        {
            try
            {
                FormaPagodalc.Instancia.Update(FormaPago);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

    }
}
