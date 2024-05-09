<%-- 
    Document   : peticiones
    Created on : 2/05/2024, 5:27:48 p.?m.
    Author     : Acer
--%>

<%@page import="com.mycompany.SistemaPQRS.SistemaPQRS"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>

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
        z-index: 1000; /* Asegura que est? al frente de otros elementos */
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
            <h2>Un administrador las respondera tan pronto como sea posible...</h2>
        </div>
    </div>
    <div class="bg-circle-1 bg-circle" style="background-color: #64B5F6;"></div> <!-- Azul claro -->
    <div class="bg-circle-2 bg-circle" style="background-color: #1976D2;"></div> <!-- Azul oscuro -->
    <div class="bg-circle-3 bg-circle" style="background-color: #1565C0;"></div> <!-- Azul m?s oscuro -->
    <div class="bg-circle-4 bg-circle" style="background-color: #0D47A1;"></div> <!-- Azul a?n m?s oscuro -->
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
                            <th>Titulo</th>
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
                          // Obtener el ID de usuario de la sesi?n
                          String idUsuarioS = (String) session.getAttribute("idUsuario");
                          int idUsuario = Integer.parseInt(idUsuarioS);

                          // Importar las clases necesarias y establecer la conexi?n a la base de datos
                          PreparedStatement pstmt = null;
                          SistemaPQRS conectar = new SistemaPQRS();
                          Connection conn = null;
                          PreparedStatement stmt = null;
                          ResultSet rs = null;

                          try {
                              conn = conectar.establecerConexion();

                              // Actualizar la consulta SQL para filtrar por idUsuario y unir la tabla de tiposolicitud
                              String sql = "SELECT IdSolicitud, Titulo, Mensaje, tipo, Fecha, ruta_archivo, Respuesta, Estado "
                                      + "FROM solicitud "
                                      + "INNER JOIN tiposolicitud ON solicitud.IdTipoSolicitud = tiposolicitud.IdTipoSolicitud "
                                      + "WHERE IdUsuario = ? ORDER BY Fecha ASC";

                              pstmt = conn.prepareStatement(sql);
                              pstmt.setInt(1, idUsuario);
                              rs = pstmt.executeQuery();

                              // Iterar a trav?s del conjunto de resultados y mostrar cada solicitud en la tabla
                              while (rs.next()) {
                                  int idSolicitud = rs.getInt("IdSolicitud");
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
                            <td><% if (archivo != null) { %>
                                    <a href="archivos/<%= archivo %>" target="_blank" class="btn btn-primary">
        <i class="fas fa-file-download"></i> Abrir PDF
    </a>
                                    <% } else { %>
                                    <!-- Bot�n deshabilitado si archivo es null -->
                                    <button class="btn btn-primary" disabled>
                                        <i class="fas fa-file-download"></i> Abrir PDF
                                    </button>
                                    <% } %>
                            </td>
                            <td><%= fechaSolicitud %></td>
                            <td><%= estado %></td>
                            <td><%= respuesta %></td>
                            <td>
                                <!-- Botones de edici?n y eliminaci?n -->
                                <div class="btn-group" role="group" aria-label="Acciones">
                                    <a href="#" class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#editModal" title="Editar"
                                       data-idsolicitud="<%= idSolicitud %>"
                                       data-titulo="<%= titulo %>"
                                       data-tiposolicitud="<%= tipoSolicitud %>"
                                       data-mensaje="<%= mensaje %>"
                                       data-fecha="<%= fechaSolicitud %>"
                                       data-archivo="<%= archivo %>"
                                       data-respuesta="<%= respuesta %>"
                                       data-estado="<%= estado %>">
                                        <i class="fas fa-edit"></i> Editar
                                    </a>

                                    <a href="#" class="btn btn-danger btn-sm" title="Eliminar" onclick="confirmarEliminacion(<%= idSolicitud %>);">
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
                        
<!-- Modal para editar solicitudes -->
    <div class="modal fade modal-dark" id="editModal" tabindex="-1" aria-labelledby="editModal" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content bg-dark text-light">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Edicion de Solicitud</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="SvEditarSolicitud" method="POST" id="editForm" enctype="multipart/form-data">
                        <div class="mb-3" hidden>
                            <label for="idSolicitud" class="col-form-label">ID Solicitud:</label>
                            <input type="text" class="form-control" id="idSolicitud" name="idSolicitud" placeholder="ID de la solicitud" readonly required>
                        </div>
                        <div class="mb-3">
                            <label for="titulo" class="col-form-label">Titulo:</label>
                            <input type="text" class="form-control" id="titulo" name="titulo" placeholder="T?tulo de la solicitud" required>
                        </div>
                        <div class="mb-3">
                            <label for="tipoSolicitud" class="col-form-label">Tipo de Solicitud:</label>
                            <select class="form-control" name="tipoSolicitud" id="tipoSolicitud" required>
                                <option value="" selected disabled>Seleccionar Tipo de Solicitud</option>
                                <%
                                       
                                    try {
                                        conn = conectar.establecerConexion();
                                        String sql = "SELECT IdTipoSolicitud, tipo FROM tiposolicitud";
                                        pstmt = conn.prepareStatement(sql);
                                        rs = pstmt.executeQuery();

                                        while (rs.next()) {
                                            int idTipoSolicitud = rs.getInt("IdTipoSolicitud");
                                            String nombre = rs.getString("tipo");
                                %>
                                <option value="<%= idTipoSolicitud%>"><%= nombre%></option>
                                <%
                                        }
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    } finally {
                                        // Cierra la conexi?n y los recursos
                                        try {
                                            if (rs != null) {
                                                rs.close();
                                            }
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
                                %>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="mensaje" class="col-form-label">Mensaje:</label>
                            <textarea class="form-control" id="mensaje" name="mensaje" rows="3" required></textarea>
                        </div>
                        <div class="mb-3" hidden>
                            <label for="fecha" class="col-form-label">Fecha:</label>
                            <input type="text" class="form-control" id="fecha" name="fecha" placeholder="Fecha de la solicitud" readonly required>
                        </div>
                        <div class="mb-3">
                                <label for="archivo" class="col-form-label">Archivo:</label>
                                <input type="text" class="form-control" id="archivo_nombre" readonly>
                                <input type="file" class="form-control" id="archivo" name="archivo">
                                <small class="text-muted">Si desea cambiar el archivo, seleccione uno nuevo.</small>
                            </div>
                        <div class="mb-3" hidden>
                            <label for="respuesta" class="col-form-label">Respuesta:</label>
                            <textarea class="form-control" id="respuesta" name="respuesta" rows="3" readonly></textarea>
                        </div>
                        <div class="mb-3" hidden>
                            <label for="estado" class="col-form-label">Estado:</label>
                            <input type="text" class="form-control" id="estado" name="estado" placeholder="Estado de la solicitud" readonly required>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        $('#editModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget);
    var idSolicitud = button.data('idsolicitud');
    var titulo = button.data('titulo');
    var tipoSolicitud = button.data('tiposolicitud');
    var mensaje = button.data('mensaje');
    var fecha = button.data('fecha');
    var archivo = button.data('archivo');
    var respuesta = button.data('respuesta');
    var estado = button.data('estado');

    // Establecer valores en los campos del formulario
    var modal = $(this);
    modal.find('#idSolicitud').val(idSolicitud);
    modal.find('#titulo').val(titulo);
    modal.find('#mensaje').val(mensaje);
    modal.find('#fecha').val(fecha);
    modal.find('#archivo_nombre').val(archivo);
    modal.find('#respuesta').val(respuesta);
    modal.find('#estado').val(estado);

    // Establecer el tipo de solicitud actual como seleccionado
    modal.find('#tipoSolicitud option').each(function () {
        if ($(this).text() === tipoSolicitud) {
            $(this).prop('selected', true);
        }
    });
});
    </script>


    <script>
        function confirmarEliminacion(idSolicitud) {
            if (confirm("?Est? seguro de querer borrar esta solicitud suya?")) {
                window.location.href = "SvSolicitud?id=" + idSolicitud;
            }
        }

    </script>
</section>
</body>

<!-- Footer-->
<footer class="py-5 bg-black">
    <div class="container px-5">
        <p class="m-0 text-center text-white small">Copyright &copy; Boostrap Wonder Pages/ Editado por Samuel Bola?os y Portilla</p>
    </div>
</footer>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="js/scripts.js"></script>

</html>