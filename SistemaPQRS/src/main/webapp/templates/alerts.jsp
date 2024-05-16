<%
    String success = request.getParameter("success");
    if ("true".equals(success)) {
%>
<div id="successAlert" class="alert alert-success alert-dismissible fade show" role="alert">
    Usuario registrado
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<script>
    // Ocultar el mensaje de �xito despu�s de 5 segundos
    setTimeout(function() {
        document.getElementById('successAlert').style.display = 'none';
    }, 5000); // 5000 milisegundos = 5 segundos
</script>
<%
    }
%>
<%
    String successE = request.getParameter("success");
    if ("true".equals(successE)) {
%>
<div id="successAlert" class="alert alert-success alert-dismissible fade show" role="alert">
    Usuario editado
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<script>
    // Ocultar el mensaje de �xito despu�s de 5 segundos
    setTimeout(function() {
        document.getElementById('successAlert').style.display = 'none';
    }, 5000); // 5000 milisegundos = 5 segundos
</script>
<%
    }
%>


<%
    String error = request.getParameter("error");
    if ("true".equals(error)) {
%>
<div id="errorAlert" class="alert alert-danger alert-dismissible fade show" role="alert">
    Hubo un error al crear el perfil. La cedula o el correo ya est�n registrados.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<script>
    // Ocultar el mensaje de error despu�s de 5 segundos
    setTimeout(function() {
        document.getElementById('errorAlert').style.display = 'none';
    }, 5000); // 5000 milisegundos = 5 segundos
</script>
<%
    }
%>


<%
    String errorP = request.getParameter("errorP");
    if ("true".equals(errorP)) {
%>
<div id="errorPAlert" class="alert alert-danger alert-dismissible fade show" role="alert">
    C�dula o contrase�a incorrectos, por favor int�ntelo otra vez.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<script>
    // Ocultar el mensaje de error de contrase�a despu�s de 5 segundos
    setTimeout(function() {
        document.getElementById('errorPAlert').style.display = 'none';
    }, 5000); // 5000 milisegundos = 5 segundos
</script>
<%
    }
%>
