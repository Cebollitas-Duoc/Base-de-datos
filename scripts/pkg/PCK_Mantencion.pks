CREATE OR REPLACE PACKAGE USR_TURISMO_REAL.PCK_MANTENCION IS 

PROCEDURE P_AGREGAR_MANTENCION  (PIN_ID_CATEGORIA   IN NUMBER
                                ,PIN_ID_DPTO   	    IN NUMBER
                                ,PIN_DESCRIPCION    IN VARCHAR2
                                ,PIN_VALOR          IN NUMBER
                                ,PIN_FECHA_INICIO   IN NUMBER
                                ,PIN_FECHA_FIN      IN NUMBER
                                ,OUT_RETURNCODE     OUT NUMBER);

PROCEDURE P_EDITAR_MANTENCION   (PIN_ID_MANTENCION  IN NUMBER
                                ,PIN_DESCRIPCION    IN VARCHAR2
                                ,PIN_VALOR          IN NUMBER
                                ,PIN_FECHA_INICIO   IN NUMBER
                                ,PIN_FECHA_FIN      IN NUMBER
                                ,OUT_RETURNCODE     OUT NUMBER);

PROCEDURE P_LISTAR_MANTENCIONES (PIN_ID_DPTO        IN NUMBER
                                ,OUT_MANTENCIONES   OUT SYS_REFCURSOR
                                ,OUT_RETURNCODE     OUT NUMBER);

PROCEDURE P_BORRAR_MANTENCION   (PIN_ID_MANTENCION  IN NUMBER
                                ,OUT_RETURNCODE     OUT NUMBER);

END PCK_MANTENCION;
/