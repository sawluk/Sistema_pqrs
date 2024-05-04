<%@page import="java.sql.SQLException"%>
<%@page import="com.mycompany.sistema_pqrs.Sistema_PQRS"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Formulario PQRS</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            .navbar {
                background-color: #333;
                overflow: hidden;
            }

            .navbar a {
                float: left;
                display: block;
                color: white;
                text-align: center;
                padding: 14px 20px;
                text-decoration: none;
            }

            .navbar a:hover {
                background-color: #ddd;
                color: black;
            }

            .navbar a.active {
                background-color: #007bff;
                color: white;
            }

            .navbar-right {
                float: right;
            }

            @media screen and (max-width: 600px) {
                .navbar a {
                    float: none;
                    display: block;
                    text-align: left;
                }

                .navbar-right {
                    float: none;
                }
            }

            .container {
                max-width: 600px;
                margin: 50px auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            h1 {
                text-align: center;
                color: #333;
            }

            h2 {
                margin-top: 30px;
                color: #555;
            }

            form {
                margin-top: 20px;
            }

            label {
                display: block;
                margin-bottom: 5px;
                color: #777;
            }

            input[type="text"],
            input[type="email"],
            select,
            textarea,
            input[type="date"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }

            select {
                appearance: none;
                background-image: url('data:image/svg+xml;utf8,<svg fill="%23777" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><path d="M8 11L3 6h10z"/></svg>');
                background-repeat: no-repeat;
                background-position: right 10px top 50%;
                background-size: 20px;
            }

            textarea {
                resize: none;
            }

            input[type="file"] {
                margin-top: 5px;
                margin-bottom: 20px;
            }

            button[type="submit"] {
                display: block;
                width: 100%;
                padding: 10px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            button[type="submit"]:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="navbar">
            <a class="active" href="usuario.jsp">Inicio</a>
            <a href="peticiones.jsp">Lista PQRS</a>
            <div class="navbar-right">
                <a href="index.jsp">Cerrar sesion</a>
            </div>
        </div>
        <% String nombreUsuario = (String) session.getAttribute("nombreu"); %>
        <% String idusuario = (String) session.getAttribute("idusuario"); %>
        <%-- Verificar si el nombre de usuario está presente en la sesión --%>
        <% if (nombreUsuario != null && !nombreUsuario.isEmpty()) {%>
        <p>¡Hola, <%= nombreUsuario%>!</p>
        <% } %>
        <div class="container">

            <h2>Formulario PQRS</h2>
            <form action="SvPeticion" method="POST" enctype="multipart/form-data">
                <div class="mb-3">
                    <!-- Campo de título de la solicitud -->
                    <div class="form-group mt-3">
                        <input type="text" class="form-control" name="titulo" id="titulo" placeholder="Título de la Solicitud" required>
                    </div>

                    <!-- Campo de mensaje de la solicitud -->
                    <div class="form-group mt-3">
                        <textarea class="form-control" name="mensaje" rows="5" placeholder="Mensaje de la Solicitud" required></textarea>
                    </div>
                    <label for="tipo_peticion" class="form-label text-light">Tipo de petición</label>
                    <select name="peticion" class="form-select" id="peticion"required>
                        <option value="" disabled selected>Seleccionar tipo</option>
                        <%
                            Connection conn = null;
                            PreparedStatement stmt = null;
                            ResultSet rs = null;
                            try {
                                // Establecer conexión y ejecutar consulta SQL
                                Sistema_PQRS conectar = new Sistema_PQRS();
                                conn = conectar.establecerConexion();
                                String sql = "SELECT idTipoSolicitud, tipo FROM tiposolicitud";
                                stmt = conn.prepareStatement(sql);
                                rs = stmt.executeQuery();

                                // Iterar sobre los resultados de la consulta y generar las opciones del menú desplegable
                                while (rs.next()) {
                                    int idTipoSolicitud = rs.getInt("idTipoSolicitud");
                                    String tipo = rs.getString("tipo");
                        %>
                        <option value="<%= idTipoSolicitud%>"><%= tipo%></option>
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
                    </select>
                    <!-- Campo oculto para el ID del usuario obtenido de la sesión -->
                    <input type="hidden" name="idUsuario" value="<%= idusuario%>">

                    <!-- Campo oculto para la fecha de la solicitud -->
                    <input type="hidden" name="fechaSolicitud" value="<%= java.time.LocalDateTime.now()%>">

                </div>
                <div class="mb-3">
                    <label for="archivo" class="form-label">Archivo (PDF):</label>
                    <input type="file" id="archivo" name="archivo" accept=".pdf" class="form-control">
                </div>
                <button type="submit" class="btn btn-primary">Enviar PQRS</button>
            </form>

        </div>
    </body>
</html>
