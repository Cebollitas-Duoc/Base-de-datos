-- Generated by Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   at:        2022-10-22 21:50:08 CLST
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE t_categoriamantencion (
    id_categoriamantencion NUMBER NOT NULL,
    descripcion            VARCHAR2(100)
);

ALTER TABLE t_categoriamantencion ADD CONSTRAINT t_categoriamantencion_pk PRIMARY KEY ( id_categoriamantencion );

CREATE TABLE t_categoriareporte (
    id_categoria NUMBER NOT NULL,
    nombre       VARCHAR2(50) NOT NULL
);

ALTER TABLE t_categoriareporte ADD CONSTRAINT t_categoriareporte_pk PRIMARY KEY ( id_categoria );

CREATE TABLE t_categoriaservicio (
    id_categoriaservicio NUMBER NOT NULL,
    descripcion          VARCHAR2(100) NOT NULL
);

ALTER TABLE t_categoriaservicio ADD CONSTRAINT t_servicio_pk PRIMARY KEY ( id_categoriaservicio );

CREATE TABLE t_categoriaservicioextra (
    id_categoriaservicioextra NUMBER NOT NULL,
    descripcion               VARCHAR2(100) NOT NULL
);

ALTER TABLE t_categoriaservicioextra ADD CONSTRAINT t_categoriaservicioextra_pk PRIMARY KEY ( id_categoriaservicioextra );

CREATE TABLE t_chofer (
    id_chofer       NUMBER NOT NULL,
    nombres         VARCHAR2(50) NOT NULL,
    apellidos       VARCHAR2(50) NOT NULL,
    patentevehiculo VARCHAR2(50)
);

ALTER TABLE t_chofer ADD CONSTRAINT t_chofer_pk PRIMARY KEY ( id_chofer );

CREATE TABLE t_departamento (
    id_departamento NUMBER NOT NULL,
    id_estado       NUMBER NOT NULL,
    direccion       VARCHAR2(50) NOT NULL,
    longitud        NUMBER,
    latitud         NUMBER,
    habitaciones    NUMBER NOT NULL,
    banios          NUMBER NOT NULL,
    tamanio         NUMBER NOT NULL,
    valor           NUMBER NOT NULL,
    descripcion     VARCHAR2(1000)
);

ALTER TABLE t_departamento ADD CONSTRAINT t_departamento_pk PRIMARY KEY ( id_departamento );

CREATE TABLE t_error (
    id_error    NUMBER NOT NULL,
    nombreerror VARCHAR2(50),
    descripcion VARCHAR2(200),
    fechahora   NUMBER,
    zona        VARCHAR2(50)
);

ALTER TABLE t_error ADD CONSTRAINT t_error_pk PRIMARY KEY ( id_error );

CREATE TABLE t_estado (
    id_estado   NUMBER NOT NULL,
    descripcion VARCHAR2(50) NOT NULL
);

ALTER TABLE t_estado ADD CONSTRAINT t_estado_pk PRIMARY KEY ( id_estado );

CREATE TABLE t_estadopago (
    id_estadopago NUMBER NOT NULL,
    nombre        VARCHAR2(50),
    descripcion   VARCHAR2(200)
);

ALTER TABLE t_estadopago ADD CONSTRAINT t_estadopago_pk PRIMARY KEY ( id_estadopago );

CREATE TABLE t_estadoreserva (
    id_estadoreserva NUMBER NOT NULL,
    nombre           VARCHAR2(50),
    descripcion      VARCHAR2(200),
    tipocontenido    VARCHAR2(50)
);

ALTER TABLE t_estadoreserva ADD CONSTRAINT t_estadoreserva_pk PRIMARY KEY ( id_estadoreserva );

CREATE TABLE t_estadousuario (
    id_estadousuario NUMBER NOT NULL,
    descripcion      VARCHAR2(50) NOT NULL
);

ALTER TABLE t_estadousuario ADD CONSTRAINT t_estadousuario_pk PRIMARY KEY ( id_estadousuario );

CREATE TABLE t_foto (
    id_foto VARCHAR2(50) NOT NULL,
    imgdata CLOB NOT NULL
);

ALTER TABLE t_foto ADD CONSTRAINT t_foto_pk PRIMARY KEY ( id_foto );

CREATE TABLE t_fotodpto (
    id_fotodpto     NUMBER NOT NULL,
    id_departamento NUMBER NOT NULL,
    id_foto         VARCHAR2(50) NOT NULL,
    principal       NUMBER,
    orden           NUMBER
);

ALTER TABLE t_fotodpto ADD CONSTRAINT t_fotodpto_pk PRIMARY KEY ( id_fotodpto );

