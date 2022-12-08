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
                RUT,
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
                        ,PIN_RUT                 IN NUMBER
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
                ,RUT              = PIN_RUT
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
                                ,PIN_DESCRIPCION    IN VARCHAR2
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
        ,VALOR
        ,DESCRIPCION)
    VALUES
        (PIN_ID_ESTADO
        ,PIN_DIRECCION
        ,PIN_LONGITUD
        ,PIN_LATITUD 
        ,PIN_HABITACIONES 
        ,PIN_BANIOS
        ,PIN_TAMANIO
        ,PIN_VALOR
        ,PIN_DESCRIPCION);
        
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
                        ,PIN_DESCRIPCION    IN VARCHAR2
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
                ,DESCRIPCION      = PIN_DESCRIPCION
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

--servicios

PROCEDURE P_ADD_SERVICE (PIN_CAT_SRV    IN NUMBER
                        ,PIN_ID_DPTO    IN NUMBER
                        ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        INSERT INTO T_SERVICIO (ID_CATEGORIASERVICIO, ID_DEPARTAMENTO, ID_ESTADO, CANTIDAD)
        VALUES (PIN_CAT_SRV, PIN_ID_DPTO, 0, 1);
        
        COMMIT;
        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN
            OUT_RETURNCODE := 0;
    END;

PROCEDURE P_EDIT_SERVICE (PIN_ID_SRV     IN NUMBER
                         ,PIN_ID_ESTADO  IN NUMBER
                         ,PIN_CANTIDAD   IN NUMBER
                         ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        UPDATE T_SERVICIO
        SET ID_ESTADO = PIN_ID_ESTADO,
            CANTIDAD  = PIN_CANTIDAD
        WHERE ID_SERVICIO = PIN_ID_SRV;
        
        COMMIT;
        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN
            OUT_RETURNCODE := 0;
    END;

PROCEDURE P_ADD_SRV_CAT (PIN_DESCRIPCION IN VARCHAR2
                        ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        INSERT INTO T_CategoriaServicio 
        (Descripcion) 
        VALUES (PIN_DESCRIPCION);
        
        COMMIT;
        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
    END;

-- servicios extra
PROCEDURE P_ADD_EXTRASERVICE    (PIN_ID_DPTO        IN NUMBER
                                ,PIN_ID_CAT_SRV     IN NUMBER
                                ,PIN_ID_ESTADO      IN NUMBER
                                ,PIN_ID_TRABAJADOR  IN NUMBER
                                ,PIN_VALOR          IN NUMBER
                                ,PIN_DESCRIPTION    IN VARCHAR2
                                ,OUT_RETURNCODE     OUT NUMBER) IS
    BEGIN
        INSERT 
        INTO T_SERVICIOEXTRA(ID_Departamento
                            ,ID_CategoriaServicioExtra
                            ,ID_Estado
                            ,ID_Trabajador
                            ,Valor
                            ,descripcion)
			VALUES  (PIN_ID_DPTO
					,PIN_ID_CAT_SRV
					,PIN_ID_ESTADO
                    ,PIN_ID_TRABAJADOR
					,PIN_VALOR
                    ,PIN_DESCRIPTION
					);
        
        COMMIT;
        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
    END;

PROCEDURE P_EDIT_EXTRASERVICE   (PIN_ID_EXTRASRV    IN NUMBER
                                ,PIN_ID_ESTADO      IN NUMBER
                                ,PIN_ID_TRABAJADOR  IN NUMBER
                                ,PIN_VALOR          IN NUMBER
                                ,PIN_DESCRIPTION    IN VARCHAR2
                                ,OUT_RETURNCODE     OUT NUMBER) IS
    BEGIN
        UPDATE T_SERVICIOEXTRA
        SET     
                ID_Estado       = PIN_ID_ESTADO,
                ID_Trabajador   = PIN_ID_TRABAJADOR,
                VALOR           = PIN_VALOR,
                DESCRIPCION      = PIN_DESCRIPTION
        WHERE ID_ServicioExtra = PIN_ID_EXTRASRV;
        
        COMMIT;
        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
    END;

PROCEDURE P_ADD_EXTSRV_CAT  (PIN_DESCRIPCION IN VARCHAR2
                            ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        INSERT INTO t_categoriaservicioextra 
        (Descripcion) 
        VALUES (PIN_DESCRIPCION);
        
        COMMIT;
        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
    END;





END PCK_ADMIN;
/