<%-- 
    Document   : peticiones
    Created on : 2/05/2024, 5:27:48 p. m.
    Author     : Acer
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.mycompany.sistema_pqrs.Sistema_PQRS"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file= "templates/header.jsp" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
// Declarar las variables fuera del bloque try
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
%>
<div class="container p-4 d-flex justify-content-center">
    <div class="col-md-8">
        <table id="tutorialesTable" class="table table-bordered table-dark">
            <thead>
            
            <div class="input-group mb-3">

                <div class="input-group-append" style="margin-left: 10px;">
                    <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Peticiones
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1" style="padding: 10px;">
                        <li><a class="dropdown-item" href="#" data-categoria="0">Todas las peticiones</a></li>
                            <%
                                try {
                                    Sistema_PQRS conectar = new Sistema_PQRS();
                                    conn = conectar.establecerConexion();
                                    String sql = "SELECT idPeticion, peticion FROM Peticion";
                                    stmt = conn.prepareStatement(sql);
                                    rs = stmt.executeQuery();
                                    while (rs.next()) {
                                        int idCategoria = rs.getInt("idPeticion");
                                        String categoria = rs.getString("Peticion");
                            %>
                        <li><a class="dropdown-item" href="#" data-categoria="<%= idCategoria%>"><%= categoria%></a></li>
                            <%
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            %>
                    </ul>
                </div>
            </div>


            <tr>
                <th>ID</th>
                <th>Titulo</th>
                <th>Mensaje</th>
                <th>Archivo</th>
                <th>fechaSolicitud</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
                <%
                    try {

                        // Obtener la conexión a la base de datos
                        Sistema_PQRS conectar = new Sistema_PQRS();
                        conn = conectar.establecerConexion();

                        // Crear una declaración para la consulta
                        String sql = "SELECT idTutorial, titulo, prioridad, url, estado, categoria "
                                + "FROM tutoriales "
                                + "INNER JOIN categorias ON tutoriales.idCategoria = categorias.idCategoria";
                        stmt = conn.prepareStatement(sql);
                        rs = stmt.executeQuery();

                        // Iterar sobre el conjunto de resultados y mostrar cada fila en la tabla
                        while (rs.next()) {
                            int idTutorial = rs.getInt("idTutorial");
                            String titulo = rs.getString("titulo");
                            int prioridad = rs.getInt("prioridad");
                            String url = rs.getString("url");
                            String estado = rs.getString("estado");
                            String categoria = rs.getString("categoria");
                %>
                <tr>
                    <td><%= idTutorial%></td>
                    <td><%= titulo%></td>
                    <td><%= prioridad%></td>
                    <td><a href="<%= url%>" target="_blank"><i class="fas fa-eye"></i></a></td>
                    <td><%= estado%></td>
                    <td><%= categoria%></td>
                    <td>
                        <!-- Botón de edición -->
                        <div class="btn-group" role="group" aria-label="Acciones">
                            <!-- Botón de edición -->
                            <a href="#" class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#editModal" title="Editar"
                               data-id="<%= idTutorial%>"
                               data-titulo="<%= titulo%>"
                               data-prioridad="<%= prioridad%>"
                               data-url="<%= url%>"
                               data-estado="<%= estado%>"
                               data-categoria="<%= categoria%>">
                                <i class="fas fa-edit"></i> 
                            </a>
                            <a href="#" title="Eliminar" class="btn btn-danger btn-sm" onclick="confirmarEliminacion(<%= idTutorial%>)">
                                <i class="fas fa-trash"></i> 
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
                %>
            </tbody>
        </table>
    </div>
</div>

    </body>
</html>
