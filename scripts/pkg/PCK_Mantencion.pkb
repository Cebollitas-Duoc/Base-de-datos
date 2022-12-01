CREATE OR REPLACE PACKAGE BODY USR_TURISMO_REAL.PCK_MANTENCION IS

PROCEDURE P_AGREGAR_MANTENCION  (PIN_ID_CATEGORIA   IN NUMBER
                                ,PIN_ID_DPTO   	    IN NUMBER
                                ,PIN_DESCRIPCION    IN VARCHAR2
                                ,PIN_VALOR          IN NUMBER
                                ,PIN_FECHA_INICIO   IN NUMBER
                                ,PIN_FECHA_FIN      IN NUMBER
                                ,OUT_RETURNCODE     OUT NUMBER) IS
    BEGIN
        INSERT INTO T_MANTENCION    (ID_CategoriaMantencion  
                                    ,ID_Departamento
                                    ,Descripcion
                                    ,Valor
                                    ,FechaInicio
                                    ,FechaFin)
        VALUES  (PIN_ID_CATEGORIA            
                ,PIN_ID_DPTO   
                ,PIN_DESCRIPCION
                ,PIN_VALOR
                ,PIN_FECHA_INICIO
                ,PIN_FECHA_FIN);
        
        COMMIT;
        OUT_RETURNCODE := 1;
        EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
        
    END;

PROCEDURE P_EDITAR_MANTENCION   (PIN_ID_MANTENCION  IN NUMBER
                                ,PIN_DESCRIPCION    IN VARCHAR2
                                ,PIN_VALOR          IN NUMBER
                                ,PIN_FECHA_INICIO   IN NUMBER
                                ,PIN_FECHA_FIN      IN NUMBER
                                ,OUT_RETURNCODE     OUT NUMBER) IS
    BEGIN

        UPDATE T_MANTENCION
        SET     
            DESCRIPCION     = PIN_DESCRIPCION
            ,VALOR          = PIN_VALOR  
            ,FECHAINICIO    = PIN_FECHA_INICIO  
            ,FECHAFIN       = PIN_FECHA_FIN  
        WHERE ID_Mantencion = PIN_ID_MANTENCION;
        
        COMMIT;
        OUT_RETURNCODE := 1;
        EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
        
    END;

PROCEDURE P_LISTAR_MANTENCIONES (PIN_ID_DPTO        IN NUMBER
                                ,OUT_MANTENCIONES   OUT SYS_REFCURSOR
                                ,OUT_RETURNCODE     OUT NUMBER) IS
    BEGIN
        OPEN OUT_MANTENCIONES FOR
        SELECT
            m.id_mantencion,
            m.id_categoriamantencion,
            c.descripcion CATEGORIA,
            m.id_departamento,
            m.descripcion,
            m.valor,
            m.fechainicio,
            m.fechafin
        FROM T_MANTENCION M
        INNER JOIN t_categoriamantencion C ON c.id_categoriamantencion = m.id_categoriamantencion 
        WHERE ID_DEPARTAMENTO = PIN_ID_DPTO;

        OUT_RETURNCODE := 1;
        EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;
        
    END;

PROCEDURE P_BORRAR_MANTENCION   (PIN_ID_MANTENCION  IN NUMBER
                                ,OUT_RETURNCODE     OUT NUMBER) IS
    BEGIN
        DELETE FROM T_MANTENCION
        WHERE ID_MANTENCION = PIN_ID_MANTENCION;
        
        COMMIT;
        OUT_RETURNCODE := 1;
        EXCEPTION
        WHEN OTHERS THEN BEGIN
            OUT_RETURNCODE := 0;
        END;

    END;

END PCK_MANTENCION;
/