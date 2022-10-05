CREATE OR REPLACE PACKAGE USR_TURISMO_REAL.PCK_USUARIOS IS 
----,OUT_CURSOR       OUT SYS_REFCURSOR) IS
    PROCEDURE P_LEE_USUARIO     (PIN_EMAIL               IN VARCHAR2
                                ,OUT_USER_EXIST          OUT VARCHAR2
                                ,OUT_ID_PERMISO       	 OUT NUMBER
                                ,OUT_ID_ESTADOUSUARIO    OUT NUMBER
                                ,OUT_PASSWORD            OUT VARCHAR2
                                ,OUT_PRIMERNOMBRE        OUT VARCHAR2
                                ,OUT_SEGUNDONOMBRE       OUT VARCHAR2
                                ,OUT_PRIMERAPELLIDO      OUT VARCHAR2
                                ,OUT_SEGUNDOAPELLIDO     OUT VARCHAR2
                                ,OUT_DIRECCION           OUT VARCHAR2
                                ,OUT_TELEFONO            OUT VARCHAR2
                                ,OUT_RUTAFOTOPERFIL      OUT VARCHAR2
                                ,OUT_RETURNCODE          OUT NUMBER);
                                            
	PROCEDURE P_AGREGAR_USUARIO (PIN_EMAIL        	     IN VARCHAR2
                                ,PIN_ID_PERMISO       	 IN NUMBER
                                ,PIN_ID_ESTADOUSUARIO    IN NUMBER
                                ,PIN_PASSWORD            IN VARCHAR2
                                ,PIN_PRIMERNOMBRE        IN VARCHAR2
                                ,PIN_SEGUNDONOMBRE       IN VARCHAR2
                                ,PIN_PRIMERAPELLIDO      IN VARCHAR2
                                ,PIN_SEGUNDOAPELLIDO     IN VARCHAR2
                                ,PIN_DIRECCION           IN VARCHAR2
                                ,PIN_TELEFONO            IN VARCHAR2
                                ,PIN_RUTAFOTOPERFIL      IN VARCHAR2
                                ,OUT_RETURNCODE          OUT NUMBER);
                                                
    PROCEDURE P_EDIT_SESSION_PROFILE (PIN_SESION              IN VARCHAR2
                                     ,PIN_EMAIL        	      IN VARCHAR2
                                     ,PIN_PRIMERNOMBRE        IN VARCHAR2
                                     ,PIN_SEGUNDONOMBRE       IN VARCHAR2
                                     ,PIN_PRIMERAPELLIDO      IN VARCHAR2
                                     ,PIN_SEGUNDOAPELLIDO     IN VARCHAR2
                                     ,PIN_DIRECCION           IN VARCHAR2
                                     ,PIN_TELEFONO            IN VARCHAR2
                                     ,PIN_RUTAFOTOPERFIL      IN VARCHAR2
                                     ,OUT_RETURNCODE          OUT NUMBER);
    
    PROCEDURE P_LEE_PERFIL_DE_SESION    (PIN_SESION              IN VARCHAR2
                                        ,OUT_EMAIL               OUT VARCHAR2
                                        ,OUT_PRIMERNOMBRE        OUT VARCHAR2
                                        ,OUT_SEGUNDONOMBRE       OUT VARCHAR2
                                        ,OUT_PRIMERAPELLIDO      OUT VARCHAR2
                                        ,OUT_SEGUNDOAPELLIDO     OUT VARCHAR2
                                        ,OUT_DIRECCION           OUT VARCHAR2
                                        ,OUT_TELEFONO            OUT VARCHAR2
                                        ,OUT_RUTAFOTOPERFIL      OUT VARCHAR2
                                        ,OUT_VALIDSESSION        OUT VARCHAR2
                                        ,OUT_RETURNCODE          OUT NUMBER);
   
END PCK_USUARIOS;
/