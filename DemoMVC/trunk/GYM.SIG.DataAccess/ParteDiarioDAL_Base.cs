using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GYM.SIG.DataAccess
{
    public class ParteDiaariodalc : Singleton<ParteDiaariodalc>
    {
  
        private readonly Database _db = DatabaseFactory.CreateDatabase();


        public List<ParteDiario> ListarTodos()
        {
            try
            {
                var coleccion = new List<ParteDiario>();
                var sql = _db.GetStoredProcCommand("pa_GSC_ParteDiario");
                
                using (var lector = _db.ExecuteReader(sql))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new ParteDiario
                        {
                            IdParteDiario = lector.GetInt32(lector.GetOrdinal("IdParteDiario")),
                            IdProyecto = lector.GetInt32(lector.GetOrdinal("IdProyecto")),
                            IdRequerimiento = lector.GetInt32(lector.GetOrdinal("IdRequerimiento")),
                            IdCorDetReq = lector.GetInt32(lector.GetOrdinal("IdCorDetReq")),
                            Fecha =  lector.GetDateTime(lector.GetOrdinal("Fecha")),                                                        
                            HoraInicio = lector.IsDBNull(lector.GetOrdinal("HoraInicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("HoraInicio")),
                            HoraFin = lector.IsDBNull(lector.GetOrdinal("HoraFin")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("HoraFin")),
                            Observacion = lector.IsDBNull(lector.GetOrdinal("Observacion")) ? default(String) : lector.GetString(lector.GetOrdinal("Observacion")),
                            DescripTServicio = lector.IsDBNull(lector.GetOrdinal("DescripTServicio")) ? default(String) : lector.GetString(lector.GetOrdinal("DescripTServicio")),
                            DescripSolDetalle = lector.IsDBNull(lector.GetOrdinal("DescripSolDetalle")) ? default(String) : lector.GetString(lector.GetOrdinal("DescripSolDetalle")),
                            DescripProyecto = lector.IsDBNull(lector.GetOrdinal("Nombre")) ? default(String) : lector.GetString(lector.GetOrdinal("Nombre")),
                            DescripEstado = lector.IsDBNull(lector.GetOrdinal("DescripEstado")) ? default(String) : lector.GetString(lector.GetOrdinal("DescripEstado"))
                        });
                    }
                }
                sql.Dispose();
                return coleccion;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }



    }
}
