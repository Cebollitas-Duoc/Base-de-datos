CREATE OR REPLACE PACKAGE USR_TURISMO_REAL.PCK_ADMIN IS 
                   
--Usuarios                         
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
                        ,PIN_RUT                 IN NUMBER
                        ,PIN_DIRECCION           IN VARCHAR2
                        ,PIN_TELEFONO            IN VARCHAR2
                        ,PIN_ID_FOTO             IN VARCHAR2
                        ,OUT_RETURNCODE          OUT NUMBER);
                        
--Departamentos
PROCEDURE P_AGREGAR_DPTO    (PIN_ID_ESTADO       IN NUMBER
                            ,PIN_DIRECCION      IN VARCHAR2
                            ,PIN_LONGITUD       IN NUMBER
                            ,PIN_LATITUD        IN NUMBER
                            ,PIN_HABITACIONES   IN NUMBER
                            ,PIN_BANIOS         IN NUMBER
                            ,PIN_TAMANIO        IN NUMBER
                            ,PIN_VALOR          IN NUMBER
                            ,PIN_DESCRIPCION    IN VARCHAR2
                            ,OUT_RETURNCODE     OUT NUMBER);
                            
PROCEDURE P_EDIT_DPTO       (PIN_ID_DPTO        IN NUMBER
                            ,PIN_ID_ESTADO      IN NUMBER
                            ,PIN_DIRECCION      IN VARCHAR2
                            ,PIN_LONGITUD       IN NUMBER
                            ,PIN_LATITUD        IN NUMBER
                            ,PIN_HABITACIONES   IN NUMBER
                            ,PIN_BANIOS         IN NUMBER
                            ,PIN_TAMANIO        IN NUMBER
                            ,PIN_VALOR          IN NUMBER
                            ,PIN_DESCRIPCION    IN VARCHAR2
                            ,OUT_RETURNCODE     OUT NUMBER);
                            
--Imagenes Departamentos
PROCEDURE P_AGREGAR_FOTO_DPTO   (PIN_ID_DPTO    IN NUMBER
                                ,PIN_PRINCIPAL  IN NUMBER
                                ,PIN_DIRECCION  IN VARCHAR2
                                ,OUT_RETURNCODE OUT NUMBER);
                                
PROCEDURE P_EDIT_FOTO_DPTO      (PIN_ID_FOTO_DPTO   IN NUMBER
                                ,PIN_PRINCIPAL      IN NUMBER
                                ,PIN_ORDEN          IN NUMBER
                                ,OUT_RETURNCODE     OUT NUMBER);
                    
PROCEDURE P_BORRAR_FOTO_DPTO    (PIN_ID_FOTO_DPTO   IN NUMBER
                                ,OUT_RETURNCODE     OUT NUMBER);

-- servicios

PROCEDURE P_ADD_SERVICE (PIN_CAT_SRV    IN NUMBER
                        ,PIN_ID_DPTO    IN NUMBER
                        ,OUT_RETURNCODE OUT NUMBER);

PROCEDURE P_EDIT_SERVICE (PIN_ID_SRV     IN NUMBER
                         ,PIN_ID_ESTADO  IN NUMBER
                         ,PIN_CANTIDAD   IN NUMBER
                         ,OUT_RETURNCODE OUT NUMBER);
   
END PCK_ADMIN;
/