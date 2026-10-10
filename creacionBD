-- CLASE 15 DE AGOSTO--
create DATABASE UNIVERSIDAD
go
use UNIVERSIDAD
go
 
create TABLE FACULTAD(
    idFacultad int IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) not NULL,
    idDecano int
);
 
create TABLE CARRERAS(
    idCarrera int IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    semestres int NOT NULL,
    idCoordinador int,
    idFacultad int not null
    CONSTRAINT fk_CARRERAS_FACULTAD
    FOREIGN KEY (idFacultad)
    REFERENCES FACULTAD(idFacultad)
);
 
create TABLE ESTUDIANTES(
    codigoEstudiante INT PRIMARY KEY,
    primerNombre VARCHAR(20) not null,
    segundoNombre varchar(20),
    primerApellido varchar(20) not null,
    segundoApellido varchar(20),
    fechaNacimiento DATE,
    codigoTipoDocumento int not null,
    numeroDocumento varchar (15) not null,
    direccion VARCHAR (100),
    codBarrio int
);
 
create table ESTUDIANTEXCARRERA(
    idEstudiantexCarrera int identity(1,1) primary key,
    idCarrera INT not null,
    codigoEstudiante int not null ,
    fechaInicio date
    CONSTRAINT fk_ESTUDIANTEXCARRERA_CARRERAS
    FOREIGN KEY (idCarrera)
    REFERENCES CARRERAS(idCarrera),
    CONSTRAINT fk_ESTUDIANTEXCARRERA_ESTUDIANTES
    FOREIGN KEY (codigoEstudiante)
    REFERENCES ESTUDIANTES(codigoEstudiante)
);
 
create TABLE ASIGNATURAS(
    idAsignatura int IDENTITY(1,1) PRIMARY KEY,
    nombreAsignatura VARCHAR(100) NOT NULL,
    creditos int NOT null
);
 
create TABLE ASIGNATURAXCARRERA(
    idAsignaturaxCarrera int IDENTITY(1,1) primary key,
    idCarrera int not null,
    idAsignatura int not null,
    CONSTRAINT fk_ASIGNATURAXCARRERA_CARRERAS
    FOREIGN KEY (idCarrera)
    REFERENCES CARRERAS(idCarrera),
    CONSTRAINT fk_ASIGNATURAXCARRERA_ASIGNATURAS
    FOREIGN KEY (idAsignatura)
    REFERENCES ASIGNATURAS(idAsignatura)
);
 
CREATE TABLE PROFESORES(
    codigoProfesor int primary key,
    primerNombre VARCHAR(20) not null,
    segundoNombre varchar(20),
    primerApellido varchar(20) not null,
    segundoApellido VARCHAR(20),
    direccion varchar(100),
    telefono varchar(13) not null
);
 
CREATE TABLE GRUPOS(
    codigoGrupo int PRIMARY key,
    codigoEstudiante int not null,
    idAsignaturaxCarrera int not null,
    codigoProfesor int not null,
    CONSTRAINT fk_GRUPOS_ESTUDIANTES
    FOREIGN KEY (codigoEstudiante)
    REFERENCES ESTUDIANTES (codigoEstudiante),
    CONSTRAINT fk_GRUPOS_ASIGNATURAXCARRERA
    FOREIGN KEY (idAsignaturaxCarrera)
    REFERENCES ASIGNATURAXCARRERA(idAsignaturaxCarrera),
    CONSTRAINT fk_GRUPOS_PROFESORES
    FOREIGN KEY (codigoProfesor)
    REFERENCES PROFESORES(codigoProfesor)
);
 
CREATE TABLE ESTUDIANTEXGRUPO(
    idEstudiantexGrupo int IDENTITY(1,1) PRIMARY KEY,
    idEstudiantexCarrera int not null,
    codigoGrupo int not null,
    definitiva DECIMAL(3,2) not null,
    estado VARCHAR(20) not null,
    fecha date,
    CONSTRAINT fk_ESTUDIANTEXGRUPO_ESTUDIANTEXCARRERA
    FOREIGN KEY (idEstudiantexCarrera)
    REFERENCES ESTUDIANTEXCARRERA(idEstudiantexCarrera),
    CONSTRAINT fk_ESTUDIANTEXGRUPO_GRUPOS
    FOREIGN KEY (codigoGrupo)
    REFERENCES GRUPOS(codigoGrupo)
);
 
create Table SALONES(
    idSalon int IDENTITY(1,1) PRIMARY KEy,
    codigo int not null,
    descripcion VARCHAR(100)
);
 
CREATE TABLE SALONESXGRUPO(
    idSalonxGrupo int IDENTITY(1,1) PRIMARY key,
    idSalon int not null,
    codigoGrupo int not null,
    horario VARCHAR(200),
    CONSTRAINT fk_SALONESXGRUPO_SALONES
    FOREIGN KEY (idSalon)
    REFERENCES SALONES(idSalon),
    CONSTRAINT fk_SALONESXGRUPO_GRUPOS
    FOREIGN KEY (codigoGrupo)
    REFERENCES GRUPOS(codigoGrupo)
);