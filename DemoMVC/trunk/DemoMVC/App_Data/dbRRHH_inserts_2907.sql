insert  into grh_area (descripcion) values ('Administración'),('Contabilidad'),('Ventas'),('Recursos Humanos'),('Ventas'),('Marketing');

insert  into grh_cargo (descripcion) values ('Administrador'),('Contador Auditor'),('Analista'),('Operario'),('Jefe de Area'),('Gerente General'),('Técnico Electrónico'),('Auxiliar de Seguridad'),('Auxiliar Contable'),('Mensajería'),('Coordinador de Planta'),('Conductor'),('Electricista'),('Director Comercial'),('Secretaria');

insert  into grh_estadocivil (descripcion) values ('Soltero'),('Casado'),('Viudo'),('Divorciado');

insert  into grh_idioma (descripcion) values ('Alemán'),('Francés'),('Inglés'),('Italiano'),('Japonés'),('Portugués'),('Chino Mandarín');

insert  into grh_niveleducativo (descripcion) values ('Secundario'),('Terciario'),('Universitario'),('Post Grado'),('Master'),('Doctorado'),('Otro');

insert  into grh_nivelidioma (descripcion) values ('Básico'),('Intermedio'),('Avanzado'),('Nativo');

insert  into grh_pais (descripcion) values ('Afganistán'),('Albania'),('Argelia'),('Samoa Americana'),('Andorra'),('Angola'),('Anguilla'),('Antártida'),('Antigua y Barbuda'),('Argentina'),('Armenia'),('Aruba'),('Australia'),('Austria'),('Azerbaiyán'),('Bahamas'),('Bahréin'),('Bangladesh'),('Barbados'),('Bielorrusia'),('Bélgica'),('Belice'),('Benin'),('Bermuda'),('Bhután'),('Bolivia'),('Bosnia y Herzegovina'),('Botswana'),('Isla Bouvet'),('Brasil'),('Territorio Británico en'),('Brunei'),('Bulgaria'),('Burkina Faso'),('Burundi'),('Camboya'),('Camerún'),('Canadá'),('Cabo Verde'),('Islas Caimán'),('República Centroafrican'),('Chad'),('Chile'),('China'),('China (Hong Kong SAR, Rep&uacu'),('Isla de Navidad'),('Islas Cocos (Keeling)'),('Colombia'),('Comoras'),('Congo'),('Islas Cook'),('Costa Rica'),('Cote D´Ivoire (Ivory Coast)'),('Croacia (Hrvatska)'),('Cuba'),('Chipre'),('República Checa'),('Rep. Dem. del Congo (Zaire)'),('Dinamarca'),('Djibouti'),('Dominica'),('República Dominicana'),('Timor Oriental'),('Ecuador'),('Egipto'),('El Salvador'),('Guinea Ecuatorial'),('Eritrea'),('Estonia'),('Etiopía'),('Islas Malvinas (Falkland)'),('Islas Feroe'),('Fiji'),('Finlandia'),('Francia'),('Guayana Francesa'),('French Polynesia'),('Polinesia Francesa'),('Gabón'),('Gambia'),('Georgia'),('Alemania'),('Ghana'),('Gibraltar'),('Grecia'),('Groenlandia'),('Granada'),('Guadalupe'),('Guam'),('Guatemala'),('Guinea'),('Guinea-Bissau'),('Guyana'),('Haití'),('Islas Heard y McDonald'),('Honduras'),('Hungría'),('Islandia'),('India'),('Indonesia'),('Irán'),('Irak'),('Irlanda'),('Israel'),('Italia'),('Jamaica'),('Japón'),('Jordania'),('Kazajstán'),('Kenya'),('Kiribati'),('Corea'),('Corea (D.P.R.)'),('Kuwait'),('Kirguistán'),('Lao'),('Letonia'),('Líbano'),('Lesotho'),('Liberia'),('Libia'),('Liechtenstein'),('Lituania'),('Luxemburgo'),('Macedonia'),('Madagascar'),('Malawi'),('Malasia'),('Honduras'),('Malí'),('Malta'),('Islas Marshall'),('Martinica'),('Mauritania'),('Mauricio'),('Mayotte'),('México'),('Micronesia'),('Moldavia'),('Mónaco'),('Mongolia'),('Montserrat'),('Marruecos'),('Mozambique'),('Myanmar'),('Namibia'),('Nauru'),('Nepal'),('Holanda'),('Antillas Holandesas'),('Nueva Caledonia'),('Nueva Zelanda'),('Nicaragua'),('Niger'),('Nigeria'),('Niue'),('Isla Norfolk'),('Islas Marianas del Norte'),('Noruega'),('Omán'),('Pakistán'),('Palau'),('Panamá'),('Papúa-Nueva Guine'),('Paraguay'),('Perú'),('Filipinas'),('Pitcairn'),('Polonia'),('Portugal'),('Puerto Rico'),('Qatar'),('Reunion'),('Rumanía'),('Rusia'),('Rwanda'),('Saint Kitts And Nevis'),('Santa Lucía'),('San Vicente y las Granadinas'),('Samoa'),('San Marino'),('Santo Tomé y Prí'),('Arabia Saudí'),('Senegal'),('Seychelles'),('Sierra Leona'),('Singapur'),('Eslovaquia'),('Eslovenia'),('Islas Salomón'),('Somalia'),('Sudáfrica'),('Georgia del Sur e Islas Sandwi'),('Espa&ntilde;a'),('Sri Lanka'),('Santa Elena'),('St Pierre y Miquelon'),('Sudán'),('Suriname'),('Islas Svalbard y Jan Mayen'),('Suazilandia'),('Suecia'),('Suiza'),('Siria'),('Taiwán'),('Tayikistán'),('Tanzania'),('Tailandia'),('Togo'),('Tokelau'),('Tonga'),('Trinidad y Tobago'),('Túnez'),('Turquía'),('Turkmenistán'),('Islas Turcas y Caicos'),('Tuvalu'),('Uganda'),('Ucrania'),('Emiratos Arabes Unidos'),('Reino Unido'),('Estados Unidos'),('Estados Unidos Islas Menores'),('Uruguay'),('Uzbekistán'),('Vanuatu'),('Ciudad del Vaticano (Santa Sed'),('Venezuela'),('Vietnam'),('Islas Vírgenes (Brit&aa'),('Islas Vírgenes (EE.UU.)'),('Wallis y Futuna'),('Sáhara Occidental'),('Yemen'),('Yugoslavia'),('Zambia'),('Zimbabwe');

