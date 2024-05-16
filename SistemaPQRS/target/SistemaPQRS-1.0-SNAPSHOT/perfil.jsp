<%@include file= "templates/header.jsp" %>

<!-- Header-->
<header class="masthead text-center text-white" style="background-color: #2196F3;"> <!-- Azul -->
    <div class="masthead-content">
        <div class="container px-5">
            <h2> Aqui puedes editar tu perfil si lo quieres </h2>
            <a class="btn btn-primary btn-xl rounded-pill mt-5" href="#scroll">Formulario</a>
        </div>
    </div>
    <div class="bg-circle-1 bg-circle" style="background-color: #64B5F6;"></div> <!-- Azul claro -->
    <div class="bg-circle-2 bg-circle" style="background-color: #1976D2;"></div> <!-- Azul oscuro -->
    <div class="bg-circle-3 bg-circle" style="background-color: #1565C0;"></div> <!-- Azul más oscuro -->
    <div class="bg-circle-4 bg-circle" style="background-color: #0D47A1;"></div> <!-- Azul aún más oscuro -->
</header>

<section>
    <div class="container" data-aos="fade-up">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <h2>Formulario para editar tu perfil</h2>
                <div class="card bg-dark text-white" style="background-color: #0C0E67;">
                    
                    <div class="card-body">
                        <form action="SvEditarUsuario" method="post">
                            <div class="row">
                                <input type="hidden" name="idUsuario" value="<%= session.getAttribute("idUsuario")%>">

                                <!-- Nombre input -->
                                <div class="col-md-6 form-outline mb-4">
                                    <input type="text" id="nombreRegistro" name="nombre" class="form-control" value="${nombre}" required />
                                    <label class="form-label" for="nombreRegistro">Nombre</label>
                                </div>

                                <!-- Contraseña input -->
                                <div class="col-md-6 form-outline mb-4">
                                    <input type="password" id="contrasenaRegistro" name="contrasena" class="form-control" value="${contrasena}" required />
                                    <label class="form-label" for="contrasenaRegistro">Contraseña</label>
                                </div>

                                <!-- Correo input -->
                                <div class="col-md-6 form-outline mb-4">
                                    <input type="email" id="correoRegistro" name="correo" class="form-control" value="${correo}" required />
                                    <label class="form-label" for="correoRegistro">Correo electrónico</label>
                                </div>

                                <!-- Submit button -->
                                <div class="col-md-6">
                                    <button type="submit" class="btn btn-primary btn-block mb-4">Guardar Cambios</button>
                                </div>
                                
                                <div class="col-md-6">
                                <button type="button" class="btn btn-danger btn-block mb-4" onclick="confirmarEliminarUsuario()">Eliminar Usuario</button>
                                </div>
                                
                                <!-- Cédula input -->
                                <div class="col-md-6 form-outline mb-4">
                                    <input type="hidden" id="cedulaRegistro" name="cedula" class="form-control" value="${cedula}" required />
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section><!-- End Hero Section -->

<script>
function confirmarEliminarUsuario() {
    var idUsuario = '<%= request.getSession().getAttribute("idUsuario") %>';
    if (confirm("Estás seguro de borrar tu usuario ???(Tus solicitudes enviadas también se borrarán)")) {
        $.ajax({
            url: 'SvRegistrar',
            type: 'GET',
            data: {
                idUsuario: idUsuario
            },
            success: function(response) {
                alert(response);
                location.reload();
            }
        });
    }
}
</script>