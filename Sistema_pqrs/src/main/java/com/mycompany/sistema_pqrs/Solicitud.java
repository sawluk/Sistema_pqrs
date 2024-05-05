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
public class Solicitud {
    
    
    
    public static void crearSolicitud(int p_IdUsuario, int p_IdTipoSolicitud, String p_Titulo, String p_Mensaje, String p_RutaArchivo, LocalDateTime p_FechaSolicitud) {
        SistemaPQRS conectar = new SistemaPQRS();
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            // Obtener conexión a la base de datos
            
            conn = conectar.establecerConexion();

            // Preparar la consulta SQL
    String sql = "INSERT INTO Solicitud (IdUsuario, IdTipoSolicitud, Titulo, Mensaje, ruta_archivo) " +
                 "VALUES (?, ?, ?, ?, ?)";
    pstmt = conn.prepareStatement(sql);
    
    // Establecer los parámetros de la consulta
    pstmt.setInt(1, p_IdUsuario);
    pstmt.setInt(2, p_IdTipoSolicitud);
    pstmt.setString(3, p_Titulo);
    pstmt.setString(4, p_Mensaje);
    pstmt.setString(5, p_RutaArchivo);
    
    // Ejecutar la consulta
    pstmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Cerrar la conexión y liberar los recursos
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}