CREATE OR REPLACE PACKAGE USR_TURISMO_REAL.PCK_USUARIOS IS 
----,OUT_CURSOR       OUT SYS_REFCURSOR) IS
    PROCEDURE P_LEE_USUARIOS                (PIN_ID_USUARIO         IN NUMBER  ---PIN PARAMETRO ENTREADA  OUT_ PARAMETRO SALIDA
                                            ,OUT_CURSOR             OUT SYS_REFCURSOR);
                                            
	PROCEDURE P_AGREGAR_ACTUALIZAR_USUARIO                ( PIN_ID_USUARIO          IN NUMBER
															,PIN_EMAIL        	     IN VARCHAR2
															,PIN_ID_PERMISO       	 IN NUMBER
															,PIN_ID_ESTADOUSUARIO    IN NUMBER
															,PIN_PASSWORD            IN VARCHAR2);
    
	PROCEDURE P_ACTUALIZAR_ESTADO_USUARIO      ( PIN_ID_USUARIO          IN NUMBER);
   
END PCK_USUARIOS;
/