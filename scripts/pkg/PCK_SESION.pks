CREATE OR REPLACE PACKAGE USR_TURISMO_REAL.PCK_SESION IS 
                                            
	PROCEDURE P_AGREGAR_SESION          (PIN_EMAIL        	     IN VARCHAR2
										,PIN_ID_PERMISO       	 IN NUMBER
										,PIN_ID_ESTADOUSUARIO    IN NUMBER
										,PIN_PASSWORD            IN VARCHAR2);
   
END PCK_SESION;
/