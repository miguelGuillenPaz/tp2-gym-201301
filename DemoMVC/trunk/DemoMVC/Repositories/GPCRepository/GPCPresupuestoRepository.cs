using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GYM.SIC.GPC.Models;
using GYM.SIC.GPC.Repositories.S10Repository;
using DemoMVC;
using DemoMVC.Models;

namespace GYM.SIC.GPC.Repositories.GPCRepository
{
    public class GPCPresupuestoRepository
    {
        GPC_Entities contexto = new GPC_Entities();

        S10PresupuestoRepository S10PresupuestoRepository = new S10PresupuestoRepository();

        public IQueryable<PresupuestoObra> Presupuestos
        {
            get
            {
                return contexto.PresupuestoObra;
            }
        }

        public void ActualizarPresupuesto(PresupuestoObra Presupuesto)
        {
            if (Presupuesto.ID == 0)
            {
                contexto.PresupuestoObra.AddObject(Presupuesto);
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
                        presupuesto = new PresupuestoObra
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