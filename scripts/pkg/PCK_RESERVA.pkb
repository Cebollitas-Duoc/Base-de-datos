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
                        ,OUT_RETURNCODE     	OUT NUMBER) IS
    BEGIN
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
            U.PRIMERNOMBRE || ' ' || U.PRIMERAPELLIDO,
            U.EMAIL,
            U.TELEFONO,
            U.RUT,
            D.HABITACIONES,
            D.BANIOS
        INTO
            OUT_ID_RESERVA,
            OUT_ID_USUARIO,
            OUT_ID_DEPARTAMENTO,
            OUT_DIRECCION,
            OUT_ID_ESTADORESERVA,
            OUT_ESTADO_RESERVA,
            OUT_ID_PAGO,
            OUT_ESTADO_PAGO,
            OUT_FECHADESDE,
            OUT_FECHAHASTA,
            OUT_VALORTOTAL,
            OUT_FECHACREACION,
            OUT_NOMBRE,
            OUT_EMAIL,
            OUT_PHONE,
            OUT_RUT,
            OUT_ROOMS,
            OUT_BATHROOMS
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
                            ,PIN_INCLUDED   IN NUMBER
                            ,PIN_COMMENT    IN VARCHAR2
                            ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        INSERT INTO T_SERVICIOEXTRA_CONTRATADO 
        (ID_RESERVA, ID_SERVICIOEXTRA, INCLUIDO, COMENTARIO) 
        VALUES (PIN_ID_RSV, PIN_ID_EXTSRV, PIN_INCLUDED, PIN_COMMENT);

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
        SELECT 
            SC.ID_SERVICIOEXTRACONTRATADO,
            SC.ID_SERVICIOEXTRA,
            SC.VALOR,
            SC.INCLUIDO,
            SC.ID_PAGO,
            P.ID_ESTADOPAGO,
            CAT.ID_CATEGORIASERVICIOEXTRA,
            CAT.DESCRIPCION CATEGORIA_SERVICIO,
            SC.COMENTARIO,
            SE.DESCRIPCION DESCRIPCION_SERVICIO_EXTRA
        FROM T_SERVICIOEXTRA_CONTRATADO SC
        INNER JOIN T_SERVICIOEXTRA SE
        ON SE.ID_SERVICIOEXTRA = SC.ID_SERVICIOEXTRA
        INNER JOIN T_CATEGORIASERVICIOEXTRA CAT
        ON CAT.ID_CATEGORIASERVICIOEXTRA = SE.ID_CATEGORIASERVICIOEXTRA
        LEFT JOIN T_PAGO P
        ON P.ID_PAGO = SC.ID_PAGO
        WHERE ID_RESERVA = PIN_ID_RSV;
        
        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN
            OUT_RETURNCODE := 0;
    END;

PROCEDURE P_EDIT_H_EXTSRV_COM   (PIN_ID_extsrv  IN NUMBER
                                ,PIN_COMMENT    IN VARCHAR2
                                ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        UPDATE t_servicioextra_contratado
        SET COMENTARIO = PIN_COMMENT
        WHERE ID_ServicioExtraContratado = PIN_ID_extsrv;

        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
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
            U.PRIMERNOMBRE || ' ' || U.PRIMERAPELLIDO,
            U.RUT
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

PROCEDURE P_Finalizar_Reserva 	(PIN_ID_RSV     IN NUMBER
                                ,OUT_RETURNCODE OUT NUMBER) IS
BEGIN
	UPDATE T_RESERVA
		SET ID_ESTADORESERVA = 2
	WHERE ID_RESERVA = PIN_ID_RSV;
    
	OUT_RETURNCODE := 1;
EXCEPTION
	WHEN OTHERS THEN BEGIN
		OUT_RETURNCODE := 0;
	END;
END;

END PCK_RESERVA;
/