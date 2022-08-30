CREATE OR REPLACE PACKAGE BODY FALP.PCK_LOGIN IS
PROCEDURE P_LEE_USUARIOS                (PIN_ID_USUARIO        IN NUMBER  ---PIN PARAMETRO ENTREADA  OUT_ PARAMETRO SALIDA
                                        ,OUT_CURSOR       OUT SYS_REFCURSOR) IS
													
	
											
	BEGIN										
		OPEN OUT_CURSOR FOR
		SELECT 	 ID_USUARIO
				,PASSWORD
				,ID_PERMISO
				,ID_ESTADOUSUARIO
				,EMAIL
		FROM USUARIO
		WHERE ((PIN_ID_USUARIO = 0) OR (PIN_ID_USUARIO != 0 AND PIN_ID_USUARIO = ID_USUARIO));
    END;    

PROCEDURE P_ADM_SESION                (PIN_ID_USUARIO        IN NUMBER
                                        ,OUT_CODIGO            OUT NUMBER
                                        ,OUT_LLAVE             OUT VARCHAR2) IS

	----X_CODIGO  0: OK												
    ----X_CODIGO  1: ERROR FECHA CADUCADA												
    ----X_CODIGO  2: SESION NUEVA
    ----X_CODIGO  3: ERROR AL LEER TABLA SESION
    
	
    X_ID_SESION     NUMBER;
    X_LLAVE         VARCHAR2(50);
    X_EXPIRACION    DATE;
    X_CODIGO        NUMBER:=0;
	BEGIN					
        BEGIN
            SELECT ID_SESION INTO X_ID_SESION
            FROM SESION
            WHERE ID_SESION = PIN_ID_SESION;
            
                SELECT LLAVE
                      ,EXPIRACION
                INTO X_LLAVE
                     ,X_EXPIRACION
                FROM SESION
                WHERE ID_SESION = PIN_ID_SESION;
                
                IF X_EXPIRACION < SYSDATE THEN
                    X_CODIGO := 1;
                END IF;
                
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                BEGIN
                    SELECT SEQ_SESION.NEXTVAL INTO X_ID_SESION
                    FROM DUAL;
                EXCEPTION
                    WHEN OTHERS THEN
                        X_CPMD_ID := 1;
                END;
                ---------CAMBIAR LLAVE------------------
                X_LLAVE := 'XXXX';
                ---------CAMBIAR LLAVE------------------
                INSERT INTO SESION (
                                    ID_SESION
                                    ,ID_USUARIO
                                    ,LLAVE
                                    ,EXPIRACION
                                    ,FECHACREACION
                                    )
                VALUES (
                         X_ID_SESION
                        ,PIN_ID_USUARIO
                        ,X_LLAVE
                        ,SYSDATE + 10
                        ,SYSDATE
                        );
                X_CODIGO := 2;  ---NUEVA SESION
            WHEN OTHERS THEN
                X_CODIGO := 3;
        END;
        OUT_CODIGO := X_CODIGO;
        OUT_LLAVE  := X_LLAVE;
    END;    

END PCK_LOGIN;
/