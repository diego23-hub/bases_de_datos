go
use UNIVERSIDAD;
go

/*CLASE 12 DE SEPTIEMBRE
PROCEDIMIENTOS
EJERCICIO 1*/

ALTER PROCEDURE calculoEstudiantesMencionHonor
@promedio DECIMAL (2,1)
AS
BEGIN

SELECT e.codigoEstudiante, e.primerNombre, e.primerApellido, c.nombre,
dbo.promedio_Est (e.codigoEstudiante, c.nombre) AS PROMEDIO
from ESTUDIANTES e
inner join ESTUDIANTEXCARRERA ec
on ec.codigoEstudiante=e.codigoEstudiante
inner join CARRERAS c
on c.idCarrera=ec.idCarrera
WHERE dbo.promedio_Est(e.codigoEstudiante, c.nombre) >= @promedio
ORDER BY e.primerApellido ASC;
END

exec calculoEstudiantesMencionHonor 4.5;

/*CURSORES
EJERCICIO 2*/

ALTER PROCEDURE calculoEstudiantesMedallaHonor
	@promedio DECIMAL (2,1)

AS
BEGIN 
	DECLARE @idEstudiante  INT 
	DECLARE @NombreEstudiante VARCHAR (50)
	DECLARE @ApellidoEstudiante VARCHAR (50)
	DECLARE @Carrera VARCHAR (50)
	DECLARE @prom DECIMAL (2,1)

	DECLARE cursor_Honor CURSOR FOR 
	SELECT e.codigoEstudiante, e.primerNombre, e.primerApellido, c.nombre,
dbo.promedio_Est (e.codigoEstudiante, ec.idCarrera) as promedio
from ESTUDIANTES e
inner join ESTUDIANTEXCARRERA ec
on ec.codigoEstudiante=e.codigoEstudiante
INNER JOIN Carreras c
on c.idCarrera=ec.idcarrera
WHERE dbo.promedio_Est(e.codigoEstudiante, ec.idcarrera) > = @promedio
ORDER BY e.primerApellido ASC;

OPEN cursor_Honor;
FETCH NEXT FROM cursor_Honor
INTO @idEstudiante, @NombreEstudiante,@ApellidoEstudiante,@Carrera,@prom;
WHILE @@FETCH_STATUS = 0 -- recorre el cursor 
BEGIN 
	IF  @prom BETWEEN 4.0 AND 4.3
	BEGIN
		PRINT @NombreEstudiante + '' + @ApellidoEstudiante + ''+ @Carrera +''+ cast (@prom AS VARCHAR) + 'BRONCE';
	END 

	ELSE IF @prom > 4.3 AND @prom <=4.7
	BEGIN

		PRINT @NombreEstudiante + '' + @ApellidoEstudiante + ''+ @Carrera +''+ cast (@prom AS VARCHAR) + 'PLATA';
	END

	ELSE IF @prom > 4.7
	BEGIN
		PRINT @NombreEstudiante + '' + @ApellidoEstudiante + ''+ @Carrera +''+ cast (@prom AS VARCHAR) + 'ORO';
	END


	FETCH NEXT FROM cursor_Honor
	INTO @idEstudiante, @NombreEstudiante,@ApellidoEstudiante,@Carrera, @prom
END
	
	CLOSE cursor_Honor;
	DEALLOCATE cursor_Honor;
END;

EXEC calculoEstudiantesMedallaHonor 4.7;


