CREATE OR REPLACE PACKAGE BODY USR_TURISMO_REAL.PCK_EXTRASERVICES IS

PROCEDURE P_ADD_EXTRASERVICE    (PIN_ID_DPTO        IN NUMBER
                                ,PIN_ID_CAT_SRV     IN NUMBER
                                ,PIN_ID_ESTADO      IN NUMBER
                                ,PIN_ID_TRABAJADOR  IN NUMBER
                                ,PIN_VALOR          IN NUMBER
                                ,OUT_RETURNCODE     OUT NUMBER) IS
    BEGIN
        INSERT 
        INTO T_SERVICIOEXTRA(ID_Departamento
                            ,ID_CategoriaServicioExtra
                            ,ID_Estado
                            ,ID_Trabajador
                            ,Valor)
			VALUES  (PIN_ID_DPTO
					,PIN_ID_CAT_SRV
					,PIN_ID_ESTADO
                    ,PIN_ID_TRABAJADOR
					,PIN_VALOR
					);

        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
    END;

PROCEDURE P_UPDATE_EXTRASERVICE (PIN_ID_EXTRASRV    IN NUMBER
                                ,PIN_ID_ESTADO      IN NUMBER
                                ,PIN_ID_TRABAJADOR  IN NUMBER
                                ,PIN_VALOR          IN NUMBER
                                ,OUT_RETURNCODE     OUT NUMBER) IS
    BEGIN
        UPDATE T_SERVICIOEXTRA
        SET     
                ID_Estado       = PIN_ID_ESTADO,
                ID_Trabajador   = PIN_ID_TRABAJADOR,
                Valor           = PIN_VALOR        	 
        WHERE ID_ServicioExtra = PIN_ID_EXTRASRV;

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