CREATE TABLE t_iventario (
    id_inventario   NUMBER NOT NULL,
    nombre          VARCHAR2(50),
    cantidad        NUMBER,
    id_departamento NUMBER NOT NULL
);

ALTER TABLE t_iventario ADD CONSTRAINT t_iventario_pk PRIMARY KEY ( id_inventario );

CREATE TABLE t_mantencion (
    id_mantencion          NUMBER NOT NULL,
    id_categoriamantencion NUMBER NOT NULL,
    id_departamento        NUMBER NOT NULL,
    descripcion            VARCHAR2(200),
    valor                  NUMBER,
    fechainicio            NUMBER,
    fechafin               NUMBER
);

ALTER TABLE t_mantencion ADD CONSTRAINT t_mantencion_pk PRIMARY KEY ( id_mantencion );

CREATE TABLE t_pago (
    id_pago       NUMBER NOT NULL,
    id_estadopago NUMBER NOT NULL,
    valor         NUMBER,
    fecha         NUMBER
);

ALTER TABLE t_pago ADD CONSTRAINT t_pago_pk PRIMARY KEY ( id_pago );

CREATE TABLE t_permiso (
    id_permiso  NUMBER NOT NULL,
    descripcion VARCHAR2(50) NOT NULL
);

ALTER TABLE t_permiso ADD CONSTRAINT t_permiso_pk PRIMARY KEY ( id_permiso );

CREATE TABLE t_reporte (
    id_reporte   VARCHAR2(50) NOT NULL,
    id_reserva   NUMBER NOT NULL,
    id_categoria NUMBER NOT NULL
);

ALTER TABLE t_reporte ADD CONSTRAINT t_reporte_pk PRIMARY KEY ( id_reserva,
                                                                id_reporte );

CREATE TABLE t_reserva (
    id_reserva       NUMBER NOT NULL,
    id_usuario       NUMBER NOT NULL,
    id_departamento  NUMBER NOT NULL,
    id_estadoreserva NUMBER NOT NULL,
    id_pago          NUMBER NOT NULL,
    fechadesde       NUMBER(25),
    fechahasta       NUMBER(25),
    valortotal       NUMBER
);

ALTER TABLE t_reserva ADD CONSTRAINT t_reserva_pk PRIMARY KEY ( id_reserva );

CREATE TABLE t_servicio (
    id_servicio          NUMBER NOT NULL,
    id_categoriaservicio NUMBER NOT NULL,
    id_departamento      NUMBER NOT NULL,
    id_estado            NUMBER NOT NULL,
    cantidad             NUMBER
);

ALTER TABLE t_servicio ADD CONSTRAINT t_servicio_pkv1 PRIMARY KEY ( id_servicio );

CREATE TABLE t_servicioextra_contratado (
    id_reserva       NUMBER NOT NULL,
    id_servicioextra NUMBER NOT NULL,
    valor            NUMBER NOT NULL
);

ALTER TABLE t_servicioextra_contratado ADD CONSTRAINT t_servicioextra_contratado_pk PRIMARY KEY ( id_reserva,
                                                                                                  id_servicioextra );

CREATE TABLE t_servicioextra_departamento (
    id_servicioextra          NUMBER NOT NULL,
    id_departamento           NUMBER NOT NULL,
    id_categoriaservicioextra NUMBER NOT NULL,
    id_chofer                 NUMBER NOT NULL,
    id_estado                 NUMBER NOT NULL,
    valor                     NUMBER NOT NULL
);

--  ERROR: PK name length exceeds maximum allowed length(30) 
ALTER TABLE t_servicioextra_departamento ADD CONSTRAINT t_servicioextra_departamento_pk PRIMARY KEY ( id_servicioextra );

CREATE TABLE t_sesion (
    id_sesion     NUMBER NOT NULL,
    id_usuario    NUMBER NOT NULL,
    llave         VARCHAR2(64) NOT NULL,
    expiracion    NUMBER(25),
    fechacreacion NUMBER(25)
);

ALTER TABLE t_sesion ADD CONSTRAINT t_sesion_pk PRIMARY KEY ( id_sesion );

CREATE TABLE t_usuario (
    id_usuario       NUMBER NOT NULL,
    id_permiso       NUMBER NOT NULL,
    rut              NUMBER NOT NULL,
    email            VARCHAR2(50) NOT NULL,
    password         VARCHAR2(50) NOT NULL,
    primernombre     VARCHAR2(50) NOT NULL,
    segundonombre    VARCHAR2(50),
    primerapellido   VARCHAR2(50) NOT NULL,
    segundoapellido  VARCHAR2(50),
    direccion        VARCHAR2(50) NOT NULL,
    telefono         NUMBER NOT NULL,
    id_foto          VARCHAR2(50) NOT NULL,
    id_estadousuario NUMBER NOT NULL
);

