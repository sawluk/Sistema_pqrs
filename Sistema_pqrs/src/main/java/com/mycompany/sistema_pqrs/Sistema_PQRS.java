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
    
    public class NombreYRolUsuario {
    private String nombre;
    private String rol;
    
    public NombreYRolUsuario() {
    }
    
    public NombreYRolUsuario(String nombre, String rol) {
        this.nombre = nombre;
        this.rol = rol;
    }

    public String getNombre() {
        return nombre;
    }

    public String getRol() {
        return rol;
    }
}
    
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
    
    public NombreYRolUsuario obtenerInformacionUsuario(String cedula, String contrasena) {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    NombreYRolUsuario informacionUsuario = null;

    // Validar si el usuario está registrado en la base de datos
    if (validarUsuario(cedula, contrasena)) {
        // Establecer la conexión a la base de datos
        conn = establecerConexion();
        try {
            // Si hay conexión a la base de datos, se ejecuta la consulta
            if (conn != null) {
                // Consulta para obtener el nombre y el rol del usuario
                String consultaUsuario = "SELECT Nombre_usuario, Rol FROM Usuario WHERE Cedula = ?";
                stmt = conn.prepareStatement(consultaUsuario);
                stmt.setString(1, cedula);
                rs = stmt.executeQuery();

                // Obtener el nombre y el rol del usuario
                if (rs.next()) {
                    String nombre = rs.getString("Nombre_usuario");
                    String rol = rs.getString("Rol");
                    informacionUsuario = new NombreYRolUsuario(nombre, rol);
                } else {
                    // En caso de que no se encuentre el usuario, se asigna un valor por defecto
                    informacionUsuario = new NombreYRolUsuario("Usuario no encontrado", "Rol no encontrado");
                }
            }
        } catch (SQLException e) {
            // Manejar cualquier error de SQL
            e.printStackTrace();
            informacionUsuario = new NombreYRolUsuario("Error de SQL", "Error de SQL");
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
    } else { // El usuario no está registrado en la base de datos
        // En caso de que no se encuentre el usuario, se asigna un valor por defecto
        informacionUsuario = new NombreYRolUsuario("Usuario no encontrado", "Rol no encontrado");
    }

    return informacionUsuario;
}


}
