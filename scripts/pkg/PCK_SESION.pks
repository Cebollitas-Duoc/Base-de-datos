CREATE OR REPLACE PACKAGE USR_TURISMO_REAL.PCK_SESION IS 
                                            
	PROCEDURE P_AGREGAR_SESION             ( PIN_LLAVE        	    IN VARCHAR2
											,PIN_EXPIRACION      	IN NUMBER
											,PIN_ID_USUARIO   		IN NUMBER
											,PIN_FECHACREACION      IN NUMBER);
   
END PCK_SESION;
/