CREATE OR REPLACE PACKAGE BODY USR_TURISMO_REAL.PCK_SESION IS

PROCEDURE P_AGREGAR_SESION             ( PIN_LLAVE        	    IN VARCHAR2
										,PIN_ID_USUARIO   		IN NUMBER
                                        ,PIN_EXPIRACION      	IN NUMBER
										,PIN_FECHACREACION      IN NUMBER
                                        ,OUT_NOMBRE        	    OUT VARCHAR2
                                        ,OUT_FOTO        	    OUT VARCHAR2
                                        ,OUT_RETURNCODE         OUT NUMBER) IS
		BEGIN
			INSERT INTO T_SESION (  
								 LLAVE        
								,EXPIRACION   
								,ID_USUARIO   
								,FECHACREACION)
			VALUES (       	 
					 PIN_LLAVE            
					,PIN_EXPIRACION   
					,PIN_ID_USUARIO   
					,PIN_FECHACREACION
					);
                    
            SELECT PRIMERNOMBRE || ' ' || PRIMERAPELLIDO, ID_FOTO
            INTO OUT_NOMBRE, OUT_FOTO
            FROM T_USUARIO
            WHERE ID_USUARIO = PIN_ID_USUARIO;
            
            OUT_RETURNCODE := 1;
            
            EXCEPTION
            WHEN OTHERS THEN BEGIN
                OUT_RETURNCODE := 0;
            END;
            
		END;
        
PROCEDURE P_USER_CREADENTIALS   (PIN_EMAIL      IN VARCHAR2
                                ,OUT_USER_EXIST OUT VARCHAR2
                                ,OUT_ID_USUARIO OUT NUMBER
                                ,OUT_ID_PERMISO OUT NUMBER
                                ,OUT_ID_ESTADO  OUT NUMBER
                                ,OUT_PASS       OUT VARCHAR2
                                ,OUT_RETURNCODE          OUT NUMBER) IS
		BEGIN
            SELECT 'True', ID_USUARIO, ID_PERMISO, ID_ESTADOUSUARIO, PASSWORD
            INTO OUT_USER_EXIST, OUT_ID_USUARIO, OUT_ID_PERMISO, OUT_ID_ESTADO, OUT_PASS
            FROM T_USUARIO
            WHERE EMAIL = PIN_EMAIL;
            
            OUT_RETURNCODE := 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN BEGIN
                OUT_USER_EXIST := 'False';
                OUT_RETURNCODE := 0;
            END;
            WHEN OTHERS THEN BEGIN
                OUT_RETURNCODE := 0;
            END;
		END;

PROCEDURE P_SESSION_CREADENTIALS    (PIN_LLAVE          IN VARCHAR2
                                    ,OUT_VALID_SESSION  OUT VARCHAR2
                                	,OUT_ID_USUARIO     OUT NUMBER
                                    ,OUT_ID_PERMISO     OUT NUMBER
                                    ,OUT_PASS           OUT VARCHAR2
                                    ,OUT_RETURNCODE     OUT NUMBER) IS
		BEGIN
            SELECT 'TRUE', U.ID_USUARIO, U.ID_PERMISO, U.PASSWORD
            INTO OUT_VALID_SESSION, OUT_ID_USUARIO, OUT_ID_PERMISO, OUT_PASS
            FROM T_SESION S
            INNER JOIN T_USUARIO U
            ON U.ID_USUARIO = S.ID_USUARIO
            WHERE S.LLAVE = PIN_LLAVE;
            
            OUT_RETURNCODE := 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN BEGIN
                OUT_VALID_SESSION := 'False';
                OUT_RETURNCODE := 0;
            END;
            WHEN OTHERS THEN BEGIN
                OUT_RETURNCODE := 0;
            END;
		END;
        
PROCEDURE P_SESION_VALIDA   (PIN_LLAVE        	    IN VARCHAR2
                            ,OUT_ES_VALIDA          OUT VARCHAR2
                            ,OUT_ID_USUARIO   		OUT NUMBER
                            ,OUT_ID_PERMISO         OUT NUMBER
                            ,OUT_ID_ESTADO          OUT NUMBER
                            ,OUT_RETURNCODE         OUT NUMBER) IS
		BEGIN
            select U.ID_USUARIO, U.ID_PERMISO, ID_ESTADOUSUARIO
            INTO OUT_ID_USUARIO, OUT_ID_PERMISO, OUT_ID_ESTADO
            from T_SESION s
            INNER JOIN T_Usuario u
            ON U.ID_USUARIO = s.ID_USUARIO
            WHERE S.LLAVE = PIN_LLAVE;
            
            OUT_ES_VALIDA := 'True';
            OUT_RETURNCODE := 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN BEGIN
                OUT_ES_VALIDA := 'False';
                OUT_RETURNCODE := 0;
            END;
            WHEN OTHERS THEN BEGIN
                OUT_RETURNCODE := 0;
            END;
		END;
        
PROCEDURE P_UPDATE_PASSWORD (PIN_ID_USUARIO IN VARCHAR2
                            ,PIN_PASSWORD   IN VARCHAR2
                            ,OUT_RETURNCODE OUT NUMBER) IS
		BEGIN
            UPDATE T_USUARIO
            SET PASSWORD = PIN_PASSWORD
            WHERE ID_USUARIO = PIN_ID_USUARIO;
            
            OUT_RETURNCODE := 1;
        EXCEPTION
            WHEN OTHERS THEN BEGIN
                OUT_RETURNCODE := 0;
            END;
		END;

END PCK_SESION;
/