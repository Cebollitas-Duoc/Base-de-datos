CREATE OR REPLACE PACKAGE BODY USR_TURISMO_REAL.PCK_DPTO IS

PROCEDURE P_LISTAR_DPTOS    (OUT_DPTOS   OUT SYS_REFCURSOR
                            ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        OPEN OUT_DPTOS FOR
        SELECT
        d.id_departamento, d.direccion, d.longitud, d.latitud, d.habitaciones, d.banios, d.tamanio, d.valor, d.id_estado, (
        SELECT DISTINCT FIRST_VALUE(ID_FOTO)
            OVER (ORDER BY PRINCIPAL DESC, ORDEN ASC )
            FROM T_FOTODPTO 
            WHERE ID_DEPARTAMENTO = d.id_departamento
        ) as imagen_principal
        FROM T_DEPARTAMENTO d;
        
        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
    END;

PROCEDURE P_VER_DPTO    (PIN_ID_DPTO        IN NUMBER
                        ,OUT_DIRECCION      OUT VARCHAR2
                        ,OUT_LONGITUD       OUT NUMBER
                        ,OUT_LATITUD        OUT NUMBER
                        ,OUT_HABITACIONES   OUT NUMBER
                        ,OUT_BANIOS         OUT NUMBER
                        ,OUT_TAMANIO        OUT NUMBER
                        ,OUT_VALOR          OUT NUMBER
                        ,OUT_ID_ESTADO      OUT NUMBER
                        ,OUT_IMAGEN         OUT VARCHAR2
                        ,OUT_RETURNCODE     OUT NUMBER) IS
    BEGIN
        SELECT
        d.direccion, d.longitud, d.latitud, d.habitaciones, d.banios, d.tamanio, d.valor, d.id_estado, (
        SELECT DISTINCT FIRST_VALUE(ID_FOTO)
            OVER (ORDER BY PRINCIPAL DESC, ORDEN ASC )
            FROM T_FOTODPTO 
            WHERE ID_DEPARTAMENTO = d.id_departamento
        ) as imagen_principal
        INTO OUT_DIRECCION, OUT_LONGITUD, OUT_LATITUD, OUT_HABITACIONES, OUT_BANIOS, OUT_TAMANIO, OUT_VALOR, OUT_ID_ESTADO, OUT_IMAGEN
        FROM T_DEPARTAMENTO d
        WHERE d.id_departamento = PIN_ID_DPTO;
        
        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
    END;
        
PROCEDURE P_LISTAR_FOTOS_DPTO   (PIN_ID_DPTO    IN NUMBER
                                ,OUT_FOTOS      OUT SYS_REFCURSOR
                                ,OUT_RETURNCODE OUT NUMBER) IS
    BEGIN
        OPEN OUT_FOTOS FOR
        SELECT ID_FOTODPTO, ID_FOTO, PRINCIPAL, ORDEN 
        FROM T_FOTODPTO f
        WHERE ID_DEPARTAMENTO = PIN_ID_DPTO
        ORDER BY ORDEN;
        
        OUT_RETURNCODE := 1;
    EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
    END;
        

END PCK_DPTO;
/