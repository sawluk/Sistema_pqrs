<%@page import="java.sql.SQLException"%>
<%@page import="com.mycompany.sistema_pqrs.SistemaPQRS"%>
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
            <a href="solicitud.jsp">Lista PQRS</a>
            <div class="navbar-right">
                <a href="index.jsp">Cerrar sesion</a>
            </div>
        </div>
        <% String nombreUsuario = (String) session.getAttribute("nombre"); %>
        <%-- Verificar si el nombre de usuario está presente en la sesión --%>
        <% if (nombreUsuario != null && !nombreUsuario.isEmpty()) {%>
        <p>¡Hola, <%= nombreUsuario%>!</p>
        <% } %>
        <div class="container">

            <h2>Formulario PQRS</h2>
            <form action="SvPeticion" method="post" role="form">

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
                                <option value="<%= idTipoSolicitud %>"><%= nombre %></option>
                                <% 
                                        }
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    } finally {
                                        // Cierra la conexión y los recursos
                                        try {
                                            if (rs != null) rs.close();
                                            if (pstmt != null) pstmt.close();
                                            if (conn != null) conn.close();
                                        } catch (SQLException e) {
                                            e.printStackTrace();
                                        }
                                    }
                                %>
                            </select>

                        </div>
                            <!-- Campo de mensaje de la solicitud -->
                        <div class="form-group mt-3">
                            <textarea class="form-control" name="mensaje" rows="5" placeholder="Mensaje de la Solicitud" required></textarea>
                        </div>

                        <!-- Campo oculto para el ID del usuario obtenido de la sesión -->
                        <input type="hidden" name="idUsuario" value="<%= session.getAttribute("idUsuario") %>">
                        
                        <!-- Campo oculto para la fecha de la solicitud -->
                        <input type="hidden" name="fechaSolicitud" value="<%= java.time.LocalDateTime.now() %>">


                        <!-- Campo para subir archivo adjunto -->
                        <div class="form-group mt-3">
                            <label for="archivoAdjunto"></label>
                            <input type="file" class="form-control" name="archivoAdjunto" id="archivoAdjunto">
                        </div>

                        <div class="my-3"></div>
                        <!-- Botón para enviar la solicitud -->
                        <div class="text-center"><button type="submit">Enviar Solicitud</button></div>
                    </form>

        </div>
    </body>
</html>
