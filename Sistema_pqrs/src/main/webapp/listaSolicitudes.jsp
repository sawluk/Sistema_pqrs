<%@page import="java.sql.SQLException"%>
<%@page import="com.mycompany.sistema_pqrs.SistemaPQRS"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@include file= "templates/headeradmin.jsp" %>


<!-- Header-->
<header class="masthead text-center text-white" style="background-color: #2196F3;"> <!-- Azul -->
    <div class="masthead-content">
        <div class="container px-5">
            <h2> Lista de solicitudes </h2>
        </div>
    </div>
    <div class="bg-circle-1 bg-circle" style="background-color: #64B5F6;"></div> <!-- Azul claro -->
    <div class="bg-circle-2 bg-circle" style="background-color: #1976D2;"></div> <!-- Azul oscuro -->
    <div class="bg-circle-3 bg-circle" style="background-color: #1565C0;"></div> <!-- Azul más oscuro -->
    <div class="bg-circle-4 bg-circle" style="background-color: #0D47A1;"></div> <!-- Azul aún más oscuro -->
</header>

<section id="scroll">
    <div class="container px-5">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <table id="tutorialesTable" class="table table-bordered table-dark">
                    <thead>
                        <tr>
                            <th>ID Solicitud</th>
                            <th>Tipo solicitud</th>
                            <th>Usuario</th>
                            <th>Titulo</th>
                            <th>Mensaje</th>
                            <th>Archivo</th>
                            <th>Fecha</th>
                            <th>Acciones</th>
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
                                String sql = "SELECT s.IdSolicitud, s.Titulo, s.Mensaje, u.Nombre_usuario AS NombreUsuario, ts.tipo AS TipoSolicitud, s.Fecha, s.ruta_archivo " +
                                             "FROM Solicitud s " +
                                             "INNER JOIN usuario u ON s.IdUsuario = u.Idusuario " +
                                             "INNER JOIN tipoSolicitud ts ON s.IdTipoSolicitud = ts.IdTipoSolicitud " +
                                             "ORDER BY s.IdSolicitud ASC";

                                pstmt = conn.prepareStatement(sql);
                                rs = pstmt.executeQuery();

                                // Iterar a través del conjunto de resultados y mostrar cada solicitud en la tabla
                                while (rs.next()) {
                                    String idsolicitud = rs.getString("IdSolicitud");
                                    String nombreUsuario = rs.getString("NombreUsuario");
                                    String tipoSolicitud = rs.getString("TipoSolicitud");
                                    String titulo = rs.getString("Titulo");
                                    String mensaje = rs.getString("Mensaje");
                                    String archivo = rs.getString("ruta_archivo");
                                    String fecha = rs.getString("Fecha");
                        %>




                        <tr>
                            <td><%= idsolicitud %></td>
                            <td><%= tipoSolicitud %></td> <!-- Utilizar la variable tipoSolicitud en lugar de idtipo -->
                            <td><%= nombreUsuario %></td> <!-- Utilizar la variable nombreUsuario en lugar de idusuario -->
                            <td><%= titulo %></td>
                            <td><%= mensaje %></td>
                            <td><%= archivo %></td>
                            <td><%= fecha %></td>
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