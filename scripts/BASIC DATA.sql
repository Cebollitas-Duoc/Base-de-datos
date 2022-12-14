INSERT INTO T_Permiso (ID_Permiso, Descripcion) VALUES (0, 'Cliente');
INSERT INTO T_Permiso (ID_Permiso, Descripcion) VALUES (1, 'Funcionario');
INSERT INTO T_Permiso (ID_Permiso, Descripcion) VALUES (2, 'Admin');

INSERT INTO T_EstadoUsuario (ID_EstadoUsuario, Descripcion) VALUES (0, 'Por validar');
INSERT INTO T_EstadoUsuario (ID_EstadoUsuario, Descripcion) VALUES (1, 'Validado');
INSERT INTO T_EstadoUsuario (ID_EstadoUsuario, Descripcion) VALUES (2, 'Bloqueado');

INSERT INTO T_Estado (ID_Estado, Descripcion) VALUES (0, 'Activo');
INSERT INTO T_Estado (ID_Estado, Descripcion) VALUES (1, 'Inactivo');

INSERT INTO T_EstadoPago (ID_EstadoPago, Nombre, Descripcion) VALUES (0, 'Creado', 'El pago fue creado');
INSERT INTO T_EstadoPago (ID_EstadoPago, Nombre, Descripcion) VALUES (1, 'Pagado', 'El pago fue pagado con exito');
INSERT INTO T_EstadoPago (ID_EstadoPago, Nombre, Descripcion) VALUES (2, 'Cancelado', 'El pago no se puedo efectuar');

INSERT INTO T_EstadoReserva (ID_EstadoReserva, Nombre, Descripcion) VALUES (0, 'Creada', 'La reserva fue creada');
INSERT INTO T_EstadoReserva (ID_EstadoReserva, Nombre, Descripcion) VALUES (1, 'Pagada', 'La reserva fue pagada');
INSERT INTO T_EstadoReserva (ID_EstadoReserva, Nombre, Descripcion) VALUES (2, 'Finalizada', 'La estadia finalizo');
INSERT INTO T_EstadoReserva (ID_EstadoReserva, Nombre, Descripcion) VALUES (3, 'Cancelada', 'La reserva fue cancelada');

INSERT INTO T_CategoriaServicio (Descripcion) VALUES ('WIFI');
INSERT INTO T_CategoriaServicio (Descripcion) VALUES ('Calefaccion');
INSERT INTO T_CategoriaServicio (Descripcion) VALUES ('Estacionamiento');
INSERT INTO T_CategoriaServicio (Descripcion) VALUES ('TV');
INSERT INTO T_CategoriaServicio (Descripcion) VALUES ('Cocina');
INSERT INTO T_CategoriaServicio (Descripcion) VALUES ('Patio');
INSERT INTO T_CategoriaServicio (Descripcion) VALUES ('Cama - Singular');
INSERT INTO T_CategoriaServicio (Descripcion) VALUES ('Cama - Queen');
INSERT INTO T_CategoriaServicio (Descripcion) VALUES ('Cama - King');

INSERT INTO t_categoriaservicioextra (Descripcion) VALUES ('Transporte');
INSERT INTO t_categoriaservicioextra (Descripcion) VALUES ('Turismo');

INSERT INTO T_CategoriaMantencion (Descripcion) VALUES ('Electrica');
INSERT INTO T_CategoriaMantencion (Descripcion) VALUES ('Plomeria agua');
INSERT INTO T_CategoriaMantencion (Descripcion) VALUES ('Plomeria gas');
INSERT INTO T_CategoriaMantencion (Descripcion) VALUES ('Pintura');
INSERT INTO T_CategoriaMantencion (Descripcion) VALUES ('Telecomunicaciones');
INSERT INTO T_CategoriaMantencion (Descripcion) VALUES ('Reparacion');

INSERT INTO T_CategoriaReporte (ID_Categoria, Nombre) VALUES (0, 'Documento generico');
INSERT INTO T_CategoriaReporte (ID_Categoria, Nombre) VALUES (1, 'Check In');
INSERT INTO T_CategoriaReporte (ID_Categoria, Nombre) VALUES (2, 'Check Out');
INSERT INTO T_CategoriaReporte (ID_Categoria, Nombre) VALUES (3, 'Boleta');
INSERT INTO T_CategoriaReporte (ID_Categoria, Nombre) VALUES (4, 'Factura');
INSERT INTO T_CategoriaReporte (ID_Categoria, Nombre) VALUES (5, 'Contrato servicio extra');

INSERT INTO T_usuario (PASSWORD, ID_PERMISO, ID_ESTADOUSUARIO, RUT, EMAIL, PRIMERNOMBRE, PRIMERAPELLIDO, DIRECCION, TELEFONO)
VALUES ('01#40#l3Fh8sFj#547e930f2408757c50c287c568bbc4dcfaa54ad41f6d6731920108b3375f4f46', 1, 1, 20100100, 'jose@turismoreal.cl', 'Jose', 'Espinoza', 'Casa Jose', 40402020);

INSERT INTO T_usuario (PASSWORD, ID_PERMISO, ID_ESTADOUSUARIO, RUT, EMAIL, PRIMERNOMBRE, PRIMERAPELLIDO, DIRECCION, TELEFONO)
VALUES ('01#40#l3Fh8sFj#547e930f2408757c50c287c568bbc4dcfaa54ad41f6d6731920108b3375f4f46', 0, 1, 15164019, 'andres@turismoreal.cl', 'Andres', 'Groselj', '308 Belmont Avenue', 12344321);

INSERT INTO T_usuario (PASSWORD, ID_PERMISO, ID_ESTADOUSUARIO, RUT, EMAIL, PRIMERNOMBRE, PRIMERAPELLIDO, DIRECCION, TELEFONO)
VALUES ('01#40#l3Fh8sFj#547e930f2408757c50c287c568bbc4dcfaa54ad41f6d6731920108b3375f4f46', 0, 2, 20200200, 'diego@turismoreal.cl', 'Diego', 'Soto', 'Casa Diego', 87654321);

INSERT INTO t_sesion (id_usuario, llave, expiracion, fechacreacion) 
VALUES (1, 'sesionPruebasAdmin', 2209035600000, 0);

INSERT INTO t_sesion (id_usuario, llave, expiracion, fechacreacion) 
VALUES (2, 'sesionPruebasUser', 2209035600000, 0);

insert into t_trabajador (nombres, apellidos) values ('Juan Jesus', 'Castellano');
insert into t_trabajador (nombres, apellidos) values ('Victor Manuel', 'Linares');

Commit;

