CREATE OR REPLACE PACKAGE BODY USR_TURISMO_REAL.PCK_FILES IS
--PICTURES
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
--DOCUMENTS
PROCEDURE P_INSERT_DOCUMENT (PIN_ID_DOCUMENT    IN VARCHAR2
                            ,PIN_ID_CATEGORY    IN NUMBER
                            ,PIN_ID_RESERVA     IN NUMBER
                            ,PIN_TIPOCONTENIDO  IN VARCHAR2
                            ,PIN_DATA           IN CLOB
                            ,OUT_RETURNCODE     OUT NUMBER) IS
		BEGIN
            INSERT INTO T_REPORTE (ID_REPORTE, ID_RESERVA, ID_CATEGORIA, TIPOCONTENIDO, FILEDATA)
            VALUES (PIN_ID_DOCUMENT, PIN_ID_RESERVA, PIN_ID_CATEGORY, PIN_TIPOCONTENIDO, PIN_DATA);
            
            OUT_RETURNCODE := 1;
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                --un documento con el mismo hash fue guardada (son iguales)
                OUT_RETURNCODE := 1;
            WHEN OTHERS THEN
                OUT_RETURNCODE := 0;
		END;

PROCEDURE P_GET_DOCUMENT    (PIN_ID_DOCUMENT    IN VARCHAR2
                            ,OUT_ID_CATEGORY    OUT NUMBER
                            ,OUT_CATEGORY    OUT VARCHAR2
                            ,OUT_ID_RESERVA     OUT NUMBER
                            ,OUT_TIPOCONTENIDO  OUT VARCHAR2
                            ,OUT_USER_ID        OUT VARCHAR2
                            ,OUT_DATA           OUT CLOB
                            ,OUT_RETURNCODE     OUT NUMBER) IS
		BEGIN
            SELECT D.ID_CATEGORIA, D.ID_RESERVA, R.ID_USUARIO, D.TIPOCONTENIDO, D.FILEDATA
            INTO OUT_ID_CATEGORY, OUT_ID_RESERVA, OUT_USER_ID, OUT_TIPOCONTENIDO, OUT_DATA
            FROM T_REPORTE D
            INNER JOIN T_RESERVA R
            ON R.ID_RESERVA = D.ID_RESERVA
            WHERE D.ID_REPORTE = PIN_ID_DOCUMENT;
            
            OUT_RETURNCODE := 1;
        EXCEPTION
            WHEN OTHERS THEN
                OUT_RETURNCODE := 0;
		END;
        
PROCEDURE P_GET_RSV_DOCS    (PIN_ID_RSV     IN NUMBER
                            ,OUT_DOCS       OUT SYS_REFCURSOR
                            ,OUT_RETURNCODE OUT NUMBER) IS
		BEGIN
            OPEN OUT_DOCS FOR
            SELECT *
            FROM T_REPORTE
            WHERE ID_RESERVA = PIN_ID_RSV;
            
            OUT_RETURNCODE := 1;
        EXCEPTION
            WHEN OTHERS THEN
                OUT_RETURNCODE := 0;
		END;


END PCK_FILES;
/