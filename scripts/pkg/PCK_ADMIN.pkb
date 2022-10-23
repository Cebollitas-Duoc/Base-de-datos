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
                ID_FOTO
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
                        ,PIN_ID_FOTO             IN VARCHAR2
                        ,OUT_RETURNCODE          OUT NUMBER) IS

    X_ID_FOTO  VARCHAR2(200);
	
	BEGIN
        --Si no se especifica una foto, se usa la antigua
        IF PIN_ID_FOTO is NULL THEN
            SELECT ID_FOTO INTO X_ID_FOTO
            FROM T_USUARIO
            WHERE ID_USUARIO = PIN_ID_USUARIO;
        ELSE
            X_ID_FOTO := PIN_ID_FOTO;
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
                ,ID_FOTO          = X_ID_FOTO
                
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
    PROCEDURE P_AGREGAR_DPTO    (PIN_ID_ESTADO      IN NUMBER
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
        (ID_ESTADO
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
    
PROCEDURE P_EDIT_DPTO   (PIN_ID_DPTO        IN NUMBER
                        ,PIN_ID_ESTADO      IN NUMBER
                        ,PIN_DIRECCION      IN VARCHAR2
                        ,PIN_LONGITUD       IN NUMBER
                        ,PIN_LATITUD        IN NUMBER
                        ,PIN_HABITACIONES   IN NUMBER
                        ,PIN_BANIOS         IN NUMBER
                        ,PIN_TAMANIO        IN NUMBER
                        ,PIN_VALOR          IN NUMBER
                        ,OUT_RETURNCODE     OUT NUMBER) IS
BEGIN

        UPDATE T_DEPARTAMENTO
        SET     
                ID_ESTADO         = PIN_ID_ESTADO
                ,DIRECCION        = PIN_DIRECCION
                ,LONGITUD         = PIN_LONGITUD        	 
                ,LATITUD          = PIN_LATITUD
                ,HABITACIONES     = PIN_HABITACIONES
                ,BANIOS           = PIN_BANIOS
                ,TAMANIO          = PIN_TAMANIO
                ,VALOR            = PIN_VALOR
        WHERE ID_DEPARTAMENTO = PIN_ID_DPTO;
        
        COMMIT;
        OUT_RETURNCODE := 1;
        
        EXCEPTION
            WHEN OTHERS THEN
                BEGIN
                    OUT_RETURNCODE := 0;
                    ROLLBACK;
                END;	
			
	END;
    
PROCEDURE P_LISTAR_DPTOS    (OUT_DPTOS   OUT SYS_REFCURSOR
                            ,OUT_RETURNCODE OUT NUMBER) IS
		BEGIN
            OPEN OUT_DPTOS FOR
            SELECT
            d.id_departamento, d.direccion, d.longitud, d.latitud, d.habitaciones, d.banios, d.tamanio, d.valor, d.id_estado, (
            SELECT DISTINCT FIRST_VALUE(ID_FOTO)
                OVER (ORDER BY PRINCIPAL DESC, ORDEN ASC )
                FROM T_FOTODPTO 
                WHERE ID_DEPARTAMENTO = d.id_departamento
            ) as imagen_principal
            FROM T_DEPARTAMENTO d;
            
            OUT_RETURNCODE := 1;
        EXCEPTION
            WHEN OTHERS THEN BEGIN
                OUT_RETURNCODE := 0;
            END;
		END;
        
--Imagenes Departamentos
PROCEDURE P_AGREGAR_FOTO_DPTO   (PIN_ID_DPTO    IN NUMBER
                                ,PIN_PRINCIPAL  IN NUMBER
                                ,PIN_DIRECCION  IN VARCHAR2
                                ,OUT_RETURNCODE OUT NUMBER) IS
        BEGIN
            IF (PIN_PRINCIPAL = 1) THEN
                UPDATE t_fotodpto
                SET PRINCIPAL = 0        	 
                WHERE ID_DEPARTAMENTO = PIN_ID_DPTO;
            END IF;
        
            INSERT INTO T_FOTODPTO (ID_DEPARTAMENTO, PRINCIPAL, ID_FOTO)
            VALUES (
            PIN_ID_DPTO, 
            PIN_PRINCIPAL, 
            PIN_DIRECCION);
            
            COMMIT;
            OUT_RETURNCODE := 1;
        EXCEPTION
            WHEN OTHERS THEN BEGIN
                OUT_RETURNCODE := 0;
            END;
		END;
        
PROCEDURE P_EDIT_FOTO_DPTO  (PIN_ID_FOTO_DPTO   IN NUMBER
                            ,PIN_PRINCIPAL      IN NUMBER
                            ,PIN_ORDEN          IN NUMBER
                            ,OUT_RETURNCODE     OUT NUMBER) IS
		X_ID_DPTO NUMBER;
        BEGIN
            IF (PIN_PRINCIPAL = 1) THEN
                SELECT ID_DEPARTAMENTO INTO X_ID_DPTO
                FROM T_FOTODPTO        	 
                WHERE ID_FOTODPTO = PIN_ID_FOTO_DPTO;
            
                UPDATE t_fotodpto
                SET PRINCIPAL = 0        	 
                WHERE ID_DEPARTAMENTO = X_ID_DPTO;
            END IF;
            
            UPDATE T_FOTODPTO
            SET 
                PRINCIPAL = PIN_PRINCIPAL,
                ORDEN = PIN_ORDEN
            WHERE ID_FOTODPTO = PIN_ID_FOTO_DPTO;
            
            COMMIT;
            OUT_RETURNCODE := 1;
        EXCEPTION
            WHEN OTHERS THEN BEGIN
                OUT_RETURNCODE := 0;
            END;
		END;
        
PROCEDURE P_LISTAR_FOTOS_DPTO   (PIN_ID_DPTO    IN NUMBER
                                ,OUT_FOTOS      OUT SYS_REFCURSOR
                                ,OUT_RETURNCODE OUT NUMBER) IS
		BEGIN
            OPEN OUT_FOTOS FOR
            SELECT ID_FOTODPTO, ID_FOTO, PRINCIPAL, ORDEN 
            FROM T_FOTODPTO f
            WHERE ID_DEPARTAMENTO = PIN_ID_DPTO
            ORDER BY ORDEN;
            
            OUT_RETURNCODE := 1;
        EXCEPTION
            WHEN OTHERS THEN BEGIN
                OUT_RETURNCODE := 0;
            END;
		END;
        
PROCEDURE P_BORRAR_FOTO_DPTO    (PIN_ID_FOTO_DPTO   IN NUMBER
                                ,OUT_RETURNCODE     OUT NUMBER) IS
		BEGIN
            DELETE FROM t_fotodpto
            WHERE id_fotodpto = PIN_ID_FOTO_DPTO;
            
            COMMIT;
            OUT_RETURNCODE := 1;
        EXCEPTION
            WHEN OTHERS THEN BEGIN
                OUT_RETURNCODE := 0;
            END;
		END;

END PCK_ADMIN;
/