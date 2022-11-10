CREATE OR REPLACE PACKAGE BODY USR_TURISMO_REAL.PCK_EXTRASERVICES IS

PROCEDURE P_ADD_EXTRASERVICE    (PIN_ID_DPTO    IN NUMBER
                                ,PIN_ID_CAT_SRV IN NUMBER
                                ,PIN_ID_estado  IN NUMBER
                                ,PIN_VALOR      IN NUMBER
                                ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        INSERT 
        INTO T_ServicioExtra(ID_Departamento        
                            ,ID_CategoriaServicioExtra   
                            ,ID_Estado   
                            ,Valor)
			VALUES  (PIN_ID_DPTO            
					,PIN_ID_CAT_SRV   
					,PIN_ID_estado   
					,PIN_VALOR
					);

        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
    END;

PROCEDURE P_LIST_DPTO_EXTRASERVICES (PIN_ID_DPTO    IN NUMBER
                                    ,OUT_SERVICES   OUT SYS_REFCURSOR
                                    ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        OPEN OUT_SERVICES FOR
        SELECT ID_SERVICIOEXTRA, ID_CATEGORIASERVICIOEXTRA, ID_ESTADO, ID_TRABAJADOR, VALOR
        FROM T_SERVICIOEXTRA
        WHERE ID_DEPARTAMENTO = PIN_ID_DPTO;
        
        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
    END;
    
PROCEDURE P_LIST_CAT_EXTSRV (OUT_CAT_SRV   OUT SYS_REFCURSOR
                            ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        OPEN OUT_CAT_SRV FOR
        SELECT *
        FROM t_categoriaservicioextra;
        
        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
    END;

END PCK_EXTRASERVICES;
/