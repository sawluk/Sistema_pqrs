<%-- 
    Document   : admin
    Created on : 28/04/2024, 5:25:38 p. m.
    Author     : Acer
--%>

<%@include file= "templates/header.jsp" %>
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
    
