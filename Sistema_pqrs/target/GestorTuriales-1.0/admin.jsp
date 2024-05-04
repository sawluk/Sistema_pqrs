<%-- 
    Document   : admin
    Created on : 28/04/2024, 5:25:38 p. m.
    Author     : Acer
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.mycompany.sistema_pqrs.SistemaPQRS"%>
<%@page import="java.sql.PreparedStatement"%>
<%@include file= "templates/header.jsp" %>
        <% String nombreUsuario = (String) session.getAttribute("nombre"); %>
    
    <%-- Verificar si el nombre de usuario está presente en la sesión --%>
    <% if (nombreUsuario != null && !nombreUsuario.isEmpty()) { %>
    <p style="text-align: center">¡Hola, administrador <%= nombreUsuario %>!</p>
    <% } else { %>
        <p>No se ha encontrado un nombre de usuario en la sesión.</p>
    <% } %>
    
    <h1 style="text-align: center">Usuarios Registrados</h1>
    <div class="container p-4 d-flex justify-content-center">
    <div class="col-md-8">
        <table id="tutorialesTable" class="table table-bordered table-dark">
            <thead>
        <tr>
            <th>Id Usuario</th>
            <th>Cedula</th>
            <th>Nombre</th>
            <th>Correo</th>
        </tr>
    </thead>
    <tbody>
        <%

// Importar las clases necesarias y establecer la conexión a la base de datos
PreparedStatement pstmt = null;
SistemaPQRS conectar = new SistemaPQRS();
Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;

try {
    conn = conectar.establecerConexion();

    // Actualizar la consulta SQL para filtrar por idUsuario y unir la tabla de tiposolicitud
String sql = "SELECT idusuario, Cedula, Nombre_usuario, Correo " +
             "FROM usuario " +
             "WHERE Rol = 'Usuario'";

    pstmt = conn.prepareStatement(sql);
    rs = pstmt.executeQuery();

    // Iterar a través del conjunto de resultados y mostrar cada solicitud en la tabla
    while (rs.next()) {
        String idusuario = rs.getString("idusuario");
        String cedula = rs.getString("Cedula");
        String nombre = rs.getString("Nombre_usuario");
        String correo = rs.getString("Correo");

%>

        <tr>
            <td><%= idusuario %></td>
            <td><%= cedula %></td>
            <td><%= nombre %></td>
            <td><%= correo %></td>
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
    
