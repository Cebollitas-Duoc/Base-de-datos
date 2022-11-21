CREATE OR REPLACE PACKAGE BODY USR_TURISMO_REAL.PCK_USUARIOS IS
PROCEDURE P_LEE_USUARIO     (PIN_EMAIL               IN VARCHAR2
                            ,OUT_USER_EXIST          OUT VARCHAR2
                            ,OUT_ID_PERMISO       	 OUT NUMBER
                            ,OUT_ID_ESTADOUSUARIO    OUT NUMBER
                            ,OUT_PASSWORD            OUT VARCHAR2
                            ,OUT_PRIMERNOMBRE        OUT VARCHAR2
                            ,OUT_SEGUNDONOMBRE       OUT VARCHAR2
                            ,OUT_PRIMERAPELLIDO      OUT VARCHAR2
                            ,OUT_SEGUNDOAPELLIDO     OUT VARCHAR2
                            ,OUT_RUT                 OUT NUMBER
                            ,OUT_DIRECCION           OUT VARCHAR2
                            ,OUT_TELEFONO            OUT VARCHAR2
                            ,OUT_RUTAFOTOPERFIL      OUT VARCHAR2
                            ,OUT_RETURNCODE          OUT NUMBER) IS
													
	BEGIN										
		SELECT
            'True',
            ID_PERMISO,
            ID_ESTADOUSUARIO,
            PASSWORD,
            PRIMERNOMBRE,
            SEGUNDONOMBRE,
            PRIMERAPELLIDO,
            SEGUNDOAPELLIDO,
            RUT,
            DIRECCION,
            TELEFONO,
            ID_FOTO
        INTO
            OUT_USER_EXIST,
            OUT_ID_PERMISO,
            OUT_ID_ESTADOUSUARIO,
            OUT_PASSWORD,
            OUT_PRIMERNOMBRE,
            OUT_SEGUNDONOMBRE,
            OUT_PRIMERAPELLIDO,
            OUT_SEGUNDOAPELLIDO,
            OUT_RUT,
            OUT_DIRECCION,
            OUT_TELEFONO,
            OUT_RUTAFOTOPERFIL
        FROM T_USUARIO
        WHERE EMAIL = PIN_EMAIL;
        
        OUT_RETURNCODE := 1;
    EXCEPTION
            WHEN NO_DATA_FOUND THEN BEGIN
                SELECT 'False'
                INTO OUT_USER_EXIST
                FROM DUAL;
                
                OUT_RETURNCODE := 0;
            END;
            WHEN OTHERS THEN BEGIN
                OUT_RETURNCODE := 0;
            END;
    END;    
	
