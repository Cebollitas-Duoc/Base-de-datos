CREATE OR REPLACE PACKAGE BODY USR_TURISMO_REAL.PCK_INVENTARIO IS 
                                            
PROCEDURE P_AGREGAR_ITEM    (PIN_ID_DPTO    IN NUMBER
                            ,PIN_NOMBRE     IN VARCHAR2
                            ,PIN_CANTIDAD   IN NUMBER
                            ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        INSERT INTO T_INVENTARIO (ID_DEPARTAMENTO  
                                ,NOMBRE
                                ,CANTIDAD)
        VALUES  (PIN_ID_DPTO            
                ,PIN_NOMBRE   
                ,PIN_CANTIDAD);
        
        commit;
        OUT_RETURNCODE := 1;
        EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
        
    END;

PROCEDURE P_EDIT_ITEM   (PIN_ID_ITEM    IN NUMBER
                        ,PIN_NOMBRE     IN VARCHAR2
                        ,PIN_CANTIDAD   IN NUMBER
                        ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN

        UPDATE T_INVENTARIO
        SET     
            NOMBRE          = PIN_NOMBRE
            ,CANTIDAD       = PIN_CANTIDAD  
        WHERE ID_INVENTARIO = PIN_ID_ITEM;
        
        commit;
        OUT_RETURNCODE := 1;
        EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
        
    END;
                    
PROCEDURE P_LIST_ITEM   (PIN_ID_DPTO    IN NUMBER
                        ,OUT_ITEMS      OUT SYS_REFCURSOR
                        ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        OPEN OUT_ITEMS FOR
        SELECT * 
        FROM T_INVENTARIO
        WHERE ID_DEPARTAMENTO = PIN_ID_DPTO;

        OUT_RETURNCODE := 1;
        EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
        
    END;

PROCEDURE P_DELETE_ITEM (PIN_ID_ITEM    IN NUMBER
                        ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        DELETE FROM T_INVENTARIO
        WHERE ID_INVENTARIO = PIN_ID_ITEM;
        
        commit;
        OUT_RETURNCODE := 1;
        EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
        
    END;
   
END PCK_INVENTARIO;
/