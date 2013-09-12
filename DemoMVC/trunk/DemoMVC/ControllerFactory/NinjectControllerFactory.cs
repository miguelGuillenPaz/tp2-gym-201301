using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Ninject;
using System.Web.Mvc;
using System.Web.Routing;
using GYM.SIC.GPC.Repositories.GPCRepository;

namespace DemoMVC.ControllerFactory
{
    public class NinjectControllerFactory : DefaultControllerFactory
    {
        private IKernel ninjectKernel;
        public NinjectControllerFactory()
        {
            ninjectKernel = new StandardKernel();
            AddBindings();
        }
        protected override IController GetControllerInstance(RequestContext requestContext,
        Type controllerType)
        {
            return controllerType == null
            ? null
            : (IController)ninjectKernel.Get(controllerType);
        }
        private void AddBindings()
        {
            ninjectKernel.Bind<IGPCCronogramaRepository>().To<GPCCronogramaRepository>();
            ninjectKernel.Bind<IGPCExpedienteTecnicoRepository>().To<GPCExpedienteTecnicoRepository>();
            ninjectKernel.Bind<IGPCHistoricoAprobacionesRepository>().To<GPCHistoricoAprobacionesRepository>();
            ninjectKernel.Bind<IGPCNotificacionesRepository>().To<GPCNotificacionesRepository>();
            ninjectKernel.Bind<IGPCPartidaRespository>().To<GPCPartidaRespository>();
            ninjectKernel.Bind<IGPCPresupuestoRepository>().To<GPCPresupuestoRepository>();
            ninjectKernel.Bind<IGPCSolicitudesRepository>().To<GPCSolicitudesRepository>();
            ninjectKernel.Bind<IGPCInconsistenciaPresupuestoObraRepository>().To<GPCInconsistenciaPresupuestoObraRepository>();
        }
    }
}