/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.SistemaPQRS;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Acer
 */
public class SistemaPQRS {

    /**
     * Metodo para establecer la conexion a la base de datos
     *
     * @return
     */
    public Connection establecerConexion() {
        String url = "jdbc:mysql://localhost:3306/sistema_pqrs?serverTimeZone=utc";
        String user = "root"; // Nombre de usuario correcto
        String password = "ingsistemas"; // Contraseña de tu base de datos, si la tienes
        Connection conn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            if (conn != null) {
                System.out.println("Conexion exitosa");
            }
        } catch (Exception e) {
            System.out.println("Error de conexion" + e.getMessage());
        }
        return conn;
    }

    /**
     * Metodo que registra al usuario en el sistema
     *
     * @param cedula
     * @param nombre
     * @param correo
     * @param contrasena
     */

    public void registrarUsuario(String cedula, String nombre, String correo, String contrasena) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        conn = establecerConexion();
        try {
            if (conn != null) {
                String sqlConsulta = "SELECT COUNT(*) AS cantidad FROM usuario WHERE Cedula = ?";
                PreparedStatement stmtConsulta = conn.prepareStatement(sqlConsulta);
                stmtConsulta.setString(1, cedula);
                rs = stmtConsulta.executeQuery();
                if (rs.next()) {
                    int cantidad = rs.getInt("cantidad");
                    if (cantidad > 0) {
                        System.err.println("La cédula ya está registrada en el sistema.");
                        return;
                    }
                }
                String sql = "INSERT INTO usuario (Cedula, Nombre_usuario, Correo, Contrasena) VALUES (?, ?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, cedula);
                stmt.setString(2, nombre);
                stmt.setString(3, correo);
                stmt.setString(4, contrasena);
                stmt.executeUpdate();
                System.out.println("Usuario registrado exitosamente.");
            } else {
                System.err.println("No se pudo establecer la conexión con la base de datos.");
            }
        } catch (SQLException e) {
            System.err.println("Error al registrar usuario: " + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                System.err.println("Error al cerrar el ResultSet: " + e.getMessage());
            }
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

    /**
     * Metodo que valida al usuario para ingresar al sistema
     *
     * @param cedula
     * @param contrasena
     * @return boolean usuarioValido
     */
    public String[] ingresar(String cedula, String contrasena) {
        Connection conn = establecerConexion();
        String[] datosUsuario = null;

        try {
            if (conn != null) {
                String sql = "SELECT Idusuario, Rol, Nombre_usuario FROM usuario WHERE Cedula = ? AND Contrasena = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, cedula);
                pstmt.setString(2, contrasena);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    // Si las credenciales son válidas, obtener el id, rol y nombre del usuario
                    int idUsuario = rs.getInt("Idusuario");
                    String rol = rs.getString("Rol");
                    String nombre = rs.getString("Nombre_usuario");
                    datosUsuario = new String[]{String.valueOf(idUsuario), rol, nombre};
                }

                rs.close();
                pstmt.close();
                conn.close();
            } else {
                System.out.println("La conexión a la base de datos es nula.");
            }
        } catch (SQLException e) {
            System.out.println("Error al iniciar sesión: " + e.getMessage());
        }

        return datosUsuario;
    }

}
