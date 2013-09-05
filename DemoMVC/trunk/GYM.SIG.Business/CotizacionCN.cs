using System;
using System.Collections.Generic;
using GYM.SIG.DataAccess;
using GYM.SIG.Entity;
using GYM.SIG.Entity.Generics;

namespace GYM.SIG.Business
{
    public class CotizacionCN : Singleton<CotizacionCN>
    {

        public List<Cotizacion> ObtenerCotizaciones(String tipoFecha, DateTime fechaInicio, DateTime fechaFin, int codPro, int codTServ, int codEstado, int codSolCotizacion, int codProv, int codCotizacion)
        {
            try
            {
                var lista = Cotizaciondalc.Instancia.ObtenerCotizaciones(tipoFecha, fechaInicio, fechaFin, codPro, codTServ, codEstado, codSolCotizacion, codProv, codCotizacion);
                foreach (var item in lista)
                {
                    item.estadoActual = item.estado;
                    if (item.estadoActual.Equals("Creado"))
                    {
                        if (DateTime.Now.Subtract(item.fechaFin).Days > 0)
                        {
                            item.estadoActual = "Vencida";
                        }
                    }
                }
                return lista;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<Cotizacion> listartodos()
        {
            try
            {
                return Cotizaciondalc.Instancia.ListarTodos();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual Cotizacion GetByPrimaryKey(Int32 codCotizacion)
        {
            try
            {
                return Cotizaciondalc.Instancia.GetByPrimaryKey(codCotizacion);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<Cotizacion> Getcoleccion(string wheresql, string orderbysql)
        {
            try
            {
                return Cotizaciondalc.Instancia.Getcoleccion(wheresql, orderbysql);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual int Grabar(Cotizacion cotizacion, List<DetalleCotizacion> detalles)
        {
            try
            {
                return Cotizaciondalc.Instancia.Grabar(cotizacion, detalles);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual int Insert(Cotizacion Cotizacion)
        {
            try
            {
                return Cotizaciondalc.Instancia.Insert(Cotizacion);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual void CambiarEstado(int codCotizacion, int codEstado)
        {
            try
            {
                Cotizaciondalc.Instancia.CambiarEstado(codCotizacion, codEstado);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public virtual void Update(Cotizacion Cotizacion)
        {
            try
            {
                Cotizaciondalc.Instancia.Update(Cotizacion);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

    }
}
