using System;
using System.Collections.Generic;
using GYM.SIG.DataAccess;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;

namespace GYM.SIG.Business
{
    public class CalificacionServicioCN : Singleton<CalificacionServicioCN>
    {

        public List<CalificacionServicio> ListarTodos()
        {
            try
            {
                var lista = CalificacionServiciodalc.Instancia.ListarTodos();                
                return lista;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

    }
}
