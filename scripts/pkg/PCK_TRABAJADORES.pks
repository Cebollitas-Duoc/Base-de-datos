CREATE OR REPLACE PACKAGE USR_TURISMO_REAL.PCK_TRABAJADORES IS 

PROCEDURE P_LISTAR_TRABAJADORES (OUT_WORKERS   OUT SYS_REFCURSOR
                                ,OUT_RETURNCODE OUT NUMBER);
   
END PCK_TRABAJADORES;
/