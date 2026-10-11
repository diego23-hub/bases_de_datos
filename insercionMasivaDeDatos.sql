USE [Universidad]
GO
/****** Objeto: StoredProcedure [dbo].[sp_generar_datos_universidad] Fecha de script: 10/10/2026 10:57:06 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_generar_datos_universidad]
    @num_facultades INT ,
    @num_carreras INT ,
    @num_asignaturas INT ,
    @num_asignaturasxcarrera INT ,
    @num_estudiantes INT ,
    @num_estudiantesxcarrera INT,
    @num_grupos INT ,
    @num_profesores INT,
    @num_estudiantesxgrupo INT,
    @num_salones INT,
    @num_salones_grupo INT
AS
BEGIN
SET NOCOUNT ON;

 -------------------------
    -- Temporales Nombres y apellidos
-------------------------

CREATE TABLE #Nombres
(
    Nombre VARCHAR(100),
);

INSERT INTO #Nombres
VALUES ('Juan'),('María'),('Paulina'),('Felipe'),('Ana'),('Pedro'),('Mauricio'),('Renata'),('Renato'),('Mariana'),('Mariano'),('Luis'),('Luisa'),('Aurora'),('Eler'),('Juana'),('Lucas'),('Laura'),('Claudia'),('Claudio'),('Julio'),('Gregorio'),('Juliana'),('Julian'),('Carlos'),('Carla');

CREATE TABLE #Apellidos
(
    Apellido VARCHAR(100),
);

INSERT INTO #Apellidos
VALUES ('Perez'),('Gamboa'),('Martinez'),('Lara'),('Lobo'),('Betancur'),('Alvarez'),('Ruiz'),('Villa'),('Cano'),('Calvo'),('Maestre'),('Rosas'),('Florez'),('Luna'),('Santos'),('Llano'),('Echeverry'),('Macano'),('Vaca'),('Soler'),('Bautista'),('Perez'),('Peña'),('Jimenez'),('Acevedo');
 -------------------------
    -- FACULTADES
-------------------------

DECLARE @max_facultad INT = (SELECT MAX(idFacultad) FROM Facultad);
DECLARE @contador INT=0;

WHILE  @contador<@num_facultades
begin
    insert into Facultad(nombre) values(
    CONCAT('Facultad_',(@max_facultad +@contador+1))
    )
    set @contador=@contador+1
end
 
 set @contador=0;

 -------------------------
    -- CARRERAS
-------------------------
DECLARE @max_carrera INT = (SELECT MAX(idCarrera) FROM Carreras);

WHILE  @contador<@num_carreras
begin
    insert into Carreras(nombre,idFacultad) values(
    CONCAT('Carera_',(@max_carrera +@contador+1)),
    (SELECT top 1 idFacultad from Facultad order by NEWID())
    )
    set @contador=@contador+1
end

 -------------------------
    -- ASIGNATURAS
-------------------------
set @contador=0;
DECLARE @maxasigna INT = (SELECT MAX(idAsignatura) FROM Asignaturas);

WHILE  @contador<@num_asignaturas
begin
    insert into Asignaturas(nombreAsignatura,creditos) values(
    CONCAT('Asignatura_',(@maxasigna +@contador+1)),
    1+ABS(CHECKSUM(NEWID())) % 10
    )
    set @contador=@contador+1
end


 -------------------------
    -- ESTUDIANTES
-------------------------
set @contador=0;
WHILE  @contador<@num_estudiantes
begin
    DECLARE @Documento VARCHAR(8);
    DECLARE @CodEstudiante INT;

    WHILE 1 = 1
    BEGIN
        SET @Documento = CAST(
            10000000 + ABS(CHECKSUM(NEWID())) % 90000000 
            AS VARCHAR(8)
        );

        SET @CodEstudiante = ISNULL((SELECT MAX(codigoEstudiante) FROM Estudiantes), 0) + 1;

        IF NOT EXISTS (
            SELECT 1
            FROM Estudiantes
            WHERE numeroDocumento = @Documento
        )
            BREAK;
     END;
     Declare @primNom VARCHAR(100)=(select top 1 Nombre from #Nombres order by NEWID());
     Declare @segNom VARCHAR(100)=(select top 1 Nombre from #Nombres order by NEWID());
     Declare @primApe VARCHAR(100)=(select top 1 apellido from #Apellidos order by NEWID());
     Declare @segApe VARCHAR(100)=(select top 1 apellido from #Apellidos order by NEWID());

    insert into Estudiantes(primerNombre,segundoNombre,primerApellido,segundoApellido,codigoTipoDocumento,numeroDocumento,correo,codigoEstudiante) values(
    CAST(@Documento AS INT), 
        @primNom,                
        @segNom,                
        @primApe,               
        @segApe,                 
        1,                        
        @Documento,               
        CONCAT(@primNom,'.',@primApe,'@miuniversidad.edu.co')
    );
    set @contador=@contador+1
end
 -------------------------
    -- DOCENTES
-------------------------
set @contador=0;
WHILE  @contador<@num_profesores
begin
    DECLARE @DocumentoP VARCHAR(8);
    DECLARE @CodProfesor INT;

    WHILE 1 = 1
    BEGIN
        SET @Documentop = CAST(
            10000000 + ABS(CHECKSUM(NEWID())) % 90000000 
            AS VARCHAR(8)
        );

        SET @CodProfesor = ISNULL((SELECT MAX(codigoProfesor) FROM Profesores), 0) + 1;

        IF NOT EXISTS (
            SELECT 1
            FROM Profesores
            WHERE codigoProfesor = @CodProfesor
        )
            BREAK;
     END;
     Declare @primNomP VARCHAR(100)=(select top 1 nombre from #Nombres order by NEWID());
     Declare @segNomP VARCHAR(100)=(select top 1 nombre from #Nombres order by NEWID());
     Declare @primApeP VARCHAR(100)=(select top 1 apellido from #Apellidos order by NEWID());
     Declare @segApeP VARCHAR(100)=(select top 1 apellido from #Apellidos order by NEWID());

    insert into Profesores(primerNombre,segundoNombre,primerApellido,segundoApellido,telefono,codigoProfesor,correo) values(
    @CodProfesor,
    @primNomP,
    @segNomP,
    @primApeP,
    @segApeP,   
    '555-0000',
    CONCAT(@primNomP,'.',@primApeP,'@miuniversidad.edu.co')
    )
    set @contador=@contador+1
end

 -------------------------
    -- ASIGNATURAXCARRERAS
-------------------------
set @contador=0;
WHILE  @contador<@num_asignaturasxcarrera
begin
    INSERT INTO AsignaturaXCarrera (idAsignatura, idCarrera)
    SELECT TOP 1
        a.idAsignatura,
        c.idCarrera
    FROM Asignaturas a
    CROSS JOIN Carreras c
    WHERE NOT EXISTS (
        SELECT 1
        FROM AsignaturaXCarrera ac
        WHERE ac.idAsignatura = a.idAsignatura
          AND ac.idCarrera = c.idCarrera
    )
ORDER BY NEWID();
    set @contador=@contador+1
end


 -------------------------
    -- estudiantesxcarrera
-------------------------
set @contador=0;
WHILE  @contador<@num_estudiantesxcarrera
begin
    insert into EstudianteXCarrera(codigoEstudiante,idCarrera)
     SELECT TOP 1
        a.codigoEstudiante,
        c.idCarrera
    FROM Estudiantes a
    CROSS JOIN Carreras c
    WHERE NOT EXISTS (
        SELECT 1
        FROM EstudianteXCarrera ac
        WHERE ac.codigoEstudiante = a.codigoEstudiante
          AND ac.idCarrera = c.idCarrera
    )
    ORDER BY NEWID()
        
    set @contador=@contador+1
end

 -------------------------
    -- grupos
-------------------------
set @contador=0;
DECLARE @maxgrupo INT = (SELECT MAX(codigoGrupo) FROM Grupos);
WHILE  @contador<@num_grupos
begin
    insert into Grupos(codigoGrupo,codigoEstudiante, idAsignaturaxCarrera,codigoProfesor) 
    SELECT TOP 1
        CONCAT('Grupo',(@maxgrupo +@contador+1)),
        e.codigoEstudiante,
        p.codigoProfesor,
        ac.idAsignaturaxCarrera
    FROM Profesores p
    CROSS JOIN ESTUDIANTES e
    CROSS JOIN AsignaturaXCarrera ac
    WHERE NOT EXISTS (
        SELECT 1
        FROM Grupos g
        WHERE g.codigoGrupo = (@maxgrupo + @contador + 1)
    )
    ORDER BY NEWID()
    
    set @contador=@contador+1
end


 -------------------------
    -- estudiantesxgrupo
-------------------------
set @contador=0;

WHILE  @contador<@num_estudiantesxgrupo
begin
    insert into EstudiantesXGrupo(codigoEstudiante,codigoGrupo,estado) 
    SELECT TOP 1
        a.codigoEstudiante,
        c.codigoGrupo,
        'Activo'
    FROM Estudiantes a
    CROSS JOIN Grupos c
    WHERE NOT EXISTS (
        SELECT 1
        FROM EstudiantesXGrupo ac
        WHERE ac.codigoEstudiante = a.codigoEstudiante
          AND ac.codigoGrupo = c.codigoGrupo
    )
    ORDER BY NEWID()
    
    set @contador=@contador+1
end

 -------------------------
    -- SALONES
-------------------------

DECLARE @max_salon INT = (SELECT MAX(idSalon) FROM Salones);
set @contador=0;

WHILE  @contador<@num_salones
begin
    insert into Salones(nombre,capacidad) values(
    CONCAT('Salon_',(@max_salon +@contador+1)),
    10+ABS(CHECKSUM(NEWID())) % 30
    )
    set @contador=@contador+1
end
 


 -------------------------
    -- salonesxgrupo
-------------------------
set @contador=0;
WHILE  @contador<@num_salones_grupo
begin
    insert into SalonesXGrupo(idSalon,codigoGrupo)
    SELECT TOP 1
        a.idSalon,
        c.codigoGrupo
    FROM Salones a
    CROSS JOIN Grupos c
    WHERE NOT EXISTS (
        SELECT 1
        FROM SalonesXGrupo ac
        WHERE ac.idSalon = a.idSalon
          AND ac.codigoGrupo = c.codigoGrupo
    )
    ORDER BY NEWID()
    
    set @contador=@contador+1
end

end;