ALTER TABLE t_usuario ADD CONSTRAINT t_usuario_pk PRIMARY KEY ( id_usuario );

ALTER TABLE t_departamento
    ADD CONSTRAINT t_departamento_t_estado_fk FOREIGN KEY ( id_estado )
        REFERENCES t_estado ( id_estado );

ALTER TABLE t_fotodpto
    ADD CONSTRAINT t_fotodpto_t_departamento_fk FOREIGN KEY ( id_departamento )
        REFERENCES t_departamento ( id_departamento );

ALTER TABLE t_fotodpto
    ADD CONSTRAINT t_fotodpto_t_foto_fk FOREIGN KEY ( id_foto )
        REFERENCES t_foto ( id_foto );

ALTER TABLE t_iventario
    ADD CONSTRAINT t_iventario_t_departamento_fk FOREIGN KEY ( id_departamento )
        REFERENCES t_departamento ( id_departamento );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_mantencion
    ADD CONSTRAINT t_mantencion_t_categoriamantencion_fk FOREIGN KEY ( id_categoriamantencion )
        REFERENCES t_categoriamantencion ( id_categoriamantencion );

ALTER TABLE t_mantencion
    ADD CONSTRAINT t_mantencion_t_departamento_fk FOREIGN KEY ( id_departamento )
        REFERENCES t_departamento ( id_departamento );

ALTER TABLE t_pago
    ADD CONSTRAINT t_pago_t_estadopago_fk FOREIGN KEY ( id_estadopago )
        REFERENCES t_estadopago ( id_estadopago );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_reporte
    ADD CONSTRAINT t_reporte_t_categoriareporte_fk FOREIGN KEY ( id_categoria )
        REFERENCES t_categoriareporte ( id_categoria );

ALTER TABLE t_reporte
    ADD CONSTRAINT t_reporte_t_reserva_fk FOREIGN KEY ( id_reserva )
        REFERENCES t_reserva ( id_reserva );

ALTER TABLE t_reserva
    ADD CONSTRAINT t_reserva_t_departamento_fk FOREIGN KEY ( id_departamento )
        REFERENCES t_departamento ( id_departamento );

ALTER TABLE t_reserva
    ADD CONSTRAINT t_reserva_t_estadoreserva_fk FOREIGN KEY ( id_estadoreserva )
        REFERENCES t_estadoreserva ( id_estadoreserva );

ALTER TABLE t_reserva
    ADD CONSTRAINT t_reserva_t_pago_fk FOREIGN KEY ( id_pago )
        REFERENCES t_pago ( id_pago );

ALTER TABLE t_reserva
    ADD CONSTRAINT t_reserva_t_usuario_fk FOREIGN KEY ( id_usuario )
        REFERENCES t_usuario ( id_usuario );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_servicio
    ADD CONSTRAINT t_servicio_t_categoriaservicio_fk FOREIGN KEY ( id_categoriaservicio )
        REFERENCES t_categoriaservicio ( id_categoriaservicio );

ALTER TABLE t_servicio
    ADD CONSTRAINT t_servicio_t_departamento_fk FOREIGN KEY ( id_departamento )
        REFERENCES t_departamento ( id_departamento );

ALTER TABLE t_servicio
    ADD CONSTRAINT t_servicio_t_estado_fk FOREIGN KEY ( id_estado )
        REFERENCES t_estado ( id_estado );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_servicioextra_contratado
    ADD CONSTRAINT t_servicioextra_contratado_t_reserva_fk FOREIGN KEY ( id_reserva )
        REFERENCES t_reserva ( id_reserva );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_servicioextra_contratado
    ADD CONSTRAINT t_servicioextra_contratado_t_servicioextra_departamento_fk FOREIGN KEY ( id_servicioextra )
        REFERENCES t_servicioextra_departamento ( id_servicioextra );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_servicioextra_departamento
    ADD CONSTRAINT t_servicioextra_departamento_t_categoriaservicioextra_fk FOREIGN KEY ( id_categoriaservicioextra )
        REFERENCES t_categoriaservicioextra ( id_categoriaservicioextra );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_servicioextra_departamento
    ADD CONSTRAINT t_servicioextra_departamento_t_chofer_fk FOREIGN KEY ( id_chofer )
        REFERENCES t_chofer ( id_chofer );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_servicioextra_departamento
    ADD CONSTRAINT t_servicioextra_departamento_t_departamento_fk FOREIGN KEY ( id_departamento )
        REFERENCES t_departamento ( id_departamento );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_servicioextra_departamento
    ADD CONSTRAINT t_servicioextra_departamento_t_estado_fk FOREIGN KEY ( id_estado )
        REFERENCES t_estado ( id_estado );

