CREATE OR REPLACE PACKAGE BODY USR_TURISMO_REAL.PCK_USUARIOS IS
PROCEDURE P_LEE_USUARIOS                (PIN_EMAIL        IN VARCHAR2  ---PIN PARAMETRO ENTREADA  OUT_ PARAMETRO SALIDA
                                        ,OUT_CURSOR       OUT SYS_REFCURSOR) IS
													
	
											
	BEGIN										
		OPEN OUT_CURSOR FOR
		SELECT 	 'True'
				,ID_USUARIO
				,PASSWORD
		FROM T_USUARIO
		WHERE ((PIN_EMAIL = '') OR (PIN_EMAIL = EMAIL))
			  AND (ID_ESTADOUSUARIO = '1');
    END;    

PROCEDURE P_ACTUALIZAR_ESTADO_USUARIO      ( PIN_ID_USUARIO          IN NUMBER) IS

	X_ESTADO    NUMBER;
		
	BEGIN
		SELECT ID_ESTADOUSUARIO INTO X_ESTADO
		FROM T_USUARIO
		WHERE ID_USUARIO = PIN_ID_USUARIO;
		
		IF X_ESTADO = 1 THEN
			X_ESTADO := 2;
			
		ELSE
			X_ESTADO := 1;
			
	    END IF;
		
		UPDATE T_USUARIO
		SET   ID_ESTADOUSUARIO = X_ESTADO
		WHERE PIN_ID_USUARIO = ID_USUARIO;
		
		
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				NULL;
	END;
	
PROCEDURE P_AGREGAR_USUARIO     (PIN_EMAIL        	     IN VARCHAR2
                                ,PIN_ID_PERMISO       	 IN NUMBER
                                ,PIN_ID_ESTADOUSUARIO    IN NUMBER
                                ,PIN_PASSWORD            IN VARCHAR2
                                ,PIN_PRIMERNOMBRE        IN VARCHAR2
                                ,PIN_SEGUNDONOMBRE       IN VARCHAR2
                                ,PIN_PRIMERAPELLIDO      IN VARCHAR2
                                ,PIN_SEGUNDOAPELLIDO     IN VARCHAR2
                                ,PIN_DIRECCION           IN VARCHAR2
                                ,PIN_TELEFONO            IN VARCHAR2
                                ,PIN_RUTAFOTOPERFIL      IN VARCHAR2
                                ,OUT_RETURNCODE          OUT NUMBER) IS
	
	BEGIN    
        INSERT INTO T_USUARIO (
            EMAIL, 
            PASSWORD, 
            ID_PERMISO, 
            ID_ESTADOUSUARIO, 
            PRIMERNOMBRE, 
            SEGUNDONOMBRE, 
            PRIMERAPELLIDO, 
            SEGUNDOAPELLIDO, 
            DIRECCION, 
            TELEFONO, 
            RUTAFOTOPERFIL)
        VALUES ( 
            PIN_EMAIL, 
            PIN_PASSWORD, 
            PIN_ID_PERMISO, 
            PIN_ID_ESTADOUSUARIO, 
            PIN_PRIMERNOMBRE, 
            PIN_SEGUNDONOMBRE, 
            PIN_PRIMERAPELLIDO, 
            PIN_SEGUNDOAPELLIDO, 
            PIN_DIRECCION, 
            PIN_TELEFONO, 
            PIN_RUTAFOTOPERFIL);
    
        COMMIT;
            OUT_RETURNCODE := 1;
        
    EXCEPTION
        WHEN OTHERS THEN
            BEGIN
                OUT_RETURNCODE := 0;
                ROLLBACK;
            END;	

    END;
    
PROCEDURE P_ACTUALIZAR_USUARIO  (PIN_ID_USUARIO         IN NUMBER
                                ,PIN_EMAIL        	     IN VARCHAR2
                                ,PIN_ID_PERMISO       	 IN NUMBER
                                ,PIN_ID_ESTADOUSUARIO    IN NUMBER
                                ,PIN_PASSWORD            IN VARCHAR2
                                ,PIN_PRIMERNOMBRE        IN VARCHAR2
                                ,PIN_SEGUNDONOMBRE       IN VARCHAR2
                                ,PIN_PRIMERAPELLIDO      IN VARCHAR2
                                ,PIN_SEGUNDOAPELLIDO     IN VARCHAR2
                                ,PIN_DIRECCION           IN VARCHAR2
                                ,PIN_TELEFONO            IN VARCHAR2
                                ,PIN_RUTAFOTOPERFIL      IN VARCHAR2
                                ,OUT_RETURNCODE          OUT NUMBER) IS

	X_ID_USUARIO     NUMBER;
	
	BEGIN
	
		SELECT ID_USUARIO INTO X_ID_USUARIO
		FROM T_USUARIO
		WHERE ID_USUARIO = PIN_ID_USUARIO;
	

        UPDATE T_USUARIO
        SET      EMAIL        	  = PIN_EMAIL        	 
                ,ID_PERMISO       = PIN_ID_PERMISO      
                ,ID_ESTADOUSUARIO = PIN_ID_ESTADOUSUARIO
                ,PASSWORD         = PIN_PASSWORD
                ,PRIMERNOMBRE     = PIN_PRIMERNOMBRE
                ,SEGUNDONOMBRE    = PIN_SEGUNDONOMBRE
                ,PRIMERAPELLIDO   = PIN_PRIMERAPELLIDO
                ,SEGUNDOAPELLIDO  = PIN_SEGUNDOAPELLIDO
                ,DIRECCION        = PIN_DIRECCION
                ,TELEFONO         = PIN_TELEFONO
                ,RUTAFOTOPERFIL   = PIN_RUTAFOTOPERFIL
                
        WHERE PIN_ID_USUARIO = ID_USUARIO;
        
        COMMIT;
        OUT_RETURNCODE := 1;
        
    EXCEPTION
        WHEN OTHERS THEN
            BEGIN
                OUT_RETURNCODE := 0;
                ROLLBACK;
            END;	
			
	END;	
	
	
END PCK_USUARIOS;
/