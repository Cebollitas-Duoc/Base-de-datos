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
                                    
	PROCEDURE P_GET_RESERVA (PIN_ID_RSV         	IN NUMBER
							,OUT_ID_RESERVA			OUT NUMBER
							,OUT_ID_USUARIO			OUT NUMBER
							,OUT_ID_DEPARTAMENTO	OUT NUMBER
							,OUT_DIRECCION			OUT VARCHAR2
							,OUT_ID_ESTADORESERVA 	OUT NUMBER
							,OUT_ESTADO_RESERVA 	OUT VARCHAR2
							,OUT_ID_PAGO 			OUT NUMBER
							,OUT_ESTADO_PAGO 		OUT VARCHAR2
							,OUT_FECHADESDE			OUT NUMBER
							,OUT_FECHAHASTA			OUT NUMBER
							,OUT_VALORTOTAL			OUT NUMBER
							,OUT_FECHACREACION		OUT NUMBER
							,OUT_NOMBRE				OUT VARCHAR2
							,OUT_EMAIL				OUT VARCHAR2
							,OUT_PHONE				OUT NUMBER
							,OUT_RUT				OUT NUMBER
							,OUT_ROOMS				OUT NUMBER
							,OUT_BATHROOMS		    OUT NUMBER
							,OUT_RETURNCODE     	OUT NUMBER);
    
    PROCEDURE P_CANCEL_RESERVA  (PIN_ID_RSV     IN NUMBER
                                ,OUT_RETURNCODE OUT NUMBER);
                        
    PROCEDURE P_GET_DPTO_RANGES (PIN_ID_DPTO    IN NUMBER
                                ,OUT_RANGES     OUT SYS_REFCURSOR
                                ,OUT_RETURNCODE OUT NUMBER);
    
    PROCEDURE P_ADD_EXTRA_SRV   (PIN_ID_RSV     IN NUMBER
                                ,PIN_ID_EXTSRV  IN NUMBER
                                ,PIN_INCLUDED   IN NUMBER
                                ,PIN_COMMENT    IN VARCHAR2
                                ,OUT_RETURNCODE OUT NUMBER);

    PROCEDURE P_LIST_RESERVA_EXTSRV (PIN_ID_RSV     IN NUMBER
                                    ,OUT_EXTSRV     OUT SYS_REFCURSOR
                                    ,OUT_RETURNCODE OUT NUMBER);
                                    
    PROCEDURE P_EDIT_H_EXTSRV_COM   (PIN_ID_extsrv  IN NUMBER
                                    ,PIN_COMMENT    IN VARCHAR2
                                    ,OUT_RETURNCODE OUT NUMBER);
                                    
    -- ADMIN
    
    PROCEDURE P_LIST_RESERVAS   (OUT_RESERVAS   OUT SYS_REFCURSOR
                                ,OUT_RETURNCODE OUT NUMBER);
	PROCEDURE P_Finalizar_Reserva 	(PIN_ID_RSV     IN NUMBER
									,OUT_RETURNCODE OUT NUMBER);

END PCK_RESERVA;
/