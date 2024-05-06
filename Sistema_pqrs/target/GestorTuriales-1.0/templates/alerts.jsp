<%
    String success = request.getParameter("success");
    if ("true".equals(success)) {
        %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            Usuario registrado
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <%
            }
        %>
        
        
 <%
    String error = request.getParameter("error");
    if ("true".equals(error)) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    Hubo un error al crear el perfil. La cedula o el correo ya estan registrad.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
    }
%>

 <%
    String errorP = request.getParameter("errorP");
    if ("true".equals(errorP)) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    Cedula o contrasena incorrectos, porfavor intentelo otra vez
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
    }
%>