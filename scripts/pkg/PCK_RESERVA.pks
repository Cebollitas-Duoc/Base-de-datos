CREATE OR REPLACE PACKAGE USR_TURISMO_REAL.PCK_RESERVA IS  

    PROCEDURE P_CREAR_RESERVA   (PIN_ID_USR         IN NUMBER
                                ,PIN_ID_DEPTO       IN NUMBER
                                ,PIN_ID_ESTADO      IN NUMBER
								,PIN_FECHADESDE     IN NUMBER
								,PIN_FECHAHASTA     IN NUMBER
								,PIN_FECHACREACION  IN NUMBER
                                ,PIN_VALOR          IN NUMBER
                                ,OUT_ID_RSV         OUT NUMBER
                                ,OUT_RETURNCODE     OUT NUMBER);
    
    PROCEDURE P_GET_USR_RESERVAS    (PIN_ID_USR     IN NUMBER
                                    ,OUT_RESERVAS   OUT SYS_REFCURSOR
                                    ,OUT_RETURNCODE OUT NUMBER);
                                    
	PROCEDURE P_GET_RESERVA (PIN_ID_RSV         IN NUMBER
							,OUT_RESERVA        OUT SYS_REFCURSOR
							,OUT_RETURNCODE     OUT NUMBER);
    
    PROCEDURE P_CANCEL_RESERVA  (PIN_ID_RSV     IN NUMBER
                                ,OUT_RETURNCODE OUT NUMBER);
                        
    PROCEDURE P_GET_DPTO_RANGES (PIN_ID_DPTO    IN NUMBER
                                ,OUT_RANGES     OUT SYS_REFCURSOR
                                ,OUT_RETURNCODE OUT NUMBER);
    
    PROCEDURE P_ADD_EXTRA_SRV   (PIN_ID_RSV     IN NUMBER
                                ,PIN_ID_EXTSRV  IN NUMBER
                                ,PIN_included   IN NUMBER
                                ,OUT_RETURNCODE OUT NUMBER);

    PROCEDURE P_LIST_RESERVA_EXTSRV (PIN_ID_RSV     IN NUMBER
                                    ,OUT_EXTSRV     OUT SYS_REFCURSOR
                                    ,OUT_RETURNCODE OUT NUMBER);
   
END PCK_RESERVA;
/