CREATE OR REPLACE PACKAGE USR_TURISMO_REAL.PCK_FILES IS  
--PICTURES
    PROCEDURE P_INSERT_PICTURE  (PIN_ID_FOTO        IN VARCHAR2
                                ,PIN_TIPOCONTENIDO  IN VARCHAR2
                                ,PIN_IMGDATA        IN CLOB
                                ,OUT_RETURNCODE     OUT NUMBER);
    
    PROCEDURE P_GET_PICTURE     (PIN_ID_FOTO        IN VARCHAR2
                                ,OUT_TIPOCONTENIDO  OUT VARCHAR2
                                ,OUT_IMGDATA        OUT CLOB
                                ,OUT_RETURNCODE     OUT NUMBER);
--DOCUMENTS      
    PROCEDURE P_INSERT_DOCUMENT (PIN_ID_DOCUMENT    IN VARCHAR2
                                ,PIN_ID_CATEGORY    IN NUMBER
                                ,PIN_ID_RESERVA     IN NUMBER
                                ,PIN_TIPOCONTENIDO  IN VARCHAR2
                                ,PIN_DATA           IN CLOB
                                ,OUT_RETURNCODE     OUT NUMBER);
    
    PROCEDURE P_GET_DOCUMENT    (PIN_ID_DOCUMENT    IN VARCHAR2
                                ,OUT_ID_CATEGORY    OUT NUMBER
                                ,OUT_CATEGORY       OUT VARCHAR2
                                ,OUT_ID_RESERVA     OUT NUMBER
                                ,OUT_USER_ID        OUT NUMBER
                                ,OUT_TIPOCONTENIDO  OUT VARCHAR2
                                ,OUT_DATA           OUT CLOB
                                ,OUT_RETURNCODE     OUT NUMBER);
    
    PROCEDURE P_GET_RSV_DOCS    (PIN_ID_RSV     IN NUMBER
                                ,OUT_DOCS       OUT SYS_REFCURSOR
                                ,OUT_RETURNCODE OUT NUMBER);

END PCK_FILES;
/