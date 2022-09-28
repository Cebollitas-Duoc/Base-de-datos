CREATE OR REPLACE PACKAGE USR_TURISMO_REAL.PCK_SESION IS 
                                            
	PROCEDURE P_AGREGAR_SESION             ( PIN_LLAVE        	IN VARCHAR2
                                            ,PIN_ID_USUARIO   	IN NUMBER
											,PIN_EXPIRACION     IN NUMBER
											,PIN_FECHACREACION  IN NUMBER
                                            ,OUT_NOMBRE        	OUT VARCHAR2
                                            ,OUT_FOTO        	OUT VARCHAR2
                                            ,OUT_RETURNCODE     OUT NUMBER);
                                            
    PROCEDURE P_USER_CREADENTIALS           (PIN_EMAIL          IN VARCHAR2
											,OUT_USER_EXIST     OUT VARCHAR2
											,OUT_ID_USUARIO     OUT VARCHAR2
											,OUT_PASS           OUT VARCHAR2
                                            ,OUT_RETURNCODE     OUT NUMBER);
                                            
    PROCEDURE P_SESSION_CREADENTIALS        (PIN_LLAVE          IN VARCHAR2
											,OUT_VALID_SESSION  OUT VARCHAR2
											,OUT_ID_USUARIO     OUT VARCHAR2
											,OUT_PASS           OUT VARCHAR2
                                            ,OUT_RETURNCODE     OUT NUMBER);
                                            
    PROCEDURE P_SESION_VALIDA               (PIN_LLAVE        	IN VARCHAR2
                                            ,OUT_ES_VALIDA      OUT VARCHAR2
                                            ,OUT_ID_USUARIO   	OUT NUMBER
                                            ,OUT_PERMISO       	OUT NUMBER
                                            ,OUT_RETURNCODE     OUT NUMBER);
                                            
    PROCEDURE P_UPDATE_PASSWORD             (PIN_ID_USUARIO     IN VARCHAR2
                                            ,PIN_PASSWORD       IN VARCHAR2
                                            ,OUT_RETURNCODE     OUT NUMBER);
   
END PCK_SESION;
/