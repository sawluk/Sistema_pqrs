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
	Rol ENUM('Admin', 'Usuario') NOT NULL DEFAULT 'Usuario'
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
    ruta_archivo VARCHAR(255),
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Estado ENUM('Sin revisar', 'Revisado') DEFAULT 'Sin revisar' NOT NULL,
    Respuesta TEXT,
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(Idusuario) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (IdTipoSolicitud) REFERENCES tipoSolicitud(IdTipoSolicitud) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Procedimiento de almacenado tabla usuario
DELIMITER //
CREATE PROCEDURE RegistrarUsuario(
    IN p_cedula VARCHAR(20),
    IN p_nombre_usuario VARCHAR(50),
    IN p_correo VARCHAR(50),
    IN p_contrasena VARCHAR(50)
)
BEGIN
    INSERT INTO usuario (Cedula, Nombre_usuario, Correo, Contrasena)
    VALUES (p_cedula, p_nombre_usuario, p_correo, p_contrasena);
END //
DELIMITER ;


-- Procedimiento para editar un usuario

DELIMITER //
CREATE PROCEDURE EditarUsuario (
    IN p_Idusuario INT,
    IN p_Cedula VARCHAR(20),
    IN p_Nombre_usuario VARCHAR(50),
    IN p_Correo VARCHAR(50),
    IN p_Contrasena VARCHAR(50)
)
BEGIN
    UPDATE usuario
    SET Cedula = p_Cedula,
        Nombre_usuario = p_Nombre_usuario,
        Correo = p_Correo,
        Contrasena = p_Contrasena
    WHERE Idusuario = p_Idusuario;
END //

DELIMITER ;

DELIMITER //

-- procedimiento para eliminar un usuario

CREATE PROCEDURE EliminarUsuario (
    IN p_IdUsuario INT
)
BEGIN
    DELETE FROM usuario WHERE Idusuario = p_idUsuario;
END //

DELIMITER ;

-- procedimiento para agregar solicitudes

DELIMITER //

CREATE PROCEDURE InsertarSolicitud(
    IN p_idUsuario INT,
    IN p_idtipoSolicitud INT,
    IN p_titulo VARCHAR(255),
    IN p_mensaje TEXT,
    IN p_rutaArchivo VARCHAR(255),
    IN p_fechaSolicitud DATETIME
)
BEGIN
    -- Insertar una nueva solicitud con los parámetros proporcionados
    INSERT INTO solicitud (IdUsuario, IdtipoSolicitud, Titulo, Mensaje, ruta_archivo, FechaSolicitud)
    VALUES (p_idUsuario, p_idtipoSolicitud, p_titulo, p_mensaje, p_rutaArchivo, p_fechaSolicitud);
END //

DELIMITER ;

-- Procedimiento para editar las solicitudes

DELIMITER //

CREATE PROCEDURE EditarSolicitud(
    IN p_IdSolicitud INT,
    IN p_Titulo VARCHAR(100),
    IN p_Mensaje TEXT,
    IN p_RutaArchivo VARCHAR(255),
    IN p_Estado ENUM('Sin revisar', 'Revisado'),
    IN p_Respuesta TEXT,
    IN p_TipoSolicitud INT
)
BEGIN
    UPDATE Solicitud
    SET
        Titulo = p_Titulo,
        Mensaje = p_Mensaje,
        ruta_archivo = p_RutaArchivo,
        Estado = p_Estado,
        Respuesta = p_Respuesta,
        IdTipoSolicitud = p_TipoSolicitud  -- Agregado para actualizar el tipo de solicitud
    WHERE
        IdSolicitud = p_IdSolicitud;
END //

DELIMITER ;

-- procedimiento para Eliminar una solicitud
DELIMITER //

CREATE PROCEDURE EliminarSolicitud(
    IN p_IdSolicitud INT
)
BEGIN
    DELETE FROM Solicitud
    WHERE IdSolicitud = p_IdSolicitud;
END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE Respuesta(
    IN p_IdSolicitud INT,
    IN p_Respuesta TEXT
)
BEGIN
    UPDATE Solicitud 
    SET Estado = 'Revisado', Respuesta = p_Respuesta
    WHERE IdSolicitud = p_IdSolicitud;
END; //
DELIMITER ;


INSERT INTO usuario (Cedula, Nombre_usuario, Correo, Contrasena, Rol) 
VALUES 
('1', 'Alejandro', 'cecilceil110@gmail.com', '1', 'Admin'),
('123', 'David', 'davidnoguera0912@gmail.com', '123', 'Usuario'),
('123456', 'Jorge', 'JorgeO@gmail.com', 'jorge456', 'Usuario');

INSERT INTO tipoSolicitud (tipo) VALUES
('Pregunta'),
('Queja'),
('Reclamo'),
('Sugerencia'),
('Felicitacion');

INSERT INTO Solicitud (IdUsuario, IdTipoSolicitud, Titulo, Mensaje, ruta_archivo)
VALUES 
    (2, 1, 'Consulta sobre el funcionamiento', 'Tengo una pregunta sobre cómo utilizar cierta funcionalidad del sistema.', NULL),
    (2, 2, 'Queja sobre el servicio', 'He experimentado problemas con la lentitud del sistema.', NULL),
    (2, 4, 'Sugerencia para mejorar la interfaz', 'Creo que sería útil agregar un botón de acceso rápido en la página principal.', NULL);













