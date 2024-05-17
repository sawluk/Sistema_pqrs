/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.SistemaPQRS;

import java.sql.CallableStatement;
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
                String sql = "SELECT Idusuario, Rol, Nombre_usuario,Correo,Contrasena FROM usuario WHERE Cedula = ? AND Contrasena = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, cedula);
                pstmt.setString(2, contrasena);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    // Si las credenciales son válidas, obtener el id, rol y nombre del usuario
                    int idUsuario = rs.getInt("Idusuario");
                    String rol = rs.getString("Rol");
                    String nombre = rs.getString("Nombre_usuario");
                    String correo = rs.getString("Correo");
                    datosUsuario = new String[]{String.valueOf(idUsuario), rol, nombre, cedula, correo, contrasena};
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
    
    /**
     * Metodo para editar un usuario
     * @param idusuario
     * @param cedula
     * @param nombre
     * @param correo
     * @param contrasena 
     */
    public void editarUsuario(int idusuario, String cedula, String nombre, String correo, String contrasena) {
        // Establecer la conexión a la base de datos
    SistemaPQRS conectar = new SistemaPQRS();
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        conn = conectar.establecerConexion();

        // Preparar la consulta SQL para actualizar el usuario
        String sql = "UPDATE usuario SET Cedula = ?, Nombre_usuario = ?, Correo = ?, Contrasena = ? WHERE Idusuario = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, cedula);
        stmt.setString(2, nombre);
        stmt.setString(3, correo);
        stmt.setString(4, contrasena);
        stmt.setInt(5, idusuario);

        // Ejecutar la consulta para actualizar el usuario
        stmt.executeUpdate();

        // Imprimir mensaje de éxito
        System.out.println("Usuario editado");

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
    /**
     * Metodo para eliminar un usuario
     * @param idUsuario 
     */
    public void eliminarUsuario(int idUsuario) {
        Connection conn = establecerConexion();
        CallableStatement cs = null;

        try {
            cs = conn.prepareCall("DELETE FROM usuario WHERE Idusuario = ?");
            cs.setInt(1, idUsuario);
            cs.execute();
            System.out.println("Usuario eliminado ");
        } catch (SQLException e) {
            System.out.println("Error al borrar el usuario: " + e.getMessage());
        } finally {
            try {
                if (cs != null) {
                    cs.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error al cerrar la conexión: " + ex.getMessage());
            }
        }
    }

}
