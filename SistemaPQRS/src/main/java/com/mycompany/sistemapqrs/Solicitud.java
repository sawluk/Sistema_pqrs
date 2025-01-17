/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.SistemaPQRS;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * Samuel Bolaños y Alejandro Portilla
 *
 * @author Acer
 */
public class Solicitud {

    /**
     * Metodo para crear una nueva solicitud PQRS
     *
     * @param p_IdUsuario
     * @param p_IdTipoSolicitud
     * @param p_Titulo
     * @param p_Mensaje
     * @param pdf
     * @param p_FechaSolicitud
     */
    public static void crearSolicitud(int p_IdUsuario, int p_IdTipoSolicitud, String p_Titulo, String p_Mensaje, String pdf, LocalDateTime p_FechaSolicitud) {
        SistemaPQRS conectar = new SistemaPQRS();
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Obtener conexión a la base de datos
            conn = conectar.establecerConexion();
            // Preparar la consulta SQL para añadir una solicitud
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

    /**
     * Metodo para editar una solicitud PQRS
     *
     * @param p_IdSolicitud
     * @param p_Titulo
     * @param p_Mensaje
     * @param p_RutaArchivo
     * @param p_Estado
     * @param p_Respuesta
     * @param p_TipoSolicitud
     */
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

    /**
     * Metodo para eliminar una solicitud PQRS de la base de datos
     *
     * @param p_IdSolicitud
     */
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

    /**
     * Metodo para actualizar una solicitud en la base de datos
     *
     * @param idSolicitud
     * @param respuesta
     */
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

    /**
     * Metodo que envia la respuesta del administrador a la solicitud PQRS del
     * usuario
     *
     * @param p_IdSolicitud
     * @param p_Respuesta
     */
    public static void respuesta(int p_IdSolicitud, String p_Respuesta) {
        SistemaPQRS conectar = new SistemaPQRS();
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Obtener conexión a la base de datos
            conn = conectar.establecerConexion();

            // Preparar la consulta SQL
            String sql = "UPDATE Solicitud SET Respuesta = ?, Estado = 'Revisado' WHERE IdSolicitud = ?";
            pstmt = conn.prepareStatement(sql);

            // Establecer los parámetros de la consulta
            pstmt.setString(1, p_Respuesta);
            pstmt.setInt(2, p_IdSolicitud);

            // Ejecutar la consulta
            pstmt.executeUpdate();

            // La solicitud ha sido atendida y marcada como revisada
            System.out.println("La solicitud ha sido atendida y marcada como revisada.");
        } catch (SQLException e) {
            // Manejar cualquier excepción SQL
            e.printStackTrace();
        } finally {
            // Cerrar la conexión y liberar los recursos
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * Metodo para enviar respuesta por correo a la solicitud PQRS del usuario
     *
     * @param para
     * @param asunto
     * @param texto
     */
    public static void enviarCorreo(String para, String asunto, String texto) {
        // Propiedades del servidor de correo Gmail
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Autenticación del correo
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("cecilceil110@gmail.com", "kmdt zxvv qvsb jiyk"); // Cambia esto por tu correo y contraseña
            }
        });

        // Composición del correo
        Message message = new MimeMessage(session);
        try {
            message.setFrom(new InternetAddress("cecilceil110@gmail.com")); // Cambia esto por tu correo
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(para));
            message.setSubject(asunto);
            message.setText(texto);

            // Envío del correo
            Transport.send(message);
        } catch (MessagingException e) {
            // Manejar cualquier excepción de envío de correo
            e.printStackTrace();
        }
    }
}
