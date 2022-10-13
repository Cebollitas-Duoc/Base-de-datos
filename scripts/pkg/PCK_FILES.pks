CREATE OR REPLACE PACKAGE USR_TURISMO_REAL.PCK_FILES IS  

    PROCEDURE P_INSERT_PICTURE  (PIN_ID_FOTO    IN VARCHAR2
                                ,PIN_IMGDATA    IN CLOB
                                ,OUT_RETURNCODE OUT NUMBER);
    
    PROCEDURE P_GET_PICTURE     (PIN_ID_FOTO    IN VARCHAR2
                                ,OUT_IMGDATA    OUT CLOB
                                ,OUT_RETURNCODE OUT NUMBER);
   
END PCK_FILES;
/