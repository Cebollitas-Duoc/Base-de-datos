CREATE OR REPLACE PACKAGE BODY USR_TURISMO_REAL.PCK_RESERVA IS
    
PROCEDURE P_CREAR_RESERVA   (PIN_ID_USR         IN NUMBER
                            ,PIN_ID_DEPTO       IN NUMBER
                            ,PIN_ID_ESTADO      IN NUMBER
                    		,PIN_FECHADESDE     IN NUMBER
                			,PIN_FECHAHASTA     IN NUMBER
            				,PIN_FECHACREACION  IN NUMBER
                            ,PIN_VALOR          IN NUMBER
                            ,OUT_ID_RSV         OUT NUMBER
                            ,OUT_RETURNCODE     OUT NUMBER) IS
    X_ID_RSV NUMBER;
    BEGIN
        X_ID_RSV := SEQ_RESERVA_ID_RESERVA.NEXTVAL;
        INSERT INTO T_RESERVA (ID_RESERVA, ID_USUARIO, ID_DEPARTAMENTO, ID_ESTADORESERVA, FECHADESDE, FECHAHASTA, FECHACREACION, VALORTOTAL)
        VALUES (X_ID_RSV, PIN_ID_USR, PIN_ID_DEPTO, PIN_ID_ESTADO, PIN_FECHADESDE, PIN_FECHAHASTA, PIN_FECHACREACION, PIN_VALOR);
        
        OUT_ID_RSV  := X_ID_RSV;             
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

PROCEDURE P_GET_RESERVA (PIN_ID_RSV         IN NUMBER
                        ,OUT_ID_USR         OUT NUMBER
                        ,OUT_ID_DPTO        OUT NUMBER
                        ,OUT_ID_ESTADO      OUT NUMBER
                        ,OUT_ID_PAGO        OUT NUMBER
                        ,OUT_FECHADESDE     OUT NUMBER
                        ,OUT_FECHAHASTA     OUT NUMBER
                        ,OUT_FECHACREACION  OUT NUMBER
                        ,OUT_VALOR          OUT NUMBER
                        ,OUT_RETURNCODE     OUT NUMBER) IS
    BEGIN
        select 
            ID_USUARIO, 
            ID_DEPARTAMENTO, 
            ID_ESTADORESERVA, 
            ID_PAGO, 
            FECHADESDE, 
            FECHAHASTA, 
            FECHACREACION, 
            VALORTOTAL
        into
            OUT_ID_USR,
            OUT_ID_DPTO,
            OUT_ID_ESTADO,
            OUT_ID_PAGO,
            OUT_FECHADESDE,
            OUT_FECHAHASTA,
            OUT_FECHACREACION,
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

PROCEDURE P_GET_DPTO_RANGES (PIN_ID_DPTO    IN NUMBER
                            ,OUT_RANGES     OUT SYS_REFCURSOR
                            ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        OPEN OUT_RANGES FOR
        SELECT FECHADESDE, FECHAHASTA
        FROM T_RESERVA
        WHERE ID_ESTADORESERVA != 3 AND ID_DEPARTAMENTO = PIN_ID_DPTO;
        
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

-- ADMIN
    
PROCEDURE P_LIST_RESERVAS   (OUT_RESERVAS     OUT SYS_REFCURSOR
                            ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        OPEN OUT_RESERVAS FOR
        SELECT 
            R.ID_RESERVA,
            R.ID_USUARIO,
            R.ID_DEPARTAMENTO,
            D.DIRECCION,
            R.ID_ESTADORESERVA,
            E.NOMBRE ESTADO_RESERVA,
            P.ID_PAGO,
            EP.NOMBRE ESTADO_PAGO,
            R.FECHADESDE,
            R.FECHAHASTA,
            R.VALORTOTAL,
            R.FECHACREACION,
            U.PRIMERNOMBRE || ' ' || U.PRIMERAPELLIDO
        FROM T_RESERVA R
        INNER JOIN t_departamento D
        ON D.ID_DEPARTAMENTO = R.ID_DEPARTAMENTO
        INNER JOIN T_USUARIO U
        ON U.ID_USUARIO = R.ID_USUARIO
        INNER JOIN T_ESTADORESERVA E
        ON E.ID_ESTADORESERVA = R.ID_ESTADORESERVA
        LEFT OUTER JOIN T_PAGO P
        ON P.ID_PAGO = R.ID_PAGO
        LEFT OUTER JOIN T_ESTADOPAGO EP
        ON EP.ID_ESTADOPAGO = P.ID_ESTADOPAGO 
        ORDER BY R.FECHACREACION DESC;
        
        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
    END;

END PCK_RESERVA;
/