PROCEDURE P_AGREGAR_USUARIO     (PIN_EMAIL        	     IN VARCHAR2
                                ,PIN_ID_PERMISO       	 IN NUMBER
                                ,PIN_ID_ESTADOUSUARIO    IN NUMBER
                                ,PIN_PASSWORD            IN VARCHAR2
                                ,PIN_PRIMERNOMBRE        IN VARCHAR2
                                ,PIN_SEGUNDONOMBRE       IN VARCHAR2
                                ,PIN_PRIMERAPELLIDO      IN VARCHAR2
                                ,PIN_SEGUNDOAPELLIDO     IN VARCHAR2
                                ,PIN_RUT                 IN NUMBER
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
            RUT,
            DIRECCION, 
            TELEFONO, 
            ID_FOTO)
        VALUES ( 
            PIN_EMAIL, 
            PIN_PASSWORD, 
            PIN_ID_PERMISO, 
            PIN_ID_ESTADOUSUARIO, 
            PIN_PRIMERNOMBRE, 
            PIN_SEGUNDONOMBRE, 
            PIN_PRIMERAPELLIDO, 
            PIN_SEGUNDOAPELLIDO,
            PIN_RUT,
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
    
PROCEDURE P_EDIT_SESSION_PROFILE (PIN_SESION              IN VARCHAR2
                                 ,PIN_EMAIL        	      IN VARCHAR2
                                 ,PIN_PRIMERNOMBRE        IN VARCHAR2
                                 ,PIN_SEGUNDONOMBRE       IN VARCHAR2
                                 ,PIN_PRIMERAPELLIDO      IN VARCHAR2
                                 ,PIN_SEGUNDOAPELLIDO     IN VARCHAR2
                                 ,PIN_RUT                 IN NUMBER
                                 ,PIN_DIRECCION           IN VARCHAR2
                                 ,PIN_TELEFONO            IN VARCHAR2
                                 ,PIN_ID_FOTO             IN VARCHAR2
                                 ,OUT_RETURNCODE          OUT NUMBER) IS

	X_ID_USUARIO    NUMBER;
    X_ID_FOTO       VARCHAR2(200);
	
	BEGIN
        --Buscar id de la sesion
        SELECT U.ID_USUARIO INTO X_ID_USUARIO
        FROM T_SESION S
        INNER JOIN T_USUARIO U 
        ON U.ID_USUARIO = S.ID_USUARIO 
        WHERE S.LLAVE = PIN_SESION;

        --Si no se especifica una foto, se usa la antigua
        IF PIN_ID_FOTO is NULL THEN
            SELECT ID_FOTO INTO X_ID_FOTO
            FROM T_USUARIO
            WHERE ID_USUARIO = X_ID_USUARIO;
        ELSE
            X_ID_FOTO := PIN_ID_FOTO;
        END IF;

        UPDATE T_USUARIO
        SET      EMAIL        	  = PIN_EMAIL        	 
                ,PRIMERNOMBRE     = PIN_PRIMERNOMBRE
                ,SEGUNDONOMBRE    = PIN_SEGUNDONOMBRE
                ,PRIMERAPELLIDO   = PIN_PRIMERAPELLIDO
                ,SEGUNDOAPELLIDO  = PIN_SEGUNDOAPELLIDO
                ,RUT              = PIN_RUT
                ,DIRECCION        = PIN_DIRECCION
                ,TELEFONO         = PIN_TELEFONO
                ,ID_FOTO          = X_ID_FOTO
                
        WHERE ID_USUARIO = X_ID_USUARIO;
        
        COMMIT;
        OUT_RETURNCODE := 1;
        
        EXCEPTION
            WHEN OTHERS THEN
                BEGIN
                    OUT_RETURNCODE := 0;
                    ROLLBACK;
                END;	
			
	END;	
	
PROCEDURE P_LEE_PERFIL_DE_SESION    (PIN_SESION              IN VARCHAR2
                                    ,OUT_EMAIL               OUT VARCHAR2
                                    ,OUT_PRIMERNOMBRE        OUT VARCHAR2
                                    ,OUT_SEGUNDONOMBRE       OUT VARCHAR2
                                    ,OUT_PRIMERAPELLIDO      OUT VARCHAR2
                                    ,OUT_SEGUNDOAPELLIDO     OUT VARCHAR2
                                    ,OUT_RUT                 OUT NUMBER
                                    ,OUT_DIRECCION           OUT VARCHAR2
                                    ,OUT_TELEFONO            OUT VARCHAR2
                                    ,OUT_RUTAFOTOPERFIL      OUT VARCHAR2
                                    ,OUT_PERMISO             OUT VARCHAR2
                                    ,OUT_VALIDSESSION        OUT VARCHAR2
                                    ,OUT_RETURNCODE          OUT NUMBER) IS
													
	BEGIN										
        SELECT
            U.EMAIL,
            U.PRIMERNOMBRE,
            U.SEGUNDONOMBRE,
            U.PRIMERAPELLIDO,
            U.SEGUNDOAPELLIDO,
            U.RUT,
            U.DIRECCION,
            U.TELEFONO,
            U.ID_FOTO,
            P.DESCRIPCION permiso,
            'True'
        INTO
            OUT_EMAIL,
            OUT_PRIMERNOMBRE,
            OUT_SEGUNDONOMBRE,
            OUT_PRIMERAPELLIDO,
            OUT_SEGUNDOAPELLIDO,
            OUT_RUT,
            OUT_DIRECCION,
            OUT_TELEFONO,
            OUT_RUTAFOTOPERFIL,
            OUT_PERMISO,
            OUT_VALIDSESSION
        FROM T_SESION S
        INNER JOIN T_USUARIO U 
        ON U.ID_USUARIO = S.ID_USUARIO 
        INNER JOIN T_PERMISO P 
        ON U.ID_PERMISO = P.ID_PERMISO
        WHERE S.LLAVE = PIN_SESION;
        
        OUT_RETURNCODE := 1;
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN BEGIN
                OUT_VALIDSESSION := 'False';
                OUT_RETURNCODE := 0;
                ROLLBACK;
            END;
            WHEN OTHERS THEN BEGIN
                OUT_RETURNCODE := 0;
                ROLLBACK;
            END;	
        
    END;    


END PCK_USUARIOS;
/