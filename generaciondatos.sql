BEGIN TRY
    EXEC sp_generar_datos_universidad
        @num_facultades = 10,
        @num_carreras = 10,
        @num_asignaturas = 15,
        @num_asignaturasxcarrera = 20,
        @num_estudiantes = 50000,
        @num_estudiantesxcarrera = 2000,
        @num_grupos = 100,
        @num_profesores = 20,
        @num_estudiantesxgrupo = 200,
        @num_salones = 10,
        @num_salones_grupo = 20;

    PRINT '¡Inserción masiva completada con éxito!';
END TRY
BEGIN CATCH
    PRINT 'Ocurrió un error en la ejecución:';
    PRINT ERROR_MESSAGE();
END CATCH

EXEC sp_who2;
