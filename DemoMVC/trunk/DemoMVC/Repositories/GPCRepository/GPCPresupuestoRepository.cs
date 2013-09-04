using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GYM.SIC.GPC.Models;
using GYM.SIC.GPC.Repositories.S10Repository;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCPresupuestoRepository
    {
        Entities contexto = new Entities();

        S10PresupuestoRepository S10PresupuestoRepository = new S10PresupuestoRepository();

        public IQueryable<Presupuesto> Presupuestos
        {
            get
            {
                return contexto.Presupuesto;
            }
        }

        public void ActualizarPresupuesto(Presupuesto Presupuesto)
        {
            if (Presupuesto.ID == 0)
            {
                contexto.Presupuesto.AddObject(Presupuesto);
            }
            contexto.SaveChanges();
        }

        public List<PresupuestoModel> PresupuestosModel
        {
            get
            {
                var presupuestosModel = new List<PresupuestoModel>();

                var S10presupuestos = S10PresupuestoRepository.Presupuestos;

                S10presupuestos.ToList().ForEach((S10Presupuesto) =>
                {

                    var presupuestoModel = new PresupuestoModel();
                    var presupuesto = this.Presupuestos.Where(x => x.Numero == S10Presupuesto.Numero).FirstOrDefault();

                    if (presupuesto == null)
                    {
                        presupuesto = new Presupuesto
                        {
                            Numero = S10Presupuesto.Numero,
                        };

                        ActualizarPresupuesto(presupuesto);
                    }

                    presupuestoModel.Cliente = S10Presupuesto.S10Cliente.RazonSocial;
                    presupuestoModel.Direccion = S10Presupuesto.S10Obra.Direccion;
                    presupuestoModel.FechaFin = S10Presupuesto.FechaFin;
                    presupuestoModel.FechaInicio = S10Presupuesto.FechaInicio;
                    presupuestoModel.FechaCambioEstado = S10Presupuesto.FechaRegistro;
                    presupuestoModel.Nombre = S10Presupuesto.Nombre;
                    presupuestoModel.Numero = S10Presupuesto.Numero;
                    presupuestoModel.FechaCambioEstado = presupuesto.FechaCambioEstado;
                    presupuestoModel.UsuarioCambioEstado = presupuesto.UsuarioCambioEstado;
                    presupuestoModel.TotalPresupuestado = S10Presupuesto.TotalPresupuesto;
                    presupuestoModel.FechaRegistro = S10Presupuesto.FechaRegistro;
                    presupuestoModel.ID = presupuesto.ID;
                    presupuestoModel.IDEstado = presupuesto.IDEstado;
                    presupuestosModel.Add(presupuestoModel);

                });

                return presupuestosModel;
            }
        }

    }
}