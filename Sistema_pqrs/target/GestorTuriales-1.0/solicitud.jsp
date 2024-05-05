<%-- 
    Document   : peticiones
    Created on : 2/05/2024, 5:27:48 p. m.
    Author     : Acer
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.mycompany.sistema_pqrs.SistemaPQRS"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file= "templates/header.jsp" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

<div class="container p-4 d-flex justify-content-center">
    <div class="col-md-8">
        <table id="tutorialesTable" class="table table-bordered table-dark">
            <thead>
        <tr>
            <th>Título</th>
            <th>Tipo</th>
            <th>Mensaje</th>
            <th>Archivo</th>
            <th>Fecha de Solicitud</th>
            <th>Estado</th>
            <th>Respuesta</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody>
        <%
// Obtener el ID de usuario de la sesión
String idUsuarioS = (String) session.getAttribute("idUsuario");
int idUsuario = Integer.parseInt(idUsuarioS);

// Importar las clases necesarias y establecer la conexión a la base de datos
PreparedStatement pstmt = null;
SistemaPQRS conectar = new SistemaPQRS();
Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;

try {
    conn = conectar.establecerConexion();

    // Actualizar la consulta SQL para filtrar por idUsuario y unir la tabla de tiposolicitud
    String sql = "SELECT Titulo, Mensaje, tipo, Fecha, ruta_archivo, Respuesta, Estado " +
             "FROM solicitud " +
             "INNER JOIN tiposolicitud ON solicitud.IdTipoSolicitud = tiposolicitud.IdTipoSolicitud " +
             "WHERE IdUsuario = ? ORDER BY Fecha DESC";


    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, idUsuario);
    rs = pstmt.executeQuery();

    // Iterar a través del conjunto de resultados y mostrar cada solicitud en la tabla
    while (rs.next()) {
        String titulo = rs.getString("Titulo");
        String mensaje = rs.getString("Mensaje");
        String tipoSolicitud = rs.getString("tipo");
        String fechaSolicitud = rs.getString("Fecha");
        String archivo = rs.getString("ruta_archivo");
        String respuesta = rs.getString("Respuesta");
        String estado = rs.getString("Estado");
%>



        <tr>
            <td><%= titulo %></td>
            <td><%= tipoSolicitud %></td>
            <td><%= mensaje %></td>
            <td><%= archivo %></td>
            <td><%= fechaSolicitud %></td>
            <td><%= estado %></td>
            <td><%= respuesta %></td>
            <td>
                <!-- Botones de edición y eliminación -->
                <div class="btn-group" role="group" aria-label="Acciones">
                    <a href="#" class="btn btn-success btn-sm" title="Editar" onclick="">
                        <i class="fas fa-edit"></i> Editar
                    </a>
                    <a href="#" class="btn btn-danger btn-sm" title="Eliminar" onclick="">
                        <i class="fas fa-trash"></i> Eliminar
                    </a>
                </div>
            </td>
        </tr>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                // Cerrar recursos
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </tbody>
        </table>
    </div>
</div>

    </body>
</html>
