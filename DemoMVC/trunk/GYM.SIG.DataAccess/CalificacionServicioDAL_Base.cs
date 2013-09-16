using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GYM.SIG.DataAccess
{
    public class CalificacionServiciodalc : Singleton<CalificacionServiciodalc>
    {
  
        private readonly Database _db = DatabaseFactory.CreateDatabase();


        public List<CalificacionServicio> ListarTodos()
        {
            try
            {
                var coleccion = new List<CalificacionServicio>();
                var sql = _db.GetStoredProcCommand("pa_GSC_CalificacionServicio");
                
                using (var lector = _db.ExecuteReader(sql))
                {
                    while (lector.Read())
                    {
                        coleccion.Add(new CalificacionServicio
                        {
                            IdCalificacion = lector.GetInt32(lector.GetOrdinal("IdCalificacion")),
                            IdProyecto = lector.GetInt32(lector.GetOrdinal("IdProyecto")),
                            IdRequerimiento = lector.GetInt32(lector.GetOrdinal("IdRequerimiento")),
                            IdCorDetReq = lector.GetInt32(lector.GetOrdinal("IdCorDetReq")),                            
                            Fecha = lector.IsDBNull(lector.GetOrdinal("FechaCalificacion")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaCalificacion")),                            
                            FechaFin = lector.IsDBNull(lector.GetOrdinal("FechaFinServicio")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaFinServicio")),                            
                            Observacion = lector.IsDBNull(lector.GetOrdinal("Observacion")) ? default(String) : lector.GetString(lector.GetOrdinal("Observacion")),
                            IdEstado = lector.GetInt32(lector.GetOrdinal("IdEstado")),
                            DescripTServicio = lector.IsDBNull(lector.GetOrdinal("DescripTServicio")) ? default(String) : lector.GetString(lector.GetOrdinal("DescripTServicio")),
                            DescripSolDetalle = lector.IsDBNull(lector.GetOrdinal("DescripSolDetalle")) ? default(String) : lector.GetString(lector.GetOrdinal("DescripSolDetalle")),
                            DescripProyecto = lector.IsDBNull(lector.GetOrdinal("Nombre")) ? default(String) : lector.GetString(lector.GetOrdinal("Nombre")),
                            DescripEstado = lector.IsDBNull(lector.GetOrdinal("DescripEstado")) ? default(String) : lector.GetString(lector.GetOrdinal("DescripEstado")),
                            IdPuntualidad = lector.GetInt32(lector.GetOrdinal("IdParametroCalificacionPuntualidad")),
                            IdCalidad = lector.GetInt32(lector.GetOrdinal("IdParametroCalificacionCalidad")),
                            IdIncidencia = lector.GetInt32(lector.GetOrdinal("IdParametroCalificacionIncidencia"))
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
