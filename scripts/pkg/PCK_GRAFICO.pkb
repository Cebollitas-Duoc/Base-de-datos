CREATE OR REPLACE PACKAGE BODY USR_TURISMO_REAL.PCK_GRAFICOS IS

PROCEDURE P_DATOS_GRAFICO       (PIN_ID_PAGO        IN NUMBER
                                ,PIN_ID_ESTADOPAGO  NUMBER
                                ,OUT_RETURNCODE     OUT NUMBER) IS
    BEGIN
        OPEN PIN_CANTIDAD FOR
        SELECT  R.ID_PAGO, P.ID_ESTADOPAGO
        FROM T_RESERVA R
        INNER JOIN T_PAGO P 
        ON R.ID_PAGO = P.ID_PAGO
        WHERE P.ID_ESTADOPAGO = 1;
        
        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
    END;

END PCK_GRAFICOS;
/