go
use UNIVERSIDAD
go

-- CLASE 22 DE AGOSTO --
select e.primerNombre, e.primerApellido, c.nombre AS carrera
FROM ESTUDIANTES e 
INNER JOIN ESTUDIANTEXCARRERA ec 
on e.codigoEstudiante=ec.codigoEstudiante
INNER JOIN CARRERAS c
ON ec.idCarrera=c.idCarrera
order by e.primerApellido, e.primerNombre;

select f.nombre as Facultad, count(c.idCarrera) as totalCarreras
from FACULTAD f
inner join CARRERAS c 
on f.idFacultad=c.idFacultad
GROUP BY f.nombre;

select c.nombre as Carrera, COUNT(ac.idAsignaturaxCarrera) as totalAsignaturas
from CARRERAS c 
inner join ASIGNATURAXCARRERA ac 
on c.idCarrera=ac.idCarrera
GROUP BY c.nombre;

select e.primerNombre, e.primerApellido, c.nombre, avg(eg.definitiva) as promedio
from ESTUDIANTES e 
inner join ESTUDIANTEXCARRERA ec 
on e.codigoEstudiante=ec.codigoEstudiante
inner join ESTUDIANTEXGRUPO eg 
on ec.idEstudiantexCarrera=eg.idEstudiantexCarrera
inner join carreras c 
on ec.idCarrera=c.idCarrera
GROUP by e.primerNombre, e.primerApellido, c.nombre;

select e.primerNombre, e.primerApellido, c.nombre as Carrera, a.nombreAsignatura as Asignatura, p.primerNombre, p.primerApellido, eg.definitiva, eg.estado
from ESTUDIANTES e 
inner join ESTUDIANTEXCARRERA ec 
on e.codigoEstudiante=ec.codigoEstudiante
inner join ESTUDIANTEXGRUPO eg 
on ec.idEstudiantexCarrera=eg.idEstudiantexCarrera
inner join carreras c 
on ec.idCarrera=c.idCarrera
inner join grupos g 
on eg.codigoGrupo=g.codigoGrupo
inner join ASIGNATURAXCARRERA ac 
on g.idAsignaturaxCarrera=ac.idAsignaturaxCarrera
inner join ASIGNATURAS a 
on ac.idAsignatura=a.idAsignatura
inner join PROFESORES p 
on g.codigoProfesor=p.codigoProfesor;