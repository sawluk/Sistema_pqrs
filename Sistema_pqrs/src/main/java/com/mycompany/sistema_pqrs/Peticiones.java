/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.sistema_pqrs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;

/**
 *
 * @author Acer
 */
public class Peticiones {
    
    Sistema_PQRS conectar = new Sistema_PQRS();
    
    public void almacenarDatosSolicitud(String titulo, String mensaje, int idtipoSolicitud, int idUsuario, LocalDateTime fechaSolicitud, String rutaArchivo) {
    Connection conn = null;
    PreparedStatement stmt = null;
    try {
        // Llamamos al método para conectar a la base de datos
        conn = conectar.establecerConexion();
        
        if (conn != null) { // Verificar si hay conexión a la base de datos para hacer el registro de la solicitud
            
            // Definir la consulta SQL para insertar una nueva solicitud
            String sql = "INSERT INTO solicitudes (Titulo, Mensaje, idTipoSolicitud, IdUsuario, FechaSolicitud, RutaArchivo) VALUES (?, ?, ?, ?, ?, ?)";
            
            // Preparar la declaración
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, titulo);
            stmt.setString(2, mensaje);
            stmt.setInt(3, idtipoSolicitud);
            stmt.setInt(4, idUsuario);
            stmt.setObject(5, fechaSolicitud); // Usamos setObject para almacenar LocalDateTime en la base de datos
            stmt.setString(6, rutaArchivo);
            
            // Ejecutar la consulta
            stmt.executeUpdate();
            
            System.out.println("Solicitud almacenada exitosamente.");
        } else {
            System.err.println("No se pudo establecer la conexión con la base de datos.");
        }
    } catch (SQLException e) {
        System.err.println("Error al almacenar la solicitud: " + e.getMessage());
    } finally {
        // Cerrar la conexión y liberar recursos
        try {
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            System.err.println("Error al cerrar la conexión: " + e.getMessage());
        }
    }
}

}