insert  into grh_situacionestudio (descripcion) values ('Graduado'),('En curso'),('Abandonado');

insert  into grh_tipoderechohabiente (descripcion) values ('Hijo'),('Cónyuge'),('Concubina');

insert  into grh_tipodocumento (descripcion) values ('DNI'),('Pasaporte'),('Carnet de Extranjería');

insert  into grh_especialidad (descripcion) values ('Especialidad 1'),('Especialidad 2'),('Especialidad 3');

declare @idpersona int
insert into grh_persona (nombre,apellidoPaterno,apellidoMaterno, direccion, sexo, fechaNacimiento, idPais_R, idPais_N, idEstadoCivil)
values ('LORENA','PEREZ','LAZO','LIMA',0,convert(datetime,'1984-01-20',120),1,100,1)
set @idpersona=@@identity
insert into grh_postulante (idPersona, disponibilidad, aprobado) values(@idpersona,'15 DIAS',1)
insert into grh_documento (idpersona,idtipodocumento,nroDocumento) values (@idpersona,1,'42828282')
insert into grh_telefono (idpersona,nrotelefono) values (@idpersona,'9928388737'),(@idpersona,'994737737'),(@idpersona,'992483737')
insert into grh_correo (idpersona,cuentaCorreo) values (@idpersona,'l@c.com'),(@idpersona,'x@u.pe'),(@idpersona,'p@d.com')

insert into grh_persona (nombre,apellidoPaterno,apellidoMaterno, direccion, sexo, fechaNacimiento, idPais_R, idPais_N, idEstadoCivil) 
values ('JUAN','GOMEZ','LINARES','Calle Siempre Viva 1233',0,convert(datetime,'1984-01-20',120),5,43,1)
set @idpersona=@@identity
insert into grh_postulante (idPersona, disponibilidad, aprobado) values
(@idpersona,'20 DIAS',1)
insert into grh_documento (idpersona,idtipodocumento,nroDocumento) values
(@idpersona,1,'42536457')
insert into grh_telefono (idpersona,nrotelefono) values (@idpersona,'9934588737'),(@idpersona,'9977171877'),(@idpersona,'992481234')
insert into grh_correo (idpersona,cuentaCorreo) values (@idpersona,'jgomez@cuenta.com'),(@idpersona,'u838@upc.pe'),(@idpersona,'gomez@diez.com')

