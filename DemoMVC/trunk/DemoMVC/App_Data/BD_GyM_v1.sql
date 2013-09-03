USE [GYM]
GO
/****** Object:  Table [dbo].[GRH_TipoDerechoHabiente]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_TipoDerechoHabiente](
	[IdTipoDerechoHabiente] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](30) NULL,
 CONSTRAINT [XPKGRH_TipoDerechoHabiente] PRIMARY KEY CLUSTERED 
(
	[IdTipoDerechoHabiente] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_Persona]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_Persona](
	[IdPersona] [int] IDENTITY(1,1) NOT NULL,
	[IdPaisResidencia] [int] NULL,
	[IdPaisNacionalidad] [int] NULL,
	[IdEstadoCivil] [int] NULL,
	[Nombre] [varchar](30) NULL,
	[ApellidoPaterno] [varchar](30) NULL,
	[ApellidoMaterno] [varchar](30) NULL,
	[Direccion] [varchar](150) NULL,
	[Sexo] [bit] NULL,
	[FechaNacimiento] [datetime] NULL,
 CONSTRAINT [XPKGRH_Persona] PRIMARY KEY CLUSTERED 
(
	[IdPersona] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_DerechoHabiente]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRH_DerechoHabiente](
	[IdDerechoHabiente] [int] IDENTITY(1,1) NOT NULL,
	[IdPersona] [int] NULL,
	[IdEmpleado] [int] NULL,
	[IdTipoDerechoHabiente] [int] NULL,
 CONSTRAINT [XPKGRH_DerechoHabiente] PRIMARY KEY CLUSTERED 
(
	[IdDerechoHabiente] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GRH_Empleado]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRH_Empleado](
	[IdEmpleado] [int] IDENTITY(1,1) NOT NULL,
	[IdPersona] [int] NULL,
	[IdCargo] [int] NULL,
	[IdArea] [int] NULL,
	[FechaIngreso] [datetime] NULL,
	[FechaCese] [datetime] NULL,
 CONSTRAINT [XPKGRH_Empleado] PRIMARY KEY CLUSTERED 
(
	[IdEmpleado] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GRH_EvaluacionCompetencia]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRH_EvaluacionCompetencia](
	[IdEvaluacionCompetencia] [int] NOT NULL,
	[Fecha] [datetime] NULL,
	[IdPerfil] [int] NULL,
	[IdEmpleado] [int] NULL,
 CONSTRAINT [XPKGRH_EvaluacionCompetencia] PRIMARY KEY CLUSTERED 
(
	[IdEvaluacionCompetencia] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GRH_EvaluacionCompetenciaCuestionario]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRH_EvaluacionCompetenciaCuestionario](
	[IdCuestionario] [int] NULL,
	[IdEvaluacionCompetencia] [int] NULL,
	[IdEvaluacionCompetenciaCuestionario] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [XPKGRH_EvaluacionCompetenciaCartillaCuestionario] PRIMARY KEY CLUSTERED 
(
	[IdEvaluacionCompetenciaCuestionario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GRH_CartillaCuestionario]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_CartillaCuestionario](
	[IdCuestionario] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[IdParametroCriterio] [int] NULL,
 CONSTRAINT [XPKGRH_CartillaCuestionario] PRIMARY KEY CLUSTERED 
(
	[IdCuestionario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_EvaluacionCompetenciaEvaluador]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRH_EvaluacionCompetenciaEvaluador](
	[IdCuestionario] [int] NULL,
	[IdPerfil] [int] NULL,
	[IdEvaluacionCompetencia] [int] NULL,
	[IdEvaluacionCompetenciaEvaluador] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [XPKGRH_EvaluacionCompetenciaEvaluador] PRIMARY KEY CLUSTERED 
(
	[IdEvaluacionCompetenciaEvaluador] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GRH_Perfil]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_Perfil](
	[IdPerfil] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Descripcion] [varchar](max) NULL,
 CONSTRAINT [XPKGRH_Perfil] PRIMARY KEY CLUSTERED 
(
	[IdPerfil] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_Convocatoria]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_Convocatoria](
	[IdConvocatoria] [int] IDENTITY(1,1) NOT NULL,
	[FechaInicio] [datetime] NOT NULL,
	[FechaFin] [datetime] NOT NULL,
	[Titulo] [varchar](100) NOT NULL,
	[Detalle] [varchar](max) NOT NULL,
	[CantidadVacantes] [int] NOT NULL,
	[IdPerfil] [int] NOT NULL,
 CONSTRAINT [XPKGRH_Convocatoria] PRIMARY KEY CLUSTERED 
(
	[IdConvocatoria] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_ConvocatoriaPostulante]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRH_ConvocatoriaPostulante](
	[IdConvocatoriaPostulante] [int] IDENTITY(1,1) NOT NULL,
	[FechaPostulacion] [datetime] NULL,
	[IdPostulante] [int] NULL,
	[IdConvocatoria] [int] NULL,
 CONSTRAINT [XPKGRH_ConvocatoriaPostulante] PRIMARY KEY CLUSTERED 
(
	[IdConvocatoriaPostulante] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GRH_DetallePlanEvaluacionCompetencias]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRH_DetallePlanEvaluacionCompetencias](
	[FechaIncio] [datetime] NULL,
	[FechaFin] [datetime] NULL,
	[FechaEnvio] [datetime] NULL,
	[IdPlanEvaluacionCompetencias] [int] NULL,
	[IdEvaluacionCompetencia] [int] NULL,
	[IdDetallePlanEvaluacionCompetencias] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [XPKGRH_DetallePlanEvaluacionCompetencias] PRIMARY KEY CLUSTERED 
(
	[IdDetallePlanEvaluacionCompetencias] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GRH_PlanEvaluacionCompetencias]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_PlanEvaluacionCompetencias](
	[IdPlanEvaluacionCompetencias] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](150) NULL,
	[Anho] [char](18) NULL,
 CONSTRAINT [XPKGRH_PlanEvaluacionCompetencias] PRIMARY KEY CLUSTERED 
(
	[IdPlanEvaluacionCompetencias] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_Telefono]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_Telefono](
	[IdTelefono] [int] IDENTITY(1,1) NOT NULL,
	[IdPersona] [int] NULL,
	[NumeroTelefono] [varchar](30) NULL,
 CONSTRAINT [XPKGRH_Telefono] PRIMARY KEY CLUSTERED 
(
	[IdTelefono] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_Postulante]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_Postulante](
	[IdPostulante] [int] IDENTITY(1,1) NOT NULL,
	[IdPersona] [int] NULL,
	[Disponibilidad] [varchar](250) NULL,
	[Aprobado] [bit] NULL,
 CONSTRAINT [XPKGRH_Postulante] PRIMARY KEY CLUSTERED 
(
	[IdPostulante] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_Correo]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_Correo](
	[IdCorreo] [int] IDENTITY(1,1) NOT NULL,
	[IdPersona] [int] NULL,
	[CuentaCorreo] [varchar](50) NULL,
 CONSTRAINT [XPKGRH_Correo] PRIMARY KEY CLUSTERED 
(
	[IdCorreo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_ParametroCriterio]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRH_ParametroCriterio](
	[IdCriterio] [int] NULL,
	[IdParametro] [int] NULL,
	[IdParametroCriterio] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [XPKGRH_Parametos_x_Criterio] PRIMARY KEY CLUSTERED 
(
	[IdParametroCriterio] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GRH_Criterio]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_Criterio](
	[IdCriterio] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [char](18) NULL,
 CONSTRAINT [XPKGRH_Criterios] PRIMARY KEY CLUSTERED 
(
	[IdCriterio] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_Parametro]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_Parametro](
	[IdParametro] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](20) NULL,
 CONSTRAINT [XPKGRH_Parametros] PRIMARY KEY CLUSTERED 
(
	[IdParametro] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_Pais]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_Pais](
	[IdPais] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](30) NULL,
 CONSTRAINT [XPKGRH_Pais] PRIMARY KEY CLUSTERED 
(
	[IdPais] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_NivelIdioma]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_NivelIdioma](
	[IdNivelIdioma] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](30) NULL,
 CONSTRAINT [XPKGRH_NivelIdioma] PRIMARY KEY CLUSTERED 
(
	[IdNivelIdioma] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_IdiomaPersona]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRH_IdiomaPersona](
	[IdPersona] [int] NOT NULL,
	[IdIdioma] [int] NOT NULL,
	[IdNivelIdioma] [int] NULL,
	[Nativo] [bit] NULL,
	[IdIdiomaPersona] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [XPKGRH_IdiomaPersona] PRIMARY KEY CLUSTERED 
(
	[IdIdiomaPersona] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GRH_Idioma]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_Idioma](
	[IdIdioma] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](30) NULL,
 CONSTRAINT [XPKGRH_Idioma] PRIMARY KEY CLUSTERED 
(
	[IdIdioma] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_ExperienciaLaboral]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_ExperienciaLaboral](
	[IdExperienciaLaboral] [int] IDENTITY(1,1) NOT NULL,
	[IdPersona] [int] NULL,
	[FechaInicio] [datetime] NULL,
	[FechaFin] [datetime] NULL,
	[Conocimientos] [varchar](400) NULL,
	[Cargo] [varchar](50) NULL,
	[Empresa] [varchar](50) NULL,
 CONSTRAINT [XPKGRH_ExperienciaLaboral] PRIMARY KEY CLUSTERED 
(
	[IdExperienciaLaboral] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_SituacionEstudio]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_SituacionEstudio](
	[IdSituacionEstudio] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](30) NULL,
 CONSTRAINT [XPKGRH_SituacionEstudio] PRIMARY KEY CLUSTERED 
(
	[IdSituacionEstudio] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_EstudioRealizado]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_EstudioRealizado](
	[IdEstudioRealizado] [int] IDENTITY(1,1) NOT NULL,
	[IdSituacionEstudio] [int] NULL,
	[CentroEstudio] [varchar](50) NULL,
	[FechaInicio] [datetime] NULL,
	[FechaFin] [datetime] NULL,
	[NombreEstudio] [varchar](50) NULL,
	[IdNivelEducativo] [int] NULL,
	[IdPersona] [int] NULL,
	[IdEspecialidad] [int] NULL,
 CONSTRAINT [XPKGRH_EstudioRealizado] PRIMARY KEY CLUSTERED 
(
	[IdEstudioRealizado] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_NivelEducativo]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_NivelEducativo](
	[IdNivelEducativo] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](30) NULL,
 CONSTRAINT [XPKGRH_NivelEducativo] PRIMARY KEY CLUSTERED 
(
	[IdNivelEducativo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_EstadoCivil]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_EstadoCivil](
	[IdEstadoCivil] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](30) NULL,
 CONSTRAINT [XPKGRH_EstadoCivil] PRIMARY KEY CLUSTERED 
(
	[IdEstadoCivil] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_Especialidad]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_Especialidad](
	[IdEspecialidad] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](30) NULL,
 CONSTRAINT [XPKGRH_Especialidad] PRIMARY KEY CLUSTERED 
(
	[IdEspecialidad] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_Legajo]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_Legajo](
	[IdLegajo] [int] IDENTITY(1,1) NOT NULL,
	[Ubicacion] [varchar](250) NULL,
	[NombreArchivo] [varchar](50) NULL,
	[IdEmpleado] [int] NULL,
 CONSTRAINT [XPKGRH_Legajo] PRIMARY KEY CLUSTERED 
(
	[IdLegajo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_ContratoPersonal]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_ContratoPersonal](
	[IdContratoPersonal] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpleado] [int] NULL,
	[NumeroContrato] [varchar](20) NULL,
	[FechaInicio] [datetime] NULL,
	[FechaFin] [datetime] NULL,
 CONSTRAINT [XPKGRH_ContratoPersonal] PRIMARY KEY CLUSTERED 
(
	[IdContratoPersonal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_Cargo]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_Cargo](
	[IdCargo] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](30) NULL,
 CONSTRAINT [XPKGRH_Cargo] PRIMARY KEY CLUSTERED 
(
	[IdCargo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_Area]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_Area](
	[IdArea] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](30) NULL,
 CONSTRAINT [XPKGRH_Area] PRIMARY KEY CLUSTERED 
(
	[IdArea] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_Documento]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_Documento](
	[IdDocumento] [int] NOT NULL,
	[nomTipDocIde] [varchar](255) NOT NULL,
	[desTipDocIde] [varchar](255) NOT NULL,
 CONSTRAINT [PK_GRH_Documento] PRIMARY KEY CLUSTERED 
(
	[IdDocumento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GPC_Obra]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPC_Obra](
	[IDObra] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](200) NULL,
	[Direccion] [varchar](200) NULL,
	[IDUsuario] [int] NULL,
 CONSTRAINT [PK_GPC_Obra] PRIMARY KEY CLUSTERED 
(
	[IDObra] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[GPC_Obra] ON
INSERT [dbo].[GPC_Obra] ([IDObra], [Nombre], [Direccion], [IDUsuario]) VALUES (1, N'Proyecto Interbank', N'Av. La Marina 123', 1)
INSERT [dbo].[GPC_Obra] ([IDObra], [Nombre], [Direccion], [IDUsuario]) VALUES (2, N'Proyecto Scotiabank', N'Javier Prado Oeste 123', 1)
INSERT [dbo].[GPC_Obra] ([IDObra], [Nombre], [Direccion], [IDUsuario]) VALUES (3, N'Proyecto BCP', N'Benavides 13', 1)
INSERT [dbo].[GPC_Obra] ([IDObra], [Nombre], [Direccion], [IDUsuario]) VALUES (4, N'Proyecto Continental', N'Los Alamos 12', 1)
SET IDENTITY_INSERT [dbo].[GPC_Obra] OFF
/****** Object:  Table [dbo].[GPC_TipoSolicitud]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPC_TipoSolicitud](
	[IDTipoSolicitud] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](200) NULL,
 CONSTRAINT [PK_GPC_TipoSolicitud] PRIMARY KEY CLUSTERED 
(
	[IDTipoSolicitud] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[GPC_TipoSolicitud] ON
INSERT [dbo].[GPC_TipoSolicitud] ([IDTipoSolicitud], [Nombre]) VALUES (1, N'Anulacion')
SET IDENTITY_INSERT [dbo].[GPC_TipoSolicitud] OFF
/****** Object:  Table [dbo].[GPC_Estado]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPC_Estado](
	[IDEstado] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](200) NULL,
	[Entidad] [varchar](200) NULL,
 CONSTRAINT [PK_GPC_Estado] PRIMARY KEY CLUSTERED 
(
	[IDEstado] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[GPC_Estado] ON
INSERT [dbo].[GPC_Estado] ([IDEstado], [Nombre], [Entidad]) VALUES (1, N'Pendiente de Aprobación por el Jefe de Obra', N'Presupuesto')
INSERT [dbo].[GPC_Estado] ([IDEstado], [Nombre], [Entidad]) VALUES (2, N'Pendiente de Aprobación por el Asesor del Cliente', N'Presupuesto')
INSERT [dbo].[GPC_Estado] ([IDEstado], [Nombre], [Entidad]) VALUES (3, N'Rechazado', N'Presupuesto')
INSERT [dbo].[GPC_Estado] ([IDEstado], [Nombre], [Entidad]) VALUES (4, N'En Solicitud de Anulación', N'Presupuesto')
INSERT [dbo].[GPC_Estado] ([IDEstado], [Nombre], [Entidad]) VALUES (5, N'Anulado', N'Presupuesto')
INSERT [dbo].[GPC_Estado] ([IDEstado], [Nombre], [Entidad]) VALUES (6, N'Aprobado', N'Presupuesto')
INSERT [dbo].[GPC_Estado] ([IDEstado], [Nombre], [Entidad]) VALUES (7, N'Con Expediente Tecnico', N'Presupuesto')
SET IDENTITY_INSERT [dbo].[GPC_Estado] OFF
/****** Object:  Table [dbo].[GJ_ClausulaAdicional]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GJ_ClausulaAdicional](
	[IDClausulaAdicional] [int] NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDClausulaAdicional] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GJ_CartaNotarialVecinoColindante]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GJ_CartaNotarialVecinoColindante](
	[IDCartaNotarialVecinoColindante] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellido] [varchar](50) NOT NULL,
	[Dni] [char](8) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDCartaNotarialVecinoColindante] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GJ_RequerimientoLegalEstado]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GJ_RequerimientoLegalEstado](
	[IDRequerimientoLegalEstado] [smallint] NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDRequerimientoLegalEstado] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[GJ_RequerimientoLegalEstado] ([IDRequerimientoLegalEstado], [Descripcion]) VALUES (1, N'Pendiente')
INSERT [dbo].[GJ_RequerimientoLegalEstado] ([IDRequerimientoLegalEstado], [Descripcion]) VALUES (2, N'Asignado')
INSERT [dbo].[GJ_RequerimientoLegalEstado] ([IDRequerimientoLegalEstado], [Descripcion]) VALUES (3, N'Resuelto')
INSERT [dbo].[GJ_RequerimientoLegalEstado] ([IDRequerimientoLegalEstado], [Descripcion]) VALUES (4, N'No Conforme')
/****** Object:  Table [dbo].[GD_TipoDocumento]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GD_TipoDocumento](
	[IdTipoDocumento] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Vigencia] [smallint] NULL,
 CONSTRAINT [PK_TipoDocumento] PRIMARY KEY CLUSTERED 
(
	[IdTipoDocumento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GD_Estado]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GD_Estado](
	[IdEstado] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
 CONSTRAINT [PK_Estado] PRIMARY KEY CLUSTERED 
(
	[IdEstado] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GD_DocumentoPerfilAcceso]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GD_DocumentoPerfilAcceso](
	[IdDocPerfilAcceso] [int] IDENTITY(1,1) NOT NULL,
	[IdDocumento] [int] NOT NULL,
	[IdPerfil] [int] NOT NULL,
 CONSTRAINT [PK_Accesos] PRIMARY KEY CLUSTERED 
(
	[IdDocPerfilAcceso] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GD_DocumentoHistorial]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GD_DocumentoHistorial](
	[IdDocumentoHistorial] [int] IDENTITY(1,1) NOT NULL,
	[IdDocumento] [int] NOT NULL,
	[IdUsuarioPerfil] [int] NOT NULL,
	[FechaAcceso] [date] NOT NULL,
	[IdEstado] [int] NOT NULL,
	[Descripcion] [varchar](150) NULL,
 CONSTRAINT [PK_HistorialDocumento] PRIMARY KEY CLUSTERED 
(
	[IdDocumentoHistorial] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GD_Documento]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GD_Documento](
	[IdDocumento] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[RutaFisica] [varchar](100) NOT NULL,
	[Descripcion] [varchar](100) NULL,
	[Tags] [varchar](50) NULL,
	[FechaRegistro] [date] NOT NULL,
	[FechaDocumento] [date] NULL,
	[IdProyecto] [int] NULL,
	[IdEstado] [int] NOT NULL,
	[IdArea] [int] NULL,
	[IdTipoDocumento] [int] NOT NULL,
	[Ubicacion] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Documento] PRIMARY KEY CLUSTERED 
(
	[IdDocumento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GPC_Categoria]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPC_Categoria](
	[IDCategoria] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](200) NULL,
 CONSTRAINT [PK_GPC_Categoria] PRIMARY KEY CLUSTERED 
(
	[IDCategoria] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[GPC_Categoria] ON
INSERT [dbo].[GPC_Categoria] ([IDCategoria], [Nombre]) VALUES (1, N'Materiales')
INSERT [dbo].[GPC_Categoria] ([IDCategoria], [Nombre]) VALUES (2, N'Mano de Obra')
INSERT [dbo].[GPC_Categoria] ([IDCategoria], [Nombre]) VALUES (3, N'Equipos')
INSERT [dbo].[GPC_Categoria] ([IDCategoria], [Nombre]) VALUES (4, N'Subpartidas')
SET IDENTITY_INSERT [dbo].[GPC_Categoria] OFF
/****** Object:  Table [dbo].[GPC_APU]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPC_APU](
	[IDApu] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](200) NULL,
	[UM] [varchar](200) NULL,
	[Total] [numeric](18, 2) NULL,
 CONSTRAINT [PK_GPC_APU] PRIMARY KEY CLUSTERED 
(
	[IDApu] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[GPC_APU] ON
INSERT [dbo].[GPC_APU] ([IDApu], [Nombre], [UM], [Total]) VALUES (1, N'FLETE TERRESTRE', N'glb', NULL)
INSERT [dbo].[GPC_APU] ([IDApu], [Nombre], [UM], [Total]) VALUES (2, N'TOPOGRAFO', N'hh', NULL)
INSERT [dbo].[GPC_APU] ([IDApu], [Nombre], [UM], [Total]) VALUES (3, N'PEON', N'hh', NULL)
INSERT [dbo].[GPC_APU] ([IDApu], [Nombre], [UM], [Total]) VALUES (4, N'ACERO CORRUGADO fy=4200 kg/cm2 GRADO 60', N'kg', NULL)
INSERT [dbo].[GPC_APU] ([IDApu], [Nombre], [UM], [Total]) VALUES (5, N'CAL', N'kg', NULL)
INSERT [dbo].[GPC_APU] ([IDApu], [Nombre], [UM], [Total]) VALUES (6, N'PINTURA', N'gal', NULL)
INSERT [dbo].[GPC_APU] ([IDApu], [Nombre], [UM], [Total]) VALUES (7, N'HERRAMIENTAS MANUALES', N'%MO', NULL)
INSERT [dbo].[GPC_APU] ([IDApu], [Nombre], [UM], [Total]) VALUES (8, N'NIVEL TOPOGRAFICO', N'hm', NULL)
INSERT [dbo].[GPC_APU] ([IDApu], [Nombre], [UM], [Total]) VALUES (9, N'ESTACION TOTAL', N'hm', NULL)
INSERT [dbo].[GPC_APU] ([IDApu], [Nombre], [UM], [Total]) VALUES (10, N'CAPATAZ', N'hh', NULL)
INSERT [dbo].[GPC_APU] ([IDApu], [Nombre], [UM], [Total]) VALUES (11, N'LAMPARA INTERMITENTE', N'und', NULL)
INSERT [dbo].[GPC_APU] ([IDApu], [Nombre], [UM], [Total]) VALUES (12, N'CINTA DE SEÑALIZACION', N'm', NULL)
INSERT [dbo].[GPC_APU] ([IDApu], [Nombre], [UM], [Total]) VALUES (13, N'TRANQUERAS', N'und', NULL)
INSERT [dbo].[GPC_APU] ([IDApu], [Nombre], [UM], [Total]) VALUES (14, N'PILA GRANDE', N'und', NULL)
INSERT [dbo].[GPC_APU] ([IDApu], [Nombre], [UM], [Total]) VALUES (15, N'BANDERINES', N'und', NULL)
INSERT [dbo].[GPC_APU] ([IDApu], [Nombre], [UM], [Total]) VALUES (16, N'CAL', N'kg', NULL)
INSERT [dbo].[GPC_APU] ([IDApu], [Nombre], [UM], [Total]) VALUES (17, N'CAMION CISTERNA 4 X 2 (AGUA) 122 HP 2,000 gl', N'hm', NULL)
INSERT [dbo].[GPC_APU] ([IDApu], [Nombre], [UM], [Total]) VALUES (18, N'CAMION VOLQUETE 15 m3', N'hm', NULL)
INSERT [dbo].[GPC_APU] ([IDApu], [Nombre], [UM], [Total]) VALUES (19, N'RODILLO LISO VIBRATORIO AUTOPROPULSADO 70-100 HP 7-9', N'tonhm', NULL)
INSERT [dbo].[GPC_APU] ([IDApu], [Nombre], [UM], [Total]) VALUES (20, N'CARGADOR SOBRE LLANTAS 200-250 HP 4.6 yd3', N'hm', NULL)
INSERT [dbo].[GPC_APU] ([IDApu], [Nombre], [UM], [Total]) VALUES (21, N'MOTONIVELADORA DE 145-150 HP', N'hm', NULL)
SET IDENTITY_INSERT [dbo].[GPC_APU] OFF
/****** Object:  Table [dbo].[GJ_TipoContratoLegal]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GJ_TipoContratoLegal](
	[IDTipoContratoLegal] [int] NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDTipoContratoLegal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[GJ_TipoContratoLegal] ([IDTipoContratoLegal], [Descripcion]) VALUES (1, N'Contrato de Trabajo a Plazo Indeterminado')
INSERT [dbo].[GJ_TipoContratoLegal] ([IDTipoContratoLegal], [Descripcion]) VALUES (2, N'Contrato de Prestación de Servicios')
INSERT [dbo].[GJ_TipoContratoLegal] ([IDTipoContratoLegal], [Descripcion]) VALUES (3, N'Contrato de Trabajo Sujeto a Modalidad')
/****** Object:  Table [dbo].[GJ_RequerimientoLegalTipo]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GJ_RequerimientoLegalTipo](
	[IDRequerimientoLegalTipo] [smallint] NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
	[Activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDRequerimientoLegalTipo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[GJ_RequerimientoLegalTipo] ([IDRequerimientoLegalTipo], [Descripcion], [Activo]) VALUES (2, N'Contratos', 1)
INSERT [dbo].[GJ_RequerimientoLegalTipo] ([IDRequerimientoLegalTipo], [Descripcion], [Activo]) VALUES (3, N'Declaración Jurídica', 1)
/****** Object:  Table [dbo].[GPP_TipoProyecto]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPP_TipoProyecto](
	[IdTipoProyecto] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Descripcion] [varchar](255) NOT NULL,
 CONSTRAINT [PK_GPP_TipoProyecto] PRIMARY KEY CLUSTERED 
(
	[IdTipoProyecto] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GPP_TipoCambio]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GPP_TipoCambio](
	[IdTipoCambio] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
	[ValorCompra] [float] NOT NULL,
	[ValorVenta] [float] NOT NULL,
 CONSTRAINT [PK_T_TipoCambio] PRIMARY KEY CLUSTERED 
(
	[IdTipoCambio] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GPP_RequerimientoPlanProy]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPP_RequerimientoPlanProy](
	[IdRequerimientoPlan] [int] NOT NULL,
	[Descripcion] [varchar](255) NOT NULL,
	[fecReq] [date] NOT NULL,
	[priReq] [varchar](100) NOT NULL,
	[IdProyecto] [int] NOT NULL,
	[IdTipoRecurso] [int] NOT NULL,
 CONSTRAINT [PK_GPP_Requerimiento] PRIMARY KEY CLUSTERED 
(
	[IdRequerimientoPlan] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GSC_FormaPago]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GSC_FormaPago](
	[IdFormaPago] [int] NOT NULL,
	[DescripFormPag] [varchar](100) NULL,
 CONSTRAINT [PK_FormaPago] PRIMARY KEY CLUSTERED 
(
	[IdFormaPago] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GSC_Estado]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GSC_Estado](
	[IdEstado] [int] NOT NULL,
	[DescripEstado] [varchar](50) NULL,
	[FlagSolCotizacion] [char](1) NULL,
	[FlagCotizacion] [char](1) NULL,
 CONSTRAINT [PK_Estado_1] PRIMARY KEY CLUSTERED 
(
	[IdEstado] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRH_TipoDocumento]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRH_TipoDocumento](
	[IdTipoDocumento] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](30) NULL,
 CONSTRAINT [XPKGRH_TipoDocumento] PRIMARY KEY CLUSTERED 
(
	[IdTipoDocumento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GPP_Proyecto]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPP_Proyecto](
	[IdProyecto] [int] NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Descripcion] [varchar](250) NULL,
	[NroHojaEnvio] [varchar](50) NULL,
	[FechaHojaEnvio] [date] NULL,
	[FechaInicioPlaneada] [date] NULL,
	[FechaFinPlaneada] [date] NULL,
	[FechaInicioReal] [date] NULL,
	[FechaFinReal] [date] NULL,
	[CondicionPago] [varchar](50) NULL,
	[RazonSocial] [varchar](50) NULL,
	[Ruc] [varchar](11) NULL,
	[Estado] [varchar](2) NULL,
	[Prioridad] [int] NULL,
 CONSTRAINT [PK_GPP_Proyecto] PRIMARY KEY CLUSTERED 
(
	[IdProyecto] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GPP_VariablesPresupuesto]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPP_VariablesPresupuesto](
	[IdVariablePre] [int] NOT NULL,
	[Descripcion] [varchar](255) NOT NULL,
 CONSTRAINT [PK_GPP_VariablesPresupuesto] PRIMARY KEY CLUSTERED 
(
	[IdVariablePre] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GPP_Ubigeo]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPP_Ubigeo](
	[IdUbigeo] [int] NOT NULL,
	[CodigoDep] [int] NOT NULL,
	[CodigoProv] [int] NOT NULL,
	[CodigoDist] [int] NOT NULL,
	[NombreDep] [varchar](50) NOT NULL,
	[NombreProv] [varchar](50) NOT NULL,
	[NombreDist] [varchar](50) NOT NULL,
	[CodigoPostal] [char](5) NOT NULL,
 CONSTRAINT [PK_GPP_Ubigeo] PRIMARY KEY CLUSTERED 
(
	[IdUbigeo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[IdUbigeo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GSC_UnidadMedida]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GSC_UnidadMedida](
	[IdUnidadMedida] [int] NOT NULL,
	[DescripUMedi] [varchar](50) NULL,
	[AbrviaUMedi] [nchar](10) NULL,
 CONSTRAINT [PK_UnidadMedida] PRIMARY KEY CLUSTERED 
(
	[IdUnidadMedida] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GSC_TipoServicio]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GSC_TipoServicio](
	[IdTipoServicio] [int] NOT NULL,
	[DescripTServicio] [varchar](50) NULL,
	[FecActualizacion] [datetime] NULL,
 CONSTRAINT [PK_TipoServicio] PRIMARY KEY CLUSTERED 
(
	[IdTipoServicio] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GSC_TipoCambio]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GSC_TipoCambio](
	[FecTipCam] [date] NOT NULL,
	[ValComTipCam] [decimal](18, 3) NULL,
	[ValVenTipCam] [decimal](18, 3) NULL,
 CONSTRAINT [PK_TipoCambio] PRIMARY KEY CLUSTERED 
(
	[FecTipCam] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GSC_Moneda]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GSC_Moneda](
	[IdMoneda] [int] NOT NULL,
	[DescripMoned] [varchar](50) NULL,
	[AbreviaMoned] [varchar](10) NULL,
 CONSTRAINT [PK_Moneda] PRIMARY KEY CLUSTERED 
(
	[IdMoneda] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GSC_ParametroCalificacion]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GSC_ParametroCalificacion](
	[IdParametroCalificacion] [int] NOT NULL,
	[DescripParamCalif] [varchar](50) NULL,
	[PuntuacionMax] [int] NULL,
 CONSTRAINT [PK_ParametrosCalificacion] PRIMARY KEY CLUSTERED 
(
	[IdParametroCalificacion] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SEG_Usuario]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SEG_Usuario](
	[IDUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[ApellidoPaterno] [varchar](50) NULL,
	[ApellidoMaterno] [varchar](50) NULL,
	[Usuario] [varchar](50) NOT NULL,
	[Clave] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[IDUsuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[SEG_Usuario] ON
INSERT [dbo].[SEG_Usuario] ([IDUsuario], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [Usuario], [Clave]) VALUES (1, N'Juan José', N'Vento', N'Sevilla', N'1234', N'1234')
INSERT [dbo].[SEG_Usuario] ([IDUsuario], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [Usuario], [Clave]) VALUES (2, N'Morgan', N'Osorio', N'Gallegos', N'1234', N'1234')
INSERT [dbo].[SEG_Usuario] ([IDUsuario], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [Usuario], [Clave]) VALUES (3, N'Arturo', N'Villarreal', N'Calderón', N'1234', N'1234')
INSERT [dbo].[SEG_Usuario] ([IDUsuario], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [Usuario], [Clave]) VALUES (4, N'Miguel', N'Guillen', N'Paz', N'mguillen', N'mguillen')
INSERT [dbo].[SEG_Usuario] ([IDUsuario], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [Usuario], [Clave]) VALUES (5, N'Carlos', N'Perez', N'Betancour', N'cperez', N'cperez')
SET IDENTITY_INSERT [dbo].[SEG_Usuario] OFF
/****** Object:  Table [dbo].[SEG_Perfil]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SEG_Perfil](
	[IDPerfil] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Perfil] PRIMARY KEY CLUSTERED 
(
	[IDPerfil] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[SEG_Perfil] ON
INSERT [dbo].[SEG_Perfil] ([IDPerfil], [Nombre]) VALUES (1, N'Ingeniero Residente')
INSERT [dbo].[SEG_Perfil] ([IDPerfil], [Nombre]) VALUES (2, N'Jefe de Obra')
INSERT [dbo].[SEG_Perfil] ([IDPerfil], [Nombre]) VALUES (3, N'Asesor de Cliente')
SET IDENTITY_INSERT [dbo].[SEG_Perfil] OFF
/****** Object:  Table [dbo].[GSC_Proveedor]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GSC_Proveedor](
	[IdProveedor] [int] IDENTITY(1,1) NOT NULL,
	[RucProv] [varchar](11) NOT NULL,
	[RazonSocialProv] [varchar](50) NOT NULL,
	[DireccionProv] [varchar](50) NULL,
	[EmailProv] [varchar](50) NULL,
	[EstadoProv] [char](2) NULL,
 CONSTRAINT [PK_Proveedor_1] PRIMARY KEY CLUSTERED 
(
	[IdProveedor] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GSC_SolicitudCotizacion]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GSC_SolicitudCotizacion](
	[IdSolicitudCotizacion] [int] IDENTITY(1,1) NOT NULL,
	[DescripSolCotizacion] [varchar](50) NULL,
	[FecSolCotizacion] [datetime] NULL,
	[Observaciones] [varchar](50) NULL,
	[FechaVencimiento] [date] NULL,
	[IdTipoServicio] [int] NULL,
	[FechaEnvio] [datetime] NULL,
	[IdEstado] [int] NULL,
 CONSTRAINT [PK_SolicitudCotizacion] PRIMARY KEY CLUSTERED 
(
	[IdSolicitudCotizacion] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GSC_Requerimiento]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GSC_Requerimiento](
	[IdProyecto] [int] NOT NULL,
	[IdRequerimiento] [int] NOT NULL,
	[DescripReq] [varchar](50) NULL,
	[FechaReq] [datetime] NULL,
	[PriReq] [varchar](3) NULL,
 CONSTRAINT [PK_Requerimiento] PRIMARY KEY CLUSTERED 
(
	[IdProyecto] ASC,
	[IdRequerimiento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GSC_ProveedorTipoServicio]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GSC_ProveedorTipoServicio](
	[IdProveedor] [int] NOT NULL,
	[IdTipoServicio] [int] NOT NULL,
	[DescProvTipoServ] [varchar](50) NULL,
	[FechaProvTipoServ] [datetime] NULL,
	[ContactoProvTipoServ] [varchar](50) NULL,
	[EmailProvTipoServ] [varchar](80) NOT NULL,
	[calificacionTipoServ] [int] NULL,
 CONSTRAINT [PK_ProveedorTipoServicio] PRIMARY KEY CLUSTERED 
(
	[IdProveedor] ASC,
	[IdTipoServicio] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[pa_GSC_Moneda]    Script Date: 09/01/2013 22:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--===========================================================================================
--==========PROCEDIMIENTO MonedaUpdate ========================
--===========================================================================================
--===========================================================================================
CREATE PROCEDURE [dbo].[pa_GSC_Moneda]
             @IdMoneda    int=Null,
             @DescripMoned    varchar(50)=Null,
             @AbreviaMoned    varchar(10)=Null

,@TipoConsulta tinyint
AS 
if @TipoConsulta=1 
Begin
             UPDATE dbo.[GSC_Moneda]SET 
                          [DescripMoned]=@DescripMoned,
                          [AbreviaMoned]=@AbreviaMoned
             WHERE  IdMoneda = @IdMoneda

End

--===========================================================================================
--==========PROCEDIMIENTO MonedaGetByAll ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=2
begin
Select * from GSC_Moneda
End

--===========================================================================================
--==========PROCEDIMIENTO MonedaGetByPrimaryKey ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=3
begin
Select * from GSC_Moneda
WHERE  IdMoneda = @IdMoneda
End

--===========================================================================================
--==========PROCEDIMIENTO MonedaInsert ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=4
Begin
             INSERT INTO [dbo].[GSC_Moneda]
             (
                          [IdMoneda],
                          [DescripMoned],
                          [AbreviaMoned]

             )
             VALUES
             (
                          @IdMoneda,
                          @DescripMoned,
                          @AbreviaMoned

             )
             SET @IdMoneda= @@IDENTITY
End

--===========================================================================================
--==========PROCEDIMIENTO MonedaDelete ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=5
begin
Delete from GSC_Moneda
WHERE  IdMoneda = @IdMoneda
end

--===========================================================================================
else if @TipoConsulta=6
begin
Select * from GSC_Moneda
where DescripMoned Like @DescripMoned+ '%'
end

--===========================================================================================
--==========PROCEDIMIENTO MonedaDelete ========================
--===========================================================================================
--===========================================================================================
else
begin
Delete from GSC_Moneda
end
GO
/****** Object:  StoredProcedure [dbo].[pa_GSC_FormaPago]    Script Date: 09/01/2013 22:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--===========================================================================================
--==========PROCEDIMIENTO FormaPagoUpdate ========================
--===========================================================================================
--===========================================================================================
CREATE PROCEDURE [dbo].[pa_GSC_FormaPago]
             @IdFormaPago    int=Null,
             @DescripFormPag    varchar(50)=Null

,@TipoConsulta tinyint
AS 
if @TipoConsulta=1 
Begin
             UPDATE dbo.[GSC_FormaPago]SET 
                          [DescripFormPag]=@DescripFormPag
             WHERE  IdFormaPago = @IdFormaPago

End

--===========================================================================================
--==========PROCEDIMIENTO FormaPagoGetByAll ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=2
begin
Select * from GSC_FormaPago
End

--===========================================================================================
--==========PROCEDIMIENTO FormaPagoGetByPrimaryKey ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=3
begin
Select * from GSC_FormaPago
WHERE  IdFormaPago = @IdFormaPago
End

--===========================================================================================
--==========PROCEDIMIENTO FormaPagoInsert ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=4
Begin
             INSERT INTO [dbo].[GSC_FormaPago]
             (
                          [IdFormaPago],
                          [DescripFormPag]

             )
             VALUES
             (
                          @IdFormaPago,
                          @DescripFormPag

             )
             SET @IdFormaPago= @@IDENTITY
End

--===========================================================================================
--==========PROCEDIMIENTO FormaPagoDelete ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=5
begin
Delete from GSC_FormaPago
WHERE  IdFormaPago = @IdFormaPago
end

--===========================================================================================
else if @TipoConsulta=6
begin
Select * from GSC_FormaPago
where DescripFormPag Like @DescripFormPag+ '%'
end

--===========================================================================================
--==========PROCEDIMIENTO FormaPagoDelete ========================
--===========================================================================================
--===========================================================================================
else
begin
Delete from FormaPago
end
GO
/****** Object:  StoredProcedure [dbo].[pa_GSC_Estado]    Script Date: 09/01/2013 22:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--===========================================================================================
--==========PROCEDIMIENTO EstadoUpdate ========================
--===========================================================================================
--===========================================================================================
CREATE PROCEDURE [dbo].[pa_GSC_Estado]
             @IdEstado    int=Null,
             @DescripEstado    varchar(50)=Null,
             @FlagSolCotizacion    char(1)=Null,
             @FlagCotizacion    char(1)=Null,
             @flag		char(1)=Null

,@TipoConsulta tinyint
AS 
if @TipoConsulta=1 
Begin
             UPDATE dbo.[GSC_Estado]SET 
                          [DescripEstado]=@DescripEstado,
                          [FlagSolCotizacion]=@FlagSolCotizacion,
                          [FlagCotizacion]=@FlagCotizacion
             WHERE  IdEstado = @IdEstado

End

--===========================================================================================
--==========PROCEDIMIENTO EstadoGetByAll ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=2
begin
	if @flag = 'C'
	begin
		Select * from GSC_Estado where FlagCotizacion = '1'
	end
	else if @flag = 'S'
	begin
		Select * from GSC_Estado where FlagSolCotizacion = '1'
	end	
	else
	begin
		Select * from GSC_Estado
	end
End

--===========================================================================================
--==========PROCEDIMIENTO EstadoGetByPrimaryKey ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=3
begin
Select * from GSC_Estado
WHERE  IdEstado = @IdEstado
End

--===========================================================================================
--==========PROCEDIMIENTO EstadoInsert ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=4
Begin
     INSERT INTO [dbo].[GSC_Estado]
     (
          [IdEstado],
          [DescripEstado],
          [FlagSolCotizacion],
          [FlagCotizacion]
     )
     VALUES
     (
          @IdEstado,
          @DescripEstado,
          @FlagSolCotizacion,
          @FlagCotizacion
     )
     SET @IdEstado= @@IDENTITY
End

--===========================================================================================
--==========PROCEDIMIENTO EstadoDelete ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=5
begin
	Delete from GSC_Estado
	WHERE  IdEstado = @IdEstado
end

--===========================================================================================
else if @TipoConsulta=6
begin
	Select * from GSC_Estado
	where DescripEstado Like @DescripEstado+ '%'
end
GO
/****** Object:  StoredProcedure [dbo].[pa_GSC_TipoServicio]    Script Date: 09/01/2013 22:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--===========================================================================================
--==========PROCEDIMIENTO TipoServicioUpdate ========================
--===========================================================================================
--===========================================================================================
CREATE PROCEDURE [dbo].[pa_GSC_TipoServicio]
             @IdTipoServicio    int=Null,
             @DescripTServicio    varchar(50)=Null,
             @FecActualizacion    datetime=Null

,@TipoConsulta tinyint
AS 
if @TipoConsulta=1 
Begin
             UPDATE dbo.[GSC_TipoServicio]SET 
                          [DescripTServicio]=@DescripTServicio,
                          [FecActualizacion]=@FecActualizacion
             WHERE  IdTipoServicio = @IdTipoServicio

End

	--===========================================================================================
--==========PROCEDIMIENTO TipoServicioGetByAll ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=2
begin
Select * from GSC_TipoServicio
End

--===========================================================================================
--==========PROCEDIMIENTO TipoServicioGetByPrimaryKey ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=3
begin
Select * from GSC_TipoServicio
WHERE  IdTipoServicio = @IdTipoServicio
End
--===========================================================================================
--==========PROCEDIMIENTO TipoServicioInsert ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=4
Begin
             INSERT INTO [dbo].[GSC_TipoServicio]
             (
                          [IdTipoServicio],
                          [DescripTServicio],
                          [FecActualizacion]

             )
             VALUES
             (
                          @IdTipoServicio,
                          @DescripTServicio,
                          @FecActualizacion

             )
             SET @IdTipoServicio= @@IDENTITY
End

--===========================================================================================
--==========PROCEDIMIENTO TipoServicioDelete ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=5
begin
Delete from GSC_TipoServicio
WHERE  IdTipoServicio = @IdTipoServicio
end

--===========================================================================================
else if @TipoConsulta=6
begin
Select * from GSC_TipoServicio
where DescripTServicio Like @DescripTServicio+ '%'
end

--===========================================================================================
--==========PROCEDIMIENTO TipoServicioDelete ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=6
begin
	Delete from GSC_TipoServicio
end
GO
/****** Object:  Table [dbo].[SEG_UsuarioPerfil]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SEG_UsuarioPerfil](
	[IdUsuarioPerfil] [int] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [int] NOT NULL,
	[IdPerfil] [int] NOT NULL,
	[FechaInicioVigencia] [date] NULL,
	[FechaFinVigencia] [date] NULL,
 CONSTRAINT [PK_UsuarioPerfil] PRIMARY KEY CLUSTERED 
(
	[IdUsuarioPerfil] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[SEG_UsuarioPerfil] ON
INSERT [dbo].[SEG_UsuarioPerfil] ([IdUsuarioPerfil], [IdUsuario], [IdPerfil], [FechaInicioVigencia], [FechaFinVigencia]) VALUES (1, 1, 2, NULL, NULL)
INSERT [dbo].[SEG_UsuarioPerfil] ([IdUsuarioPerfil], [IdUsuario], [IdPerfil], [FechaInicioVigencia], [FechaFinVigencia]) VALUES (2, 2, 3, NULL, NULL)
INSERT [dbo].[SEG_UsuarioPerfil] ([IdUsuarioPerfil], [IdUsuario], [IdPerfil], [FechaInicioVigencia], [FechaFinVigencia]) VALUES (3, 3, 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[SEG_UsuarioPerfil] OFF
/****** Object:  Table [dbo].[GSC_ParametroCalificacionTipoServicio]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GSC_ParametroCalificacionTipoServicio](
	[IdTipoServicio] [int] NOT NULL,
	[IdParametroCalificacion] [int] NOT NULL,
	[FechaAsig] [datetime] NULL,
 CONSTRAINT [PK_ParametrosCalificacionTipoServicio] PRIMARY KEY CLUSTERED 
(
	[IdTipoServicio] ASC,
	[IdParametroCalificacion] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GPP_TipoRecurso]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPP_TipoRecurso](
	[IdTipoRecurso] [int] NOT NULL,
	[Nombre] [varchar](255) NOT NULL,
	[Descripcion] [varchar](255) NOT NULL,
	[IdProyecto] [int] NOT NULL,
 CONSTRAINT [PK_GPP_TipoRecurso] PRIMARY KEY CLUSTERED 
(
	[IdTipoRecurso] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GPP_Presupuesto]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPP_Presupuesto](
	[IdPresupuesto] [int] NOT NULL,
	[NroVersion] [int] NOT NULL,
	[Fecha] [char](8) NULL,
	[Moneda] [float] NOT NULL,
	[ImporteTotal] [float] NOT NULL,
	[Estado] [char](1) NOT NULL,
	[NroOrdenEjecucion] [int] NOT NULL,
	[ImporteAsignado] [float] NOT NULL,
	[IdProyecto] [int] NOT NULL,
	[IdMoneda] [int] NOT NULL,
 CONSTRAINT [PK_GPP_Presupuesto] PRIMARY KEY CLUSTERED 
(
	[IdPresupuesto] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GPP_FlujoCaja]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPP_FlujoCaja](
	[IdFlujoCaja] [int] NOT NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFin] [date] NOT NULL,
	[FactorProy] [char](11) NOT NULL,
	[MontoProy] [float] NOT NULL,
	[DetalleIngresoProy] [float] NOT NULL,
	[Gasto] [float] NOT NULL,
	[Rentabilidad] [float] NOT NULL,
	[DetalleMontoAct] [float] NOT NULL,
	[EgresoTrim1] [float] NOT NULL,
	[EgresoTrim2] [float] NOT NULL,
	[EgresoTrim3] [float] NOT NULL,
	[EgresoTrim4] [float] NOT NULL,
	[IdTipoCambio] [int] NOT NULL,
 CONSTRAINT [PK_GPP_FlujoCaja] PRIMARY KEY CLUSTERED 
(
	[IdFlujoCaja] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GJ_UsuarioAtencion]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GJ_UsuarioAtencion](
	[IDUsuarioAtencion] [int] IDENTITY(1,1) NOT NULL,
	[Apellido] [varchar](100) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[IDUsuario] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDUsuarioAtencion] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GJ_RequerimientoLegalPlantillaContrato]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GJ_RequerimientoLegalPlantillaContrato](
	[IDRequerimientoLegalPlantillaContrato] [int] IDENTITY(1,1) NOT NULL,
	[IDProyecto] [int] NOT NULL,
	[IDRequerimientoLegalTipo] [smallint] NOT NULL,
	[IDTipoContratoLegal] [int] NOT NULL,
	[IDUsuario] [int] NOT NULL,
	[IDRequerimientoLegalEstado] [smallint] NOT NULL,
	[FechaRegistro] [datetime] NULL,
	[IDUsuarioAtencion] [int] NULL,
	[FechaAsignacion] [datetime] NULL,
	[PrioridadAtencion] [char](3) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDRequerimientoLegalPlantillaContrato] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GJ_RequerimientoLegalDeclaracionFabrica]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GJ_RequerimientoLegalDeclaracionFabrica](
	[IDRequerimientoLegalDeclaracionFabrica] [int] IDENTITY(1,1) NOT NULL,
	[IDProyecto] [int] NOT NULL,
	[IDRequerimientoLegalTipo] [smallint] NOT NULL,
	[IDUsuario] [int] NOT NULL,
	[IDRequerimientoLegalEstado] [smallint] NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
	[FechaRegistro] [datetime] NULL,
	[IDUsuarioAtencion] [int] NULL,
	[FechaAsignacion] [datetime] NULL,
	[PrioridadAtencion] [char](3) NULL,
	[DeclaracionFabrica] [varchar](500) NOT NULL,
	[Planos] [varchar](500) NOT NULL,
	[InformeVerificacionTecnica] [varchar](500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDRequerimientoLegalDeclaracionFabrica] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GJ_RequerimientoLegalCartaNotarial]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GJ_RequerimientoLegalCartaNotarial](
	[IDRequerimientoLegalCartaNotarial] [int] IDENTITY(1,1) NOT NULL,
	[IDProyecto] [int] NOT NULL,
	[IDRequerimientoLegalTipo] [smallint] NOT NULL,
	[IDUsuario] [int] NOT NULL,
	[IDRequerimientoLegalEstado] [smallint] NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
	[FechaRegistro] [datetime] NULL,
	[IDUsuarioAtencion] [int] NULL,
	[FechaAsignacion] [datetime] NULL,
	[PrioridadAtencion] [char](3) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDRequerimientoLegalCartaNotarial] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GPC_ClienteObra]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPC_ClienteObra](
	[IDClienteObra] [int] IDENTITY(1,1) NOT NULL,
	[RazonSocial] [varchar](200) NULL,
	[IDUsuario] [int] NULL,
 CONSTRAINT [PK_GPC_ClienteObra] PRIMARY KEY CLUSTERED 
(
	[IDClienteObra] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[GPC_ClienteObra] ON
INSERT [dbo].[GPC_ClienteObra] ([IDClienteObra], [RazonSocial], [IDUsuario]) VALUES (1, N'Interbank', 2)
INSERT [dbo].[GPC_ClienteObra] ([IDClienteObra], [RazonSocial], [IDUsuario]) VALUES (2, N'Scotiabank', 2)
INSERT [dbo].[GPC_ClienteObra] ([IDClienteObra], [RazonSocial], [IDUsuario]) VALUES (3, N'BCP', 2)
INSERT [dbo].[GPC_ClienteObra] ([IDClienteObra], [RazonSocial], [IDUsuario]) VALUES (4, N'Continental', 2)
SET IDENTITY_INSERT [dbo].[GPC_ClienteObra] OFF
/****** Object:  Table [dbo].[GPP_Entregable]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPP_Entregable](
	[IdEntregable] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Descripcion] [varchar](255) NOT NULL,
	[IdProyecto] [int] NOT NULL,
 CONSTRAINT [PK_GPP_Entregable] PRIMARY KEY CLUSTERED 
(
	[IdEntregable] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GPP_DetallePresupuesto]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPP_DetallePresupuesto](
	[IdDetPresupuesto] [int] NOT NULL,
	[Descripcion] [varchar](255) NOT NULL,
	[Porcentake] [float] NOT NULL,
	[Monto] [nchar](10) NULL,
	[Importe] [float] NOT NULL,
	[IdPresupuesto] [int] NOT NULL,
	[IdVariablePre] [int] NOT NULL,
 CONSTRAINT [PK_GPP_DetallePresupuesto] PRIMARY KEY CLUSTERED 
(
	[IdDetPresupuesto] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GPC_PresupuestoObra]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPC_PresupuestoObra](
	[IDPresupuestoObra] [int] IDENTITY(1,1) NOT NULL,
	[Numero] [varchar](10) NULL,
	[MontoPresupuestado] [numeric](18, 2) NULL,
	[MontoEjecutado] [numeric](18, 2) NULL,
	[FechaCambioEstado] [datetime] NULL,
	[UsuarioCambioEstado] [varchar](200) NULL,
	[IDEstado] [int] NULL,
	[IDClienteObra] [int] NULL,
	[IDObra] [int] NULL,
 CONSTRAINT [PK_GPC_PresupuestoObra] PRIMARY KEY CLUSTERED 
(
	[IDPresupuestoObra] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[GPC_PresupuestoObra] ON
INSERT [dbo].[GPC_PresupuestoObra] ([IDPresupuestoObra], [Numero], [MontoPresupuestado], [MontoEjecutado], [FechaCambioEstado], [UsuarioCambioEstado], [IDEstado], [IDClienteObra], [IDObra]) VALUES (1, N'00000001', NULL, NULL, NULL, NULL, 6, 1, 1)
INSERT [dbo].[GPC_PresupuestoObra] ([IDPresupuestoObra], [Numero], [MontoPresupuestado], [MontoEjecutado], [FechaCambioEstado], [UsuarioCambioEstado], [IDEstado], [IDClienteObra], [IDObra]) VALUES (2, N'00000002', NULL, NULL, NULL, NULL, 2, 2, 2)
INSERT [dbo].[GPC_PresupuestoObra] ([IDPresupuestoObra], [Numero], [MontoPresupuestado], [MontoEjecutado], [FechaCambioEstado], [UsuarioCambioEstado], [IDEstado], [IDClienteObra], [IDObra]) VALUES (3, N'00000003', NULL, NULL, NULL, NULL, 2, 3, 3)
INSERT [dbo].[GPC_PresupuestoObra] ([IDPresupuestoObra], [Numero], [MontoPresupuestado], [MontoEjecutado], [FechaCambioEstado], [UsuarioCambioEstado], [IDEstado], [IDClienteObra], [IDObra]) VALUES (4, N'00000004', NULL, NULL, NULL, NULL, 6, 4, 4)
SET IDENTITY_INSERT [dbo].[GPC_PresupuestoObra] OFF
/****** Object:  Table [dbo].[GJ_ContratoTrabajoSujetoModalidad]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GJ_ContratoTrabajoSujetoModalidad](
	[IDContratoTrabajoSujetoModalidad] [int] IDENTITY(1,1) NOT NULL,
	[IDRequerimientoLegalPlantillaContrato] [int] NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
	[NombreTrabajador] [varchar](100) NOT NULL,
	[DniTrabajador] [char](8) NOT NULL,
	[ModalidadContrato] [varchar](100) NOT NULL,
	[Duracion] [varchar](50) NOT NULL,
	[HoraInicioLabor] [varchar](20) NOT NULL,
	[HoraFinLabor] [varchar](20) NOT NULL,
	[HoraInicioRefrigerio] [varchar](20) NOT NULL,
	[HoraFinRefrigerio] [varchar](20) NOT NULL,
	[JuezControversia] [varchar](100) NOT NULL,
	[TieneClausulaAdicional] [bit] NULL,
	[IDClausulaAdicional] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDContratoTrabajoSujetoModalidad] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GJ_ContratoTrabajoPlazoIndeterminado]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GJ_ContratoTrabajoPlazoIndeterminado](
	[IDContratoTrabajoPlazoIndeterminado] [int] IDENTITY(1,1) NOT NULL,
	[IDRequerimientoLegalPlantillaContrato] [int] NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
	[NombreTrabajador] [varchar](100) NOT NULL,
	[DniTrabajador] [char](8) NOT NULL,
	[Cargo] [varchar](100) NOT NULL,
	[LaborDesempenar] [varchar](100) NOT NULL,
	[HoraInicioLabor] [varchar](20) NOT NULL,
	[HoraFinLabor] [varchar](20) NOT NULL,
	[HoraInicioRefrigerio] [varchar](20) NOT NULL,
	[HoraFinRefrigerio] [varchar](20) NOT NULL,
	[PeriodoPrueba] [varchar](50) NOT NULL,
	[TieneClausulaAdicional] [bit] NULL,
	[IDClausulaAdicional] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDContratoTrabajoPlazoIndeterminado] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GJ_ContatoPrestacionServicios]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GJ_ContatoPrestacionServicios](
	[IDContatoPrestacionServicios] [int] IDENTITY(1,1) NOT NULL,
	[IDRequerimientoLegalPlantillaContrato] [int] NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
	[EmpresaOutsorcing] [varchar](100) NOT NULL,
	[Ruc] [char](11) NOT NULL,
	[Domicilio] [varchar](100) NOT NULL,
	[RepresentanteLegal] [varchar](100) NOT NULL,
	[DniRepresentanteLegal] [char](8) NOT NULL,
	[FichaPoderJudicial] [varchar](100) NOT NULL,
	[ObjetoSocialOutsorcing] [varchar](100) NOT NULL,
	[ServiciosBrindar] [varchar](100) NOT NULL,
	[DuracionContrato] [varchar](50) NOT NULL,
	[JuezControversia] [varchar](100) NOT NULL,
	[TieneClausulaAdicional] [bit] NULL,
	[IDClausulaAdicional] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDContatoPrestacionServicios] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GJ_CartaNotarialDetalleVecinoColindante]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GJ_CartaNotarialDetalleVecinoColindante](
	[IDCartaNotarialDetalleVecinoColindante] [int] IDENTITY(1,1) NOT NULL,
	[IDRequerimientoLegalCartaNotarial] [int] NOT NULL,
	[IDCartaNotarialVecinoColindante] [int] NOT NULL,
	[TipoEdificacion] [char](3) NOT NULL,
	[NombreCondominio] [varchar](100) NULL,
	[Direccion] [varchar](100) NOT NULL,
	[IDDepartamento] [int] NULL,
	[IDProvincia] [int] NOT NULL,
	[IDDistrito] [int] NOT NULL,
	[Visitado] [bit] NULL,
	[FechaVisita] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDCartaNotarialDetalleVecinoColindante] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GPP_Recurso]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPP_Recurso](
	[IdRecurso] [int] NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Precio] [float] NOT NULL,
	[IdTipoRecurso] [int] NOT NULL,
 CONSTRAINT [PK_GPP_Recurso] PRIMARY KEY CLUSTERED 
(
	[IdRecurso] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GPP_DetalleRequerimiento]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GPP_DetalleRequerimiento](
	[IdDetalleRequerimiento] [int] NOT NULL,
	[Cantidad] [smallint] NOT NULL,
	[IdEmpleado] [int] NOT NULL,
	[IdRequerimientoPlanProy] [int] NOT NULL,
	[IdRecurso] [int] NOT NULL,
 CONSTRAINT [PK_GPP_DetalleRequerimiento] PRIMARY KEY CLUSTERED 
(
	[IdDetalleRequerimiento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GPP_ProyectoHist]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPP_ProyectoHist](
	[IdProyectoHist] [int] NOT NULL,
	[IdTipoProyecto] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[FechaInicioPlaneada] [char](10) NOT NULL,
	[FechaFinPlaneada] [char](10) NOT NULL,
	[FechaInicioReal] [char](10) NULL,
	[FechaFinReal] [char](10) NULL,
	[Prioridad] [int] NOT NULL,
	[Descripcion] [varchar](255) NOT NULL,
	[RazonSocial] [char](11) NOT NULL,
	[CondicionPago] [varchar](125) NOT NULL,
	[MontoFacturado] [char](5) NOT NULL,
	[NroHojaEnvio] [int] NOT NULL,
	[FechaHojaEnvio] [char](10) NULL,
	[Estado] [char](3) NOT NULL,
	[Ruc] [char](11) NOT NULL,
	[IdUbigeo] [int] NOT NULL,
	[IdEntregable] [int] NOT NULL,
	[IdPresupuesto] [int] NOT NULL,
 CONSTRAINT [PK_GPP_ProyectoHist] PRIMARY KEY CLUSTERED 
(
	[IdProyectoHist] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GSC_DetalleRequerimiento]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GSC_DetalleRequerimiento](
	[IdProyecto] [int] NOT NULL,
	[IdRequerimiento] [int] NOT NULL,
	[IdCorDetReq] [int] NOT NULL,
	[CanDetReq] [int] NULL,
	[FecInicio] [datetime] NULL,
	[FecFin] [datetime] NULL,
	[DesServicio] [varchar](200) NULL,
	[ActServicio] [char](1) NULL,
	[IdUnidadMedida] [int] NULL,
	[IdTipoServicio] [int] NULL,
 CONSTRAINT [PK_DetalleRequerimiento] PRIMARY KEY CLUSTERED 
(
	[IdProyecto] ASC,
	[IdRequerimiento] ASC,
	[IdCorDetReq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GSC_InformeFinal]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GSC_InformeFinal](
	[IdInformeFinal] [int] NOT NULL,
	[Fecha] [datetime] NULL,
	[FechaActualizacion] [datetime] NULL,
	[TextInforme] [text] NULL,
	[IdRequerimiento] [int] NULL,
	[IdProyecto] [int] NULL,
 CONSTRAINT [PK_InformeFinal] PRIMARY KEY CLUSTERED 
(
	[IdInformeFinal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GPP_PlanProyecto]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPP_PlanProyecto](
	[IdPlanProyecto] [int] NOT NULL,
	[Descripcion] [varchar](255) NOT NULL,
	[IdProyecto] [int] NOT NULL,
	[IdFlujoCaja] [int] NOT NULL,
 CONSTRAINT [PK_GPP_PlanProyecto] PRIMARY KEY CLUSTERED 
(
	[IdPlanProyecto] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GPP_PlanEmpleadosActividad]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GPP_PlanEmpleadosActividad](
	[Horas] [float] NOT NULL,
	[IdEmpleado] [int] NOT NULL,
	[IdPlanProyecto] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GSC_SolicitudProveedorTipoServicio]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GSC_SolicitudProveedorTipoServicio](
	[IdSolicitudCotizacion] [int] NOT NULL,
	[IdProveedor] [int] NOT NULL,
	[IdTipoServicio] [int] NOT NULL,
	[FechaSolProTServ] [datetime] NULL,
 CONSTRAINT [PK_SolicitudProveedorTipoServicio] PRIMARY KEY CLUSTERED 
(
	[IdSolicitudCotizacion] ASC,
	[IdProveedor] ASC,
	[IdTipoServicio] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[pa_GSC_Proveedor]    Script Date: 09/01/2013 22:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--===========================================================================================
--==========PROCEDIMIENTO ProveedorUpdate ========================
--===========================================================================================
--===========================================================================================
CREATE PROCEDURE [dbo].[pa_GSC_Proveedor]
             @IdProveedor    int=Null,
             @RucProv    varchar(11)=Null,
             @RazonSocialProv    varchar(50)=Null,
             @DireccionProv    varchar(50)=Null,
             @EmailProv    varchar(20)=Null,
             @IdRequerimiento	  int=Null,
             @IdTipoServicio    int=Null,
             @TipoBusqueda varchar(20)=Null,
             @Expresion	   varchar(20)=Null,
             @IdSolicitudCotizacion int=Null
,@TipoConsulta tinyint
AS 
if @TipoConsulta=1 
Begin
             UPDATE dbo.[GSC_Proveedor]SET 
                          [RucProv]=@RucProv,
                          [RazonSocialProv]=@RazonSocialProv,
                          [DireccionProv]=@DireccionProv,
                          [EmailProv]=@EmailProv
             WHERE  IdProveedor = @IdProveedor

End

--===========================================================================================
--==========PROCEDIMIENTO ProveedorGetByAll ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=2
begin
	select p.* from GSC_Proveedor p			
End

--===========================================================================================
--==========PROCEDIMIENTO ProveedorGetByPrimaryKey ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=3
begin
Select * from GSC_Proveedor
WHERE  IdProveedor = @IdProveedor
End

--===========================================================================================
--==========PROCEDIMIENTO ProveedorInsert ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=4
Begin
             INSERT INTO [dbo].[GSC_Proveedor]
             (
                          [IdProveedor],
                          [RucProv],
                          [RazonSocialProv],
                          [DireccionProv],
                          [EmailProv]

             )
             VALUES
             (
                          @IdProveedor,
                          @RucProv,
                          @RazonSocialProv,
                          @DireccionProv,
                          @EmailProv

             )
             SET @IdProveedor= @@IDENTITY
End

--===========================================================================================
--==========PROCEDIMIENTO ProveedorDelete ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=5
begin
Delete from GSC_Proveedor
WHERE  IdProveedor = @IdProveedor
end

--===========================================================================================
else if @TipoConsulta=6
begin
Select * from GSC_Proveedor
where RucProv Like @RucProv+ '%'
end

--===========================================================================================
--==========PROCEDIMIENTO ProveedorDelete ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=7
begin
	
	if @TipoBusqueda = 'ruc'
	begin
	
		Select p.*, pts.ContactoProvTipoServ, pts.EmailProvTipoServ, pts.CalificacionTipoServ calificacion
		from GSC_Proveedor p
		join dbo.GSC_ProveedorTipoServicio pts on pts.IdProveedor = p.IdProveedor and (pts.IdTipoServicio = @IdTipoServicio or @IdTipoServicio = 0)
		where p.RucProv like '%'+@expresion+'%' and p.EstadoProv = 'HA'
		order by pts.CalificacionTipoServ desc
	end
	else
	begin
	
		Select p.*, pts.contactoProTServ, pts.emailProTServ, pts.calificacionTServ calificacion
		from GSC_Proveedor p
		join dbo.ProveedorTipoServicio pts on pts.codProv = p.IdProveedor and (pts.codTServ = @IdTipoServicio or @IdTipoServicio = 0)
		where p.RazonSocialProv like '%'+@expresion+'%' and p.EstadoProv = 'HA'
		order by pts.calificacionTServ desc
	end
end
else if @TipoConsulta=8
begin

	Select p.*, pts.ContactoProvTipoServ, pts.EmailProvTipoServ, pts.CalificacionTipoServ calificacion
	from GSC_Proveedor p
	join GSC_SolicitudProveedorTipoServicio sp on sp.IdProveedor = p.IdProveedor and sp.IdSolicitudCotizacion = @IdSolicitudCotizacion
	join dbo.GSC_ProveedorTipoServicio pts on pts.IdProveedor = p.IdProveedor and pts.IdTipoServicio = sp.IdTipoServicio
	where p.EstadoProv = 'HA'
	order by pts.CalificacionTipoServ desc

end
GO
/****** Object:  Table [dbo].[GSC_InformeServicio]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GSC_InformeServicio](
	[IdProyecto] [int] NOT NULL,
	[IdRequerimiento] [int] NOT NULL,
	[IdCorDetReq] [int] NOT NULL,
	[IdInfServ] [int] NOT NULL,
	[Fecha] [datetime] NULL,
	[FlagFinal] [char](1) NULL,
	[TextoInforme] [text] NULL,
 CONSTRAINT [PK_InformeServicio] PRIMARY KEY CLUSTERED 
(
	[IdProyecto] ASC,
	[IdRequerimiento] ASC,
	[IdCorDetReq] ASC,
	[IdInfServ] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GSC_ParteDiario]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GSC_ParteDiario](
	[IdProyecto] [int] NOT NULL,
	[IdRequerimiento] [int] NOT NULL,
	[IdParteDiario] [int] NOT NULL,
	[IdCorDetReq] [int] NOT NULL,
	[Fecha] [datetime] NULL,
	[HoraInicio] [datetime] NULL,
	[HoraFin] [datetime] NULL,
	[Observacion] [varchar](max) NULL,
 CONSTRAINT [PK_ParteDiario] PRIMARY KEY CLUSTERED 
(
	[IdProyecto] ASC,
	[IdRequerimiento] ASC,
	[IdParteDiario] ASC,
	[IdCorDetReq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GPP_PlanProyectoHist]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPP_PlanProyectoHist](
	[IdPlanProyectoHist] [int] NOT NULL,
	[Descripcion] [varchar](255) NOT NULL,
	[IdProyectoHist] [int] NOT NULL,
 CONSTRAINT [PK_GPP_PlanProyectoHist] PRIMARY KEY CLUSTERED 
(
	[IdPlanProyectoHist] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GPP_Material]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPP_Material](
	[Marca] [varchar](150) NOT NULL,
	[Tipo] [varchar](150) NOT NULL,
	[Modelo] [varchar](255) NOT NULL,
	[UnidadMedida] [varchar](50) NOT NULL,
	[IdRecurso] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GPP_Equipo]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPP_Equipo](
	[Marca] [int] NOT NULL,
	[FechaAdquisicion] [date] NOT NULL,
	[Tipo] [varchar](150) NOT NULL,
	[Anio] [date] NOT NULL,
	[Modelo] [varchar](150) NOT NULL,
	[IdRecurso] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GSC_DetalleSolicitudRequerimiento]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GSC_DetalleSolicitudRequerimiento](
	[IdSolicitudCotizacion] [int] NOT NULL,
	[IdSolicitudDetalle] [int] IDENTITY(1,1) NOT NULL,
	[DescripSolDetalle] [varchar](200) NULL,
	[FecSolDetalle] [datetime] NULL,
	[IdProyecto] [int] NULL,
	[IdRequerimiento] [int] NULL,
	[IdCorDetReq] [int] NULL,
 CONSTRAINT [PK_DetalleSolicitudRequerimiento] PRIMARY KEY CLUSTERED 
(
	[IdSolicitudCotizacion] ASC,
	[IdSolicitudDetalle] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GSC_Cotizacion]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GSC_Cotizacion](
	[IdCotizacion] [int] IDENTITY(1,1) NOT NULL,
	[FechaInicio] [datetime] NULL,
	[FechaFin] [datetime] NULL,
	[Monto] [decimal](18, 2) NULL,
	[Igv] [decimal](18, 2) NULL,
	[Total] [decimal](18, 2) NULL,
	[Comentarios] [varchar](300) NULL,
	[PdfCotizacion] [varchar](200) NULL,
	[IdMoneda] [int] NULL,
	[IdSolicitudCotizacion] [int] NULL,
	[IdProveedor] [int] NULL,
	[IdTipoServicio] [int] NULL,
	[IdFormaPago] [int] NULL,
	[IdEstado] [int] NULL,
 CONSTRAINT [PK_Cotizacion] PRIMARY KEY CLUSTERED 
(
	[IdCotizacion] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GSC_CalificacionServicioProveedorTipoServicio]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GSC_CalificacionServicioProveedorTipoServicio](
	[IdRequerimiento] [int] NOT NULL,
	[IdTipoServicio] [int] NOT NULL,
	[IdParametroCalificacion] [int] NOT NULL,
	[Calificacion] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[IdProveedor] [int] NOT NULL,
	[IdProyecto] [int] NOT NULL,
	[IdCorDetReq] [int] NULL,
 CONSTRAINT [PK_CalificacionServicioProveedorTipoServicio] PRIMARY KEY CLUSTERED 
(
	[IdRequerimiento] ASC,
	[IdTipoServicio] ASC,
	[IdParametroCalificacion] ASC,
	[IdProveedor] ASC,
	[IdProyecto] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GJ_CartaNotarial]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GJ_CartaNotarial](
	[IDCartaNotarial] [int] IDENTITY(1,1) NOT NULL,
	[IDCartaNotarialDetalleVecinoColindante] [int] NULL,
	[FechaRecepcion] [datetime] NULL,
	[FechaRespuesta] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDCartaNotarial] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GPC_Partida]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPC_Partida](
	[IDPartida] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](200) NULL,
	[UM] [varchar](100) NULL,
	[Total] [numeric](18, 2) NULL,
	[IDPresupuestoObra] [int] NULL,
 CONSTRAINT [PK_GPC_Partida] PRIMARY KEY CLUSTERED 
(
	[IDPartida] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[GPC_Partida] ON
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (1, N'MOVILIZACION Y DESMOVILIZACION DE EQUIPOS', N'GLB', NULL, 1)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (2, N'TRAZO Y REPLANTEO', N'GLB', NULL, 1)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (3, N'MANTENIMIENTO DE TRÁNSITO Y SEGURIDAD VIAL', N'mes', NULL, 1)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (4, N'CAMPAMENTOS Y OBRAS PROVISIONALES', N'GLB', NULL, 1)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (5, N'MANTENIMIENTO DE ACCESO A CANTERAS', N'km', NULL, 1)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (6, N'CARTEL DE OBRA', N'GLB', NULL, 1)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (7, N'DESBROCE Y LIMPIEZA', N'ha', NULL, 1)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (8, N'CORTE EN MATERIAL SUELTO', N'm3', NULL, 2)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (9, N'TERRAPLENES CON MATERIAL DE CORTE', N'm3', NULL, 2)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (10, N'TERRAPLENES CON MATERIAL DE PRESTAMO', N'm3', NULL, 2)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (11, N'PERFILADO Y COMPACTACION DE LA SUBRASANTE EN ZONAS DE CORTE', N'm2', NULL, 2)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (12, N'REMOCION DE CARPETA ASFALTICA EXISTENTE', N'm2', NULL, 2)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (13, N'DEMOLICION DE ESTRUCTURAS', N'm3', NULL, 2)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (14, N'SUB BASE GRANULAR', N'm3', NULL, 2)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (15, N'AFIRMADO TIPO I', N'm3', NULL, 3)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (16, N'AFIRMADO TIPO III', N'm3', NULL, 3)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (17, N'LOSA DE CONCRETO HIDRAULICO', N'm2', NULL, 3)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (18, N'JUNTA LONGITUDINAL DE CONSTRUCCION', N'm', NULL, 3)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (19, N'JUNTA TRANSVERSAL DE CONTRACCION', N'm', NULL, 3)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (20, N'TRANSICION DE PAVIMENTO RIGIDO CON PAVIMENTO FLEXIBLE', N'm', NULL, 3)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (21, N'EXCAVACIÓN N/CLASIF. PARA ESTRUCTURAS', N'm3', NULL, 3)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (22, N'RELLENO PARA ESTRUCTURAS', N'm3', NULL, 4)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (23, N'RELLENO PARA ALCANTARILLA DE GRAN LUZ', N'm3', NULL, 4)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (24, N'CONCRETO F''C=100 KG/CM2', N'm3', NULL, 4)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (25, N'CONCRETO F''C=210 KG/CM2', N'm3', NULL, 4)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (26, N'CONCRETO CICLÓPEO F''C=140 KG/CM2 + 30%PM', N'm3', NULL, 4)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (27, N'CONCRETO CICLÓPEO F''C=175 KG/CM2 + 30%PM', N'm3', NULL, 4)
INSERT [dbo].[GPC_Partida] ([IDPartida], [Nombre], [UM], [Total], [IDPresupuestoObra]) VALUES (28, N'ENCOFRADO Y DESENCOFRADO', N'm2', NULL, 4)
SET IDENTITY_INSERT [dbo].[GPC_Partida] OFF
/****** Object:  Table [dbo].[GPC_CronogramaObra]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPC_CronogramaObra](
	[IDCronogramaObra] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](200) NULL,
	[FechaInicio] [date] NULL,
	[FechaFin] [date] NULL,
	[Responsable] [varchar](200) NULL,
	[IDPresupuestoObra] [int] NULL,
 CONSTRAINT [PK_GPC_CronogramaObra] PRIMARY KEY CLUSTERED 
(
	[IDCronogramaObra] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[GPC_CronogramaObra] ON
INSERT [dbo].[GPC_CronogramaObra] ([IDCronogramaObra], [Nombre], [FechaInicio], [FechaFin], [Responsable], [IDPresupuestoObra]) VALUES (1, N'Proyecto Interbank', CAST(0x68370B00 AS Date), NULL, N'Juan Vento', 1)
INSERT [dbo].[GPC_CronogramaObra] ([IDCronogramaObra], [Nombre], [FechaInicio], [FechaFin], [Responsable], [IDPresupuestoObra]) VALUES (2, N'Proyecto Scotiabank', CAST(0x68370B00 AS Date), NULL, N'Juan Vento', 2)
INSERT [dbo].[GPC_CronogramaObra] ([IDCronogramaObra], [Nombre], [FechaInicio], [FechaFin], [Responsable], [IDPresupuestoObra]) VALUES (3, N'Proyecto BCP', CAST(0x68370B00 AS Date), NULL, N'Juan Vento', 3)
INSERT [dbo].[GPC_CronogramaObra] ([IDCronogramaObra], [Nombre], [FechaInicio], [FechaFin], [Responsable], [IDPresupuestoObra]) VALUES (4, N'Proyecto Continental', CAST(0x68370B00 AS Date), NULL, N'Juan Vento', 4)
SET IDENTITY_INSERT [dbo].[GPC_CronogramaObra] OFF
/****** Object:  Table [dbo].[GPP_Actividad]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPP_Actividad](
	[IdActividad] [int] NOT NULL,
	[Correlativo] [int] NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFin] [date] NOT NULL,
	[Predecesor] [varchar](255) NOT NULL,
	[Tipo] [char](1) NOT NULL,
	[IdEntregable] [int] NOT NULL,
	[IdPlanProyecto] [int] NOT NULL,
 CONSTRAINT [PK_GPP_Actividad] PRIMARY KEY CLUSTERED 
(
	[IdActividad] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GPC_Solicitud]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPC_Solicitud](
	[IDSolicitud] [int] IDENTITY(1,1) NOT NULL,
	[FechaRegistro] [datetime] NULL,
	[Observacion] [varchar](500) NULL,
	[IDPresupuestoObra] [int] NULL,
	[IDEstado] [int] NULL,
	[IDUsuario] [int] NULL,
	[IDTipoSolicitud] [int] NULL,
 CONSTRAINT [PK_GPC_Solicitud] PRIMARY KEY CLUSTERED 
(
	[IDSolicitud] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[GPC_Solicitud] ON
INSERT [dbo].[GPC_Solicitud] ([IDSolicitud], [FechaRegistro], [Observacion], [IDPresupuestoObra], [IDEstado], [IDUsuario], [IDTipoSolicitud]) VALUES (1, CAST(0x0000A214003CFAC3 AS DateTime), N'PRUEBA 3 ANULAR', 3, 4, 2, 1)
SET IDENTITY_INSERT [dbo].[GPC_Solicitud] OFF
/****** Object:  Table [dbo].[GPC_Notificacion]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPC_Notificacion](
	[IDNotificacion] [int] IDENTITY(1,1) NOT NULL,
	[FechaRegistro] [datetime] NULL,
	[Observacion] [varchar](500) NULL,
	[IDPresupuestoObra] [int] NULL,
 CONSTRAINT [PK_GPC_Notificacion] PRIMARY KEY CLUSTERED 
(
	[IDNotificacion] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[GPC_Notificacion] ON
INSERT [dbo].[GPC_Notificacion] ([IDNotificacion], [FechaRegistro], [Observacion], [IDPresupuestoObra]) VALUES (3, CAST(0x0000A214003C9DDA AS DateTime), N'PRUEBA 1 APROBAR', 1)
INSERT [dbo].[GPC_Notificacion] ([IDNotificacion], [FechaRegistro], [Observacion], [IDPresupuestoObra]) VALUES (4, CAST(0x0000A214003CD9D8 AS DateTime), N'PRUEBA 2 RECHAZAR', 2)
INSERT [dbo].[GPC_Notificacion] ([IDNotificacion], [FechaRegistro], [Observacion], [IDPresupuestoObra]) VALUES (5, CAST(0x0000A214003CFAC6 AS DateTime), N'PRUEBA 3 ANULAR', 3)
INSERT [dbo].[GPC_Notificacion] ([IDNotificacion], [FechaRegistro], [Observacion], [IDPresupuestoObra]) VALUES (6, CAST(0x0000A21400E39CDE AS DateTime), N'PRUEBA APROBAR', 1)
INSERT [dbo].[GPC_Notificacion] ([IDNotificacion], [FechaRegistro], [Observacion], [IDPresupuestoObra]) VALUES (7, CAST(0x0000A21400E67313 AS DateTime), N'APROBAR PRESUPUESTO CONTINENTAL', 4)
SET IDENTITY_INSERT [dbo].[GPC_Notificacion] OFF
/****** Object:  Table [dbo].[GPC_HistoricoAprobacion]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPC_HistoricoAprobacion](
	[IDHistoricoAprobacion] [int] IDENTITY(1,1) NOT NULL,
	[FechaRegistro] [datetime] NULL,
	[Observacion] [varchar](500) NULL,
	[IDPresupuestoObra] [int] NULL,
	[IDEstado] [int] NULL,
	[IDUsuario] [int] NULL,
 CONSTRAINT [PK_GPC_HistoricoAprobacion] PRIMARY KEY CLUSTERED 
(
	[IDHistoricoAprobacion] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[GPC_HistoricoAprobacion] ON
INSERT [dbo].[GPC_HistoricoAprobacion] ([IDHistoricoAprobacion], [FechaRegistro], [Observacion], [IDPresupuestoObra], [IDEstado], [IDUsuario]) VALUES (0, CAST(0x0000A21400371BD9 AS DateTime), NULL, 1, 6, 2)
INSERT [dbo].[GPC_HistoricoAprobacion] ([IDHistoricoAprobacion], [FechaRegistro], [Observacion], [IDPresupuestoObra], [IDEstado], [IDUsuario]) VALUES (2, CAST(0x0000A214003A4F1B AS DateTime), N'PRUEBA 1-APROBAR', 2, 6, 2)
INSERT [dbo].[GPC_HistoricoAprobacion] ([IDHistoricoAprobacion], [FechaRegistro], [Observacion], [IDPresupuestoObra], [IDEstado], [IDUsuario]) VALUES (3, CAST(0x0000A214003C4661 AS DateTime), N'PRUEBA 1 APROBAR', 1, 6, 2)
INSERT [dbo].[GPC_HistoricoAprobacion] ([IDHistoricoAprobacion], [FechaRegistro], [Observacion], [IDPresupuestoObra], [IDEstado], [IDUsuario]) VALUES (4, CAST(0x0000A214003C9DDA AS DateTime), N'PRUEBA 1 APROBAR', 1, 6, 2)
INSERT [dbo].[GPC_HistoricoAprobacion] ([IDHistoricoAprobacion], [FechaRegistro], [Observacion], [IDPresupuestoObra], [IDEstado], [IDUsuario]) VALUES (5, CAST(0x0000A214003CD9D6 AS DateTime), N'PRUEBA 2 RECHAZAR', 2, 3, 2)
INSERT [dbo].[GPC_HistoricoAprobacion] ([IDHistoricoAprobacion], [FechaRegistro], [Observacion], [IDPresupuestoObra], [IDEstado], [IDUsuario]) VALUES (6, CAST(0x0000A21400E39CD7 AS DateTime), N'PRUEBA APROBAR', 1, 6, 2)
INSERT [dbo].[GPC_HistoricoAprobacion] ([IDHistoricoAprobacion], [FechaRegistro], [Observacion], [IDPresupuestoObra], [IDEstado], [IDUsuario]) VALUES (7, CAST(0x0000A21400E67313 AS DateTime), N'APROBAR PRESUPUESTO CONTINENTAL', 4, 6, 2)
SET IDENTITY_INSERT [dbo].[GPC_HistoricoAprobacion] OFF
/****** Object:  Table [dbo].[GPC_ExpedienteTecnico]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GPC_ExpedienteTecnico](
	[IDExpedienteTecnico] [int] IDENTITY(1,1) NOT NULL,
	[RutaArchivoAnalisis] [nvarchar](200) NULL,
	[NombreArchivo] [nvarchar](200) NULL,
	[Observacion] [nvarchar](250) NULL,
	[UsuarioModificacion] [nvarchar](250) NULL,
	[FechaModificacion] [datetime] NULL,
	[IDPresupuestoObra] [int] NULL,
 CONSTRAINT [PK_GPC_ExpedienteTecnico] PRIMARY KEY CLUSTERED 
(
	[IDExpedienteTecnico] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GPP_Articulo]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPP_Articulo](
	[UnidadMedida] [varchar](50) NOT NULL,
	[IdRecurso] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GPP_ActividadHist]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPP_ActividadHist](
	[IdActividadHistorica] [int] NOT NULL,
	[Correlativo] [int] NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[FechaInicio] [char](10) NOT NULL,
	[FechaFin] [char](10) NOT NULL,
	[Predecesor] [varchar](255) NOT NULL,
	[Tipo] [char](1) NOT NULL,
	[IdEntregable] [int] NOT NULL,
	[IdPlanProyectoHist] [int] NOT NULL,
 CONSTRAINT [PK_GPP_ActividadHist] PRIMARY KEY CLUSTERED 
(
	[IdActividadHistorica] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GPC_DetallePartida]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GPC_DetallePartida](
	[IDDetallePartida] [int] IDENTITY(1,1) NOT NULL,
	[Cantidad] [numeric](18, 2) NULL,
	[PrecioUnitarioReal] [numeric](18, 2) NULL,
	[IDPartida] [int] NULL,
	[IDCategoria] [int] NULL,
	[IDAPU] [int] NULL,
 CONSTRAINT [PK_GPC_DetallePartida] PRIMARY KEY CLUSTERED 
(
	[IDDetallePartida] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[GPC_DetallePartida] ON
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (1, CAST(1000.00 AS Numeric(18, 2)), CAST(219542.83 AS Numeric(18, 2)), 1, 1, 1)
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (2, CAST(727.27 AS Numeric(18, 2)), CAST(9.51 AS Numeric(18, 2)), 2, 2, 2)
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (3, CAST(1454.55 AS Numeric(18, 2)), CAST(5.10 AS Numeric(18, 2)), 2, 2, 3)
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (4, CAST(1600.00 AS Numeric(18, 2)), CAST(1.36 AS Numeric(18, 2)), 2, 1, 4)
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (5, CAST(320.00 AS Numeric(18, 2)), CAST(0.37 AS Numeric(18, 2)), 2, 1, 5)
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (6, CAST(176.00 AS Numeric(18, 2)), CAST(10.20 AS Numeric(18, 2)), 2, 1, 6)
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (7, CAST(5.00 AS Numeric(18, 2)), CAST(14334.54 AS Numeric(18, 2)), 2, 3, 7)
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (8, CAST(727.27 AS Numeric(18, 2)), CAST(2.50 AS Numeric(18, 2)), 2, 3, 8)
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (9, CAST(727.27 AS Numeric(18, 2)), CAST(7.50 AS Numeric(18, 2)), 2, 3, 9)
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (10, CAST(0.80 AS Numeric(18, 2)), CAST(9.51 AS Numeric(18, 2)), 3, 2, 10)
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (11, CAST(48.00 AS Numeric(18, 2)), CAST(5.10 AS Numeric(18, 2)), 3, 2, 3)
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (12, CAST(20.00 AS Numeric(18, 2)), CAST(43.53 AS Numeric(18, 2)), 3, 1, 11)
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (13, CAST(150.00 AS Numeric(18, 2)), CAST(1.15 AS Numeric(18, 2)), 3, 1, 12)
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (14, CAST(8.00 AS Numeric(18, 2)), CAST(110.00 AS Numeric(18, 2)), 3, 1, 13)
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (15, CAST(5.00 AS Numeric(18, 2)), CAST(2.70 AS Numeric(18, 2)), 3, 1, 14)
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (16, CAST(6.00 AS Numeric(18, 2)), CAST(3.43 AS Numeric(18, 2)), 3, 1, 15)
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (17, CAST(3.00 AS Numeric(18, 2)), CAST(252.41 AS Numeric(18, 2)), 3, 3, 7)
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (18, CAST(16.00 AS Numeric(18, 2)), CAST(45.45 AS Numeric(18, 2)), 3, 3, 17)
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (19, CAST(2.40 AS Numeric(18, 2)), CAST(91.56 AS Numeric(18, 2)), 3, 3, 18)
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (20, CAST(8.00 AS Numeric(18, 2)), CAST(52.40 AS Numeric(18, 2)), 3, 3, 19)
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (21, CAST(0.80 AS Numeric(18, 2)), CAST(87.31 AS Numeric(18, 2)), 3, 3, 20)
INSERT [dbo].[GPC_DetallePartida] ([IDDetallePartida], [Cantidad], [PrecioUnitarioReal], [IDPartida], [IDCategoria], [IDAPU]) VALUES (22, CAST(8.00 AS Numeric(18, 2)), CAST(72.44 AS Numeric(18, 2)), 3, 3, 21)
SET IDENTITY_INSERT [dbo].[GPC_DetallePartida] OFF
/****** Object:  Table [dbo].[GPC_ActividadObra]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GPC_ActividadObra](
	[IDActividadObra] [int] IDENTITY(1,1) NOT NULL,
	[Responsable] [varchar](200) NULL,
	[Fecha] [date] NULL,
	[Hito] [varchar](500) NULL,
	[Nombre] [varchar](200) NULL,
	[IDCronogramaObra] [int] NULL,
 CONSTRAINT [PK_GPC_ActividadObra] PRIMARY KEY CLUSTERED 
(
	[IDActividadObra] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[GPC_ActividadObra] ON
INSERT [dbo].[GPC_ActividadObra] ([IDActividadObra], [Responsable], [Fecha], [Hito], [Nombre], [IDCronogramaObra]) VALUES (1, N'Juan Vento', CAST(0x75370B00 AS Date), N'Revisión', N'MOVILIZACION Y DESMOVILIZACION DE EQUIPOS', 1)
INSERT [dbo].[GPC_ActividadObra] ([IDActividadObra], [Responsable], [Fecha], [Hito], [Nombre], [IDCronogramaObra]) VALUES (2, N'Juan Vento', CAST(0x76370B00 AS Date), N'Revisión', N'TRAZO Y REPLANTEO', 1)
INSERT [dbo].[GPC_ActividadObra] ([IDActividadObra], [Responsable], [Fecha], [Hito], [Nombre], [IDCronogramaObra]) VALUES (3, N'Juan Vento', CAST(0x16370B00 AS Date), N'Revisión', N'MANTENIMIENTO DE TRANSITO Y SEGURIDAD VIAL', 2)
INSERT [dbo].[GPC_ActividadObra] ([IDActividadObra], [Responsable], [Fecha], [Hito], [Nombre], [IDCronogramaObra]) VALUES (4, N'Juan Vento', CAST(0x17370B00 AS Date), N'Revisión', N'CAMPAMENTO Y OBRAS PROVISIONALES', 2)
INSERT [dbo].[GPC_ActividadObra] ([IDActividadObra], [Responsable], [Fecha], [Hito], [Nombre], [IDCronogramaObra]) VALUES (5, N'Juan Vento', CAST(0x87370B00 AS Date), N'Revisión', N'ACCESO A CANTERA', 3)
INSERT [dbo].[GPC_ActividadObra] ([IDActividadObra], [Responsable], [Fecha], [Hito], [Nombre], [IDCronogramaObra]) VALUES (6, N'Juan Vento', CAST(0x88370B00 AS Date), N'Revisión', N'CARTEL DE OBRA', 3)
INSERT [dbo].[GPC_ActividadObra] ([IDActividadObra], [Responsable], [Fecha], [Hito], [Nombre], [IDCronogramaObra]) VALUES (7, N'Juan Vento', CAST(0x76370B00 AS Date), N'Revisión', N'DESBROCE Y LIMPIEZA', 4)
INSERT [dbo].[GPC_ActividadObra] ([IDActividadObra], [Responsable], [Fecha], [Hito], [Nombre], [IDCronogramaObra]) VALUES (8, N'Juan Vento', CAST(0x77370B00 AS Date), N'Revisión', N'CORTE EN MATERIAL SUELTO', 4)
SET IDENTITY_INSERT [dbo].[GPC_ActividadObra] OFF
/****** Object:  Table [dbo].[GSC_Incidencia]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GSC_Incidencia](
	[IdProyecto] [int] NOT NULL,
	[IdRequerimiento] [int] NOT NULL,
	[IdCorDetReq] [int] NOT NULL,
	[IdParteDiario] [int] NOT NULL,
	[IdIncidencia] [int] NOT NULL,
	[DescIncidencia] [varchar](50) NULL,
	[ObservacionesTecnicas] [varchar](max) NULL,
 CONSTRAINT [PK_Incidencia] PRIMARY KEY CLUSTERED 
(
	[IdProyecto] ASC,
	[IdRequerimiento] ASC,
	[IdCorDetReq] ASC,
	[IdParteDiario] ASC,
	[IdIncidencia] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GSC_DetalleCotizacion]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GSC_DetalleCotizacion](
	[IdCotizacion] [int] NOT NULL,
	[IdCotDet] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](200) NULL,
	[Cantidad] [decimal](18, 2) NULL,
	[Precio] [decimal](18, 2) NULL,
	[Importe] [decimal](18, 2) NULL,
	[IdUnidadMedida] [int] NULL,
	[IdSolicitudCotizacion] [int] NULL,
	[IdSolicitudDetalle] [int] NULL,
 CONSTRAINT [PK_DetalleCotizacion] PRIMARY KEY CLUSTERED 
(
	[IdCotizacion] ASC,
	[IdCotDet] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GPP_PlanSubcontratasActividad]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GPP_PlanSubcontratasActividad](
	[Cantidad] [smallint] NOT NULL,
	[Horas] [float] NOT NULL,
	[IdProveedor] [int] NOT NULL,
	[IdActividad] [int] NOT NULL,
 CONSTRAINT [PK_GPP_PlanSubcontratasActividad] PRIMARY KEY CLUSTERED 
(
	[IdProveedor] ASC,
	[IdActividad] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GPP_PlanRecursosActividad]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GPP_PlanRecursosActividad](
	[Cantidad] [smallint] NOT NULL,
	[Horas] [float] NOT NULL,
	[IdRecurso] [int] NOT NULL,
	[IdActividad] [int] NOT NULL,
 CONSTRAINT [PK_GPP_PlanRecursosActividad] PRIMARY KEY CLUSTERED 
(
	[IdRecurso] ASC,
	[IdActividad] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GSC_OrdenPago]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GSC_OrdenPago](
	[IdProyecto] [int] NOT NULL,
	[IdRequerimiento] [int] NOT NULL,
	[IdCorDetReq] [int] NOT NULL,
	[IdOrdenPago] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Monto] [decimal](18, 2) NOT NULL,
	[IdInfServ] [int] NULL,
 CONSTRAINT [PK_OrdenPago] PRIMARY KEY CLUSTERED 
(
	[IdProyecto] ASC,
	[IdRequerimiento] ASC,
	[IdCorDetReq] ASC,
	[IdOrdenPago] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[pa_GSC_SolicitudProveedorTipoServicio]    Script Date: 09/01/2013 22:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--===========================================================================================
--==========PROCEDIMIENTO SolicitudProveedorTipoServicioUpdate ========================
--===========================================================================================
--===========================================================================================
CREATE PROCEDURE [dbo].[pa_GSC_SolicitudProveedorTipoServicio]
             @IdSolicitudCotizacion    int=Null,
             @IdProveedor    int=Null,
             @IdTipoServicio    int=Null,
             @FechaSolProTServ    datetime=Null

,@TipoConsulta tinyint
AS 
if @TipoConsulta=1 
Begin
             UPDATE dbo.[GSC_SolicitudProveedorTipoServicio]SET 
                          [IdProveedor]=@IdProveedor,
                          [IdTipoServicio]=@IdTipoServicio,
                          [FechaSolProTServ]=@FechaSolProTServ
             WHERE  IdSolicitudCotizacion = @IdSolicitudCotizacion And IdProveedor = @IdProveedor And IdTipoServicio = @IdTipoServicio

End

--===========================================================================================
--==========PROCEDIMIENTO SolicitudProveedorTipoServicioGetByAll ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=2
begin
Select * from GSC_SolicitudProveedorTipoServicio
End

--===========================================================================================
--==========PROCEDIMIENTO SolicitudProveedorTipoServicioGetByPrimaryKey ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=3
begin
Select * from GSC_SolicitudProveedorTipoServicio
WHERE  IdSolicitudCotizacion = @IdSolicitudCotizacion And IdProveedor = @IdProveedor And IdTipoServicio = @IdTipoServicio
End

--===========================================================================================
--==========PROCEDIMIENTO SolicitudProveedorTipoServicioInsert ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=4
Begin
	
	if (select count(*) from GSC_SolicitudProveedorTipoServicio where IdSolicitudCotizacion = @IdSolicitudCotizacion and IdProveedor = @IdProveedor and IdTipoServicio = @IdTipoServicio) = 0
    begin
     INSERT INTO [dbo].[GSC_SolicitudProveedorTipoServicio]
     (
          [IdSolicitudCotizacion],
          [IdProveedor],
          [IdTipoServicio],
          [FechaSolProTServ]
     )
     VALUES
     (
          @IdSolicitudCotizacion,
          @IdProveedor,
          @IdTipoServicio,
          getDate()
     )
    end
End

--===========================================================================================
--==========PROCEDIMIENTO SolicitudProveedorTipoServicioDelete ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=5
begin
Delete from GSC_SolicitudProveedorTipoServicio
WHERE  IdSolicitudCotizacion = @IdSolicitudCotizacion And IdProveedor = @IdProveedor And IdTipoServicio = @IdTipoServicio
end

--===========================================================================================
else if @TipoConsulta=6
begin
Select * from GSC_SolicitudProveedorTipoServicio
where IdProveedor Like @IdProveedor+ '%'
end

--===========================================================================================
--==========PROCEDIMIENTO SolicitudProveedorTipoServicioGetcodSolCotizacion ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=7
Begin
Select * from GSC_SolicitudProveedorTipoServicio
where IdSolicitudCotizacion = @IdSolicitudCotizacion
end

--===========================================================================================
--===========================================================================================
--==========PROCEDIMIENTO SolicitudProveedorTipoServicioGetcodProv ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=8
Begin
Select * from GSC_SolicitudProveedorTipoServicio
where IdProveedor = @IdProveedor
end

--===========================================================================================
--===========================================================================================
--==========PROCEDIMIENTO SolicitudProveedorTipoServicioGetcodTServ ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=9
Begin
	Select sp.*, p.RazonSocialProv, s.FecSolCotizacion, ts.DescripTServicio
	from GSC_SolicitudProveedorTipoServicio sp	
	join GSC_SolicitudCotizacion s on sp.IdSolicitudCotizacion = s.IdSolicitudCotizacion
	join GSC_Proveedor p on p.IdProveedor = sp.IdProveedor
	join GSC_TipoServicio ts on ts.IdTipoServicio = sp.IdTipoServicio
	where (sp.IdTipoServicio = @IdTipoServicio or @IdTipoServicio = 0) and (sp.IdSolicitudCotizacion = @IdSolicitudCotizacion or @IdSolicitudCotizacion = 0) and
	      (sp.IdProveedor = @IdProveedor or @IdProveedor = 0) and
	      (select count(*) from GSC_Cotizacion c where c.IdSolicitudCotizacion = sp.IdSolicitudCotizacion and
	       c.IdProveedor = sp.IdProveedor and c.IdTipoServicio = sp.IdTipoServicio) = 0
end
GO
/****** Object:  StoredProcedure [dbo].[pa_GSC_DetalleRequerimiento]    Script Date: 09/01/2013 22:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--===========================================================================================
--==========PROCEDIMIENTO DetalleRequerimientoUpdate ========================
--===========================================================================================
--===========================================================================================
CREATE PROCEDURE [dbo].[pa_GSC_DetalleRequerimiento]
             @IdProyecto    int=Null,
             @IdRequerimiento    int=Null,
             @IdCorDetReq    int=Null,
             @CanDetReq    int=Null,
             @FecInicio    datetime=Null,
             @FecFin    datetime=Null,
             @DesServicio    varchar(200)=Null,
             @ActServicio    char(1)=Null,
             @IdUnidadMedida    int=Null,
             @IdTipoServicio int=Null,
             @IdSolicitudCotizacion int=Null

,@TipoConsulta tinyint
AS 
if @TipoConsulta=1 
Begin
             UPDATE dbo.[GSC_DetalleRequerimiento]SET 
                          [IdRequerimiento]=@IdRequerimiento,
                          [IdCorDetReq]=@IdCorDetReq,
                          [CanDetReq]=@CanDetReq,
                          [FecInicio]=@FecInicio,
                          [FecFin]=@FecFin,
                          [DesServicio]=@desServicio,
                          [ActServicio]=@actServicio,
                          [IdUnidadMedida]=@IdUnidadMedida
             WHERE  IdProyecto = @IdProyecto And IdRequerimiento = @IdRequerimiento And IdCorDetReq = @IdCorDetReq

End

--===========================================================================================
--==========PROCEDIMIENTO DetalleRequerimientoGetByAll ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=2
begin
Select * from GSC_DetalleRequerimiento
End

--===========================================================================================
--==========PROCEDIMIENTO DetalleRequerimientoGetByPrimaryKey ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=3
begin
Select * from GSC_DetalleRequerimiento
WHERE  IdProyecto = @IdProyecto And IdRequerimiento = @IdRequerimiento And IdCorDetReq = @IdCorDetReq
End

--===========================================================================================
--==========PROCEDIMIENTO DetalleRequerimientoInsert ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=4
Begin
             INSERT INTO [dbo].[GSC_DetalleRequerimiento]
             (
                          [IdProyecto],
                          [IdRequerimiento],
                          [IdCorDetReq],
                          [CanDetReq],
                          [FecInicio],
                          [FecFin],
                          [DesServicio],
                          [ActServicio],
                          [IdUnidadMedida]

             )
             VALUES
             (
                          @IdProyecto,
                          @IdRequerimiento,
                          @IdCorDetReq,
                          @CanDetReq,
                          @FecInicio,
                          @FecFin,
                          @DesServicio,
                          @ActServicio,
                          @IdUnidadMedida

             )
             --SET @codPro= @@IDENTITY
End

--===========================================================================================
--==========PROCEDIMIENTO DetalleRequerimientoDelete ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=5
begin
Delete from GSC_DetalleRequerimiento
WHERE  IdProyecto = @IdProyecto And IdRequerimiento = @IdRequerimiento And IdCorDetReq = @IdCorDetReq
end

--===========================================================================================
else if @TipoConsulta=6
begin
Select * from GSC_DetalleRequerimiento
where IdRequerimiento Like @IdRequerimiento+ '%'
end

--===========================================================================================
--==========PROCEDIMIENTO DetalleRequerimientoGetcodPro ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=7
Begin
Select * from GSC_DetalleRequerimiento
where IdProyecto = @IdProyecto
end

--===========================================================================================
--===========================================================================================
--==========PROCEDIMIENTO DetalleRequerimientoGetcodReq ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=8
Begin
	Select * from GSC_DetalleRequerimiento
	where IdRequerimiento = @IdRequerimiento
end

--===========================================================================================
--===========================================================================================
--==========PROCEDIMIENTO DetalleRequerimientoGetcodcorDetReq ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=9
Begin
	Select * from GSC_DetalleRequerimiento
	where IdCorDetReq = @IdCorDetReq
end
else if @TipoConsulta=10
Begin
	Select distinct um.DescripUMedi, dr.*, p.Nombre, re.DescripReq
	from GSC_DetalleRequerimiento dr
	join GSC_Requerimiento re on dr.IdRequerimiento = re.IdRequerimiento
	join GPP_Proyecto p on p.IdProyecto = dr.IdProyecto
	join GSC_UnidadMedida um on dr.IdUnidadMedida = um.IdUnidadMedida
	where (dr.IdProyecto = @IdProyecto or @IdProyecto = 0) and (dr.IdRequerimiento = @IdRequerimiento or @IdRequerimiento = 0) and dr.IdTipoServicio = @IdTipoServicio and
          (select count(*) from GSC_DetalleSolicitudRequerimiento dsr 
     	   join GSC_SolicitudCotizacion sc on sc.IdSolicitudCotizacion = dsr.IdSolicitudCotizacion
		   where sc.IdEstado not in (3,4) and dsr.IdRequerimiento = dr.IdRequerimiento and dsr.IdCorDetReq = dr.IdCorDetReq and dsr.IdProyecto = dr.IdProyecto) = 0
end
else if @TipoConsulta=11
begin
	
	Select distinct um.DescripUMedi, dr.*, p.Nombre, dsr.DescripSolDetalle, re.DescripReq	       
	from GSC_DetalleSolicitudRequerimiento dsr
	join GPP_Proyecto p on p.IdProyecto = dsr.IdProyecto
	join GSC_Requerimiento re on re.IdRequerimiento = dsr.IdRequerimiento
	
	join GSC_DetalleRequerimiento dr on dsr.IdProyecto = dr.IdProyecto and dsr.IdRequerimiento = dr.IdRequerimiento and dsr.IdCorDetReq = dr.IdCorDetReq
	join GSC_UnidadMedida um on dr.IdUnidadMedida = um.IdUnidadMedida
	where dsr.IdSolicitudCotizacion = @IdSolicitudCotizacion
	
end
GO
/****** Object:  StoredProcedure [dbo].[pa_GSC_DetalleCotizacion]    Script Date: 09/01/2013 22:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--===========================================================================================
--==========PROCEDIMIENTO DetalleCotizacionUpdate ========================
--===========================================================================================
--===========================================================================================
CREATE PROCEDURE [dbo].[pa_GSC_DetalleCotizacion]
             @IdCotizacion    int=Null,
             @IdCotDet    int=Null output,
             @Descripcion    varchar(200)=Null,
             @Cantidad    decimal(18,2)=Null,
             @Precio    decimal(18,2)=Null,
             @Importe    decimal(18,2)=Null,
             @IdUnidadMedida    int=Null,
             @IdSolicitudCotizacion int=Null,
             @IdSolicitudDetalle int=Null
,@TipoConsulta tinyint
AS 
if @TipoConsulta=1 
Begin
             UPDATE dbo.[GSC_DetalleCotizacion]SET 
                          [Descripcion]=@Descripcion,
                          [Cantidad]=@Cantidad,
                          [Precio]=@Precio,
                          [Importe]=@importe,
                          [IdUnidadMedida]=@IdUnidadMedida,
                          IdSolicitudCotizacion=@IdSolicitudCotizacion,
						  IdSolicitudDetalle=@IdSolicitudDetalle
             WHERE  IdCotizacion = @IdCotizacion And IdCotDet = @IdCotDet

End

--===========================================================================================
--==========PROCEDIMIENTO DetalleCotizacionGetByAll ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=2
begin
Select * from GSC_DetalleCotizacion
End

--===========================================================================================
--==========PROCEDIMIENTO DetalleCotizacionGetByPrimaryKey ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=3
begin
Select * from GSC_DetalleCotizacion
WHERE  IdCotizacion = @IdCotizacion And IdCotDet = @IdCotDet
End

--===========================================================================================
--==========PROCEDIMIENTO DetalleCotizacionInsert ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=4
Begin
     INSERT INTO [dbo].[GSC_DetalleCotizacion]
     (
          [IdCotizacion],
          [Descripcion],
          [Cantidad],
          [Precio],
          [Importe],
          [IdUnidadMedida],
          [IdSolicitudCotizacion],
		  [IdSolicitudDetalle]
     )
     VALUES
     (
          @IdCotizacion,
          @Descripcion,
          @Cantidad,
          @Precio,
          @Importe,
          @IdUnidadMedida,
          @IdSolicitudCotizacion,
          @IdSolicitudDetalle
     )
     SET @IdSolicitudDetalle = @@IDENTITY
End

--===========================================================================================
--==========PROCEDIMIENTO DetalleCotizacionDelete ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=5
begin
Delete from GSC_DetalleCotizacion
WHERE  IdCotizacion = @IdCotizacion And IdCotDet = @IdCotDet
end

--===========================================================================================
else if @TipoConsulta=6
begin
Select * from GSC_DetalleCotizacion
where IdCotDet Like @IdCotDet+ '%'
end

--===========================================================================================
--==========PROCEDIMIENTO DetalleCotizacionGetcodCotizacion ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=7
Begin
	Select dc.*, e.DescripEstado
	from GSC_DetalleCotizacion dc
	join GSC_Cotizacion c on c.IdCotizacion = dc.IdCotizacion
	join GSC_Estado e on c.IdEstado = e.IdEstado
	where dc.IdSolicitudCotizacion = @IdSolicitudCotizacion and dc.IdSolicitudDetalle = @IdSolicitudDetalle
end

--===========================================================================================
--===========================================================================================
--==========PROCEDIMIENTO DetalleCotizacionGetcodUM ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=8
Begin
Select * from GSC_DetalleCotizacion
where IdUnidadMedida = @IdUnidadMedida
end
GO
/****** Object:  StoredProcedure [dbo].[pa_GSC_Cotizacion]    Script Date: 09/01/2013 22:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--===========================================================================================
--==========PROCEDIMIENTO CotizacionUpdate ========================
--===========================================================================================
--===========================================================================================
CREATE PROCEDURE [dbo].[pa_GSC_Cotizacion]
             @IdCotizacion    int=Null output,
             @FechaInicio    datetime=Null,
             @FechaFin    datetime=Null,
             @Monto    decimal(9)=Null,
             @Igv    decimal(9)=Null,
             @Total    decimal(9)=Null,
             @Comentarios    varchar(300)=Null,
             @PdfCotizacion    varchar(200)=Null,
             @IdMoneda    int=Null,
             @IdSolicitudCotizacion    int=Null,
             @IdProveedor    int=Null,
             @IdTipoServicio    int=Null,
             @IdFormaPago  int=Null,
             @IdEstado   int=Null,
             
             @TipoFecha varchar(20)=Null,
             @IdProyecto int=Null,
             @EliminarDetalle bit=Null

,@TipoConsulta tinyint
AS 
if @TipoConsulta=1 
Begin     
     
     if @EliminarDetalle = 1 
     begin
		UPDATE dbo.[GSC_Cotizacion]SET 
          [FechaInicio]=@fechaInicio,
          [FechaFin]=@FechaFin,
          [Monto]=@Monto,
          [Igv]=@Igv,
          [Total]=@Total,
          [Comentarios]=@Comentarios,
          [IdMoneda]=@IdMoneda,
          [IdSolicitudCotizacion]=@IdSolicitudCotizacion,
          [IdProveedor]=@IdProveedor,
          [IdTipoServicio]=@IdTipoServicio,
          [IdFormaPago]=@IdFormaPago
		WHERE  IdCotizacion = @IdCotizacion
     
		delete from GSC_DetalleCotizacion WHERE IdCotizacion = @IdCotizacion
	end
	else
	begin
		UPDATE dbo.[GSC_Cotizacion]SET 
          [FechaInicio]=@FechaInicio,
          [FechaFin]=@FechaFin,
          [Monto]=@Monto,
          [Igv]=@Igv,
          [Total]=@Total,
          [Comentarios]=@Comentarios,
          [PdfCotizacion]=@PdfCotizacion,
          [IdMoneda]=@IdMoneda,
          [IdSolicitudCotizacion]=@IdSolicitudCotizacion,
          [IdProveedor]=@IdProveedor,
          [IdTipoServicio]=@IdTipoServicio,
          [IdFormaPago]=@IdFormaPago
		WHERE  IdCotizacion = @IdCotizacion
	end

End

--===========================================================================================
--==========PROCEDIMIENTO CotizacionGetByAll ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=2
begin
Select * from GSC_Cotizacion
End

--===========================================================================================
--==========PROCEDIMIENTO CotizacionGetByPrimaryKey ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=3
begin
Select * from GSC_Cotizacion
WHERE  IdCotizacion = @IdCotizacion
End

--===========================================================================================
--==========PROCEDIMIENTO CotizacionInsert ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=4
Begin
     INSERT INTO [dbo].[GSC_Cotizacion]
     (
          [FechaInicio],
          [FechaFin],
          [Monto],
          [Igv],
          [Total],
          [Comentarios],
          [PdfCotizacion],
          [IdMoneda],
          [IdSolicitudCotizacion],
          [IdProveedor],
          [IdTipoServicio],
		  [IdFormaPago],
		  [IdEstado]
     )
     VALUES
     (
          @FechaInicio,
          @FechaFin,
          @Monto,
          @Igv,
          @Total,
          @Comentarios,
          @PdfCotizacion,
          @IdMoneda,
          @IdSolicitudCotizacion,
          @IdProveedor,
          @IdTipoServicio,
		  @IdFormaPago,
		  1
     )
     SET @IdCotizacion= @@IDENTITY
End

--===========================================================================================
--==========PROCEDIMIENTO CotizacionDelete ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=5
begin
	update GSC_Cotizacion set IdEstado = @IdEstado
	WHERE  IdCotizacion = @IdCotizacion
end

--===========================================================================================
else if @TipoConsulta=6
begin
Select * from GSC_Cotizacion
where FechaInicio Like @FechaInicio+ '%'
end

--===========================================================================================
--==========PROCEDIMIENTO CotizacionGetcodMoneda ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=7
Begin
Select * from GSC_Cotizacion
where IdMoneda = @IdMoneda
end

--===========================================================================================
--===========================================================================================
--==========PROCEDIMIENTO CotizacionGetcodSolCotizacion ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=8
begin
	
	if @tipoFecha = 'FechaCotizacion'
	begin
		select ct.*, ts.DescripTServicio, mo.DescripMoned, mo.AbreviaMoned, pr.RazonSocialProv, es.DescripEstado estado
		from GSC_Cotizacion ct
		join GSC_Moneda mo on ct.IdMoneda = mo.IdMoneda
		join GSC_Proveedor pr on pr.IdProveedor = ct.IdProveedor
		join GSC_TipoServicio ts on ct.IdTipoServicio = ts.IdTipoServicio
		join GSC_Estado es on es.IdEstado = ct.IdEstado
		where (ct.FechaInicio >= @FechaInicio and ct.FechaInicio <=  @FechaFin) and
		      (ct.IdSolicitudCotizacion = @IdSolicitudCotizacion or @IdSolicitudCotizacion = 0) and (ct.IdCotizacion = @IdCotizacion or @IdCotizacion = 0) and
			  (@IdProyecto in (select ds.IdProyecto from GSC_DetalleSolicitudRequerimiento ds where ds.IdSolicitudCotizacion = ct.IdSolicitudCotizacion) or @IdProyecto = 0) and
			  (ct.IdTipoServicio = @IdTipoServicio or @IdTipoServicio = 0) and (@IdEstado = 0 or @IdEstado = ct.IdEstado) and
			  (ct.IdProveedor = @IdProveedor or @IdProveedor = 0)
	end
	else if @TipoFecha = 'FechaVencimiento'
	begin
		select ct.*, ts.DescripTServicio, mo.DescripMoned, mo.AbreviaMoned, pr.RazonSocialProv, es.DescripEstado estado
		from GSC_Cotizacion ct
		join GSC_Moneda mo on ct.IdMoneda = mo.IdMoneda
		join GSC_Proveedor pr on pr.IdProveedor = ct.IdProveedor
		join GSC_TipoServicio ts on ct.IdTipoServicio = ts.IdTipoServicio
		join GSC_Estado es on es.IdEstado = ct.IdEstado
		where (ct.FechaFin >= @FechaInicio and ct.FechaFin <=  @FechaFin) and
		      (ct.IdSolicitudCotizacion = @IdSolicitudCotizacion or @IdSolicitudCotizacion = 0) and (ct.IdCotizacion = @IdCotizacion or @IdCotizacion = 0) and
			  (@IdProyecto in (select ds.IdProyecto from GSC_DetalleSolicitudRequerimiento ds where ds.IdSolicitudCotizacion = ct.IdSolicitudCotizacion) or @IdProyecto = 0) and
			  (ct.IdTipoServicio = @IdTipoServicio or @IdTipoServicio = 0) and (@IdEstado = 0 or @IdEstado = ct.IdEstado) and
			  (ct.IdProveedor = @IdProveedor or @IdProveedor = 0)
	end
	else
	begin
		
		select ct.*, ts.DescripTServicio, mo.DescripMoned, mo.AbreviaMoned, pr.RazonSocialProv, es.DescripEstado estado
		from GSC_Cotizacion ct
		join GSC_Moneda mo on ct.IdMoneda = mo.IdMoneda
		join GSC_Proveedor pr on pr.IdProveedor = ct.IdProveedor
		join GSC_TipoServicio ts on ct.IdTipoServicio = ts.IdTipoServicio
		join GSC_Estado es on es.IdEstado = ct.IdEstado
		where (ct.IdSolicitudCotizacion = @IdSolicitudCotizacion or @IdSolicitudCotizacion = 0) and (ct.IdCotizacion = @IdCotizacion or @IdCotizacion = 0) and
			  (@IdProyecto in (select ds.IdProyecto from GSC_DetalleSolicitudRequerimiento ds where ds.IdSolicitudCotizacion = ct.IdSolicitudCotizacion) or @IdProyecto = 0) and
			  (ct.IdTipoServicio = @IdTipoServicio or @IdTipoServicio = 0) and (@IdEstado = 0 or @IdEstado = ct.IdEstado) and
			  (ct.IdProveedor = @IdProveedor or @IdProveedor = 0)
	end
end
GO
/****** Object:  StoredProcedure [dbo].[pa_GSC_SolicitudCotizacion]    Script Date: 09/01/2013 22:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--===========================================================================================
--==========PROCEDIMIENTO SolicitudCotizacionUpdate ========================
--===========================================================================================
--===========================================================================================
CREATE PROCEDURE [dbo].[pa_GSC_SolicitudCotizacion]
             @IdSolicitudCotizacion    int=Null output,
             @DescripSolCotizacion    varchar(50)=Null,
             @FecSolCotizacion    datetime=Null,
             @FechaVencimiento	date=Null,
             @Observaciones    varchar(50)=Null,
             @Estado    char(1)=Null,
             
             @TipoFecha varchar(20)=Null,
             @FechaInicio date=Null,
             @FechaFin date=Null,
             @IdProyecto int=Null,
             @IdTipoServicio int=Null,
             @IdRequerimiento int=Null,
             @FiltrarEstado int=Null,
             @IdEstado int=Null,
             @EliminarDetalle bit=Null

,@TipoConsulta tinyint
AS 
if @TipoConsulta=1 
Begin
     
     UPDATE dbo.[GSC_SolicitudCotizacion]SET 
              [DescripSolCotizacion]=@DescripSolCotizacion,
              [FecSolCotizacion]=@FecSolCotizacion,
              [FechaVencimiento]=@FechaVencimiento,
              [Observaciones]=@Observaciones,
              [IdTipoServicio]=@IdTipoServicio
     WHERE  IdSolicitudCotizacion = @IdSolicitudCotizacion
     
     delete from GSC_SolicitudProveedorTipoServicio
     WHERE IdSolicitudCotizacion = @IdSolicitudCotizacion and 
           (select count(*) from GSC_Cotizacion c where c.IdSolicitudCotizacion = GSC_SolicitudProveedorTipoServicio.IdSolicitudCotizacion and c.IdProveedor = GSC_SolicitudProveedorTipoServicio.IdProveedor and c.IdTipoServicio = GSC_SolicitudProveedorTipoServicio.IdTipoServicio) = 0
     
     delete from GSC_DetalleSolicitudRequerimiento
     WHERE IdSolicitudCotizacion = @IdSolicitudCotizacion and 
           (select count(*) from GSC_DetalleCotizacion dc where dc.IdSolicitudCotizacion = GSC_DetalleSolicitudRequerimiento.IdSolicitudCotizacion and dc.IdSolicitudDetalle = GSC_DetalleSolicitudRequerimiento.IdSolicitudDetalle) = 0
     
End

--===========================================================================================
--==========PROCEDIMIENTO SolicitudCotizacionGetByAll ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=2
begin
Select * from GSC_SolicitudCotizacion
End

--===========================================================================================
--==========PROCEDIMIENTO SolicitudCotizacionGetByPrimaryKey ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=3
begin
	select sc.*, ts.DescripTServicio, ts.IdTipoServicio, es.DescripEstado
	from GSC_SolicitudCotizacion sc
	join GSC_TipoServicio ts on sc.IdTipoServicio = ts.IdTipoServicio
	join dbo.GSC_Estado es on es.IdEstado = sc.IdEstado
	WHERE  IdSolicitudCotizacion = @IdSolicitudCotizacion
End

--===========================================================================================
--==========PROCEDIMIENTO SolicitudCotizacionInsert ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=4
Begin
     INSERT INTO [dbo].[GSC_SolicitudCotizacion]
     (
          [DescripSolCotizacion],
          [FecSolCotizacion],
          [FechaVencimiento],
          [Observaciones],
          [IdTipoServicio],
          [IdEstado]
     )
     VALUES
     (
          @DescripSolCotizacion,
          @FecSolCotizacion,
          @FechaVencimiento,
          @Observaciones,
          @IdTipoServicio,
          1
     )
     SET @IdSolicitudCotizacion= @@IDENTITY
End

--===========================================================================================
--==========PROCEDIMIENTO SolicitudCotizacionDelete ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=5
begin
	Delete from GSC_SolicitudCotizacion
	WHERE  IdSolicitudCotizacion = @IdSolicitudCotizacion
end

--===========================================================================================
else if @TipoConsulta=6
begin
	Select * from GSC_SolicitudCotizacion
	where DescripSolCotizacion Like @DescripSolCotizacion+ '%'
end

--===========================================================================================
--==========PROCEDIMIENTO SolicitudCotizacionDelete ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=7
begin
	if @IdEstado = 2
	begin
		UPDATE dbo.[GSC_SolicitudCotizacion]SET
				   IdEstado=@IdEstado,
				   FechaEnvio=getdate()
		WHERE IdSolicitudCotizacion = @IdSolicitudCotizacion
    end
    else
    begin
		UPDATE dbo.[GSC_SolicitudCotizacion]SET
				   IdEstado=@IdEstado
		WHERE IdSolicitudCotizacion = @IdSolicitudCotizacion
    end	
end
else if @TipoConsulta=8
begin
	
	if @TipoFecha = 'FechaCotizacion'
	begin
		select sc.*, ts.DescripTServicio, ts.IdTipoServicio, es.DescripEstado
		from GSC_SolicitudCotizacion sc
		join dbo.GSC_Estado es on es.IdEstado = sc.IdEstado
		join GSC_TipoServicio ts on sc.IdTipoServicio = ts.IdTipoServicio
		where (sc.IdSolicitudCotizacion = @IdSolicitudCotizacion or @IdSolicitudCotizacion = 0) and (sc.IdEstado = @IdEstado or @IdEstado = 0) and
		      (cast(sc.FecSolCotizacion as date) >= @FechaInicio and cast(sc.FecSolCotizacion as date) <=  @FechaFin) and
			  (@IdProyecto in (select ds.IdProyecto from GSC_DetalleSolicitudRequerimiento ds where ds.IdSolicitudCotizacion = sc.IdSolicitudCotizacion) or @IdProyecto = 0) and
			  (sc.IdTipoServicio = @IdTipoServicio or @IdTipoServicio = 0) and (@filtrarEstado = -1 or @filtrarEstado != sc.IdEstado)
	end
	else if @tipoFecha = 'FechaVencimiento'
	begin
		select sc.*, ts.DescripTServicio, ts.IdTipoServicio, es.DescripEstado
		from GSC_SolicitudCotizacion sc
		join dbo.GSC_Estado es on es.IdEstado = sc.IdEstado
		join GSC_TipoServicio ts on sc.IdTipoServicio = ts.IdTipoServicio
		where (sc.IdSolicitudCotizacion = @IdSolicitudCotizacion or @IdSolicitudCotizacion = 0) and (sc.IdEstado = @IdEstado or @IdEstado = 0) and
		      (sc.fechaVencimiento >= @fechaInicio and sc.fechaVencimiento <=  @fechaFin) and
		      (@IdProyecto in (select ds.IdProyecto from GSC_DetalleSolicitudRequerimiento ds where ds.IdSolicitudCotizacion = sc.IdSolicitudCotizacion) or @IdProyecto = 0) and
			  (sc.IdTipoServicio = @IdTipoServicio or @IdTipoServicio = 0) and (@filtrarEstado = -1 or @filtrarEstado != sc.IdEstado)
	end
	else
	begin
		
		select sc.*, ts.DescripTServicio, ts.IdTipoServicio, es.DescripEstado
		from GSC_SolicitudCotizacion sc
		join dbo.GSC_Estado es on es.IdEstado = sc.IdEstado
		join GSC_TipoServicio ts on sc.IdTipoServicio = ts.IdTipoServicio
		where (sc.IdSolicitudCotizacion = @IdSolicitudCotizacion or @IdSolicitudCotizacion = 0) and (sc.IdEstado = @IdEstado or @IdEstado = 0) and
			  (@IdProyecto in (select ds.IdProyecto from GSC_DetalleSolicitudRequerimiento ds where ds.IdSolicitudCotizacion = sc.IdSolicitudCotizacion) or @IdProyecto = 0) and
			  (sc.IdTipoServicio = @IdTipoServicio or @IdTipoServicio = 0) and (@filtrarEstado = -1 or @filtrarEstado != sc.IdEstado)
	end
end
GO
/****** Object:  StoredProcedure [dbo].[pa_GSC_DetalleSolicitudRequerimiento]    Script Date: 09/01/2013 22:59:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--===========================================================================================
--==========PROCEDIMIENTO DetalleSolicitudRequerimientoUpdate ========================
--===========================================================================================
--===========================================================================================
CREATE PROCEDURE [dbo].[pa_GSC_DetalleSolicitudRequerimiento]
             @IdSolicitudCotizacion    int=Null,
             @IdSolicitudDetalle    int=Null output,
             @DescripSolDetalle    varchar(200)=Null,
             @FecSolDetalle    datetime=Null,
             @IdProyecto    int=Null,
             @IdRequerimiento    int=Null,
             @IdCorDetReq    int=Null,
			 @IdCotizacion   int=Null
,@TipoConsulta tinyint
AS 
if @TipoConsulta=1 
Begin
             UPDATE dbo.[GSC_DetalleSolicitudRequerimiento]SET                           
                          [DescripSolDetalle]=@DescripSolDetalle,
                          [FecSolDetalle]=@FecSolDetalle,
                          [IdProyecto]=@IdProyecto,
                          [IdRequerimiento]=@IdRequerimiento,
                          [IdCorDetReq]=@IdCorDetReq                          
             WHERE  IdSolicitudCotizacion = @IdSolicitudCotizacion And IdSolicitudDetalle = @IdSolicitudDetalle

End

--===========================================================================================
--==========PROCEDIMIENTO DetalleSolicitudRequerimientoGetByAll ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=2
begin
Select * from GSC_DetalleSolicitudRequerimiento
End

--===========================================================================================
--==========PROCEDIMIENTO DetalleSolicitudRequerimientoGetByPrimaryKey ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=3
begin
Select * from GSC_DetalleSolicitudRequerimiento
WHERE  IdSolicitudCotizacion = @IdSolicitudCotizacion And IdSolicitudDetalle = @IdSolicitudDetalle
End

--===========================================================================================
--==========PROCEDIMIENTO DetalleSolicitudRequerimientoInsert ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=4
Begin
     INSERT INTO [dbo].[GSC_DetalleSolicitudRequerimiento]
     (
          [IdSolicitudCotizacion],
          [DescripSolDetalle],
          [FecSolDetalle],
          [IdProyecto],
          [IdRequerimiento],
          [IdCorDetReq]          
     )
     VALUES
     (
          @IdSolicitudCotizacion,
          @DescripSolDetalle,
          getdate(),
          @IdProyecto,
          @IdRequerimiento,
          @IdCorDetReq
     )
     
     --SET @codcorDetReq = @@IDENTITY
     
     update GSC_DetalleRequerimiento set ActServicio = 0
     where IdRequerimiento = @IdRequerimiento and IdCorDetReq = @IdCorDetReq and IdProyecto = @IdProyecto
    
End

--===========================================================================================
--==========PROCEDIMIENTO DetalleSolicitudRequerimientoDelete ========================
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=5
begin
Delete from GSC_DetalleSolicitudRequerimiento
WHERE  IdSolicitudCotizacion = @IdSolicitudCotizacion And IdSolicitudDetalle = @IdSolicitudDetalle
end

--===========================================================================================
else if @TipoConsulta=6
begin
Select * from GSC_DetalleSolicitudRequerimiento
where IdSolicitudDetalle Like @IdSolicitudDetalle+ '%'
end

--===========================================================================================
--==========PROCEDIMIENTO DetalleSolicitudRequerimientoGetcodSolCotizacion ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=7
Begin
	if @IdCotizacion = 0
	begin
		Select distinct dsr.*, um.DescripUMedi, dr.CanDetReq, dr.DesServicio, p.Nombre, r.DescripReq, cast(0 as decimal(18,2)) Precio,
		       cast(0 as decimal(18,2)) importe, dr.IdUnidadMedida
		from GSC_DetalleSolicitudRequerimiento dsr	
		join GSC_DetalleRequerimiento dr on dsr.IdProyecto = dr.IdProyecto and dsr.IdRequerimiento = dr.IdRequerimiento and dsr.IdCorDetReq = dr.IdCorDetReq
		join GPP_Proyecto p on dr.IdProyecto = p.IdProyecto
		join GSC_UnidadMedida um on dr.IdUnidadMedida = um.IdUnidadMedida
		join GSC_Requerimiento r on r.IdRequerimiento = dr.IdRequerimiento
		where dsr.IdSolicitudCotizacion = @IdSolicitudCotizacion
	end
	else
	begin
		Select distinct dsr.*, um.DescripUMedi, cast(dc.cantidad as int) CanDetReq, dr.DesServicio, p.Nombre, r.DescripReq, dc.Precio, 
			   dc.Importe, dr.IdUnidadMedida
		from GSC_DetalleCotizacion dc
		join GSC_DetalleSolicitudRequerimiento dsr on dc.IdSolicitudCotizacion = dsr.IdSolicitudCotizacion and dc.IdSolicitudDetalle = dsr.IdSolicitudDetalle
		join GSC_DetalleRequerimiento dr on dsr.IdProyecto = dr.IdProyecto and dsr.IdRequerimiento = dr.IdRequerimiento and dsr.IdCorDetReq = dr.IdCorDetReq
		join GPP_Proyecto p on dr.IdProyecto = p.IdProyecto
		join GSC_UnidadMedida um on dr.IdUnidadMedida = um.IdUnidadMedida
		join GSC_Requerimiento r on r.IdRequerimiento = dr.IdRequerimiento
		where dc.IdCotizacion = @IdCotizacion
	end
end

--===========================================================================================
--===========================================================================================
--==========PROCEDIMIENTO DetalleSolicitudRequerimientoGetcodPro ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=8
Begin
Select * from GSC_DetalleSolicitudRequerimiento
where IdProyecto = @IdProyecto
end

--===========================================================================================
--===========================================================================================
--==========PROCEDIMIENTO DetalleSolicitudRequerimientoGetcodReq ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=9
Begin
Select * from GSC_DetalleSolicitudRequerimiento
where IdRequerimiento= @IdRequerimiento
end

--===========================================================================================
--===========================================================================================
--==========PROCEDIMIENTO DetalleSolicitudRequerimientoGetcodcorDetReq ===============
--===========================================================================================
--===========================================================================================
else if @TipoConsulta=10
Begin
	Select * from GSC_DetalleSolicitudRequerimiento
	where IdCorDetReq = @IdCorDetReq
end
GO
/****** Object:  Table [dbo].[GSC_Penalidad]    Script Date: 09/01/2013 22:59:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GSC_Penalidad](
	[IdProyecto] [int] NOT NULL,
	[IdRequerimiento] [int] NOT NULL,
	[IdCorDetReq] [int] NOT NULL,
	[IdInfServ] [int] NOT NULL,
	[IdPenalidad] [int] NULL,
	[Motivo] [varchar](50) NULL,
	[Monto] [decimal](18, 2) NULL,
	[IdOrdenPago] [int] NOT NULL,
 CONSTRAINT [PK_Penalidad] PRIMARY KEY CLUSTERED 
(
	[IdProyecto] ASC,
	[IdRequerimiento] ASC,
	[IdCorDetReq] ASC,
	[IdInfServ] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Default [DF__GJ_CartaN__Visit__6E765879]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_CartaNotarialDetalleVecinoColindante] ADD  DEFAULT ((0)) FOR [Visitado]
GO
/****** Object:  Default [DF__GJ_Contat__Tiene__0FD74C44]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_ContatoPrestacionServicios] ADD  DEFAULT ((0)) FOR [TieneClausulaAdicional]
GO
/****** Object:  Default [DF__GJ_Contra__Tiene__092A4EB5]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_ContratoTrabajoPlazoIndeterminado] ADD  DEFAULT ((0)) FOR [TieneClausulaAdicional]
GO
/****** Object:  Default [DF__GJ_Contra__Tiene__168449D3]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_ContratoTrabajoSujetoModalidad] ADD  DEFAULT ((0)) FOR [TieneClausulaAdicional]
GO
/****** Object:  Default [DF__GJ_Requer__Fecha__63F8CA06]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_RequerimientoLegalCartaNotarial] ADD  DEFAULT (dateadd(hour,(-5),getutcdate())) FOR [FechaRegistro]
GO
/****** Object:  Default [DF__GJ_Requer__Fecha__1F198FD4]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_RequerimientoLegalDeclaracionFabrica] ADD  DEFAULT (dateadd(hour,(-5),getutcdate())) FOR [FechaRegistro]
GO
/****** Object:  Default [DF__GJ_Requer__Fecha__7FA0E47B]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_RequerimientoLegalPlantillaContrato] ADD  DEFAULT (dateadd(hour,(-5),getutcdate())) FOR [FechaRegistro]
GO
/****** Object:  ForeignKey [FK__GJ_CartaN__IDCar__733B0D96]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_CartaNotarial]  WITH CHECK ADD FOREIGN KEY([IDCartaNotarialDetalleVecinoColindante])
REFERENCES [dbo].[GJ_CartaNotarialDetalleVecinoColindante] ([IDCartaNotarialDetalleVecinoColindante])
GO
/****** Object:  ForeignKey [FK__GJ_CartaN__IDCar__6D823440]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_CartaNotarialDetalleVecinoColindante]  WITH CHECK ADD FOREIGN KEY([IDCartaNotarialVecinoColindante])
REFERENCES [dbo].[GJ_CartaNotarialVecinoColindante] ([IDCartaNotarialVecinoColindante])
GO
/****** Object:  ForeignKey [FK__GJ_CartaN__IDReq__6C8E1007]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_CartaNotarialDetalleVecinoColindante]  WITH CHECK ADD FOREIGN KEY([IDRequerimientoLegalCartaNotarial])
REFERENCES [dbo].[GJ_RequerimientoLegalCartaNotarial] ([IDRequerimientoLegalCartaNotarial])
GO
/****** Object:  ForeignKey [FK__GJ_Contat__IDCla__10CB707D]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_ContatoPrestacionServicios]  WITH CHECK ADD FOREIGN KEY([IDClausulaAdicional])
REFERENCES [dbo].[GJ_ClausulaAdicional] ([IDClausulaAdicional])
GO
/****** Object:  ForeignKey [FK__GJ_Contat__IDReq__0EE3280B]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_ContatoPrestacionServicios]  WITH CHECK ADD FOREIGN KEY([IDRequerimientoLegalPlantillaContrato])
REFERENCES [dbo].[GJ_RequerimientoLegalPlantillaContrato] ([IDRequerimientoLegalPlantillaContrato])
GO
/****** Object:  ForeignKey [FK__GJ_Contra__IDCla__0A1E72EE]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_ContratoTrabajoPlazoIndeterminado]  WITH CHECK ADD FOREIGN KEY([IDClausulaAdicional])
REFERENCES [dbo].[GJ_ClausulaAdicional] ([IDClausulaAdicional])
GO
/****** Object:  ForeignKey [FK__GJ_Contra__IDReq__08362A7C]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_ContratoTrabajoPlazoIndeterminado]  WITH CHECK ADD FOREIGN KEY([IDRequerimientoLegalPlantillaContrato])
REFERENCES [dbo].[GJ_RequerimientoLegalPlantillaContrato] ([IDRequerimientoLegalPlantillaContrato])
GO
/****** Object:  ForeignKey [FK__GJ_Contra__IDCla__17786E0C]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_ContratoTrabajoSujetoModalidad]  WITH CHECK ADD FOREIGN KEY([IDClausulaAdicional])
REFERENCES [dbo].[GJ_ClausulaAdicional] ([IDClausulaAdicional])
GO
/****** Object:  ForeignKey [FK__GJ_Contra__IDReq__1590259A]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_ContratoTrabajoSujetoModalidad]  WITH CHECK ADD FOREIGN KEY([IDRequerimientoLegalPlantillaContrato])
REFERENCES [dbo].[GJ_RequerimientoLegalPlantillaContrato] ([IDRequerimientoLegalPlantillaContrato])
GO
/****** Object:  ForeignKey [FK__GJ_Requer__IDReq__611C5D5B]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_RequerimientoLegalCartaNotarial]  WITH CHECK ADD FOREIGN KEY([IDRequerimientoLegalTipo])
REFERENCES [dbo].[GJ_RequerimientoLegalTipo] ([IDRequerimientoLegalTipo])
GO
/****** Object:  ForeignKey [FK__GJ_Requer__IDReq__6304A5CD]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_RequerimientoLegalCartaNotarial]  WITH CHECK ADD FOREIGN KEY([IDRequerimientoLegalEstado])
REFERENCES [dbo].[GJ_RequerimientoLegalEstado] ([IDRequerimientoLegalEstado])
GO
/****** Object:  ForeignKey [FK__GJ_Requer__IDUsu__62108194]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_RequerimientoLegalCartaNotarial]  WITH CHECK ADD FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[SEG_Usuario] ([IDUsuario])
GO
/****** Object:  ForeignKey [FK__GJ_Requer__IDReq__1C3D2329]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_RequerimientoLegalDeclaracionFabrica]  WITH CHECK ADD FOREIGN KEY([IDRequerimientoLegalTipo])
REFERENCES [dbo].[GJ_RequerimientoLegalTipo] ([IDRequerimientoLegalTipo])
GO
/****** Object:  ForeignKey [FK__GJ_Requer__IDReq__1E256B9B]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_RequerimientoLegalDeclaracionFabrica]  WITH CHECK ADD FOREIGN KEY([IDRequerimientoLegalEstado])
REFERENCES [dbo].[GJ_RequerimientoLegalEstado] ([IDRequerimientoLegalEstado])
GO
/****** Object:  ForeignKey [FK__GJ_Requer__IDUsu__1D314762]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_RequerimientoLegalDeclaracionFabrica]  WITH CHECK ADD FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[SEG_Usuario] ([IDUsuario])
GO
/****** Object:  ForeignKey [FK__GJ_Requer__IDReq__7BD05397]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_RequerimientoLegalPlantillaContrato]  WITH CHECK ADD FOREIGN KEY([IDRequerimientoLegalTipo])
REFERENCES [dbo].[GJ_RequerimientoLegalTipo] ([IDRequerimientoLegalTipo])
GO
/****** Object:  ForeignKey [FK__GJ_Requer__IDReq__7EACC042]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_RequerimientoLegalPlantillaContrato]  WITH CHECK ADD FOREIGN KEY([IDRequerimientoLegalEstado])
REFERENCES [dbo].[GJ_RequerimientoLegalEstado] ([IDRequerimientoLegalEstado])
GO
/****** Object:  ForeignKey [FK__GJ_Requer__IDTip__7CC477D0]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_RequerimientoLegalPlantillaContrato]  WITH CHECK ADD FOREIGN KEY([IDTipoContratoLegal])
REFERENCES [dbo].[GJ_TipoContratoLegal] ([IDTipoContratoLegal])
GO
/****** Object:  ForeignKey [FK__GJ_Requer__IDUsu__7DB89C09]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_RequerimientoLegalPlantillaContrato]  WITH CHECK ADD FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[SEG_Usuario] ([IDUsuario])
GO
/****** Object:  ForeignKey [FK__GJ_Usuari__IDUsu__23DE44F1]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GJ_UsuarioAtencion]  WITH CHECK ADD FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[SEG_Usuario] ([IDUsuario])
GO
/****** Object:  ForeignKey [FK_GPC_ActividadObra_CronogramaObra]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPC_ActividadObra]  WITH CHECK ADD  CONSTRAINT [FK_GPC_ActividadObra_CronogramaObra] FOREIGN KEY([IDCronogramaObra])
REFERENCES [dbo].[GPC_CronogramaObra] ([IDCronogramaObra])
GO
ALTER TABLE [dbo].[GPC_ActividadObra] CHECK CONSTRAINT [FK_GPC_ActividadObra_CronogramaObra]
GO
/****** Object:  ForeignKey [FK_GPC_ClienteObra_Usuario]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPC_ClienteObra]  WITH CHECK ADD  CONSTRAINT [FK_GPC_ClienteObra_Usuario] FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[SEG_Usuario] ([IDUsuario])
GO
ALTER TABLE [dbo].[GPC_ClienteObra] CHECK CONSTRAINT [FK_GPC_ClienteObra_Usuario]
GO
/****** Object:  ForeignKey [FK_GPC_CronogramaObra_PresupuestoObra]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPC_CronogramaObra]  WITH CHECK ADD  CONSTRAINT [FK_GPC_CronogramaObra_PresupuestoObra] FOREIGN KEY([IDPresupuestoObra])
REFERENCES [dbo].[GPC_PresupuestoObra] ([IDPresupuestoObra])
GO
ALTER TABLE [dbo].[GPC_CronogramaObra] CHECK CONSTRAINT [FK_GPC_CronogramaObra_PresupuestoObra]
GO
/****** Object:  ForeignKey [FK_GPC_DetallePartida_APU]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPC_DetallePartida]  WITH CHECK ADD  CONSTRAINT [FK_GPC_DetallePartida_APU] FOREIGN KEY([IDAPU])
REFERENCES [dbo].[GPC_APU] ([IDApu])
GO
ALTER TABLE [dbo].[GPC_DetallePartida] CHECK CONSTRAINT [FK_GPC_DetallePartida_APU]
GO
/****** Object:  ForeignKey [FK_GPC_DetallePartida_Categoria]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPC_DetallePartida]  WITH CHECK ADD  CONSTRAINT [FK_GPC_DetallePartida_Categoria] FOREIGN KEY([IDCategoria])
REFERENCES [dbo].[GPC_Categoria] ([IDCategoria])
GO
ALTER TABLE [dbo].[GPC_DetallePartida] CHECK CONSTRAINT [FK_GPC_DetallePartida_Categoria]
GO
/****** Object:  ForeignKey [FK_GPC_DetallePartida_Partida]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPC_DetallePartida]  WITH CHECK ADD  CONSTRAINT [FK_GPC_DetallePartida_Partida] FOREIGN KEY([IDPartida])
REFERENCES [dbo].[GPC_Partida] ([IDPartida])
GO
ALTER TABLE [dbo].[GPC_DetallePartida] CHECK CONSTRAINT [FK_GPC_DetallePartida_Partida]
GO
/****** Object:  ForeignKey [FK_GPC_ExpedienteTecnico_PresupuestoObra]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPC_ExpedienteTecnico]  WITH CHECK ADD  CONSTRAINT [FK_GPC_ExpedienteTecnico_PresupuestoObra] FOREIGN KEY([IDPresupuestoObra])
REFERENCES [dbo].[GPC_PresupuestoObra] ([IDPresupuestoObra])
GO
ALTER TABLE [dbo].[GPC_ExpedienteTecnico] CHECK CONSTRAINT [FK_GPC_ExpedienteTecnico_PresupuestoObra]
GO
/****** Object:  ForeignKey [FK_GPC_HistoricoAprobacion_Estado]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPC_HistoricoAprobacion]  WITH CHECK ADD  CONSTRAINT [FK_GPC_HistoricoAprobacion_Estado] FOREIGN KEY([IDEstado])
REFERENCES [dbo].[GPC_Estado] ([IDEstado])
GO
ALTER TABLE [dbo].[GPC_HistoricoAprobacion] CHECK CONSTRAINT [FK_GPC_HistoricoAprobacion_Estado]
GO
/****** Object:  ForeignKey [FK_GPC_HistoricoAprobacion_PresupuestoObra]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPC_HistoricoAprobacion]  WITH CHECK ADD  CONSTRAINT [FK_GPC_HistoricoAprobacion_PresupuestoObra] FOREIGN KEY([IDPresupuestoObra])
REFERENCES [dbo].[GPC_PresupuestoObra] ([IDPresupuestoObra])
GO
ALTER TABLE [dbo].[GPC_HistoricoAprobacion] CHECK CONSTRAINT [FK_GPC_HistoricoAprobacion_PresupuestoObra]
GO
/****** Object:  ForeignKey [FK_GPC_HistoricoAprobacion_Usuario]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPC_HistoricoAprobacion]  WITH CHECK ADD  CONSTRAINT [FK_GPC_HistoricoAprobacion_Usuario] FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[SEG_Usuario] ([IDUsuario])
GO
ALTER TABLE [dbo].[GPC_HistoricoAprobacion] CHECK CONSTRAINT [FK_GPC_HistoricoAprobacion_Usuario]
GO
/****** Object:  ForeignKey [FK_GPC_Notificacion_PresupuestoObra]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPC_Notificacion]  WITH CHECK ADD  CONSTRAINT [FK_GPC_Notificacion_PresupuestoObra] FOREIGN KEY([IDPresupuestoObra])
REFERENCES [dbo].[GPC_PresupuestoObra] ([IDPresupuestoObra])
GO
ALTER TABLE [dbo].[GPC_Notificacion] CHECK CONSTRAINT [FK_GPC_Notificacion_PresupuestoObra]
GO
/****** Object:  ForeignKey [FK_GPC_Partida_PresupuestoObra]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPC_Partida]  WITH CHECK ADD  CONSTRAINT [FK_GPC_Partida_PresupuestoObra] FOREIGN KEY([IDPresupuestoObra])
REFERENCES [dbo].[GPC_PresupuestoObra] ([IDPresupuestoObra])
GO
ALTER TABLE [dbo].[GPC_Partida] CHECK CONSTRAINT [FK_GPC_Partida_PresupuestoObra]
GO
/****** Object:  ForeignKey [FK_GPC_PresupuestoObra_ClienteObra]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPC_PresupuestoObra]  WITH CHECK ADD  CONSTRAINT [FK_GPC_PresupuestoObra_ClienteObra] FOREIGN KEY([IDClienteObra])
REFERENCES [dbo].[GPC_ClienteObra] ([IDClienteObra])
GO
ALTER TABLE [dbo].[GPC_PresupuestoObra] CHECK CONSTRAINT [FK_GPC_PresupuestoObra_ClienteObra]
GO
/****** Object:  ForeignKey [FK_GPC_PresupuestoObra_Estado]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPC_PresupuestoObra]  WITH CHECK ADD  CONSTRAINT [FK_GPC_PresupuestoObra_Estado] FOREIGN KEY([IDEstado])
REFERENCES [dbo].[GPC_Estado] ([IDEstado])
GO
ALTER TABLE [dbo].[GPC_PresupuestoObra] CHECK CONSTRAINT [FK_GPC_PresupuestoObra_Estado]
GO
/****** Object:  ForeignKey [FK_GPC_PresupuestoObra_Obra]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPC_PresupuestoObra]  WITH CHECK ADD  CONSTRAINT [FK_GPC_PresupuestoObra_Obra] FOREIGN KEY([IDObra])
REFERENCES [dbo].[GPC_Obra] ([IDObra])
GO
ALTER TABLE [dbo].[GPC_PresupuestoObra] CHECK CONSTRAINT [FK_GPC_PresupuestoObra_Obra]
GO
/****** Object:  ForeignKey [FK_GPC_Solicitud_Estado]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPC_Solicitud]  WITH CHECK ADD  CONSTRAINT [FK_GPC_Solicitud_Estado] FOREIGN KEY([IDEstado])
REFERENCES [dbo].[GPC_Estado] ([IDEstado])
GO
ALTER TABLE [dbo].[GPC_Solicitud] CHECK CONSTRAINT [FK_GPC_Solicitud_Estado]
GO
/****** Object:  ForeignKey [FK_GPC_Solicitud_PresupuestoObra]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPC_Solicitud]  WITH CHECK ADD  CONSTRAINT [FK_GPC_Solicitud_PresupuestoObra] FOREIGN KEY([IDPresupuestoObra])
REFERENCES [dbo].[GPC_PresupuestoObra] ([IDPresupuestoObra])
GO
ALTER TABLE [dbo].[GPC_Solicitud] CHECK CONSTRAINT [FK_GPC_Solicitud_PresupuestoObra]
GO
/****** Object:  ForeignKey [FK_GPC_Solicitud_TipoSolicitud]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPC_Solicitud]  WITH CHECK ADD  CONSTRAINT [FK_GPC_Solicitud_TipoSolicitud] FOREIGN KEY([IDTipoSolicitud])
REFERENCES [dbo].[GPC_TipoSolicitud] ([IDTipoSolicitud])
GO
ALTER TABLE [dbo].[GPC_Solicitud] CHECK CONSTRAINT [FK_GPC_Solicitud_TipoSolicitud]
GO
/****** Object:  ForeignKey [FK_GPC_Solicitud_Usuario]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPC_Solicitud]  WITH CHECK ADD  CONSTRAINT [FK_GPC_Solicitud_Usuario] FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[SEG_Usuario] ([IDUsuario])
GO
ALTER TABLE [dbo].[GPC_Solicitud] CHECK CONSTRAINT [FK_GPC_Solicitud_Usuario]
GO
/****** Object:  ForeignKey [FK_GPP_Actividad_GPP_Entregable]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_Actividad]  WITH CHECK ADD  CONSTRAINT [FK_GPP_Actividad_GPP_Entregable] FOREIGN KEY([IdEntregable])
REFERENCES [dbo].[GPP_Entregable] ([IdEntregable])
GO
ALTER TABLE [dbo].[GPP_Actividad] CHECK CONSTRAINT [FK_GPP_Actividad_GPP_Entregable]
GO
/****** Object:  ForeignKey [FK_GPP_Actividad_GPP_PlanProyecto]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_Actividad]  WITH CHECK ADD  CONSTRAINT [FK_GPP_Actividad_GPP_PlanProyecto] FOREIGN KEY([IdPlanProyecto])
REFERENCES [dbo].[GPP_PlanProyecto] ([IdPlanProyecto])
GO
ALTER TABLE [dbo].[GPP_Actividad] CHECK CONSTRAINT [FK_GPP_Actividad_GPP_PlanProyecto]
GO
/****** Object:  ForeignKey [FK_GPP_ActividadHist_GPP_Entregable]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_ActividadHist]  WITH CHECK ADD  CONSTRAINT [FK_GPP_ActividadHist_GPP_Entregable] FOREIGN KEY([IdEntregable])
REFERENCES [dbo].[GPP_Entregable] ([IdEntregable])
GO
ALTER TABLE [dbo].[GPP_ActividadHist] CHECK CONSTRAINT [FK_GPP_ActividadHist_GPP_Entregable]
GO
/****** Object:  ForeignKey [FK_GPP_ActividadHist_GPP_PlanProyectoHist]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_ActividadHist]  WITH CHECK ADD  CONSTRAINT [FK_GPP_ActividadHist_GPP_PlanProyectoHist] FOREIGN KEY([IdPlanProyectoHist])
REFERENCES [dbo].[GPP_PlanProyectoHist] ([IdPlanProyectoHist])
GO
ALTER TABLE [dbo].[GPP_ActividadHist] CHECK CONSTRAINT [FK_GPP_ActividadHist_GPP_PlanProyectoHist]
GO
/****** Object:  ForeignKey [FK_GPP_Articulo_GPP_Recurso]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_Articulo]  WITH CHECK ADD  CONSTRAINT [FK_GPP_Articulo_GPP_Recurso] FOREIGN KEY([IdRecurso])
REFERENCES [dbo].[GPP_Recurso] ([IdRecurso])
GO
ALTER TABLE [dbo].[GPP_Articulo] CHECK CONSTRAINT [FK_GPP_Articulo_GPP_Recurso]
GO
/****** Object:  ForeignKey [FK_GPP_DetallePresupuesto_GPP_Presupuesto]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_DetallePresupuesto]  WITH CHECK ADD  CONSTRAINT [FK_GPP_DetallePresupuesto_GPP_Presupuesto] FOREIGN KEY([IdPresupuesto])
REFERENCES [dbo].[GPP_Presupuesto] ([IdPresupuesto])
GO
ALTER TABLE [dbo].[GPP_DetallePresupuesto] CHECK CONSTRAINT [FK_GPP_DetallePresupuesto_GPP_Presupuesto]
GO
/****** Object:  ForeignKey [FK_GPP_DetallePresupuesto_GPP_VariablesPresupuesto]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_DetallePresupuesto]  WITH CHECK ADD  CONSTRAINT [FK_GPP_DetallePresupuesto_GPP_VariablesPresupuesto] FOREIGN KEY([IdVariablePre])
REFERENCES [dbo].[GPP_VariablesPresupuesto] ([IdVariablePre])
GO
ALTER TABLE [dbo].[GPP_DetallePresupuesto] CHECK CONSTRAINT [FK_GPP_DetallePresupuesto_GPP_VariablesPresupuesto]
GO
/****** Object:  ForeignKey [FK_GPP_DetalleRequerimiento_GPP_Recurso]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_DetalleRequerimiento]  WITH CHECK ADD  CONSTRAINT [FK_GPP_DetalleRequerimiento_GPP_Recurso] FOREIGN KEY([IdRecurso])
REFERENCES [dbo].[GPP_Recurso] ([IdRecurso])
GO
ALTER TABLE [dbo].[GPP_DetalleRequerimiento] CHECK CONSTRAINT [FK_GPP_DetalleRequerimiento_GPP_Recurso]
GO
/****** Object:  ForeignKey [FK_GPP_DetalleRequerimiento_GPP_RequerimientoPlanProy]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_DetalleRequerimiento]  WITH CHECK ADD  CONSTRAINT [FK_GPP_DetalleRequerimiento_GPP_RequerimientoPlanProy] FOREIGN KEY([IdRequerimientoPlanProy])
REFERENCES [dbo].[GPP_RequerimientoPlanProy] ([IdRequerimientoPlan])
GO
ALTER TABLE [dbo].[GPP_DetalleRequerimiento] CHECK CONSTRAINT [FK_GPP_DetalleRequerimiento_GPP_RequerimientoPlanProy]
GO
/****** Object:  ForeignKey [FK_GPP_DetalleRequerimiento_GRH_Empleado]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_DetalleRequerimiento]  WITH CHECK ADD  CONSTRAINT [FK_GPP_DetalleRequerimiento_GRH_Empleado] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[GRH_Empleado] ([IdEmpleado])
GO
ALTER TABLE [dbo].[GPP_DetalleRequerimiento] CHECK CONSTRAINT [FK_GPP_DetalleRequerimiento_GRH_Empleado]
GO
/****** Object:  ForeignKey [FK_GPP_Entregable_GPP_Proyecto]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_Entregable]  WITH CHECK ADD  CONSTRAINT [FK_GPP_Entregable_GPP_Proyecto] FOREIGN KEY([IdProyecto])
REFERENCES [dbo].[GPP_Proyecto] ([IdProyecto])
GO
ALTER TABLE [dbo].[GPP_Entregable] CHECK CONSTRAINT [FK_GPP_Entregable_GPP_Proyecto]
GO
/****** Object:  ForeignKey [FK_GPP_Equipo_GPP_Recurso]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_Equipo]  WITH CHECK ADD  CONSTRAINT [FK_GPP_Equipo_GPP_Recurso] FOREIGN KEY([IdRecurso])
REFERENCES [dbo].[GPP_Recurso] ([IdRecurso])
GO
ALTER TABLE [dbo].[GPP_Equipo] CHECK CONSTRAINT [FK_GPP_Equipo_GPP_Recurso]
GO
/****** Object:  ForeignKey [FK_GPP_FlujoCaja_GPP_TipoCambio]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_FlujoCaja]  WITH CHECK ADD  CONSTRAINT [FK_GPP_FlujoCaja_GPP_TipoCambio] FOREIGN KEY([IdTipoCambio])
REFERENCES [dbo].[GPP_TipoCambio] ([IdTipoCambio])
GO
ALTER TABLE [dbo].[GPP_FlujoCaja] CHECK CONSTRAINT [FK_GPP_FlujoCaja_GPP_TipoCambio]
GO
/****** Object:  ForeignKey [FK_GPP_Material_GPP_Recurso]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_Material]  WITH CHECK ADD  CONSTRAINT [FK_GPP_Material_GPP_Recurso] FOREIGN KEY([IdRecurso])
REFERENCES [dbo].[GPP_Recurso] ([IdRecurso])
GO
ALTER TABLE [dbo].[GPP_Material] CHECK CONSTRAINT [FK_GPP_Material_GPP_Recurso]
GO
/****** Object:  ForeignKey [FK_GPP_PlanEmpleadosActividad_GPP_PlanProyecto]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_PlanEmpleadosActividad]  WITH CHECK ADD  CONSTRAINT [FK_GPP_PlanEmpleadosActividad_GPP_PlanProyecto] FOREIGN KEY([IdPlanProyecto])
REFERENCES [dbo].[GPP_PlanProyecto] ([IdPlanProyecto])
GO
ALTER TABLE [dbo].[GPP_PlanEmpleadosActividad] CHECK CONSTRAINT [FK_GPP_PlanEmpleadosActividad_GPP_PlanProyecto]
GO
/****** Object:  ForeignKey [FK_GPP_PlanEmpleadosActividad_GRH_Empleado]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_PlanEmpleadosActividad]  WITH CHECK ADD  CONSTRAINT [FK_GPP_PlanEmpleadosActividad_GRH_Empleado] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[GRH_Empleado] ([IdEmpleado])
GO
ALTER TABLE [dbo].[GPP_PlanEmpleadosActividad] CHECK CONSTRAINT [FK_GPP_PlanEmpleadosActividad_GRH_Empleado]
GO
/****** Object:  ForeignKey [FK_GPP_PlanProyecto_GPP_FlujoCaja]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_PlanProyecto]  WITH CHECK ADD  CONSTRAINT [FK_GPP_PlanProyecto_GPP_FlujoCaja] FOREIGN KEY([IdFlujoCaja])
REFERENCES [dbo].[GPP_FlujoCaja] ([IdFlujoCaja])
GO
ALTER TABLE [dbo].[GPP_PlanProyecto] CHECK CONSTRAINT [FK_GPP_PlanProyecto_GPP_FlujoCaja]
GO
/****** Object:  ForeignKey [FK_GPP_PlanProyecto_GPP_Proyecto]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_PlanProyecto]  WITH CHECK ADD  CONSTRAINT [FK_GPP_PlanProyecto_GPP_Proyecto] FOREIGN KEY([IdProyecto])
REFERENCES [dbo].[GPP_Proyecto] ([IdProyecto])
GO
ALTER TABLE [dbo].[GPP_PlanProyecto] CHECK CONSTRAINT [FK_GPP_PlanProyecto_GPP_Proyecto]
GO
/****** Object:  ForeignKey [FK_GPP_PlanProyectoHist_GPP_ProyectoHist]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_PlanProyectoHist]  WITH CHECK ADD  CONSTRAINT [FK_GPP_PlanProyectoHist_GPP_ProyectoHist] FOREIGN KEY([IdProyectoHist])
REFERENCES [dbo].[GPP_ProyectoHist] ([IdProyectoHist])
GO
ALTER TABLE [dbo].[GPP_PlanProyectoHist] CHECK CONSTRAINT [FK_GPP_PlanProyectoHist_GPP_ProyectoHist]
GO
/****** Object:  ForeignKey [FK_GPP_PlanRecursosActividad_GPP_Actividad]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_PlanRecursosActividad]  WITH CHECK ADD  CONSTRAINT [FK_GPP_PlanRecursosActividad_GPP_Actividad] FOREIGN KEY([IdActividad])
REFERENCES [dbo].[GPP_Actividad] ([IdActividad])
GO
ALTER TABLE [dbo].[GPP_PlanRecursosActividad] CHECK CONSTRAINT [FK_GPP_PlanRecursosActividad_GPP_Actividad]
GO
/****** Object:  ForeignKey [FK_GPP_PlanRecursosActividad_GPP_Recurso]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_PlanRecursosActividad]  WITH CHECK ADD  CONSTRAINT [FK_GPP_PlanRecursosActividad_GPP_Recurso] FOREIGN KEY([IdRecurso])
REFERENCES [dbo].[GPP_Recurso] ([IdRecurso])
GO
ALTER TABLE [dbo].[GPP_PlanRecursosActividad] CHECK CONSTRAINT [FK_GPP_PlanRecursosActividad_GPP_Recurso]
GO
/****** Object:  ForeignKey [FK_GPP_PlanSubcontratasActividad_GPP_Actividad]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_PlanSubcontratasActividad]  WITH CHECK ADD  CONSTRAINT [FK_GPP_PlanSubcontratasActividad_GPP_Actividad] FOREIGN KEY([IdActividad])
REFERENCES [dbo].[GPP_Actividad] ([IdActividad])
GO
ALTER TABLE [dbo].[GPP_PlanSubcontratasActividad] CHECK CONSTRAINT [FK_GPP_PlanSubcontratasActividad_GPP_Actividad]
GO
/****** Object:  ForeignKey [FK_GPP_PlanSubcontratasActividad_GSC_Proveedor]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_PlanSubcontratasActividad]  WITH CHECK ADD  CONSTRAINT [FK_GPP_PlanSubcontratasActividad_GSC_Proveedor] FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[GSC_Proveedor] ([IdProveedor])
GO
ALTER TABLE [dbo].[GPP_PlanSubcontratasActividad] CHECK CONSTRAINT [FK_GPP_PlanSubcontratasActividad_GSC_Proveedor]
GO
/****** Object:  ForeignKey [FK_GPP_Presupuesto_GPP_Moneda]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_Presupuesto]  WITH CHECK ADD  CONSTRAINT [FK_GPP_Presupuesto_GPP_Moneda] FOREIGN KEY([IdMoneda])
REFERENCES [dbo].[GSC_Moneda] ([IdMoneda])
GO
ALTER TABLE [dbo].[GPP_Presupuesto] CHECK CONSTRAINT [FK_GPP_Presupuesto_GPP_Moneda]
GO
/****** Object:  ForeignKey [FK_GPP_Presupuesto_GPP_Proyecto]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_Presupuesto]  WITH CHECK ADD  CONSTRAINT [FK_GPP_Presupuesto_GPP_Proyecto] FOREIGN KEY([IdProyecto])
REFERENCES [dbo].[GPP_Proyecto] ([IdProyecto])
GO
ALTER TABLE [dbo].[GPP_Presupuesto] CHECK CONSTRAINT [FK_GPP_Presupuesto_GPP_Proyecto]
GO
/****** Object:  ForeignKey [FK_GPP_ProyectoHist_GPP_Entregable]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_ProyectoHist]  WITH CHECK ADD  CONSTRAINT [FK_GPP_ProyectoHist_GPP_Entregable] FOREIGN KEY([IdEntregable])
REFERENCES [dbo].[GPP_Entregable] ([IdEntregable])
GO
ALTER TABLE [dbo].[GPP_ProyectoHist] CHECK CONSTRAINT [FK_GPP_ProyectoHist_GPP_Entregable]
GO
/****** Object:  ForeignKey [FK_GPP_ProyectoHist_GPP_ProyectoHist]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_ProyectoHist]  WITH CHECK ADD  CONSTRAINT [FK_GPP_ProyectoHist_GPP_ProyectoHist] FOREIGN KEY([IdPresupuesto])
REFERENCES [dbo].[GPP_Presupuesto] ([IdPresupuesto])
GO
ALTER TABLE [dbo].[GPP_ProyectoHist] CHECK CONSTRAINT [FK_GPP_ProyectoHist_GPP_ProyectoHist]
GO
/****** Object:  ForeignKey [FK_GPP_ProyectoHist_GPP_TipoProyecto]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_ProyectoHist]  WITH CHECK ADD  CONSTRAINT [FK_GPP_ProyectoHist_GPP_TipoProyecto] FOREIGN KEY([IdTipoProyecto])
REFERENCES [dbo].[GPP_TipoProyecto] ([IdTipoProyecto])
GO
ALTER TABLE [dbo].[GPP_ProyectoHist] CHECK CONSTRAINT [FK_GPP_ProyectoHist_GPP_TipoProyecto]
GO
/****** Object:  ForeignKey [FK_GPP_ProyectoHist_GPP_Ubigeo]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_ProyectoHist]  WITH CHECK ADD  CONSTRAINT [FK_GPP_ProyectoHist_GPP_Ubigeo] FOREIGN KEY([IdUbigeo])
REFERENCES [dbo].[GPP_Ubigeo] ([IdUbigeo])
GO
ALTER TABLE [dbo].[GPP_ProyectoHist] CHECK CONSTRAINT [FK_GPP_ProyectoHist_GPP_Ubigeo]
GO
/****** Object:  ForeignKey [FK_GPP_Recurso_GPP_TipoRecurso]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_Recurso]  WITH CHECK ADD  CONSTRAINT [FK_GPP_Recurso_GPP_TipoRecurso] FOREIGN KEY([IdTipoRecurso])
REFERENCES [dbo].[GPP_TipoRecurso] ([IdTipoRecurso])
GO
ALTER TABLE [dbo].[GPP_Recurso] CHECK CONSTRAINT [FK_GPP_Recurso_GPP_TipoRecurso]
GO
/****** Object:  ForeignKey [FK_GPP_TipoRecurso_GPP_Proyecto]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GPP_TipoRecurso]  WITH CHECK ADD  CONSTRAINT [FK_GPP_TipoRecurso_GPP_Proyecto] FOREIGN KEY([IdProyecto])
REFERENCES [dbo].[GPP_Proyecto] ([IdProyecto])
GO
ALTER TABLE [dbo].[GPP_TipoRecurso] CHECK CONSTRAINT [FK_GPP_TipoRecurso_GPP_Proyecto]
GO
/****** Object:  ForeignKey [R_47]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_CartillaCuestionario]  WITH CHECK ADD  CONSTRAINT [R_47] FOREIGN KEY([IdParametroCriterio])
REFERENCES [dbo].[GRH_ParametroCriterio] ([IdParametroCriterio])
GO
ALTER TABLE [dbo].[GRH_CartillaCuestionario] CHECK CONSTRAINT [R_47]
GO
/****** Object:  ForeignKey [R_31]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_ContratoPersonal]  WITH CHECK ADD  CONSTRAINT [R_31] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[GRH_Empleado] ([IdEmpleado])
GO
ALTER TABLE [dbo].[GRH_ContratoPersonal] CHECK CONSTRAINT [R_31]
GO
/****** Object:  ForeignKey [R_36]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_Convocatoria]  WITH CHECK ADD  CONSTRAINT [R_36] FOREIGN KEY([IdPerfil])
REFERENCES [dbo].[GRH_Perfil] ([IdPerfil])
GO
ALTER TABLE [dbo].[GRH_Convocatoria] CHECK CONSTRAINT [R_36]
GO
/****** Object:  ForeignKey [R_63]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_ConvocatoriaPostulante]  WITH CHECK ADD  CONSTRAINT [R_63] FOREIGN KEY([IdPostulante])
REFERENCES [dbo].[GRH_Postulante] ([IdPostulante])
GO
ALTER TABLE [dbo].[GRH_ConvocatoriaPostulante] CHECK CONSTRAINT [R_63]
GO
/****** Object:  ForeignKey [R_65]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_ConvocatoriaPostulante]  WITH CHECK ADD  CONSTRAINT [R_65] FOREIGN KEY([IdConvocatoria])
REFERENCES [dbo].[GRH_Convocatoria] ([IdConvocatoria])
GO
ALTER TABLE [dbo].[GRH_ConvocatoriaPostulante] CHECK CONSTRAINT [R_65]
GO
/****** Object:  ForeignKey [R_20]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_Correo]  WITH CHECK ADD  CONSTRAINT [R_20] FOREIGN KEY([IdPersona])
REFERENCES [dbo].[GRH_Persona] ([IdPersona])
GO
ALTER TABLE [dbo].[GRH_Correo] CHECK CONSTRAINT [R_20]
GO
/****** Object:  ForeignKey [R_26]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_DerechoHabiente]  WITH CHECK ADD  CONSTRAINT [R_26] FOREIGN KEY([IdPersona])
REFERENCES [dbo].[GRH_Persona] ([IdPersona])
GO
ALTER TABLE [dbo].[GRH_DerechoHabiente] CHECK CONSTRAINT [R_26]
GO
/****** Object:  ForeignKey [R_29]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_DerechoHabiente]  WITH CHECK ADD  CONSTRAINT [R_29] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[GRH_Empleado] ([IdEmpleado])
GO
ALTER TABLE [dbo].[GRH_DerechoHabiente] CHECK CONSTRAINT [R_29]
GO
/****** Object:  ForeignKey [R_30]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_DerechoHabiente]  WITH CHECK ADD  CONSTRAINT [R_30] FOREIGN KEY([IdTipoDerechoHabiente])
REFERENCES [dbo].[GRH_TipoDerechoHabiente] ([IdTipoDerechoHabiente])
GO
ALTER TABLE [dbo].[GRH_DerechoHabiente] CHECK CONSTRAINT [R_30]
GO
/****** Object:  ForeignKey [R_58]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_DetallePlanEvaluacionCompetencias]  WITH CHECK ADD  CONSTRAINT [R_58] FOREIGN KEY([IdPlanEvaluacionCompetencias])
REFERENCES [dbo].[GRH_PlanEvaluacionCompetencias] ([IdPlanEvaluacionCompetencias])
GO
ALTER TABLE [dbo].[GRH_DetallePlanEvaluacionCompetencias] CHECK CONSTRAINT [R_58]
GO
/****** Object:  ForeignKey [R_59]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_DetallePlanEvaluacionCompetencias]  WITH CHECK ADD  CONSTRAINT [R_59] FOREIGN KEY([IdEvaluacionCompetencia])
REFERENCES [dbo].[GRH_EvaluacionCompetencia] ([IdEvaluacionCompetencia])
GO
ALTER TABLE [dbo].[GRH_DetallePlanEvaluacionCompetencias] CHECK CONSTRAINT [R_59]
GO
/****** Object:  ForeignKey [R_1]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_Empleado]  WITH CHECK ADD  CONSTRAINT [R_1] FOREIGN KEY([IdPersona])
REFERENCES [dbo].[GRH_Persona] ([IdPersona])
GO
ALTER TABLE [dbo].[GRH_Empleado] CHECK CONSTRAINT [R_1]
GO
/****** Object:  ForeignKey [R_27]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_Empleado]  WITH CHECK ADD  CONSTRAINT [R_27] FOREIGN KEY([IdCargo])
REFERENCES [dbo].[GRH_Cargo] ([IdCargo])
GO
ALTER TABLE [dbo].[GRH_Empleado] CHECK CONSTRAINT [R_27]
GO
/****** Object:  ForeignKey [R_28]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_Empleado]  WITH CHECK ADD  CONSTRAINT [R_28] FOREIGN KEY([IdArea])
REFERENCES [dbo].[GRH_Area] ([IdArea])
GO
ALTER TABLE [dbo].[GRH_Empleado] CHECK CONSTRAINT [R_28]
GO
/****** Object:  ForeignKey [R_25]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_EstudioRealizado]  WITH CHECK ADD  CONSTRAINT [R_25] FOREIGN KEY([IdSituacionEstudio])
REFERENCES [dbo].[GRH_SituacionEstudio] ([IdSituacionEstudio])
GO
ALTER TABLE [dbo].[GRH_EstudioRealizado] CHECK CONSTRAINT [R_25]
GO
/****** Object:  ForeignKey [R_32]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_EstudioRealizado]  WITH CHECK ADD  CONSTRAINT [R_32] FOREIGN KEY([IdNivelEducativo])
REFERENCES [dbo].[GRH_NivelEducativo] ([IdNivelEducativo])
GO
ALTER TABLE [dbo].[GRH_EstudioRealizado] CHECK CONSTRAINT [R_32]
GO
/****** Object:  ForeignKey [R_33]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_EstudioRealizado]  WITH CHECK ADD  CONSTRAINT [R_33] FOREIGN KEY([IdPersona])
REFERENCES [dbo].[GRH_Persona] ([IdPersona])
GO
ALTER TABLE [dbo].[GRH_EstudioRealizado] CHECK CONSTRAINT [R_33]
GO
/****** Object:  ForeignKey [R_34]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_EstudioRealizado]  WITH CHECK ADD  CONSTRAINT [R_34] FOREIGN KEY([IdEspecialidad])
REFERENCES [dbo].[GRH_Especialidad] ([IdEspecialidad])
GO
ALTER TABLE [dbo].[GRH_EstudioRealizado] CHECK CONSTRAINT [R_34]
GO
/****** Object:  ForeignKey [R_35]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_EvaluacionCompetencia]  WITH CHECK ADD  CONSTRAINT [R_35] FOREIGN KEY([IdPerfil])
REFERENCES [dbo].[GRH_Perfil] ([IdPerfil])
GO
ALTER TABLE [dbo].[GRH_EvaluacionCompetencia] CHECK CONSTRAINT [R_35]
GO
/****** Object:  ForeignKey [R_41]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_EvaluacionCompetencia]  WITH CHECK ADD  CONSTRAINT [R_41] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[GRH_Empleado] ([IdEmpleado])
GO
ALTER TABLE [dbo].[GRH_EvaluacionCompetencia] CHECK CONSTRAINT [R_41]
GO
/****** Object:  ForeignKey [R_54]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_EvaluacionCompetenciaCuestionario]  WITH CHECK ADD  CONSTRAINT [R_54] FOREIGN KEY([IdCuestionario])
REFERENCES [dbo].[GRH_CartillaCuestionario] ([IdCuestionario])
GO
ALTER TABLE [dbo].[GRH_EvaluacionCompetenciaCuestionario] CHECK CONSTRAINT [R_54]
GO
/****** Object:  ForeignKey [R_57]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_EvaluacionCompetenciaCuestionario]  WITH CHECK ADD  CONSTRAINT [R_57] FOREIGN KEY([IdEvaluacionCompetencia])
REFERENCES [dbo].[GRH_EvaluacionCompetencia] ([IdEvaluacionCompetencia])
GO
ALTER TABLE [dbo].[GRH_EvaluacionCompetenciaCuestionario] CHECK CONSTRAINT [R_57]
GO
/****** Object:  ForeignKey [R_55]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_EvaluacionCompetenciaEvaluador]  WITH CHECK ADD  CONSTRAINT [R_55] FOREIGN KEY([IdCuestionario])
REFERENCES [dbo].[GRH_CartillaCuestionario] ([IdCuestionario])
GO
ALTER TABLE [dbo].[GRH_EvaluacionCompetenciaEvaluador] CHECK CONSTRAINT [R_55]
GO
/****** Object:  ForeignKey [R_56]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_EvaluacionCompetenciaEvaluador]  WITH CHECK ADD  CONSTRAINT [R_56] FOREIGN KEY([IdPerfil])
REFERENCES [dbo].[GRH_Perfil] ([IdPerfil])
GO
ALTER TABLE [dbo].[GRH_EvaluacionCompetenciaEvaluador] CHECK CONSTRAINT [R_56]
GO
/****** Object:  ForeignKey [R_60]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_EvaluacionCompetenciaEvaluador]  WITH CHECK ADD  CONSTRAINT [R_60] FOREIGN KEY([IdEvaluacionCompetencia])
REFERENCES [dbo].[GRH_EvaluacionCompetencia] ([IdEvaluacionCompetencia])
GO
ALTER TABLE [dbo].[GRH_EvaluacionCompetenciaEvaluador] CHECK CONSTRAINT [R_60]
GO
/****** Object:  ForeignKey [R_3]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_ExperienciaLaboral]  WITH CHECK ADD  CONSTRAINT [R_3] FOREIGN KEY([IdPersona])
REFERENCES [dbo].[GRH_Persona] ([IdPersona])
GO
ALTER TABLE [dbo].[GRH_ExperienciaLaboral] CHECK CONSTRAINT [R_3]
GO
/****** Object:  ForeignKey [R_15]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_IdiomaPersona]  WITH CHECK ADD  CONSTRAINT [R_15] FOREIGN KEY([IdPersona])
REFERENCES [dbo].[GRH_Persona] ([IdPersona])
GO
ALTER TABLE [dbo].[GRH_IdiomaPersona] CHECK CONSTRAINT [R_15]
GO
/****** Object:  ForeignKey [R_16]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_IdiomaPersona]  WITH CHECK ADD  CONSTRAINT [R_16] FOREIGN KEY([IdIdioma])
REFERENCES [dbo].[GRH_Idioma] ([IdIdioma])
GO
ALTER TABLE [dbo].[GRH_IdiomaPersona] CHECK CONSTRAINT [R_16]
GO
/****** Object:  ForeignKey [R_17]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_IdiomaPersona]  WITH CHECK ADD  CONSTRAINT [R_17] FOREIGN KEY([IdNivelIdioma])
REFERENCES [dbo].[GRH_NivelIdioma] ([IdNivelIdioma])
GO
ALTER TABLE [dbo].[GRH_IdiomaPersona] CHECK CONSTRAINT [R_17]
GO
/****** Object:  ForeignKey [R_66]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_Legajo]  WITH CHECK ADD  CONSTRAINT [R_66] FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[GRH_Empleado] ([IdEmpleado])
GO
ALTER TABLE [dbo].[GRH_Legajo] CHECK CONSTRAINT [R_66]
GO
/****** Object:  ForeignKey [R_61]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_ParametroCriterio]  WITH CHECK ADD  CONSTRAINT [R_61] FOREIGN KEY([IdCriterio])
REFERENCES [dbo].[GRH_Criterio] ([IdCriterio])
GO
ALTER TABLE [dbo].[GRH_ParametroCriterio] CHECK CONSTRAINT [R_61]
GO
/****** Object:  ForeignKey [R_62]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_ParametroCriterio]  WITH CHECK ADD  CONSTRAINT [R_62] FOREIGN KEY([IdParametro])
REFERENCES [dbo].[GRH_Parametro] ([IdParametro])
GO
ALTER TABLE [dbo].[GRH_ParametroCriterio] CHECK CONSTRAINT [R_62]
GO
/****** Object:  ForeignKey [R_13]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_Persona]  WITH CHECK ADD  CONSTRAINT [R_13] FOREIGN KEY([IdEstadoCivil])
REFERENCES [dbo].[GRH_EstadoCivil] ([IdEstadoCivil])
GO
ALTER TABLE [dbo].[GRH_Persona] CHECK CONSTRAINT [R_13]
GO
/****** Object:  ForeignKey [R_6]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_Persona]  WITH CHECK ADD  CONSTRAINT [R_6] FOREIGN KEY([IdPaisResidencia])
REFERENCES [dbo].[GRH_Pais] ([IdPais])
GO
ALTER TABLE [dbo].[GRH_Persona] CHECK CONSTRAINT [R_6]
GO
/****** Object:  ForeignKey [R_8]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_Persona]  WITH CHECK ADD  CONSTRAINT [R_8] FOREIGN KEY([IdPaisNacionalidad])
REFERENCES [dbo].[GRH_Pais] ([IdPais])
GO
ALTER TABLE [dbo].[GRH_Persona] CHECK CONSTRAINT [R_8]
GO
/****** Object:  ForeignKey [R_2]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_Postulante]  WITH CHECK ADD  CONSTRAINT [R_2] FOREIGN KEY([IdPersona])
REFERENCES [dbo].[GRH_Persona] ([IdPersona])
GO
ALTER TABLE [dbo].[GRH_Postulante] CHECK CONSTRAINT [R_2]
GO
/****** Object:  ForeignKey [R_4]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GRH_Telefono]  WITH CHECK ADD  CONSTRAINT [R_4] FOREIGN KEY([IdPersona])
REFERENCES [dbo].[GRH_Persona] ([IdPersona])
GO
ALTER TABLE [dbo].[GRH_Telefono] CHECK CONSTRAINT [R_4]
GO
/****** Object:  ForeignKey [FK_CalificacionServicioProveedorTipoServicio_DetalleRequerimiento]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_CalificacionServicioProveedorTipoServicio]  WITH CHECK ADD  CONSTRAINT [FK_CalificacionServicioProveedorTipoServicio_DetalleRequerimiento] FOREIGN KEY([IdProyecto], [IdRequerimiento], [IdCorDetReq])
REFERENCES [dbo].[GSC_DetalleRequerimiento] ([IdProyecto], [IdRequerimiento], [IdCorDetReq])
GO
ALTER TABLE [dbo].[GSC_CalificacionServicioProveedorTipoServicio] CHECK CONSTRAINT [FK_CalificacionServicioProveedorTipoServicio_DetalleRequerimiento]
GO
/****** Object:  ForeignKey [FK_CalificacionServicioProveedorTipoServicio_ParametrosCalificacionTipoServicio]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_CalificacionServicioProveedorTipoServicio]  WITH CHECK ADD  CONSTRAINT [FK_CalificacionServicioProveedorTipoServicio_ParametrosCalificacionTipoServicio] FOREIGN KEY([IdTipoServicio], [IdParametroCalificacion])
REFERENCES [dbo].[GSC_ParametroCalificacionTipoServicio] ([IdTipoServicio], [IdParametroCalificacion])
GO
ALTER TABLE [dbo].[GSC_CalificacionServicioProveedorTipoServicio] CHECK CONSTRAINT [FK_CalificacionServicioProveedorTipoServicio_ParametrosCalificacionTipoServicio]
GO
/****** Object:  ForeignKey [FK_CalificacionServicioProveedorTipoServicio_ProveedorTipoServicio]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_CalificacionServicioProveedorTipoServicio]  WITH CHECK ADD  CONSTRAINT [FK_CalificacionServicioProveedorTipoServicio_ProveedorTipoServicio] FOREIGN KEY([IdProveedor], [IdTipoServicio])
REFERENCES [dbo].[GSC_ProveedorTipoServicio] ([IdProveedor], [IdTipoServicio])
GO
ALTER TABLE [dbo].[GSC_CalificacionServicioProveedorTipoServicio] CHECK CONSTRAINT [FK_CalificacionServicioProveedorTipoServicio_ProveedorTipoServicio]
GO
/****** Object:  ForeignKey [FK_Cotizacion_FormaPago]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_Cotizacion]  WITH CHECK ADD  CONSTRAINT [FK_Cotizacion_FormaPago] FOREIGN KEY([IdFormaPago])
REFERENCES [dbo].[GSC_FormaPago] ([IdFormaPago])
GO
ALTER TABLE [dbo].[GSC_Cotizacion] CHECK CONSTRAINT [FK_Cotizacion_FormaPago]
GO
/****** Object:  ForeignKey [FK_Cotizacion_Moneda]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_Cotizacion]  WITH CHECK ADD  CONSTRAINT [FK_Cotizacion_Moneda] FOREIGN KEY([IdMoneda])
REFERENCES [dbo].[GSC_Moneda] ([IdMoneda])
GO
ALTER TABLE [dbo].[GSC_Cotizacion] CHECK CONSTRAINT [FK_Cotizacion_Moneda]
GO
/****** Object:  ForeignKey [FK_Cotizacion_SolicitudProveedorTipoServicio]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_Cotizacion]  WITH CHECK ADD  CONSTRAINT [FK_Cotizacion_SolicitudProveedorTipoServicio] FOREIGN KEY([IdSolicitudCotizacion], [IdProveedor], [IdTipoServicio])
REFERENCES [dbo].[GSC_SolicitudProveedorTipoServicio] ([IdSolicitudCotizacion], [IdProveedor], [IdTipoServicio])
GO
ALTER TABLE [dbo].[GSC_Cotizacion] CHECK CONSTRAINT [FK_Cotizacion_SolicitudProveedorTipoServicio]
GO
/****** Object:  ForeignKey [FK_DetalleCotizacion_Cotizacion]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_DetalleCotizacion]  WITH CHECK ADD  CONSTRAINT [FK_DetalleCotizacion_Cotizacion] FOREIGN KEY([IdCotizacion])
REFERENCES [dbo].[GSC_Cotizacion] ([IdCotizacion])
GO
ALTER TABLE [dbo].[GSC_DetalleCotizacion] CHECK CONSTRAINT [FK_DetalleCotizacion_Cotizacion]
GO
/****** Object:  ForeignKey [FK_DetalleCotizacion_DetalleSolicitud]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_DetalleCotizacion]  WITH CHECK ADD  CONSTRAINT [FK_DetalleCotizacion_DetalleSolicitud] FOREIGN KEY([IdSolicitudCotizacion], [IdSolicitudDetalle])
REFERENCES [dbo].[GSC_DetalleSolicitudRequerimiento] ([IdSolicitudCotizacion], [IdSolicitudDetalle])
GO
ALTER TABLE [dbo].[GSC_DetalleCotizacion] CHECK CONSTRAINT [FK_DetalleCotizacion_DetalleSolicitud]
GO
/****** Object:  ForeignKey [FK_DetalleCotizacion_UnidadMedida]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_DetalleCotizacion]  WITH CHECK ADD  CONSTRAINT [FK_DetalleCotizacion_UnidadMedida] FOREIGN KEY([IdUnidadMedida])
REFERENCES [dbo].[GSC_UnidadMedida] ([IdUnidadMedida])
GO
ALTER TABLE [dbo].[GSC_DetalleCotizacion] CHECK CONSTRAINT [FK_DetalleCotizacion_UnidadMedida]
GO
/****** Object:  ForeignKey [FK_DetalleRequerimiento_Requerimiento]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_DetalleRequerimiento]  WITH CHECK ADD  CONSTRAINT [FK_DetalleRequerimiento_Requerimiento] FOREIGN KEY([IdProyecto], [IdRequerimiento])
REFERENCES [dbo].[GSC_Requerimiento] ([IdProyecto], [IdRequerimiento])
GO
ALTER TABLE [dbo].[GSC_DetalleRequerimiento] CHECK CONSTRAINT [FK_DetalleRequerimiento_Requerimiento]
GO
/****** Object:  ForeignKey [FK_DetalleRequerimiento_UnidadMedida]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_DetalleRequerimiento]  WITH CHECK ADD  CONSTRAINT [FK_DetalleRequerimiento_UnidadMedida] FOREIGN KEY([IdProyecto], [IdRequerimiento], [IdCorDetReq])
REFERENCES [dbo].[GSC_DetalleRequerimiento] ([IdProyecto], [IdRequerimiento], [IdCorDetReq])
GO
ALTER TABLE [dbo].[GSC_DetalleRequerimiento] CHECK CONSTRAINT [FK_DetalleRequerimiento_UnidadMedida]
GO
/****** Object:  ForeignKey [FK_DetalleSolicitudRequerimiento_DetalleRequerimiento]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_DetalleSolicitudRequerimiento]  WITH CHECK ADD  CONSTRAINT [FK_DetalleSolicitudRequerimiento_DetalleRequerimiento] FOREIGN KEY([IdProyecto], [IdRequerimiento], [IdCorDetReq])
REFERENCES [dbo].[GSC_DetalleRequerimiento] ([IdProyecto], [IdRequerimiento], [IdCorDetReq])
GO
ALTER TABLE [dbo].[GSC_DetalleSolicitudRequerimiento] CHECK CONSTRAINT [FK_DetalleSolicitudRequerimiento_DetalleRequerimiento]
GO
/****** Object:  ForeignKey [FK_DetalleSolicitudRequerimiento_SolicitudCotizacion]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_DetalleSolicitudRequerimiento]  WITH CHECK ADD  CONSTRAINT [FK_DetalleSolicitudRequerimiento_SolicitudCotizacion] FOREIGN KEY([IdSolicitudCotizacion])
REFERENCES [dbo].[GSC_SolicitudCotizacion] ([IdSolicitudCotizacion])
GO
ALTER TABLE [dbo].[GSC_DetalleSolicitudRequerimiento] CHECK CONSTRAINT [FK_DetalleSolicitudRequerimiento_SolicitudCotizacion]
GO
/****** Object:  ForeignKey [FK_Incidencia_ParteDiario]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_Incidencia]  WITH CHECK ADD  CONSTRAINT [FK_Incidencia_ParteDiario] FOREIGN KEY([IdProyecto], [IdRequerimiento], [IdParteDiario], [IdCorDetReq])
REFERENCES [dbo].[GSC_ParteDiario] ([IdProyecto], [IdRequerimiento], [IdParteDiario], [IdCorDetReq])
GO
ALTER TABLE [dbo].[GSC_Incidencia] CHECK CONSTRAINT [FK_Incidencia_ParteDiario]
GO
/****** Object:  ForeignKey [FK_InformeFinal_Requerimiento]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_InformeFinal]  WITH CHECK ADD  CONSTRAINT [FK_InformeFinal_Requerimiento] FOREIGN KEY([IdProyecto], [IdRequerimiento])
REFERENCES [dbo].[GSC_Requerimiento] ([IdProyecto], [IdRequerimiento])
GO
ALTER TABLE [dbo].[GSC_InformeFinal] CHECK CONSTRAINT [FK_InformeFinal_Requerimiento]
GO
/****** Object:  ForeignKey [FK_InformeServicio_DetalleRequerimiento]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_InformeServicio]  WITH CHECK ADD  CONSTRAINT [FK_InformeServicio_DetalleRequerimiento] FOREIGN KEY([IdProyecto], [IdRequerimiento], [IdCorDetReq])
REFERENCES [dbo].[GSC_DetalleRequerimiento] ([IdProyecto], [IdRequerimiento], [IdCorDetReq])
GO
ALTER TABLE [dbo].[GSC_InformeServicio] CHECK CONSTRAINT [FK_InformeServicio_DetalleRequerimiento]
GO
/****** Object:  ForeignKey [FK_OrdenPago_InformeServicio]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_OrdenPago]  WITH CHECK ADD  CONSTRAINT [FK_OrdenPago_InformeServicio] FOREIGN KEY([IdProyecto], [IdRequerimiento], [IdCorDetReq], [IdInfServ])
REFERENCES [dbo].[GSC_InformeServicio] ([IdProyecto], [IdRequerimiento], [IdCorDetReq], [IdInfServ])
GO
ALTER TABLE [dbo].[GSC_OrdenPago] CHECK CONSTRAINT [FK_OrdenPago_InformeServicio]
GO
/****** Object:  ForeignKey [FK_ParametrosCalificacionTipoServicio_ParametrosCalificacion]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_ParametroCalificacionTipoServicio]  WITH CHECK ADD  CONSTRAINT [FK_ParametrosCalificacionTipoServicio_ParametrosCalificacion] FOREIGN KEY([IdParametroCalificacion])
REFERENCES [dbo].[GSC_ParametroCalificacion] ([IdParametroCalificacion])
GO
ALTER TABLE [dbo].[GSC_ParametroCalificacionTipoServicio] CHECK CONSTRAINT [FK_ParametrosCalificacionTipoServicio_ParametrosCalificacion]
GO
/****** Object:  ForeignKey [FK_ParametrosCalificacionTipoServicio_TipoServicio]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_ParametroCalificacionTipoServicio]  WITH CHECK ADD  CONSTRAINT [FK_ParametrosCalificacionTipoServicio_TipoServicio] FOREIGN KEY([IdTipoServicio])
REFERENCES [dbo].[GSC_TipoServicio] ([IdTipoServicio])
GO
ALTER TABLE [dbo].[GSC_ParametroCalificacionTipoServicio] CHECK CONSTRAINT [FK_ParametrosCalificacionTipoServicio_TipoServicio]
GO
/****** Object:  ForeignKey [FK_ParteDiario_DetalleRequerimiento]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_ParteDiario]  WITH CHECK ADD  CONSTRAINT [FK_ParteDiario_DetalleRequerimiento] FOREIGN KEY([IdProyecto], [IdRequerimiento], [IdCorDetReq])
REFERENCES [dbo].[GSC_DetalleRequerimiento] ([IdProyecto], [IdRequerimiento], [IdCorDetReq])
GO
ALTER TABLE [dbo].[GSC_ParteDiario] CHECK CONSTRAINT [FK_ParteDiario_DetalleRequerimiento]
GO
/****** Object:  ForeignKey [FK_Penalidad_InformeServicio]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_Penalidad]  WITH CHECK ADD  CONSTRAINT [FK_Penalidad_InformeServicio] FOREIGN KEY([IdProyecto], [IdRequerimiento], [IdCorDetReq], [IdInfServ])
REFERENCES [dbo].[GSC_InformeServicio] ([IdProyecto], [IdRequerimiento], [IdCorDetReq], [IdInfServ])
GO
ALTER TABLE [dbo].[GSC_Penalidad] CHECK CONSTRAINT [FK_Penalidad_InformeServicio]
GO
/****** Object:  ForeignKey [FK_Penalidad_OrdenPago]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_Penalidad]  WITH CHECK ADD  CONSTRAINT [FK_Penalidad_OrdenPago] FOREIGN KEY([IdProyecto], [IdRequerimiento], [IdCorDetReq], [IdOrdenPago])
REFERENCES [dbo].[GSC_OrdenPago] ([IdProyecto], [IdRequerimiento], [IdCorDetReq], [IdOrdenPago])
GO
ALTER TABLE [dbo].[GSC_Penalidad] CHECK CONSTRAINT [FK_Penalidad_OrdenPago]
GO
/****** Object:  ForeignKey [FK_ProveedorTipoServicio_Proveedor]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_ProveedorTipoServicio]  WITH CHECK ADD  CONSTRAINT [FK_ProveedorTipoServicio_Proveedor] FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[GSC_Proveedor] ([IdProveedor])
GO
ALTER TABLE [dbo].[GSC_ProveedorTipoServicio] CHECK CONSTRAINT [FK_ProveedorTipoServicio_Proveedor]
GO
/****** Object:  ForeignKey [FK_ProveedorTipoServicio_TipoServicio]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_ProveedorTipoServicio]  WITH CHECK ADD  CONSTRAINT [FK_ProveedorTipoServicio_TipoServicio] FOREIGN KEY([IdTipoServicio])
REFERENCES [dbo].[GSC_TipoServicio] ([IdTipoServicio])
GO
ALTER TABLE [dbo].[GSC_ProveedorTipoServicio] CHECK CONSTRAINT [FK_ProveedorTipoServicio_TipoServicio]
GO
/****** Object:  ForeignKey [FK_Requerimiento_Proyecto]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_Requerimiento]  WITH CHECK ADD  CONSTRAINT [FK_Requerimiento_Proyecto] FOREIGN KEY([IdProyecto])
REFERENCES [dbo].[GPP_Proyecto] ([IdProyecto])
GO
ALTER TABLE [dbo].[GSC_Requerimiento] CHECK CONSTRAINT [FK_Requerimiento_Proyecto]
GO
/****** Object:  ForeignKey [FK_SolicitudProveedorTipoServicio_ProveedorTipoServicio]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_SolicitudProveedorTipoServicio]  WITH CHECK ADD  CONSTRAINT [FK_SolicitudProveedorTipoServicio_ProveedorTipoServicio] FOREIGN KEY([IdProveedor], [IdTipoServicio])
REFERENCES [dbo].[GSC_ProveedorTipoServicio] ([IdProveedor], [IdTipoServicio])
GO
ALTER TABLE [dbo].[GSC_SolicitudProveedorTipoServicio] CHECK CONSTRAINT [FK_SolicitudProveedorTipoServicio_ProveedorTipoServicio]
GO
/****** Object:  ForeignKey [FK_SolicitudProveedorTipoServicio_SolicitudCotizacion]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[GSC_SolicitudProveedorTipoServicio]  WITH CHECK ADD  CONSTRAINT [FK_SolicitudProveedorTipoServicio_SolicitudCotizacion] FOREIGN KEY([IdSolicitudCotizacion])
REFERENCES [dbo].[GSC_SolicitudCotizacion] ([IdSolicitudCotizacion])
GO
ALTER TABLE [dbo].[GSC_SolicitudProveedorTipoServicio] CHECK CONSTRAINT [FK_SolicitudProveedorTipoServicio_SolicitudCotizacion]
GO
/****** Object:  ForeignKey [FK_GS_UsuarioRol_Rol]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[SEG_UsuarioPerfil]  WITH CHECK ADD  CONSTRAINT [FK_GS_UsuarioRol_Rol] FOREIGN KEY([IdPerfil])
REFERENCES [dbo].[SEG_Perfil] ([IDPerfil])
GO
ALTER TABLE [dbo].[SEG_UsuarioPerfil] CHECK CONSTRAINT [FK_GS_UsuarioRol_Rol]
GO
/****** Object:  ForeignKey [FK_GS_UsuarioRol_Usuario]    Script Date: 09/01/2013 22:59:37 ******/
ALTER TABLE [dbo].[SEG_UsuarioPerfil]  WITH CHECK ADD  CONSTRAINT [FK_GS_UsuarioRol_Usuario] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[SEG_Usuario] ([IDUsuario])
GO
ALTER TABLE [dbo].[SEG_UsuarioPerfil] CHECK CONSTRAINT [FK_GS_UsuarioRol_Usuario]
GO
