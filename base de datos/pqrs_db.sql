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
    Estado ENUM('Sin revisar', 'Revisado') DEFAULT 'Sin revisar' NOT NULL,
    Respuesta TEXT,
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(Idusuario) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (IdTipoSolicitud) REFERENCES tipoSolicitud(IdTipoSolicitud) ON DELETE CASCADE ON UPDATE CASCADE
);

DELIMITER //
CREATE PROCEDURE InsertarSolicitud (
    IN p_IdUsuario INT,                  
    IN p_IdTipoSolicitud INT,            
    IN p_Titulo VARCHAR(100),             
    IN p_Mensaje TEXT,                    
    IN p_Archivo BLOB,                    
    OUT p_IdSolicitud INT            
)
BEGIN
    -- Insertar una nueva solicitud en la tabla Solicitud
    INSERT INTO Solicitud (IdUsuario, IdTipoSolicitud, Titulo, Mensaje, Archivo)
    VALUES (p_IdUsuario, p_IdTipoSolicitud, p_Titulo, p_Mensaje, p_Archivo);
    
    -- Obtener el Id de la solicitud recién insertada
    SET p_IdSolicitud = LAST_INSERT_ID();
END //
DELIMITER ;

INSERT INTO TipoSolicitud (tipo) VALUES
('Pregunta'),
('Queja'),
('Reclamo'),
('Sugerencia'),
('Felicitacion');

-- Procedimiento de almacenado tabla usuario
DELIMITER //
-- Creamos el procedimiento almacenado para registrar un usuario
CREATE PROCEDURE RegistrarUsuario(
    -- Definimos los parámetros de entrada del procedimiento
    IN p_cedula VARCHAR(20),
    IN p_nombre_usuario VARCHAR(50),
    IN p_correo VARCHAR(50),
    IN p_contrasena VARCHAR(50),
    IN p_rol ENUM('Admin', 'Usuario')
)
BEGIN
    -- Iniciamos el bloque del procedimiento almacenado
    -- Insertamos un nuevo registro en la tabla usuario con los parámetros proporcionados
    INSERT INTO usuario (Cedula, Nombre_usuario, Correo, Contrasena, Rol)
    VALUES (p_cedula, p_nombre_usuario, p_correo, p_contrasena, p_rol);
-- Finalizamos el bloque del procedimiento almacenado
END //

DELIMITER ;
DELIMITER //
-- Procedimiento para editar los datos del usuario
CREATE PROCEDURE editarUsuario(
    IN p_Idusuario INT,
    IN p_Cedula VARCHAR(20),
    IN p_Nombre_usuario VARCHAR(50),
    IN p_Correo VARCHAR(50),
    IN p_Contrasena VARCHAR(50),
    IN p_Rol ENUM('Admin', 'Usuario')
)
BEGIN
    UPDATE usuario
    SET Cedula = p_Cedula,
        Nombre_usuario = p_Nombre_usuario,
        Correo = p_Correo,
        Contrasena = p_Contrasena,
        Rol = p_Rol
    WHERE Idusuario = p_Idusuario;
END //

DELIMITER ;


