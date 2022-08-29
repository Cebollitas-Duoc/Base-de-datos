--1--
-- BORRAR USUARIO
DROP USER USR_TURISMO_REAL CASCADE;

-- CREAR USUARIO 
CREATE USER USR_TURISMO_REAL IDENTIFIED BY USR_TURISMO_REAL;
ALTER USER "USR_TURISMO_REAL"
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP"
ACCOUNT UNLOCK ;

-- QUOTAS
ALTER USER "USR_TURISMO_REAL" QUOTA UNLIMITED ON "USERS";

-- SYSTEM PRIVILEGES
GRANT ALTER SESSION,CREATE SESSION TO USR_TURISMO_REAL;

-- TABLE PRIVILEGES
GRANT CREATE TABLE TO USR_TURISMO_REAL;
GRANT SELECT ANY TABLE TO USR_TURISMO_REAL;
GRANT ALTER ANY TABLE TO USR_TURISMO_REAL;
GRANT DROP ANY TABLE TO USR_TURISMO_REAL;

-- SEQUENCE PRIVILEGES
GRANT CREATE SEQUENCE TO USR_TURISMO_REAL;
GRANT SELECT ANY SEQUENCE TO USR_TURISMO_REAL;
GRANT ALTER ANY SEQUENCE TO USR_TURISMO_REAL;
GRANT DROP ANY SEQUENCE TO USR_TURISMO_REAL;

-- TRIGGER PRIVILEGES
GRANT CREATE TRIGGER TO USR_TURISMO_REAL;
GRANT ALTER ANY TRIGGER TO USR_TURISMO_REAL;
GRANT DROP ANY TRIGGER TO USR_TURISMO_REAL;
