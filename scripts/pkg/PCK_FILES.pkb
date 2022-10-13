CREATE OR REPLACE PACKAGE BODY USR_TURISMO_REAL.PCK_FILES IS
    
PROCEDURE P_INSERT_PICTURE  (PIN_ID_FOTO    IN VARCHAR2
                            ,PIN_IMGDATA    IN CLOB
                            ,OUT_RETURNCODE OUT NUMBER) IS
		BEGIN
            INSERT INTO T_FOTO (ID_FOTO, IMGDATA)
            VALUES (PIN_ID_FOTO, PIN_IMGDATA);
            
            OUT_RETURNCODE := 1;
        EXCEPTION
            WHEN OTHERS THEN BEGIN
                OUT_RETURNCODE := 0;
            END;
		END;

PROCEDURE P_GET_PICTURE (PIN_ID_FOTO    IN VARCHAR2
                        ,OUT_IMGDATA    OUT CLOB
                        ,OUT_RETURNCODE OUT NUMBER) IS
		BEGIN
            SELECT IMGDATA
            INTO OUT_IMGDATA
            FROM T_FOTO
            WHERE ID_FOTO = PIN_ID_FOTO;
            
            OUT_RETURNCODE := 1;
        EXCEPTION
            WHEN OTHERS THEN BEGIN
                OUT_RETURNCODE := 0;
            END;
		END;


END PCK_FILES;
/