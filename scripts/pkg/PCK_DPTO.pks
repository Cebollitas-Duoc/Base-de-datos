CREATE OR REPLACE PACKAGE USR_TURISMO_REAL.PCK_DPTO IS 
                   
    PROCEDURE P_LISTAR_DPTOS    (OUT_DPTOS   OUT SYS_REFCURSOR
                                ,OUT_RETURNCODE OUT NUMBER);
    
    PROCEDURE P_VER_DPTO    (PIN_ID_DPTO        IN NUMBER
                            ,OUT_DIRECCION      OUT VARCHAR2
                            ,OUT_LONGITUD       OUT NUMBER
                            ,OUT_LATITUD        OUT NUMBER
                            ,OUT_HABITACIONES   OUT NUMBER
                            ,OUT_BANIOS         OUT NUMBER
                            ,OUT_TAMANIO        OUT NUMBER
                            ,OUT_VALOR          OUT NUMBER
                            ,OUT_ID_ESTADO      OUT NUMBER
                            ,OUT_IMAGEN         OUT VARCHAR2
                            ,OUT_RETURNCODE     OUT NUMBER);
    
    PROCEDURE P_LISTAR_FOTOS_DPTO   (PIN_ID_DPTO   IN NUMBER
                                    ,OUT_FOTOS   OUT SYS_REFCURSOR
                                    ,OUT_RETURNCODE OUT NUMBER);
   
   
END PCK_DPTO;
/