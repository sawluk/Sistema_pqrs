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
            <h2> Lista de solicitudes por revisar </h2>
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
                            <th>Nombre usuario</th>
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
                                String sql = "SELECT s.IdSolicitud, s.Titulo, s.Mensaje, u.Nombre_usuario AS NombreUsuario, ts.tipo AS TipoSolicitud, s.Fecha, s.ruta_archivo, s.Estado "
                                        + "FROM Solicitud s "
                                        + "INNER JOIN usuario u ON s.IdUsuario = u.Idusuario "
                                        + "INNER JOIN tipoSolicitud ts ON s.IdTipoSolicitud = ts.IdTipoSolicitud "
                                        + "WHERE s.Estado NOT IN ('Revisado') "
                                        + "ORDER BY s.IdSolicitud ASC";

                                pstmt = conn.prepareStatement(sql);
                                rs = pstmt.executeQuery();

                                // Iterar a través del conjunto de resultados y mostrar cada solicitud en la tabla
                                while (rs.next()) {
                                    String idSolicitud = rs.getString("IdSolicitud");
                                    String nombreUsuario = rs.getString("NombreUsuario");
                                    String tipoSolicitud = rs.getString("TipoSolicitud");
                                    String titulo = rs.getString("Titulo");
                                    String mensaje = rs.getString("Mensaje");
                                    String archivo = rs.getString("ruta_archivo");
                                    String fecha = rs.getString("Fecha");
                        %>




                        <tr>
                            <td><%= idSolicitud%></td>
                            <td><%= tipoSolicitud%></td> <!-- Utilizar la variable tipoSolicitud en lugar de idtipo -->
                            <td><%= nombreUsuario%></td> <!-- Utilizar la variable nombreUsuario en lugar de idusuario -->
                            <td><%= titulo%></td>
                            <td><%= mensaje%></td>
                            <td><% if (archivo != null) {%>
                                <a href="archivos/<%= archivo%>" target="_blank" class="btn btn-primary">
                                    <i class="fas fa-file-download"></i> Abrir PDF
                                </a>
                                <% } else { %>
                                <!-- Botón deshabilitado si archivo es null -->
                                <button class="btn btn-primary" disabled>
                                    <i class="fas fa-file-download"></i> Abrir PDF
                                </button>
                                <% }%>
                            </td>
                            <td><%= fecha%></td>
                            <td>
                                <!-- Botones de responder -->
                                <div class="btn-group" role="group" aria-label="Acciones">
                                    <a href="#" title="Dar respuesta" class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#respuestaModal" data-idsolicitud="<%= idSolicitud%>">
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

    <!-- Modal para dar respuesta -->
    <div class="modal fade" id="respuestaModal" tabindex="-1" aria-labelledby="respuestaModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="respuestaModalLabel">Responder Solicitud</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="SvRespuesta" method="POST" id="respuestaForm">
                        <div class="mb-3">
                            <label for="respuesta" class="form-label">Respuesta:</label>
                            <textarea class="form-control" id="respuesta" name="respuesta" rows="3" required></textarea>
                        </div>
                        <!-- Campo oculto para enviar el ID de la solicitud -->
                        <input type="hidden" id="idSolicitudInput" name="idSolicitud">
                        <!-- Campo oculto para cambiar el estado de la solicitud a "Revisado" -->
                        <input type="hidden" id="estadoInput" name="estado" value="Revisado">
                        <button type="submit" class="btn btn-primary">Enviar respuesta</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Capturar el evento de clic en el botón de respuesta
        $('.btn-success').click(function () {
            // Obtener los datos de la solicitud seleccionada
            var idSolicitud = $(this).data('idsolicitud');

            // Poner el ID de la solicitud en el campo oculto del formulario
            $('#idSolicitudInput').val(idSolicitud);

            // Mostrar el modal de respuesta
            $('#respuestaModal').modal('show');
        });
    </script>

</section>