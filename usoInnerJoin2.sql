go
use UNIVERSIDAD
go

-- CLASE 29 DE AGOSTO --
select g.codigoGrupo, COUNT (eg.idEstudiantexGrupo) AS cantidadEstudiantes
from grupos g
inner join  ESTUDIANTEXGRUPO eg 
on g.codigoGrupo=eg.codigoGrupo
GROUP by g.codigoGrupo;

alter table GRUPOS 
add idEstudiantexCarrera INT,
FOREIGN KEY (idEstudiantexCarrera) REFERENCES ESTUDIANTEXCARRERA(idEstudiantexCarrera);

select p.codigoProfesor, p.primerNombre, p.primerApellido, g.codigoGrupo, a.nombreAsignatura, COUNT(eg.idEstudiantexGrupo) as cantidadEstudiantes
from PROFESORES p 
inner join GRUPOS g 
on p.codigoProfesor=g.codigoProfesor
inner join ASIGNATURAXCARRERA ac 
on ac.idAsignaturaxCarrera=g.idAsignaturaxCarrera
inner join ASIGNATURAS a 
on a.idAsignatura=ac.idAsignatura
inner join ESTUDIANTEXGRUPO eg 
on g.codigoGrupo=eg.codigoGrupo
GROUP by P.codigoProfesor, P.primerNombre, p.primerApellido, g.codigoGrupo, a.nombreAsignatura;

select e.codigoEstudiante, e.primerNombre, e.primerApellido, a.idAsignatura, a.nombreAsignatura, eg.definitiva
from estudiantes e 
inner join ESTUDIANTEXCARRERA ec 
on e.codigoEstudiante=ec.codigoEstudiante
inner join ESTUDIANTEXGRUPO eg 
on eg.idEstudiantexCarrera=ec.idEstudiantexCarrera
inner join grupos g 
on g.codigoGrupo=eg.codigoGrupo
inner join ASIGNATURAXCARRERA ac 
on ac.idAsignaturaxCarrera=g.idAsignaturaxCarrera
inner join ASIGNATURAS a 
on a.idAsignatura=ac.idAsignatura
where eg.definitiva >= 3.0;