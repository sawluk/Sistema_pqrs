/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.sistema_pqrs;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import javax.servlet.http.Part;

/**
 *
 * @author Acer
 */
public class Peticiones {
    
    Sistema_PQRS conectar = new Sistema_PQRS();
    
    public void almacenarDatosSolicitud( int idUsuario, int idtipoSolicitud, String titulo, String mensaje, String rutaArchivo , LocalDateTime fechaSolicitud) throws IOException {
    Connection conn = null;
    PreparedStatement stmt = null;
    try {
        // Llamamos al método para conectar a la base de datos
        conn = conectar.establecerConexion();
        
        if (conn != null) { // Verificar si hay conexión a la base de datos para hacer el registro de la solicitud
            
            // Preparar la llamada al procedimiento almacenado
            stmt = conn.prepareCall("{CALL InsertarSolicitud(?, ?, ?, ?, ?, ?)}");
            
            // Establecer los parámetros de entrada
            stmt.setInt(1, idUsuario);
            stmt.setInt(2, idtipoSolicitud);
            stmt.setString(3, titulo);
            stmt.setString(4, mensaje);
            stmt.setString(5, rutaArchivo);
            stmt.setObject(6, fechaSolicitud);
            //stmt.setBinaryStream(5, archivoStream.getInputStream());

            
            // Ejecutar el procedimiento almacenado
            stmt.execute();
            
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
