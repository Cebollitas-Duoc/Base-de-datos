CREATE OR REPLACE PACKAGE BODY USR_TURISMO_REAL.PCK_CHAT IS

PROCEDURE P_SUBIR_MENSAJE   (PIN_SESION     IN VARCHAR2
                            ,PIN_ID_RSV     IN NUMBER
                            ,PIN_FECHA      IN NUMBER
                            ,PIN_MENSAJE    IN VARCHAR2
                            ,OUT_RETURNCODE OUT NUMBER) IS

	X_ID_USUARIO    NUMBER;
	
	BEGIN
        --Buscar id de la sesion
        SELECT U.ID_USUARIO INTO X_ID_USUARIO
        FROM T_SESION S
        INNER JOIN T_USUARIO U 
        ON U.ID_USUARIO = S.ID_USUARIO 
        WHERE S.LLAVE = PIN_SESION;

        INSERT INTO T_MENSAJE (ID_USUARIO, ID_RESERVA, FECHA, MENSAJE)
        VALUES (X_ID_USUARIO, PIN_ID_RSV, PIN_FECHA, PIN_MENSAJE);
        
        COMMIT;
        OUT_RETURNCODE := 1;
        EXCEPTION
            WHEN OTHERS THEN
                BEGIN
                    OUT_RETURNCODE := 0;
                    ROLLBACK;
                END;
	END;	
                            
PROCEDURE P_LIST_MSG    (PIN_SESION     IN VARCHAR2
                        ,PIN_ID_RSV     IN NUMBER
                        ,OUT_MENSAJES   OUT SYS_REFCURSOR
                        ,OUT_RETURNCODE OUT NUMBER) IS
    X_ID_USUARIO    NUMBER;
	BEGIN
        --Buscar id de la sesion
        SELECT U.ID_USUARIO INTO X_ID_USUARIO
        FROM T_SESION S
        INNER JOIN T_USUARIO U 
        ON U.ID_USUARIO = S.ID_USUARIO 
        WHERE S.LLAVE = PIN_SESION;
        
        OPEN OUT_MENSAJES FOR
        SELECT
            M.ID_MENSAJE,
            M.ID_USUARIO,
            U.PRIMERNOMBRE ||' '|| U.PRIMERAPELLIDO NOMBRE,
            M.ID_RESERVA,
            M.FECHA,
            M.MENSAJE,
            CASE WHEN (M.ID_USUARIO = X_ID_USUARIO) THEN 1 ELSE 0 END TUYO
        FROM T_MENSAJE M
        INNER JOIN T_USUARIO U
        ON M.ID_USUARIO = U.ID_USUARIO
        WHERE M.ID_RESERVA = PIN_ID_RSV;
        
        OUT_RETURNCODE := 1;
        EXCEPTION
            WHEN OTHERS THEN
                BEGIN
                    OUT_RETURNCODE := 0;
                    ROLLBACK;
                END;
	END;

END PCK_CHAT;
/