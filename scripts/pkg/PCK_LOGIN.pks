CREATE OR REPLACE PACKAGE USR_TURISMO_REAL.PCK_LOGIN IS 
----,OUT_CURSOR       OUT SYS_REFCURSOR) IS
    PROCEDURE P_LEE_USUARIOS                (PIN_ID_USUARIO         IN NUMBER  ---PIN PARAMETRO ENTREADA  OUT_ PARAMETRO SALIDA
                                            ,OUT_CURSOR             OUT SYS_REFCURSOR);
                                            
    PROCEDURE P_ADM_SESION                  (PIN_ID_USUARIO        IN NUMBER
                                            ,OUT_CODIGO            OUT NUMBER
                                            ,OUT_LLAVE             OUT VARCHAR2) ;
                                            
   
END PCK_LOGIN;
/