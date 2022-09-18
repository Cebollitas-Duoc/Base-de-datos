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
                    
            SELECT PRIMERNOMBRE || ' ' || PRIMERAPELLIDO, RUTAFOTOPERFIL
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
                                ,OUT_ID_USUARIO OUT VARCHAR2
                                ,OUT_PASS       OUT VARCHAR2
                                ,OUT_RETURNCODE          OUT NUMBER) IS
		BEGIN
            SELECT 'True', ID_USUARIO, PASSWORD
            INTO OUT_USER_EXIST, OUT_ID_USUARIO, OUT_PASS
            FROM T_USUARIO
            WHERE EMAIL = PIN_EMAIL;
            
            OUT_RETURNCODE := 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN BEGIN
                SELECT 'False', '', ''
                INTO OUT_USER_EXIST, OUT_ID_USUARIO, OUT_PASS
                FROM DUAL;
                
                OUT_RETURNCODE := 0;
            END;
            WHEN OTHERS THEN BEGIN
                OUT_RETURNCODE := 0;
            END;
		END;

END PCK_SESION;
/