CREATE OR REPLACE PACKAGE BODY USR_TURISMO_REAL.PCK_ADMIN IS

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

END PCK_ADMIN;
/