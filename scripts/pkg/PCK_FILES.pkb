CREATE OR REPLACE PACKAGE BODY USR_TURISMO_REAL.PCK_FILES IS
    
PROCEDURE P_INSERT_PICTURE  (PIN_ID_FOTO        IN VARCHAR2
                            ,PIN_TIPOCONTENIDO  IN VARCHAR2
                            ,PIN_IMGDATA        IN CLOB
                            ,OUT_RETURNCODE     OUT NUMBER) IS
		BEGIN
            INSERT INTO T_FOTO (ID_FOTO, TIPOCONTENIDO, IMGDATA)
            VALUES (PIN_ID_FOTO, PIN_TIPOCONTENIDO, PIN_IMGDATA);
            
            OUT_RETURNCODE := 1;
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                --una imagen con el mismo hash fue guardada (son iguales)
                OUT_RETURNCODE := 1;
            WHEN OTHERS THEN
                OUT_RETURNCODE := 0;
		END;

PROCEDURE P_GET_PICTURE (PIN_ID_FOTO        IN VARCHAR2
                        ,OUT_TIPOCONTENIDO  OUT VARCHAR2
                        ,OUT_IMGDATA        OUT CLOB
                        ,OUT_RETURNCODE     OUT NUMBER) IS
		BEGIN
            SELECT TIPOCONTENIDO, IMGDATA
            INTO OUT_TIPOCONTENIDO, OUT_IMGDATA
            FROM T_FOTO
            WHERE ID_FOTO = PIN_ID_FOTO;
            
            OUT_RETURNCODE := 1;
        EXCEPTION
            WHEN OTHERS THEN
                OUT_RETURNCODE := 0;
		END;


END PCK_FILES;
/