insert into grh_persona (nombre,apellidoPaterno,apellidoMaterno, direccion, sexo, fechaNacimiento, idPais_R, idPais_N, idEstadoCivil)
values ('KARIN','PANIAGUA','LINARES','Av. Los Cabitos 123 dpto 1',0,convert(datetime,'1984-01-20',120),2,1,2)
set @idpersona=@@identity
insert into grh_postulante (idPersona, disponibilidad, aprobado) values
(@idpersona,'10 DIAS',1)
insert into grh_documento (idpersona,idtipodocumento,nroDocumento) values
(@idpersona,1,'42765432')
insert into grh_telefono (idpersona,nrotelefono) values (@idpersona,'9928356374'),(@idpersona,'9947012256'),(@idpersona,'9924122329')
insert into grh_correo (idpersona,cuentaCorreo) values (@idpersona,'kpaniagua@cdez.com'),(@idpersona,'kpaniagua@u.pe'),(@idpersona,'p@d.com')

insert into grh_persona (nombre,apellidoPaterno,apellidoMaterno, direccion, sexo, fechaNacimiento, idPais_R, idPais_N, idEstadoCivil)
values ('MARIO','PEREZ','SERAS','Av. Luis Roldan 1233',1,convert(datetime,'1984-01-20',120),1,1,1)
set @idpersona=@@identity
insert into grh_postulante (idPersona, disponibilidad, aprobado) values
(@idpersona,'5 DIAS',1)
insert into grh_documento (idpersona,idtipodocumento,nroDocumento) values
(@idpersona,1,'42998765')
insert into grh_telefono (idpersona,nrotelefono) values (@idpersona,'9928398076'),(@idpersona,'994772727'),(@idpersona,'9999022234')
insert into grh_correo (idpersona,cuentaCorreo) values (@idpersona,'mperez@hyper.com'),(@idpersona,'mperez@usil.pe'),(@idpersona,'mperez@d.com')

insert into grh_persona (nombre,apellidoPaterno,apellidoMaterno, direccion, sexo, fechaNacimiento, idPais_R, idPais_N, idEstadoCivil)
values ('SHELBY','CARRASCO','HUAROTO','Calle Los Jazmines Int A',1,convert(datetime,'1984-01-20',120), 8,8,1)
set @idpersona=@@identity
insert into grh_postulante (idPersona, disponibilidad, aprobado) values
(@idpersona,'15 DIAS',1)
insert into grh_documento (idpersona,idtipodocumento,nroDocumento) values
(@idpersona,1,'49987112')
insert into grh_telefono (idpersona,nrotelefono) values (@idpersona,'9928273645'),(@idpersona,'994282828'),(@idpersona,'9920009972')
insert into grh_correo (idpersona,cuentaCorreo) values (@idpersona,'scarrasco@hotmail.com'),(@idpersona,'scarrsco@utec.pe'),(@idpersona,'pepon@dinners.com')

insert into grh_persona (nombre,apellidoPaterno,apellidoMaterno, direccion, sexo, fechaNacimiento, idPais_R, idPais_N, idEstadoCivil)
values ('CARLOS','GAVILAN','JIMENEZ','Pasaje Federico Huertas 9',1,convert(datetime,'1984-01-20',120),1,1,1)
set @idpersona=@@identity
insert into grh_postulante (idPersona, disponibilidad, aprobado) values
(@idpersona,'15 DIAS',1)
insert into grh_documento (idpersona,idtipodocumento,nroDocumento) values
(@idpersona,1,'41765432')
insert into grh_telefono (idpersona,nrotelefono) values (@idpersona,'997876543'),(@idpersona,'9947234333'),(@idpersona,'992098765')
insert into grh_correo (idpersona,cuentaCorreo) values (@idpersona,'gavilano@gmail.com'),(@idpersona,'123@u.pe'),(@idpersona,'cgavilan@d.com')

insert into grh_persona (nombre,apellidoPaterno,apellidoMaterno, direccion, sexo, fechaNacimiento, idPais_R, idPais_N, idEstadoCivil)
values ('IVAN','MARTEL','BARRIONUEVO','Gallo Viejo Torres de Limatambo',1,convert(datetime,'1984-01-20',120),1,1,1)
set @idpersona=@@identity
insert into grh_postulante (idPersona, disponibilidad, aprobado) values
(@idpersona,'30 DIAS',1)
insert into grh_documento (idpersona,idtipodocumento,nroDocumento) values
(@idpersona,1,'41445673')
insert into grh_telefono (idpersona,nrotelefono) values (@idpersona,'9928098721'),(@idpersona,'994887737'),(@idpersona,'992433337')
insert into grh_correo (idpersona,cuentaCorreo) values (@idpersona,'cosito@carter.com'),(@idpersona,'imartel@u.pe'),(@idpersona,'imarte@d.com')

