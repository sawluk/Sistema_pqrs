<%@page import="java.sql.Connection"%>
<%@page import="com.mycompany.sistema_pqrs.SistemaPQRS"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@include file="templates/headeradmin.jsp" %>
<!-- Header-->
        <header class="masthead text-center text-white" style="background-color: #2196F3;"> <!-- Azul -->
            <div class="masthead-content">
                <div class="container px-5">
                    <h2> Hola administrador <% String nombreUsuario = (String) session.getAttribute("nombre"); %> <% if (nombreUsuario != null && !nombreUsuario.isEmpty()) {%>, <%= nombreUsuario%><% }%></h2>
                </div>
            </div>
            <div class="bg-circle-1 bg-circle" style="background-color: #64B5F6;"></div> <!-- Azul claro -->
            <div class="bg-circle-2 bg-circle" style="background-color: #1976D2;"></div> <!-- Azul oscuro -->
            <div class="bg-circle-3 bg-circle" style="background-color: #1565C0;"></div> <!-- Azul más oscuro -->
            <div class="bg-circle-4 bg-circle" style="background-color: #0D47A1;"></div> <!-- Azul aún más oscuro -->
        </header>
<body>
    <main>
        <h1 style="text-align: center; margin-top: 20px;">Usuarios Registrados</h1>
        <div class="container p-4 d-flex justify-content-center" style="padding-top: 20px;">
            <div class="col-md-8">
                <table id="tutorialesTable" class="table table-bordered table-dark">
                    <thead>
                        <tr>
                            <th>Id Usuario</th>
                            <th>Cédula</th>
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
                                    if (pstmt != null) pstmt.close();
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
    </main>
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
