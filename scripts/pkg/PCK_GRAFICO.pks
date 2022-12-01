CREATE OR REPLACE PACKAGE USR_TURISMO_REAL.PCK_GRAFICOS IS 
                   
PROCEDURE P_DATOS_GRAFICO       (PIN_ID_PAGO        IN NUMBER
                                ,PIN_ID_ESTADOPAGO  NUMBER
                                ,OUT_RETURNCODE     OUT NUMBER);
   
   
END PCK_GRAFICOS;
/