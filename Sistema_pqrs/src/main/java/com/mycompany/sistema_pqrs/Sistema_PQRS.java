/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.sistema_pqrs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Acer
 */
public class Sistema_PQRS {
    
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
     * metodo que Registra al usuario en el sistema
     * @param cedula
     * @param nombre
     * @param correo
     * @param contrasena
     * @param rol 
     */
    
    public void registrarUsuario(String cedula, String nombre, String correo, String contrasena, String rol) {
    Connection conn = null;
    PreparedStatement stmt = null;
    //llamamos al metodo para conectar a la base de datos
    conn = establecerConexion();
    try {
        
        if (conn != null) { // Verificar si hay conexión a la base de datos para hacer el registro del usuario
            
            // Definir la consulta SQL para insertar un nuevo usuario
            String sql = "INSERT INTO usuario (Cedula, Nombre_usuario, Correo, Contrasena, Rol) VALUES (?, ?, ?, ?, ?)";

            // Preparar la declaración
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, cedula);
            stmt.setString(2, nombre);
            stmt.setString(3, correo);
            stmt.setString(4, contrasena);
            stmt.setString(5, rol);

            // Ejecutar la consulta
            stmt.executeUpdate();

            System.out.println("Usuario registrado exitosamente.");
        } else {
            System.err.println("No se pudo establecer la conexión con la base de datos.");
        }
    } catch (SQLException e) {
        System.err.println("Error al registrar usuario: " + e.getMessage());
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
    /**
     * 
     * @param 
     * @param contrasena
     * @return 
     */
    
    public boolean validarUsuario(String cedula, String contrasena) {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    boolean usuarioValido = false;
    
    // Establecer la conexión a la base de datos
    conn = establecerConexion();  
    
    // Si hay conexión a la base de datos, se ejecuta la consulta
    if(conn != null) {
        try {
            // Consulta para verificar si el usuario está registrado
            String consultaUsuario = "SELECT * FROM Usuario WHERE Cedula = ? AND Contrasena = ?";
            stmt = conn.prepareStatement(consultaUsuario);
            stmt.setString(1, cedula);
            stmt.setString(2, contrasena);
            rs = stmt.executeQuery();

            // Verificar si se encontró al usuario
            usuarioValido = rs.next();
        } catch (SQLException e) {
            // Manejar cualquier error de SQL
            e.printStackTrace();
        } finally {
            // Cerrar la conexión y liberar recursos
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    return usuarioValido;
}

    /**
     * 
     * @param nombreUsuario
     * @param contrasena
     * @return 
     */
    
    public String obtenerRolUsuario(String cedula, String contrasena) {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String rol = null;

    // Validar si el usuario está registrado en la base de datos
    if (validarUsuario(cedula, contrasena)) {
        // Establecer la conexión a la base de datos
        conn = establecerConexion();
        try {
            // Si hay conexión a la base de datos, se ejecuta la consulta
            if(conn != null){
                // Consulta para obtener el rol del usuario
                String consultaRol = "SELECT Rol FROM Usuario WHERE Cedula = ?";
                stmt = conn.prepareStatement(consultaRol);
                stmt.setString(1, cedula);
                rs = stmt.executeQuery();

                // Obtener el rol del usuario
                if (rs.next()) {
                    rol = rs.getString("Rol");
                } else {
                    rol = "Rol no encontrado";
                } 
            }
            
        } catch (SQLException e) {
            // Manejar cualquier error de SQL
            e.printStackTrace();
            rol = "Error de SQL: " + e.getMessage();
        } finally {
            // Cerrar la conexión y liberar recursos
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return rol;
    } else { // El usuario no está registrado en la base de datos
        return "Usuario no encontrado";
    }
}

}
