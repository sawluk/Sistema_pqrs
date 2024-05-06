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

<style>
        /* Estilos para el footer */
        footer {
            position: fixed;
            bottom: 0;
            width: 100%;
            height: 5%;
            z-index: 1000; /* Asegura que esté al frente de otros elementos */
            background-color: #000;
            color: #fff;
            text-align: center;
            padding: 15px 0;
        }

        
    </style>
<!-- Header-->
<header class="masthead text-center text-white" style="background-color: #2196F3;"> <!-- Azul -->
    <div class="masthead-content">
        <div class="container px-5">
            <h2> Tus solicitudes en un solo lugar</h2>
            <h2>Un administrador las respondará tan pronto como sea posible...</h2>
        </div>
    </div>
    <div class="bg-circle-1 bg-circle" style="background-color: #64B5F6;"></div> <!-- Azul claro -->
    <div class="bg-circle-2 bg-circle" style="background-color: #1976D2;"></div> <!-- Azul oscuro -->
    <div class="bg-circle-3 bg-circle" style="background-color: #1565C0;"></div> <!-- Azul más oscuro -->
    <div class="bg-circle-4 bg-circle" style="background-color: #0D47A1;"></div> <!-- Azul aún más oscuro -->
</header>

<!-- Content section 1-->
<section id="scroll">
    <h2 style=" text-align: center">Solicitudes enviadas</h2>
        <div class="row gx-5 align-items-center">
            <div class="container p-4 d-flex justify-content-center">
                <div class="col-md-8">
                    <table id="solicitudesTable" class="table table-bordered table-dark">
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
                                    String sql = "SELECT Titulo, Mensaje, tipo, Fecha, ruta_archivo, Respuesta, Estado "
                                            + "FROM solicitud "
                                            + "INNER JOIN tiposolicitud ON solicitud.IdTipoSolicitud = tiposolicitud.IdTipoSolicitud "
                                            + "WHERE IdUsuario = ? ORDER BY Fecha DESC";

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
                                <td><%= titulo%></td>
                                <td><%= tipoSolicitud%></td>
                                <td><%= mensaje%></td>
                                <td><%= archivo%></td>
                                <td><%= fechaSolicitud%></td>
                                <td><%= estado%></td>
                                <td><%= respuesta%></td>
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
        </div>
</section>
</body>

<!-- Footer-->
<footer class="py-5 bg-black">
    <div class="container px-5">
        <p class="m-0 text-center text-white small">Copyright &copy; Boostrap Wonder Pages/ Editado por Samuel Bolaños y Portilla</p>
    </div>
</footer>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="js/scripts.js"></script>


</html>