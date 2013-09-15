using System;
using System.Collections.Generic;
using GYM.SIG.DataAccess;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;

namespace GYM.SIG.Business
{
    public class ParteDiarioCN : Singleton<ParteDiarioCN>
    {

        public List<ParteDiario> ListarTodos()
        {
            try
            {
                var lista = ParteDiaariodalc.Instancia.ListarTodos();                
                return lista;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

    }
}
