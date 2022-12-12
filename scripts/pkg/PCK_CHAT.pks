CREATE OR REPLACE PACKAGE USR_TURISMO_REAL.PCK_CHAT IS 

PROCEDURE P_SUBIR_MENSAJE   (PIN_SESION     IN VARCHAR2
                            ,PIN_ID_RSV     IN NUMBER
                            ,PIN_FECHA      IN NUMBER
                            ,PIN_MENSAJE    IN VARCHAR2
                            ,OUT_RETURNCODE OUT NUMBER);
                            
PROCEDURE P_LIST_MSG    (PIN_SESION     IN VARCHAR2
                        ,PIN_ID_RSV     IN NUMBER
                        ,PIN_DESDE      IN NUMBER
                        ,OUT_MENSAJES   OUT SYS_REFCURSOR
                        ,OUT_RETURNCODE OUT NUMBER);
   
END PCK_CHAT;
/