ALTER TABLE t_sesion
    ADD CONSTRAINT t_sesion_t_usuario_fk FOREIGN KEY ( id_usuario )
        REFERENCES t_usuario ( id_usuario );

ALTER TABLE t_usuario
    ADD CONSTRAINT t_usuario_t_estadousuario_fk FOREIGN KEY ( id_estadousuario )
        REFERENCES t_estadousuario ( id_estadousuario );

ALTER TABLE t_usuario
    ADD CONSTRAINT t_usuario_t_foto_fk FOREIGN KEY ( id_foto )
        REFERENCES t_foto ( id_foto );

ALTER TABLE t_usuario
    ADD CONSTRAINT t_usuario_t_permiso_fk FOREIGN KEY ( id_permiso )
        REFERENCES t_permiso ( id_permiso );

CREATE SEQUENCE seq_departamento_id_departam START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER trg_departamento_id_departam BEFORE
    INSERT ON t_departamento
    FOR EACH ROW
    WHEN ( new.id_departamento IS NULL )
BEGIN
    :new.id_departamento := seq_departamento_id_departam.nextval;
END;
/

CREATE SEQUENCE seq_error_id_error START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER trg_error_id_error BEFORE
    INSERT ON t_error
    FOR EACH ROW
    WHEN ( new.id_error IS NULL )
BEGIN
    :new.id_error := seq_error_id_error.nextval;
END;
/

CREATE SEQUENCE seq_fotodpto_id_fotodpto START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER trg_fotodpto_id_fotodpto BEFORE
    INSERT ON t_fotodpto
    FOR EACH ROW
    WHEN ( new.id_fotodpto IS NULL )
BEGIN
    :new.id_fotodpto := seq_fotodpto_id_fotodpto.nextval;
END;
/

CREATE SEQUENCE seq_iventario_id_inventario START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER trg_iventario_id_inventario BEFORE
    INSERT ON t_iventario
    FOR EACH ROW
    WHEN ( new.id_inventario IS NULL )
BEGIN
    :new.id_inventario := seq_iventario_id_inventario.nextval;
END;
/

CREATE SEQUENCE seq_mantencion_id_mantencion START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER trg_mantencion_id_mantencion BEFORE
    INSERT ON t_mantencion
    FOR EACH ROW
    WHEN ( new.id_mantencion IS NULL )
BEGIN
    :new.id_mantencion := seq_mantencion_id_mantencion.nextval;
END;
/

CREATE SEQUENCE seq_pago_id_pago START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER trg_pago_id_pago BEFORE
    INSERT ON t_pago
    FOR EACH ROW
    WHEN ( new.id_pago IS NULL )
BEGIN
    :new.id_pago := seq_pago_id_pago.nextval;
END;
/

CREATE SEQUENCE seq_reporte_id_reporte START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER trg_reporte_id_reporte BEFORE
    INSERT ON t_reporte
    FOR EACH ROW
    WHEN ( new.id_reporte IS NULL )
BEGIN
    :new.id_reporte := seq_reporte_id_reporte.nextval;
END;
/

CREATE SEQUENCE seq_reserva_id_reserva START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER trg_reserva_id_reserva BEFORE
    INSERT ON t_reserva
    FOR EACH ROW
    WHEN ( new.id_reserva IS NULL )
BEGIN
    :new.id_reserva := seq_reserva_id_reserva.nextval;
END;
/

CREATE SEQUENCE seq_servicio_id_servicio START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER trg_servicio_id_servicio BEFORE
    INSERT ON t_servicio
    FOR EACH ROW
    WHEN ( new.id_servicio IS NULL )
BEGIN
    :new.id_servicio := seq_servicio_id_servicio.nextval;
END;
/

CREATE SEQUENCE seq_sesion_id_sesion START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER trg_sesion_id_sesion BEFORE
    INSERT ON t_sesion
    FOR EACH ROW
    WHEN ( new.id_sesion IS NULL )
BEGIN
    :new.id_sesion := seq_sesion_id_sesion.nextval;
END;
/

CREATE SEQUENCE seq_usuario_id_usuario START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER trg_usuario_id_usuario BEFORE
    INSERT ON t_usuario
    FOR EACH ROW
    WHEN ( new.id_usuario IS NULL )
BEGIN
    :new.id_usuario := seq_usuario_id_usuario.nextval;
END;
/



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            24
-- CREATE INDEX                             0
-- ALTER TABLE                             50
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                          11
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                         11
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                  10
-- WARNINGS                                 0
