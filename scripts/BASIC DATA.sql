INSERT INTO T_Permiso (ID_Permiso, Nombre, Descripcion) VALUES (0, 'Cliente', 'Puede rentar un departamento');
INSERT INTO T_Permiso (ID_Permiso, Nombre, Descripcion) VALUES (1, 'Empleado', 'Administra el negocio');
INSERT INTO T_Permiso (ID_Permiso, Nombre, Descripcion) VALUES (2, 'Admin', 'Administra el negocio');

INSERT INTO T_EstadoUsuario (ID_EstadoUsuario, Descripcion) VALUES (0, 'Por validar');
INSERT INTO T_EstadoUsuario (ID_EstadoUsuario, Descripcion) VALUES (1, 'Validado');
INSERT INTO T_EstadoUsuario (ID_EstadoUsuario, Descripcion) VALUES (2, 'Bloqueado');

INSERT INTO T_EstadoDpto (ID_Estadodpto, Descripcion) VALUES (0, 'Activo');
INSERT INTO T_EstadoDpto (ID_Estadodpto, Descripcion) VALUES (1, 'Inactivo');

INSERT INTO T_EstadoPago (ID_EstadoPago, Nombre, Descripcion) VALUES (0, 'Creado', 'El pago fue creado');
INSERT INTO T_EstadoPago (ID_EstadoPago, Nombre, Descripcion) VALUES (1, 'Pagado', 'El pago fue pagado con exito');
INSERT INTO T_EstadoPago (ID_EstadoPago, Nombre, Descripcion) VALUES (2, 'Cancelado', 'El pago no se puedo efectuar');

INSERT INTO T_EstadoReserva (ID_EstadoReserva, Nombre, Descripcion) VALUES (0, 'Creada', 'La reserva fue creada');
INSERT INTO T_EstadoReserva (ID_EstadoReserva, Nombre, Descripcion) VALUES (1, 'Pagada', 'La reserva fue pagada');
INSERT INTO T_EstadoReserva (ID_EstadoReserva, Nombre, Descripcion) VALUES (2, 'Finalizada', 'La estadia finalizo');
INSERT INTO T_EstadoReserva (ID_EstadoReserva, Nombre, Descripcion) VALUES (3, 'Cancelada', 'La reserva fue cancelada');

INSERT INTO T_CategoriaServicio (ID_CategoriaServicio, Descripcion) VALUES (0, '');

INSERT INTO T_CategoriaMantencion (ID_CategoriaMantencion, Descripcion) VALUES (0, '');

INSERT INTO T_CategoriaReporte (ID_Categoria, Nombre) VALUES (0, 'Documento generico');
INSERT INTO T_CategoriaReporte (ID_Categoria, Nombre) VALUES (1, 'Check In');
INSERT INTO T_CategoriaReporte (ID_Categoria, Nombre) VALUES (2, 'Check Out');
INSERT INTO T_CategoriaReporte (ID_Categoria, Nombre) VALUES (3, 'Boleta');

INSERT INTO T_usuario (PASSWORD, ID_PERMISO, ID_ESTADOUSUARIO, EMAIL)
VALUES ('01#40#asdfasdf#e3e3316c1536b6d21976e118222334778854deeab0ff3f24303ad4f1f6fbffd2', 1, 1, 'jose@mrmeme.cl');

INSERT INTO T_usuario (PASSWORD, ID_PERMISO, ID_ESTADOUSUARIO, EMAIL, PRIMERNOMBRE, SEGUNDONOMBRE, PRIMERAPELLIDO, SEGUNDOAPELLIDO, DIRECCION, TELEFONO, RUTAFOTOPERFIL)
VALUES ('01#40#hjkldfgj#247728c323a8f7d2381f809267757adf4e4aa1543fe7feca268b89b0b5232d3a', 0, 1, 'andres@mrmeme.cl', 'Andres', ' ', 'Groselj', 'Pausic', '308 Belmont Avenue', '+569 1234 4321', '/img/profiles/turing.png');

INSERT INTO T_usuario (PASSWORD, ID_PERMISO, ID_ESTADOUSUARIO, EMAIL)
VALUES ('01#40#hjkldfgj#247728c323a8f7d2381f809267757adf4e4aa1543fe7feca268b89b0b5232d3a', 0, 2, 'diego@mrmeme.cl');

Commit;