insert into grh_persona (nombre,apellidoPaterno,apellidoMaterno, direccion, sexo, fechaNacimiento, idPais_R, idPais_N, idEstadoCivil)
values ('CARLA','TACSI','GAMEZ','Calle Batallon Husares 232',0,convert(datetime,'1984-01-20',120),1,100,1)
set @idpersona=@@identity
insert into grh_postulante (idPersona, disponibilidad, aprobado) values
(@idpersona,'15 DIAS',1)
insert into grh_documento (idpersona,idtipodocumento,nroDocumento) values
(@idpersona,1,'45374859')
insert into grh_telefono (idpersona,nrotelefono) values (@idpersona,'9928383222'),(@idpersona,'9949898989'),(@idpersona,'992422265')
insert into grh_correo (idpersona,cuentaCorreo) values (@idpersona,'ctaxi@hot.com'),(@idpersona,'ctaxi@u.pe'),(@idpersona,'ctaxi@d.com')

insert into grh_persona (nombre,apellidoPaterno,apellidoMaterno, direccion, sexo, fechaNacimiento, idPais_R, idPais_N, idEstadoCivil)
values ('CRISTIAN','TERAN','LONGHI','Av. Canada 34',1,convert(datetime,'1984-01-20',120),1,40,1)
set @idpersona=@@identity
insert into grh_postulante (idPersona, disponibilidad, aprobado) values
(@idpersona,'15 DIAS',1)
insert into grh_documento (idpersona,idtipodocumento,nroDocumento) values
(@idpersona,1,'40987654')
insert into grh_telefono (idpersona,nrotelefono) values (@idpersona,'9928273653'),(@idpersona,'994777765'),(@idpersona,'992888776')
insert into grh_correo (idpersona,cuentaCorreo) values (@idpersona,'cteran@juan.com'),(@idpersona,'cteran@upc.pe'),(@idpersona,'cteran@neptas.com')

insert into grh_persona (nombre,apellidoPaterno,apellidoMaterno, direccion, sexo, fechaNacimiento, idPais_R, idPais_N, idEstadoCivil)
values ('ALBERTO','PEREZ','GARCIA','Av. Mexico 1289',1,convert(datetime,'1984-01-20',120),40,1,1)
set @idpersona=@@identity
insert into grh_postulante (idPersona, disponibilidad, aprobado) values
(@idpersona,'15 DIAS',1)
insert into grh_documento (idpersona,idtipodocumento,nroDocumento) values
(@idpersona,1,'41876590')
insert into grh_telefono (idpersona,nrotelefono) values (@idpersona,'9928374660'),(@idpersona,'994098776'),(@idpersona,'992472611')
insert into grh_correo (idpersona,cuentaCorreo) values (@idpersona,'aperez@sigral.com'),(@idpersona,'aperez@u.pe'),(@idpersona,'aperez@poetics.com')

insert into grh_persona (nombre,apellidoPaterno,apellidoMaterno, direccion, sexo, fechaNacimiento, idPais_R, idPais_N, idEstadoCivil)
values ('ROBERTO','BENGALI','RUIZ','Jr. Zepita 12334',1,convert(datetime,'1984-01-20',120),1,1,1)
set @idpersona=@@identity
insert into grh_postulante (idPersona, disponibilidad, aprobado) values
(@idpersona,'15 DIAS',1)
insert into grh_documento (idpersona,idtipodocumento,nroDocumento) values
(@idpersona,1,'42093748')
insert into grh_telefono (idpersona,nrotelefono) values (@idpersona,'9928389877'),(@idpersona,'994273648'),(@idpersona,'992400009')
insert into grh_correo (idpersona,cuentaCorreo) values (@idpersona,'rbengalid@panda.com'),(@idpersona,'rbengali@ulima.pe'),(@idpersona,'rbengali@diametres.com')

insert into GRH_Convocatoria (fechaInicio,fechaFin,titulo,detalle,cantidadVacantes)
values (convert(datetime,'2013-01-01',120),convert(datetime,'2013-01-30',120),'Analista Control de proyecto','Buscamos Profesionales de Sistemas:
con experiencia en control de proyectos. Para desempeñar funciones de gestión de proyectos, control de avances, interacción con diferentes frentes (área usuaria, cliente, producción), elaboración de reportes. 
Requisitos:
- Profesionales técnico y/o universitarios de la carrea de ingeniería de sistemas, computación e informática.
- Experiencia mínima de 2 años utilizando las herramientas de Macros, MS Office y MS Project.
- Se valorará experiencia en el rubro de Banco y/o Seguros
Los interesados enviar cv a recruiting.peru@accenture.com 
Visita: cvaccenture.pe',5)

