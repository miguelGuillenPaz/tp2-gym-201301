using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Collections;

using DemoMVC.Models;

namespace DemoMVC.Persistencia
{
    public class LegalDAO
    {
        //Solicitud Requerimiento Legal
        public int insertarRequerimientoLegal(LegalRequerimiento reqLegal)
        {
            int nuevoIdReqLegal = 0;

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                SqlTransaction sqlTransaction = null;
                try
                {
                    SqlCommand cmdIns = new SqlCommand("pa_GJ_RequerimientoLegal_Insertar", con);
                    cmdIns.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();
                    sqlTransaction = con.BeginTransaction();

                    cmdIns.Parameters.Add(new SqlParameter("@idProyecto", reqLegal.idProyecto));
                    cmdIns.Parameters.Add(new SqlParameter("@idReqLegalTipo", reqLegal.idReqLegalTipo));
                    cmdIns.Parameters.Add(new SqlParameter("@cDescripcion", reqLegal.cDescripcion));

                    cmdIns.Transaction = sqlTransaction;
                    //totIns = cmdIns.ExecuteNonQuery();
                    nuevoIdReqLegal = Convert.ToInt32(cmdIns.ExecuteScalar());
                    sqlTransaction.Commit();

                    con.Close();

                }
                catch (Exception ex)
                {
                    if (sqlTransaction != null) sqlTransaction.Rollback();
                    throw new Exception(ex.ToString(), ex);
                }
                finally
                {
                    if (con.State == ConnectionState.Open) con.Close();
                    sqlTransaction.Dispose();
                }
            }

            return nuevoIdReqLegal;
        }

        //Solicitud Requerimiento Legal - Listado de Vecinos
        public int insertarRequerimientoLegalVecinos(LegalRequerimientoCN vecinoColLegal)
        {
            int totIns = 0;

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                SqlTransaction sqlTransaction = null;
                try
                {
                    SqlCommand cmdIns = new SqlCommand("pa_GJ_RequerimientoLegalCN_InsertarVecino", con);
                    cmdIns.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();
                    sqlTransaction = con.BeginTransaction();

                    cmdIns.Parameters.Add(new SqlParameter("@idReqLegal", vecinoColLegal.idReqLegal));
                    cmdIns.Parameters.Add(new SqlParameter("@cNombreVecino", vecinoColLegal.cNombreVecino));
                    cmdIns.Parameters.Add(new SqlParameter("@cApellidoVecino", vecinoColLegal.cApellidoVecino));
                    cmdIns.Parameters.Add(new SqlParameter("@idDocIdentidadTipo", vecinoColLegal.idDocIdentidadTipo));
                    cmdIns.Parameters.Add(new SqlParameter("@cNroDocIdentidad", vecinoColLegal.cNroDocIdentidad));
                    cmdIns.Parameters.Add(new SqlParameter("@cTipoEdificacion", vecinoColLegal.cTipoEdificacion));
                    cmdIns.Parameters.Add(new SqlParameter("@cNombreCondominio", vecinoColLegal.cNombreCondominio));
                    cmdIns.Parameters.Add(new SqlParameter("@cDireccion", vecinoColLegal.cDireccion));
                    cmdIns.Parameters.Add(new SqlParameter("@idDepartamento", vecinoColLegal.idDepartamento));
                    cmdIns.Parameters.Add(new SqlParameter("@idProvincia", vecinoColLegal.idProvincia));
                    cmdIns.Parameters.Add(new SqlParameter("@idDistrito", vecinoColLegal.idDistrito));

                    cmdIns.Transaction = sqlTransaction;
                    totIns = cmdIns.ExecuteNonQuery();
                    sqlTransaction.Commit();

                    con.Close();

                }
                catch (Exception ex)
                {
                    if (sqlTransaction != null) sqlTransaction.Rollback();
                    throw new Exception(ex.ToString(), ex);
                }
                finally
                {
                    if (con.State == ConnectionState.Open) con.Close();
                    sqlTransaction.Dispose();
                }
            }

