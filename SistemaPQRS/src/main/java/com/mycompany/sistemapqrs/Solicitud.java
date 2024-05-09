/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.SistemaPQRS;


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

    public static void crearSolicitud(int p_IdUsuario, int p_IdTipoSolicitud, String p_Titulo, String p_Mensaje, String pdf, LocalDateTime p_FechaSolicitud) {
        SistemaPQRS conectar = new SistemaPQRS();
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Obtener conexión a la base de datos

            conn = conectar.establecerConexion();

            // Preparar la consulta SQL
            String sql = "INSERT INTO Solicitud (IdUsuario, IdTipoSolicitud, Titulo, Mensaje, ruta_archivo) "
                    + "VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);

            // Establecer los parámetros de la consulta
            pstmt.setInt(1, p_IdUsuario);
            pstmt.setInt(2, p_IdTipoSolicitud);
            pstmt.setString(3, p_Titulo);
            pstmt.setString(4, p_Mensaje);
            pstmt.setString(5, pdf);

            // Ejecutar la consulta
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Cerrar la conexión y liberar los recursos
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /// Método para editar una solicitud
    public static void editarSolicitud(int p_IdSolicitud, String p_Titulo, String p_Mensaje, String p_RutaArchivo, String p_Estado, String p_Respuesta, int p_TipoSolicitud) {
        // Establecer la conexión a la base de datos
        SistemaPQRS conectar = new SistemaPQRS();
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = conectar.establecerConexion();

            // Preparar la consulta SQL para actualizar la solicitud
            String sql = "UPDATE Solicitud SET Titulo = ?, Mensaje = ?, ruta_archivo = ?, Estado = ?, Respuesta = ?, IdTipoSolicitud = ? WHERE IdSolicitud = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, p_Titulo);
            stmt.setString(2, p_Mensaje);
            stmt.setString(3, p_RutaArchivo);
            stmt.setString(4, p_Estado);
            stmt.setString(5, p_Respuesta);
            stmt.setInt(6, p_TipoSolicitud);
            stmt.setInt(7, p_IdSolicitud);

            // Ejecutar la consulta para actualizar la solicitud
            stmt.executeUpdate();

            // Imprimir mensaje de éxito
            System.out.println("Solicitud editada correctamente.");

        } catch (SQLException se) {
            // Manejar cualquier excepción SQL
            se.printStackTrace();
        } catch (Exception e) {
            // Manejar otras excepciones
            e.printStackTrace();
        } finally {
            // Cerrar recursos
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (SQLException se2) {
                se2.printStackTrace();
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }

    public static void eliminarSolicitud(int p_IdSolicitud) {
        // Establecer la conexión a la base de datos
        SistemaPQRS conectar = new SistemaPQRS();
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = conectar.establecerConexion();

            // Preparar la consulta SQL para eliminar la solicitud por su ID
            String sql = "DELETE FROM Solicitud WHERE IdSolicitud = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, p_IdSolicitud);

            // Ejecutar la consulta para eliminar la solicitud
            pstmt.executeUpdate();

            // Imprimir mensaje de éxito
            System.out.println("Solicitud eliminada correctamente.");

        } catch (SQLException se) {
            // Manejar cualquier excepción SQL
            se.printStackTrace();
        } catch (Exception e) {
            // Manejar otras excepciones
            e.printStackTrace();
        } finally {
            // Cerrar recursos
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
            } catch (SQLException se2) {
                se2.printStackTrace();
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }

    public static void actualizarSolicitud(int idSolicitud, String respuesta) {
        // Configura la conexión con la base de datos
        SistemaPQRS conectar = new SistemaPQRS();
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = conectar.establecerConexion();
            
            // Llama al procedimiento almacenado
            String sql = "{call actualizarSolicitud(?, ?)}";
            pstmt = conn.prepareCall(sql);
            pstmt.setInt(1, idSolicitud);
            pstmt.setString(2, respuesta);
            pstmt.execute();
            
            System.out.println("Solicitud actualizada correctamente.");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Cierra la conexión y libera los recursos
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
