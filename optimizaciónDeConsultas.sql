--consulta sin optimizar--
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT e.codigoEstudiante,e.primerNombre,e.segundoNombre, e.primerApellido, e.segundoApellido, a.nombreAsignatura,eg.definitiva FROM ESTUDIANTES e
INNER JOIN ESTUDIANTEXCARRERA ec 
    ON ec.codigoEstudiante=e.codigoEstudiante
INNER JOIN ESTUDIANTEXGRUPO eg 
    ON eg.idEstudiantexCarrera=ec.idEstudiantexCarrera
INNER JOIN GRUPOS g
    ON g.codigoGrupo=eg.codigoGrupo
INNER JOIN ASIGNATURAXCARRERA ac 
    ON ac.idAsignaturaxCarrera=g.idAsignaturaxCarrera
INNER JOIN ASIGNATURAS a 
    ON a.idAsignatura=ac.idAsignatura
WHERE e.primerApellido = 'Lobo'
    OR e.segundoApellido = 'Lobo'

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

--consulta optimizada--
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

CREATE INDEX idx_apellidos ON ESTUDIANTES(primerApellido,segundoApellido);

SELECT e.codigoEstudiante,e.primerNombre,e.segundoNombre, e.primerApellido, e.segundoApellido, a.nombreAsignatura,eg.definitiva FROM ESTUDIANTES e 
INNER JOIN ESTUDIANTEXCARRERA ec 
    ON ec.codigoEstudiante=e.codigoEstudiante
INNER JOIN ESTUDIANTEXGRUPO eg 
    ON eg.idEstudiantexCarrera=ec.idEstudiantexCarrera
INNER JOIN GRUPOS g
    ON g.codigoGrupo=eg.codigoGrupo
INNER JOIN ASIGNATURAXCARRERA ac 
    ON ac.idAsignaturaxCarrera=g.idAsignaturaxCarrera
INNER JOIN ASIGNATURAS a 
    ON a.idAsignatura=ac.idAsignatura
WHERE e.primerApellido = 'Lobo'
    OR e.segundoApellido = 'Lobo'

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
