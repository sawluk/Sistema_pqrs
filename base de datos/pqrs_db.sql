DROP DATABASE IF EXISTS sistema_pqrs;
CREATE DATABASE sistema_pqrs;
USE sistema_pqrs;

-- base de datos by Samuel Bolaños
-- creación de las tablas de la base de datos

-- tabla usuario
CREATE TABLE usuario (
    Idusuario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Cedula VARCHAR(20) UNIQUE NOT NULL,
    Nombre_usuario VARCHAR(50)NOT NULL,
    Correo VARCHAR(50) UNIQUE NOT NULL,
    Contrasena VARCHAR(50) NOT NULL,
	Rol ENUM('Admin', 'Usuario') NOT NULL
);

-- tabla tipo de solicitud
CREATE TABLE tipoSolicitud (
    IdTipoSolicitud INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(50) UNIQUE NOT NULL
);

-- tabla solicitud
CREATE TABLE Solicitud (
    IdSolicitud INT PRIMARY KEY AUTO_INCREMENT,
    IdUsuario INT NOT NULL,
    IdTipoSolicitud INT NOT NULL,
    Titulo VARCHAR(100) NOT NULL,
    Mensaje TEXT NOT NULL,
    Archivo BLOB,
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Estado ENUM('Sin revisar', 'Revisado') NOT NULL,
    Respuesta TEXT,
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(Idusuario) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (IdTipoSolicitud) REFERENCES tipoSolicitud(IdTipoSolicitud)
);

