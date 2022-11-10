CREATE OR REPLACE PACKAGE USR_TURISMO_REAL.PCK_EXTRASERVICES IS  

    PROCEDURE P_ADD_EXTRASERVICE    (PIN_ID_DPTO        IN NUMBER
                                    ,PIN_ID_CAT_SRV     IN NUMBER
                                    ,PIN_ID_ESTADO      IN NUMBER
                                    ,PIN_ID_TRABAJADOR  IN NUMBER
                                    ,PIN_VALOR          IN NUMBER
                                    ,OUT_RETURNCODE     OUT NUMBER);
    
    PROCEDURE P_UPDATE_EXTRASERVICE (PIN_ID_EXTRASRV    IN NUMBER
                                    ,PIN_ID_ESTADO      IN NUMBER
                                    ,PIN_ID_TRABAJADOR  IN NUMBER
                                    ,PIN_VALOR          IN NUMBER
                                    ,OUT_RETURNCODE     OUT NUMBER);

    PROCEDURE P_LIST_DPTO_EXTRASERVICES (PIN_ID_DPTO    IN NUMBER
                                        ,OUT_SERVICES   OUT SYS_REFCURSOR
                                        ,OUT_RETURNCODE OUT NUMBER);
    
    PROCEDURE P_LIST_CAT_EXTSRV (OUT_CAT_SRV   OUT SYS_REFCURSOR
                                ,OUT_RETURNCODE OUT NUMBER);
   
END PCK_EXTRASERVICES;
/