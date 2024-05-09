<%@page import="com.mycompany.SistemaPQRS.SistemaPQRS"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@include file= "templates/header.jsp" %>


<!-- Header-->
<header class="masthead text-center text-white" style="background-color: #2196F3;"> <!-- Azul -->
    <div class="masthead-content">
        <div class="container px-5">
            <h2> ¿Algo en lo que te podamos ayudar hoy <% String nombreUsuario = (String) session.getAttribute("nombre"); %> <% if (nombreUsuario != null && !nombreUsuario.isEmpty()) {%>, <%= nombreUsuario%>?<% }%></h2>
            <h2 class="masthead-subheading mb-0">Llena el formulario</h2>
            <a class="btn btn-primary btn-xl rounded-pill mt-5" href="#scroll">Formulario</a>
        </div>
    </div>
    <div class="bg-circle-1 bg-circle" style="background-color: #64B5F6;"></div> <!-- Azul claro -->
    <div class="bg-circle-2 bg-circle" style="background-color: #1976D2;"></div> <!-- Azul oscuro -->
    <div class="bg-circle-3 bg-circle" style="background-color: #1565C0;"></div> <!-- Azul más oscuro -->
    <div class="bg-circle-4 bg-circle" style="background-color: #0D47A1;"></div> <!-- Azul aún más oscuro -->
</header>

<!-- Content section 1-->
<section id="scroll">
    <div class="container px-5">
        <div class="row gx-5 align-items-center">
            <div class="col-lg-6 order-lg-2">
                <div class="p-5"><img class="img-fluid rounded-circle" src="assets/img/atencion.jpg" alt="..." /></div>
            </div>
            <div class="col-lg-6 order-lg-1">
                <div class="p-5">
                    <div class="container">

                        <h2>Formulario PQRS</h2>
                        <form action="SvSolicitud" method="post" role="form" enctype="multipart/form-data">

                            <!-- Campo de título de la solicitud -->
                            <div class="form-group mt-3">
                                <input type="text" class="form-control" name="titulo" id="titulo" placeholder="Título de la Solicitud" required>
                            </div>

                            <!-- Campo de tipo de solicitud -->
                            <div class="form-group mt-3">
                                <select class="form-control" name="tipoSolicitud" id="tipoSolicitud" required>
                                    <option value="" selected disabled>Seleccionar Tipo de Solicitud</option>
                                    <%
                                        // Crear una instancia de la clase gestionarSistema
                                        SistemaPQRS conectar = new SistemaPQRS();
                                        // Importa las clases necesarias y realiza la conexión a la base de datos
                                        Connection conn = null;
                                        PreparedStatement pstmt = null;
                                        ResultSet rs = null;

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
                                            // Cierra la conexión y los recursos
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
                            <!-- Campo de mensaje de la solicitud -->
                            <div class="form-group mt-3">
                                <textarea class="form-control" name="mensaje" rows="5" placeholder="Mensaje de la Solicitud"></textarea>
                            </div>

                            <!-- Campo oculto para el ID del usuario obtenido de la sesión -->
                            <input type="hidden" name="idUsuario" value="<%= session.getAttribute("idUsuario")%>">

                            <!-- Campo oculto para la fecha de la solicitud -->
                            <input type="hidden" name="fechaSolicitud" value="<%= java.time.LocalDateTime.now()%>">


                            <!-- Campo para subir archivo adjunto -->
                            <div class="form-group mt-3">
                                <label for="archivoAdjunto">Adjuntar archivo PDF:</label>
                                <input type="file" class="form-control" name="archivoAdjunto" id="archivoAdjunto" accept=".pdf">
                            </div>


                            <div class="my-3"></div>
                            <!-- Botón para enviar la solicitud -->
                            <div class="text-center"><button type="submit">Enviar Solicitud</button></div>
                        </form>

                    </div>
                </div>
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