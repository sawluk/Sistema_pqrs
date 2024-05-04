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

/**
 * Metodo para establecer la conexion a la base de datos
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
            if(rs.next()) {
                int cantidad = rs.getInt("cantidad");
                if(cantidad > 0) {
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
     * @param cedula
     * @param contrasena
     * @return boolean usuarioValido
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
     * @param cedula
     * @param contrasena
     * @return 
     */
    
    public String[] obtenerInformacionUsuario(String cedula, String contrasena) {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String[] informacionUsuario = null;

    // Establecer la conexión a la base de datos
    conn = establecerConexion();
    //validamos al usuario si esta registrado en la base de datos
    if(validarUsuario(cedula, contrasena)){
        try {
        // Si hay conexión a la base de datos, se ejecuta la consulta
        if (conn != null) {
            // Consulta para obtener el ID, nombre y el rol del usuario
            String consultaUsuario = "SELECT Idusuario, Nombre_usuario, Rol FROM Usuario WHERE Cedula = ? AND Contrasena = ?";
            stmt = conn.prepareStatement(consultaUsuario);
            stmt.setString(1, cedula);
            stmt.setString(2, contrasena);
            rs = stmt.executeQuery();

            // Obtener el ID, nombre y el rol del usuario
            if (rs.next()) {
                int idUsuario = rs.getInt("Idusuario");
                String nombre = rs.getString("Nombre_usuario");
                String rol = rs.getString("Rol");
                
                // Construir el arreglo de datos del usuario
                informacionUsuario = new String[]{String.valueOf(idUsuario), nombre, rol};
            }
        }
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
    
    return informacionUsuario;
}

}
