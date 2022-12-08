CREATE OR REPLACE PACKAGE USR_TURISMO_REAL.PCK_PAGOS IS  
PROCEDURE P_PAGAR_RESERVA   	(PIN_ID_ESTADOPAGO	  	IN 	NUMBER
                              ,PIN_VALOR		      	IN 	NUMBER
                              ,PIN_FECHA		     	IN 	NUMBER
                              ,PIN_ID_RESERVA			IN 	NUMBER
                              ,OUT_RETURNCODE			OUT NUMBER);

END PCK_PAGOS;
/