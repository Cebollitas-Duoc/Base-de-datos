CREATE OR REPLACE PACKAGE USR_TURISMO_REAL.PCK_ADMIN IS 
                                            
	PROCEDURE P_LISTAR_USUARIOS (OUT_USUARIOS   OUT SYS_REFCURSOR
                                ,OUT_RETURNCODE OUT NUMBER);
    
    PROCEDURE P_EDIT_USER   (PIN_ID_USUARIO          IN NUMBER
                            ,PIN_ID_PERMISO          IN NUMBER
                            ,PIN_ID_ESTADOUSUARIO    IN NUMBER
                            ,PIN_EMAIL        	     IN VARCHAR2
                            ,PIN_PRIMERNOMBRE        IN VARCHAR2
                            ,PIN_SEGUNDONOMBRE       IN VARCHAR2
                            ,PIN_PRIMERAPELLIDO      IN VARCHAR2
                            ,PIN_SEGUNDOAPELLIDO     IN VARCHAR2
                            ,PIN_DIRECCION           IN VARCHAR2
                            ,PIN_TELEFONO            IN VARCHAR2
                            ,PIN_RUTAFOTOPERFIL      IN VARCHAR2
                            ,OUT_RETURNCODE          OUT NUMBER);
   
END PCK_ADMIN;
/