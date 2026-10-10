go
use UNIVERSIDAD;
go

-- CLASE 05 DE SEPTIEMBRE --
CREATE FUNCTION promedio_Est
(
    @codigoEstudiante int,
    @idCarrera int
)
RETURNS DECIMAL (2,1)
AS
BEGIN 
DECLARE @prom DECIMAL(2,1);
SELECT @prom = AVG(eg.definitiva)
from ESTUDIANTEXCARRERA ec
inner join ESTUDIANTEXGRUPO eg
on ec.idEstudiantexCarrera=eg.idEstudiantexCarrera
where ec.codigoEstudiante=@codigoEstudiante
and ec.idCarrera=@idCarrera
return @prom
end;
GO


--PARA CALCULAR EL PROMEDIO DE TODOS LOS ESTUDIANTES EN GENERAL--
SELECT e.codigoEstudiante, e.primerNombre, e.primerApellido, 
    dbo.promedio_Est (e.codigoEstudiante, ec.idCarrera)
from ESTUDIANTES e 
inner join ESTUDIANTEXCARRERA ec 
on ec.codigoEstudiante=e.codigoEstudiante;

--PARA CALCULAR EL PROMEDIO DE UN ESTUDIANTE EN ESPECÍFICO--
SELECT dbo.promedio_est(1,1)
    from ESTUDIANTES e 
    inner join ESTUDIANTEXCARRERA ec 
    on ec.codigoEstudiante=e.codigoEstudiante;

--DADO EL CÓDIGO DE UN PROFESOR Y SU ASIGNATURA, RETORNAR EL GRUPO QUE HA TENIDO MAYOR NÚMERO DE ESTUDIANTES--
CREATE FUNCTION mayor_grupo
(
    @codigoProfesor int,
    @idAsignatura int
)
RETURNS int
AS
begin 
    declare @grupoMayor int;
    select top 1 @grupoMayor=g.codigoGrupo
    from ASIGNATURAXCARRERA ac 
    inner join grupos g 
    on g.idAsignaturaxCarrera=ac.idAsignaturaxCarrera
    inner join ESTUDIANTEXGRUPO eg 
    on eg.codigoGrupo=g.codigoGrupo
    where ac.idAsignatura=@idAsignatura
    and g.codigoProfesor=@codigoProfesor
    GROUP by g.codigoGrupo
    order by count(eg.idEstudiantexGrupo) desc;
    return @grupoMayor;
end;
go

select dbo.mayor_grupo(1,1)
