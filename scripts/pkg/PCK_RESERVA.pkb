CREATE OR REPLACE PACKAGE BODY USR_TURISMO_REAL.PCK_RESERVA IS
    
PROCEDURE P_CREAR_RESERVA   (PIN_ID_USR     IN NUMBER
                            ,PIN_ID_DEPTO   IN NUMBER
                            ,PIN_ID_ESTADO  IN NUMBER
                            ,PIN_VALOR      IN NUMBER
							,PIN_FECHADESDE IN NUMBER
							,PIN_FECHAHASTA IN NUMBER
                            ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        INSERT INTO T_RESERVA (ID_Usuario, ID_Departamento, ID_EstadoReserva, VALORTOTAL) 
        VALUES (PIN_ID_USR, PIN_ID_DEPTO, PIN_ID_ESTADO, PIN_FECHADESDE, PIN_FECHAHASTA, PIN_VALOR);
                                 
        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN
            OUT_RETURNCODE := 0;
    END;

PROCEDURE P_GET_USR_RESERVAS    (PIN_ID_USR     IN NUMBER
                                ,OUT_RESERVAS   OUT SYS_REFCURSOR
                                ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        OPEN OUT_RESERVAS FOR
        SELECT * FROM T_RESERVA 
        WHERE ID_USUARIO = PIN_ID_USR;
        
        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN
            OUT_RETURNCODE := 0;
    END;

PROCEDURE P_GET_RESERVA (PIN_ID_RSV     IN NUMBER
                        ,OUT_ID_USR     OUT NUMBER
                        ,OUT_ID_DPTO    OUT NUMBER
                        ,OUT_ID_ESTADO  OUT NUMBER
                        ,OUT_ID_PAGO    OUT NUMBER
                        ,OUT_FECHADESDE OUT NUMBER
                        ,OUT_FECHAHASTA OUT NUMBER
                        ,OUT_VALOR      OUT NUMBER
                        ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        select 
            ID_USUARIO, 
            id_departamento, 
            id_estadoreserva, 
            id_pago, 
            fechadesde, 
            fechahasta, 
            valortotal
        into
            OUT_ID_USR,
            OUT_ID_DPTO,
            OUT_ID_ESTADO,
            OUT_ID_PAGO,
            OUT_FECHADESDE,
            OUT_FECHAHASTA,
            OUT_VALOR
        from T_RESERVA
        WHERE ID_RESERVA = PIN_ID_RSV;
        
        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN
            OUT_RETURNCODE := 0;
    END;

PROCEDURE P_CANCEL_RESERVA  (PIN_ID_RSV     IN NUMBER
                            ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        UPDATE T_RESERVA
        SET ID_ESTADORESERVA = 3
        WHERE ID_RESERVA = PIN_ID_RSV;
        
        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN
            OUT_RETURNCODE := 0;
    END;

PROCEDURE P_ADD_EXTRA_SRV   (PIN_ID_RSV     IN NUMBER
                            ,PIN_ID_EXTSRV  IN NUMBER
                            ,PIN_included   IN NUMBER
                            ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        INSERT INTO t_servicioextra_contratado 
        (ID_Reserva, ID_ServicioExtra, Incluido) 
        VALUES (PIN_ID_RSV, PIN_ID_EXTSRV, PIN_included);

        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
    END;

PROCEDURE P_LIST_RESERVA_EXTSRV (PIN_ID_RSV     IN NUMBER
                                ,OUT_EXTSRV     OUT SYS_REFCURSOR
                                ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        OPEN OUT_EXTSRV FOR
        select * 
        from t_servicioextra_contratado
        where id_reserva = PIN_ID_RSV;
        
        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN
            OUT_RETURNCODE := 0;
    END;

END PCK_RESERVA;
/