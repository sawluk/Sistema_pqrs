<%-- 
    Document   : admin
    Created on : 28/04/2024, 5:25:38 p. m.
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
        </style>
    </head>
    <body>
        <div class="navbar">
        <a class="active" href="#">Inicio</a>
        <a href="peticiones.jsp">Peticiones</a>
        <div class="navbar-right">
            <a href="index.jsp">Cerrar sesion</a>
        </div>
    </div>
        <% String nombreUsuario = (String) session.getAttribute("nombreu"); %>
    
    <%-- Verificar si el nombre de usuario está presente en la sesión --%>
    <% if (nombreUsuario != null && !nombreUsuario.isEmpty()) { %>
        <p>¡Hola, administrador <%= nombreUsuario %>!</p>
    <% } else { %>
        <p>No se ha encontrado un nombre de usuario en la sesión.</p>
    <% } %>
    
    <h1>Usuarios Registrados</h1>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Cédula</th>
                <th>Nombre</th>
                <th>Correo Electrónico</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
    </body>
    
