<%@page import="com.mycompany.SistemaPQRS.SistemaPQRS"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@include file= "templates/headerAdmin.jsp" %>


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
                                String sql = "SELECT s.IdSolicitud, s.Titulo, s.Mensaje, u.Nombre_usuario AS NombreUsuario, ts.tipo AS TipoSolicitud, s.Fecha, s.ruta_archivo "
                                        + "FROM Solicitud s "
                                        + "INNER JOIN usuario u ON s.IdUsuario = u.Idusuario "
                                        + "INNER JOIN tipoSolicitud ts ON s.IdTipoSolicitud = ts.IdTipoSolicitud "
                                        + "ORDER BY s.IdSolicitud ASC";

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
                            <td><%= idsolicitud%></td>
                            <td><%= tipoSolicitud%></td> <!-- Utilizar la variable tipoSolicitud en lugar de idtipo -->
                            <td><%= nombreUsuario%></td> <!-- Utilizar la variable nombreUsuario en lugar de idusuario -->
                            <td><%= titulo%></td>
                            <td><%= mensaje%></td>
                            <td><% if (archivo != null) { %>
                                    <a href="archivos/<%= archivo %>" target="_blank" class="btn btn-primary">
                                        <i class="fas fa-file-download"></i> Abrir PDF
                                    </a>
                                    <% } else { %>
                                    <!-- Botón deshabilitado si archivo es null -->
                                    <button class="btn btn-primary" disabled>
                                        <i class="fas fa-file-download"></i> Abrir PDF
                                    </button>
                                    <% } %>
                            </td>
                            <td><%= fecha%></td>
                            <td>
                                <!-- Botones de edición y eliminación -->
                                <div class="btn-group" role="group" aria-label="Acciones">
                                    <a href="#" class="btn btn-primary btn-sm" title="Responder solicitud" data-toggle="modal" data-target="#modalRespuesta" onclick="abrirModalRespuesta()">
                                        <i class="fas fa-reply"></i> Responder
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

    <!-- Ventana modal para el formulario de respuesta -->
<div class="modal fade" id="modalRespuesta" tabindex="-1" role="dialog" aria-labelledby="modalRespuestaLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalRespuestaLabel">Responder solicitud</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="SvRespuesta" method="POST" id="formularioRespuesta">
                    <div class="form-group">
                        <label for="respuesta">Respuesta:</label>
                        <textarea class="form-control" id="respuesta" name="respuesta" rows="4" cols="50"></textarea>
                    </div>
                    <!-- Campo oculto para el ID del usuario obtenido de la sesión -->
                            <input type="hidden" name="idUsuario" value="<%= session.getAttribute("idSolicitud")%>">
                    <!-- Botón de enviar dentro del formulario -->
                    <button type="submit" class="btn btn-primary">Enviar</button>
                </form>
            </div>
        </div>
    </div>
</div>
    <script>
        function abrirModalRespuesta() {
            $('#modalRespuesta').modal('show');
        }

    </script>

</section>