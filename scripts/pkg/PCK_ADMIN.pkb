CREATE OR REPLACE PACKAGE BODY USR_TURISMO_REAL.PCK_ADMIN IS

--Usuarios
PROCEDURE P_LISTAR_USUARIOS (OUT_USUARIOS   OUT SYS_REFCURSOR
                            ,OUT_RETURNCODE OUT NUMBER) IS
		BEGIN
            OPEN OUT_USUARIOS FOR
            SELECT 
                ID_USUARIO, 
                ID_PERMISO, 
                ID_ESTADOUSUARIO, 
                EMAIL, 
                PRIMERNOMBRE, 
                SEGUNDONOMBRE, 
                PRIMERAPELLIDO, 
                SEGUNDOAPELLIDO, 
                DIRECCION, 
                TELEFONO, 
                RUTAFOTOPERFIL
            FROM T_USUARIO;
            
            OUT_RETURNCODE := 1;
        EXCEPTION
            WHEN OTHERS THEN BEGIN
                OUT_RETURNCODE := 0;
            END;
		END;

PROCEDURE P_EDIT_USER   (PIN_ID_USUARIO          IN NUMBER
                        ,PIN_ID_PERMISO          IN NUMBER
                        ,PIN_ID_ESTADOUSUARIO    IN NUMBER
                        ,PIN_EMAIL        	     IN VARCHAR2
                        ,PIN_PRIMERNOMBRE        IN VARCHAR2
                        ,PIN_SEGUNDONOMBRE       IN VARCHAR2
                        ,PIN_PRIMERAPELLIDO      IN VARCHAR2
                        ,PIN_SEGUNDOAPELLIDO     IN VARCHAR2
                        ,PIN_DIRECCION           IN VARCHAR2
                        ,PIN_TELEFONO            IN VARCHAR2
                        ,PIN_RUTAFOTOPERFIL      IN VARCHAR2
                        ,OUT_RETURNCODE          OUT NUMBER) IS

    X_RUTAFOTOPERFIL  VARCHAR2(200);
	
	BEGIN
        --Si no se especifica una foto, se usa la antigua
        IF PIN_RUTAFOTOPERFIL is NULL THEN
            SELECT RUTAFOTOPERFIL INTO X_RUTAFOTOPERFIL
            FROM T_USUARIO
            WHERE ID_USUARIO = PIN_ID_USUARIO;
        ELSE
            X_RUTAFOTOPERFIL := PIN_RUTAFOTOPERFIL;
        END IF;

        UPDATE T_USUARIO
        SET     
                ID_PERMISO        = PIN_ID_PERMISO
                ,ID_ESTADOUSUARIO = PIN_ID_ESTADOUSUARIO
                ,EMAIL        	  = PIN_EMAIL        	 
                ,PRIMERNOMBRE     = PIN_PRIMERNOMBRE
                ,SEGUNDONOMBRE    = PIN_SEGUNDONOMBRE
                ,PRIMERAPELLIDO   = PIN_PRIMERAPELLIDO
                ,SEGUNDOAPELLIDO  = PIN_SEGUNDOAPELLIDO
                ,DIRECCION        = PIN_DIRECCION
                ,TELEFONO         = PIN_TELEFONO
                ,RUTAFOTOPERFIL   = X_RUTAFOTOPERFIL
                
        WHERE ID_USUARIO = PIN_ID_USUARIO;
        
        COMMIT;
        OUT_RETURNCODE := 1;
        
        EXCEPTION
            WHEN OTHERS THEN
                BEGIN
                    OUT_RETURNCODE := 0;
                    ROLLBACK;
                END;	
			
	END;
    
    --Departamentos
    PROCEDURE P_AGREGAR_DPTO    (PIN_ID_ESTADO       IN NUMBER
                                ,PIN_DIRECCION      IN VARCHAR2
                                ,PIN_LONGITUD       IN NUMBER
                                ,PIN_LATITUD        IN NUMBER
                                ,PIN_HABITACIONES   IN NUMBER
                                ,PIN_BANIOS         IN NUMBER
                                ,PIN_TAMANIO        IN NUMBER
                                ,PIN_VALOR          IN NUMBER
                                ,OUT_RETURNCODE     OUT NUMBER) IS
    BEGIN
        INSERT INTO T_DEPARTAMENTO
        (ID_ESTADODPTO
        ,DIRECCION
        ,LONGITUD
        ,LATITUD
        ,HABITACIONES
        ,BANIOS
        ,TAMANIO
        ,VALOR)
    VALUES
        (PIN_ID_ESTADO
        ,PIN_DIRECCION
        ,PIN_LONGITUD
        ,PIN_LATITUD 
        ,PIN_HABITACIONES 
        ,PIN_BANIOS
        ,PIN_TAMANIO
        ,PIN_VALOR);
        
        COMMIT;
        OUT_RETURNCODE := 1;
        
        EXCEPTION
            WHEN OTHERS THEN
                BEGIN
                    OUT_RETURNCODE := 0;
                    ROLLBACK;
                END;	
			
	END;


END PCK_ADMIN;
/