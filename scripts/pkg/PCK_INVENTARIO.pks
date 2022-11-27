CREATE OR REPLACE PACKAGE USR_TURISMO_REAL.PCK_INVENTARIO IS 
                                            
	PROCEDURE P_AGREGAR_ITEM    (PIN_ID_DPTO    IN NUMBER
                                ,PIN_NOMBRE     IN VARCHAR2
								,PIN_CANTIDAD   IN NUMBER
                                ,OUT_RETURNCODE OUT NUMBER);
    
    PROCEDURE P_EDIT_ITEM   (PIN_ID_ITEM    IN NUMBER
                            ,PIN_NOMBRE     IN VARCHAR2
							,PIN_CANTIDAD   IN NUMBER
                            ,OUT_RETURNCODE OUT NUMBER);
                        
    PROCEDURE P_LIST_ITEM   (PIN_ID_DPTO    IN NUMBER
                            ,OUT_ITEMS    OUT SYS_REFCURSOR
                            ,OUT_RETURNCODE OUT NUMBER);

    PROCEDURE P_DELETE_ITEM (PIN_ID_ITEM    IN NUMBER
                            ,OUT_RETURNCODE OUT NUMBER);
   
END PCK_INVENTARIO;
/