            return totIns;
        }

        public bool insertarRequerimientoLegalPlantillaContrato(LegalRequerimientoPlantillaContrato plantillaContrato)
        {
            bool exito = false;

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                SqlTransaction sqlTransaction = null;
                try
                {
                    SqlCommand cmdIns = new SqlCommand("pa_GJ_RequerimientoLegalPC_Insertar", con);
                    cmdIns.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();
                    sqlTransaction = con.BeginTransaction();

                    cmdIns.Parameters.Add(new SqlParameter("@idReqLegal", plantillaContrato.idReqLegal));
                    cmdIns.Parameters.Add(new SqlParameter("@idContratoLegalTipo", plantillaContrato.idContratoLegalTipo));
                    cmdIns.Parameters.Add(new SqlParameter("@TieneClausulaAdicional", plantillaContrato.TieneClausulaAdicional));
                    //Plazo Indeterminado
                    cmdIns.Parameters.Add(new SqlParameter("@NombreTrabajador", plantillaContrato.NombreTrabajador));
                    cmdIns.Parameters.Add(new SqlParameter("@DniTrabajador", plantillaContrato.DniTrabajador));
                    cmdIns.Parameters.Add(new SqlParameter("@Cargo", plantillaContrato.Cargo));
                    cmdIns.Parameters.Add(new SqlParameter("@LaborDesempenar", plantillaContrato.LaborDesempenar));
                    cmdIns.Parameters.Add(new SqlParameter("@HoraInicioLabor", plantillaContrato.HoraInicioLabor));
                    cmdIns.Parameters.Add(new SqlParameter("@HoraFinLabor", plantillaContrato.HoraFinLabor));
                    cmdIns.Parameters.Add(new SqlParameter("@HoraInicioRefrigerio", plantillaContrato.HoraInicioRefrigerio));
                    cmdIns.Parameters.Add(new SqlParameter("@HoraFinRefrigerio", plantillaContrato.HoraFinRefrigerio));
                    cmdIns.Parameters.Add(new SqlParameter("@PeriodoPrueba", plantillaContrato.PeriodoPrueba));
                    //Prestación Servicios
                    cmdIns.Parameters.Add(new SqlParameter("@EmpresaOutsorcing", plantillaContrato.EmpresaOutsourcing));
                    cmdIns.Parameters.Add(new SqlParameter("@Ruc", plantillaContrato.Ruc));
                    cmdIns.Parameters.Add(new SqlParameter("@Domicilio", plantillaContrato.Domicilio));
                    cmdIns.Parameters.Add(new SqlParameter("@RepresentanteLegal", plantillaContrato.RepresentanteLegal));
                    cmdIns.Parameters.Add(new SqlParameter("@DniRepresentanteLegal", plantillaContrato.DniRepresentanteLegal));
                    cmdIns.Parameters.Add(new SqlParameter("@FichaPoderJudicial", plantillaContrato.FichaPoderJudicial));
                    cmdIns.Parameters.Add(new SqlParameter("@ObjetoSocialOutsorcing", plantillaContrato.ObjetoSocialOutsourcing));
                    cmdIns.Parameters.Add(new SqlParameter("@ServiciosBrindar", plantillaContrato.ServicioBrindar));
                    cmdIns.Parameters.Add(new SqlParameter("@DuracionContrato", plantillaContrato.DuracionContrato));
                    cmdIns.Parameters.Add(new SqlParameter("@JuezControversia", plantillaContrato.JuezControversia));
                    ///Sujeto a Modalidad
                    cmdIns.Parameters.Add(new SqlParameter("@NombreTrabajadorSM", plantillaContrato.NombreTrabajadorSM));
                    cmdIns.Parameters.Add(new SqlParameter("@DniTrabajadorSM", plantillaContrato.DniTrabajadorSM));
                    cmdIns.Parameters.Add(new SqlParameter("@ModalidadContrato", plantillaContrato.ModalidadContrato));
                    cmdIns.Parameters.Add(new SqlParameter("@Duracion", plantillaContrato.Duracion));
                    cmdIns.Parameters.Add(new SqlParameter("@HoraInicioLaborSM", plantillaContrato.HoraInicioLaborSM));
                    cmdIns.Parameters.Add(new SqlParameter("@HoraFinLaborSM", plantillaContrato.HoraFinLaborSM));
                    cmdIns.Parameters.Add(new SqlParameter("@HoraInicioRefrigerioSM", plantillaContrato.HoraInicioRefrigerioSM));
                    cmdIns.Parameters.Add(new SqlParameter("@HoraFinRefrigerioSM", plantillaContrato.HoraFinRefrigerioSM));
                    cmdIns.Parameters.Add(new SqlParameter("@JuezControversiaSM", plantillaContrato.JuezControversiaSM));
                    //
                    cmdIns.Parameters.Add(new SqlParameter("@xmlClausulasVarchar", plantillaContrato.DescripcionClausula));

                    cmdIns.Transaction = sqlTransaction;
                    cmdIns.ExecuteNonQuery();
                    sqlTransaction.Commit();

                    con.Close();

                    exito = true;

                }
                catch (Exception ex)
                {
                    if (sqlTransaction != null) sqlTransaction.Rollback();
                    exito = false;
                    throw new Exception(ex.ToString(), ex);
                }
                finally
                {
                    if (con.State == ConnectionState.Open) con.Close();
                    sqlTransaction.Dispose();
                }
            }

            return exito;
        }

        public List<Requerimiento> listarRequerimiento(Int16 idRequerimiento, Int16 idProyecto, Int16 idTipo, Int16 idEstado, DateTime fecIni, DateTime fecFin)
        {
            List<Requerimiento> listaRequerimiento = null;
            Requerimiento req = null;

           string sql = "";
           sql = "select IdRequerimientoLegal, r.IdProyecto,p.Nombre as 'descProy',p.Nombre,r.IdRequerimientoLegalTipo,rt.Descripcion,r.Descripcion as 'descReq',r.FechaRegistro,r.IdRequerimientoLegalEstado, re.Descripcion as 'estado'  ";
           sql = sql + "from GJ_RequerimientoLegal r  ";
           sql = sql + "inner join GPP_Proyecto p on p.IdProyecto = r.IdProyecto ";
           sql = sql + "inner join dbo.GJ_RequerimientoLegalTipo rt on rt.IdRequerimientoLegalTipo = r.IdRequerimientoLegalTipo ";
           sql = sql + "inner join dbo.GJ_RequerimientoLegalEstado re on re.IdRequerimientoLegalEstado= r.IdRequerimientoLegalEstado ";
           sql = sql + "where (@idEstado is null or r.IdRequerimientoLegalEstado=@idEstado)  ";
           sql = sql + "and (@idTipo is null or r.IdRequerimientoLegalTipo =@idTipo)  ";
           sql = sql + "and (@idProyecto is null or r.IdProyecto = @idProyecto) ";
           sql = sql + "and (@idReqLegal is null or r.IdRequerimientoLegal =@idReqLegal)  ";
           sql = sql + "and r.FechaRegistro>= @fecIni  ";
           sql = sql + "and r.FechaRegistro <= @fecFin";
            

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                con.Open();
                using (SqlCommand com = new SqlCommand(sql, con))
                {
                    if (idRequerimiento == 0)
                    {
                        com.Parameters.Add(new SqlParameter("@idReqLegal", DBNull.Value));
                    }
                    else
                    {
                        com.Parameters.Add(new SqlParameter("@idReqLegal", idRequerimiento));
                    }
                    if (idProyecto == 0)
                    {
                        com.Parameters.Add(new SqlParameter("@idProyecto", DBNull.Value));
                    }
                    else
                    {
                        com.Parameters.Add(new SqlParameter("@idProyecto", idProyecto));
                    }
                    if (idEstado == 0)
                    {
                        com.Parameters.Add(new SqlParameter("@idEstado", DBNull.Value));
                    }
                    else
                    {
                        com.Parameters.Add(new SqlParameter("@idEstado", idEstado));
                    }
                    if (idTipo == 0)
                    {
                        com.Parameters.Add(new SqlParameter("@idTipo", DBNull.Value));
                    }
                    else
                    {
                        com.Parameters.Add(new SqlParameter("@idTipo", idTipo));
                    }
                    com.Parameters.Add(new SqlParameter("@fecIni", fecIni));
                    com.Parameters.Add(new SqlParameter("@fecFin", fecFin));

                    using (SqlDataReader resultado = com.ExecuteReader())
                    {
                        if (resultado.HasRows)
                        {
                            listaRequerimiento = new List<Requerimiento>();
                            while (resultado.Read())
                            {
                                
                                req = new Requerimiento()
                                {
                                    idReq = (int)resultado["IdRequerimientoLegal"],
                                    descripcion = (String)resultado["descReq"],
                                    descTipoReq=(String)resultado["Descripcion"],
                                    desEstado =(String)resultado["estado"],
                                    idTipoRequerimiento = (Int16)resultado["IdRequerimientoLegalTipo"],
                                    desProyecto =(String)resultado["descProy"],
                                    idProyecto = (int)resultado["IdProyecto"],
                                    idEstado = (Int16)resultado["IdRequerimientoLegalEstado"],
                                    fecha = (DateTime)resultado["FechaRegistro"],
                                    
                                 };
                                Proyecto pro = new Proyecto();
                                pro.codPro = (int)resultado["IdProyecto"];
                                pro.desPro = (String)resultado["descProy"];

                                req.Proyecto = pro;
                                listaRequerimiento.Add(req);
                            }
                        }
                        else
                        {
                            Debug.WriteLine("No retornó registros");
                        }

                    }
                }
            }
            return listaRequerimiento;
        }

        public List<TipoRequerimiento> listarTipoRequerimiento()
        {
            List<TipoRequerimiento> listaTipoRequerimiento = null;
            TipoRequerimiento tipo = null;

            string sql = "";
            sql = "select IdRequerimientoLegalTipo, Descripcion from GJ_RequerimientoLegalTipo where Activo=1";

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                con.Open();
                using (SqlCommand com = new SqlCommand(sql, con))
                {

                    using (SqlDataReader resultado = com.ExecuteReader())
                    {
                        if (resultado.HasRows)
                        {
                            listaTipoRequerimiento = new List<TipoRequerimiento>();
                            tipo = new TipoRequerimiento()
                            {
                                idTipoReq=0,
                                descripcion="Todos",
                            };
                            listaTipoRequerimiento.Add(tipo);
                            while (resultado.Read())
                            {
                                tipo = new TipoRequerimiento()
                                {
                                    idTipoReq = (Int16)resultado["IdRequerimientoLegalTipo"],
                                    descripcion = (String)resultado["Descripcion"],
                                };
                                listaTipoRequerimiento.Add(tipo);
                            }
                        }
                        else
                        {
                            Debug.WriteLine("No retornó registros");
                        }

                    }
                }


            }
            return listaTipoRequerimiento;
        }

        public List<Estado> listarEstadoRequerimiento()
        {
            List<Estado> listaEstadoRequerimiento = null;
            Estado estado = null;

            string sql = "";
            sql = "select IdRequerimientoLegalEstado, Descripcion from GJ_RequerimientoLegalEstado";

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                con.Open();
                using (SqlCommand com= new SqlCommand(sql, con))
                {
                    using (SqlDataReader resultado = com.ExecuteReader())
                    {
                        if (resultado.HasRows)
                        {
                            listaEstadoRequerimiento = new List<Estado>();
                            estado= new Estado()
                            {
                                idEstadoReq = 0,
                                descripcion = "Todos",
                            };
                            listaEstadoRequerimiento.Add(estado);
                            while (resultado.Read())
                            {
                                estado = new Estado()
                            {
                                idEstadoReq = (Int16)resultado["IdRequerimientoLegalEstado"],
                                descripcion = (String)resultado["Descripcion"],
                            };
                                listaEstadoRequerimiento.Add(estado);
                            }
                        }
                        else
                        {
                            Debug.WriteLine("No retornó registros");
                        }
                    }
                }
            }
            return listaEstadoRequerimiento;
        }

        public int insertarRequerimientoDeclaracionFabrica(LegalRequerimientoDeclaracionFabrica legalReqDec)
        {
            int nuevoIdReqLegal = 0;

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                SqlTransaction sqlTransaction = null;
                try
                {
                    SqlCommand cmdIns = new SqlCommand("pa_GJ_RequerimientolegalDeclaracion_Insertar", con);
                    cmdIns.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();
                    sqlTransaction = con.BeginTransaction();

                    cmdIns.Parameters.Add(new SqlParameter("@idRequerimientoLegal", legalReqDec.idReqDecFab));
                    cmdIns.Parameters.Add(new SqlParameter("@declaracion", legalReqDec.DeclaracionFabrica));
                    
                    cmdIns.Transaction = sqlTransaction;
                    //totIns = cmdIns.ExecuteNonQuery();
                    nuevoIdReqLegal = Convert.ToInt32(cmdIns.ExecuteScalar());
                    sqlTransaction.Commit();

                    con.Close();

                }
                catch (Exception ex)
                {
                    if (sqlTransaction != null) sqlTransaction.Rollback();
                    throw new Exception(ex.ToString(), ex);
                }
                finally
                {
                    if (con.State == ConnectionState.Open) con.Close();
                    sqlTransaction.Dispose();
                }
            }

            return nuevoIdReqLegal;
        }

        public int insertarRequerimientoDeclaracionFabricaDocumento(LegalDeclaracionFabricaDocumento legalReqDecFabDocumento)
        {
            int nuevoIdReqLegal = 0;

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                SqlTransaction sqlTransaction = null;
                try
                {
                    SqlCommand cmdIns = new SqlCommand("pa_GJ_RequerimientolegalDeclaracionDocumento_Insertar", con);
                    cmdIns.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();
                    sqlTransaction = con.BeginTransaction();

                    cmdIns.Parameters.Add(new SqlParameter("@idRequerimientoLegalDeclaracion", legalReqDecFabDocumento.idDeclaracionFabricaDocumento));
                    cmdIns.Parameters.Add(new SqlParameter("@idDeclaracionFabricaDocumentoTipo", legalReqDecFabDocumento.idDeclaracionFabricaTipo));
                    cmdIns.Parameters.Add(new SqlParameter("@descripcion", legalReqDecFabDocumento.descripcionDocumento));
                    cmdIns.Parameters.Add(new SqlParameter("@Ruta", legalReqDecFabDocumento.ruta));

                    cmdIns.Transaction = sqlTransaction;
                    //totIns = cmdIns.ExecuteNonQuery();
                    nuevoIdReqLegal = Convert.ToInt32(cmdIns.ExecuteScalar());
                    
                    sqlTransaction.Commit();

                    con.Close();

                }
                catch (Exception ex)
                {
                    if (sqlTransaction != null) sqlTransaction.Rollback();
                    throw new Exception(ex.ToString(), ex);
                }
                finally
                {
                    if (con.State == ConnectionState.Open) con.Close();
                    sqlTransaction.Dispose();
                }
            }

            return nuevoIdReqLegal;
        }

        public List<AsesorLegal> ListarAsesorLegal()
        {
            List<AsesorLegal> listadoAsesores = null;
            AsesorLegal asesor = null;

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                SqlCommand com = new SqlCommand("pa_GJ_AsesorLegal_Listar", con);
                com.CommandType = System.Data.CommandType.StoredProcedure;

                con.Open();
                using (com)
                {
                    using (SqlDataReader resultado = com.ExecuteReader())
                    {
                        if (resultado.HasRows)
                        {
                            listadoAsesores = new List<AsesorLegal>();
                            while (resultado.Read())
                            {
                                asesor = new AsesorLegal()
                                {
                                    IdAsesorLegal = (Int32)resultado["IdAsesorLegal"],
                                    Apellido = resultado["Apellido"].ToString(),
                                    Nombre = resultado["Nombre"].ToString(),
                                    CasosAsignados = (Int32)resultado["Casos Asignados"]
                                };
                                listadoAsesores.Add(asesor);
                            }
                        }
                        else
                        {
                            Debug.WriteLine("No retornó registros");
                        }
                    }
                }
            }

            return listadoAsesores;
        }

        public List<LegalRequerimiento> ListarCasosAsignados(int idAsesorLegal)
        {
            List<LegalRequerimiento> listadoRequerimientos = null;
            LegalRequerimiento reqLegal = null;

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                SqlCommand com = new SqlCommand("pa_GJ_AsesorLegal_ListarCasosAsignados", con);
                com.CommandType = System.Data.CommandType.StoredProcedure;

                con.Open();
                using (com)
                {
                    com.Parameters.Add(new SqlParameter("@idAsesorLegal", idAsesorLegal));

                    using (SqlDataReader resultado = com.ExecuteReader())
                    {
                        if (resultado.HasRows)
                        {
                            listadoRequerimientos = new List<LegalRequerimiento>();
                            while (resultado.Read())
                            {
                                reqLegal = new LegalRequerimiento()
                                {
                                    idReqLegal = (Int32)resultado["IdRequerimientoLegal"],
                                    cDescripcionReqLegalTipo = resultado["Descripcion"].ToString(),
                                    cFechaAtencion = resultado["FechaAtencion"].ToString(),
                                    nomProyecto = resultado["Nombre"].ToString(),
                                    cDescripcionReqLegalEstado = resultado["Descripcion"].ToString()
                                };
                                listadoRequerimientos.Add(reqLegal);
                            }
                        }
                        else
                        {
                            Debug.WriteLine("No retornó registros");
                        }
                    }
                }
            }

            return listadoRequerimientos;
        }

        public bool AsignarAsesorLegal(LegalRequerimiento reqLegal)
        {
            bool exito = false;

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                SqlTransaction sqlTransaction = null;
                try
                {
                    SqlCommand cmdIns = new SqlCommand("pa_GJ_RequerimientoLegal_AsignarAsesorLegal", con);
                    cmdIns.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();
                    sqlTransaction = con.BeginTransaction();

                    cmdIns.Parameters.Add(new SqlParameter("@idReqLegal", reqLegal.idReqLegal));
                    cmdIns.Parameters.Add(new SqlParameter("@idAsesorLegal", reqLegal.idAsesorLegal));
                    cmdIns.Parameters.Add(new SqlParameter("@PrioridadAtencion", reqLegal.cPrioridadAtencion));

                    cmdIns.Transaction = sqlTransaction;
                    cmdIns.ExecuteNonQuery();
                    sqlTransaction.Commit();

                    exito = true;

                    con.Close();

                }
                catch (Exception ex)
                {
                    if (sqlTransaction != null) sqlTransaction.Rollback();
                    exito = false;
                    throw new Exception(ex.ToString(), ex);
                }
                finally
                {
                    if (con.State == ConnectionState.Open) con.Close();
                    sqlTransaction.Dispose();
                }
            }
            return exito;
        }

        public List<Usuario> listarUsuariosSolicitantes()
        {
            List<Usuario> listaUsuarios = null;
            Usuario usuario = null;

            string sql = "";
            sql += "select u.IdUsuario, u.Nombre, u.ApellidoPaterno, u.ApellidoMaterno ";
            sql += "from SEG_Usuario u ";
            sql += "inner join GJ_RequerimientoLegal l on u.IdUsuario=l.IdUsuario ";
            sql += "order by u.Nombre asc";

            using (SqlConnection con = new SqlConnection(ConexionUtil.Cadena))
            {
                con.Open();
                using (SqlCommand com = new SqlCommand(sql, con))
                {

                    using (SqlDataReader resultado = com.ExecuteReader())
                    {
                        if (resultado.HasRows)
                        {
                            listaUsuarios = new List<Usuario>();
                            usuario = new Usuario()
                            {
                                IdUsuario = 0,
                                Nombre = "Todos"
                            };
                            listaUsuarios.Add(usuario);
                            while (resultado.Read())
                            {
                                usuario = new Usuario()
                                {
                                    IdUsuario = (Int32)resultado["IdUsuario"],
                                    Nombre = (String)resultado["Nombre"] + " " + (String)resultado["ApellidoPaterno"] + " " + (String)resultado["ApellidoMaterno"]
                                };
                                listaUsuarios.Add(usuario);
                            }
                        }
                        else
                        {
                            Debug.WriteLine("No retornó registros");
                        }

                    }
                }


            }
            return listaUsuarios;
        }

    }
}