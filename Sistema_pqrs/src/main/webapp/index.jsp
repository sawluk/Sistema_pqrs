<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Inicio de Sesión</title>
        <!-- Bootstrap CSS -->
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="#">Mi Sistema</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Inicio <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Acerca de</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Contacto</a>
                    </li>
                </ul>
            </div>
        </nav>

        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <!-- Formulario de Inicio de Sesión -->
                    <div class="card mb-3">
                        <div class="card-body">
                            <h1 class="card-title text-center">Inicio de Sesión</h1>
                            <form action="SvLogin" method="POST">
                                <div class="form-group">
                                    <label for="username">Nombre de Usuario:</label>
                                    <input type="text" class="form-control" id="username" name="nombre" required>
                                </div>
                                <div class="form-group">
                                    <label for="password">Contraseña:</label>
                                    <input type="password" class="form-control" id="password" name="contrasenia" required>
                                </div>
                                <button type="submit" class="btn btn-primary btn-block">Iniciar Sesión</button>
                            </form>
                        </div>
                        <div class="card-body">
                            <p class="text-center">¿Aún no tienes cuenta?</p>
                            <%---- Botón para abrir la ventana modal ---%>
                            <button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-target="#registroModal">Registrarse</button> 
                        </div>
                    </div>


                    <!-- Ventana Modal para el Formulario de Registro -->
                    <div class="modal fade" id="registroModal" tabindex="-1" role="dialog" aria-labelledby="registroModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="registroModalLabel">Registro de Usuario</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form action="SvRegistrar" method="POST">
                                        <div class="form-group">
                                            <label for="cedula">Cédula:</label>
                                            <input type="text" class="form-control" id="cedula" name="cedula" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="nombre">Nombre de usuario:</label>
                                            <input type="text" class="form-control" id="nombre" name="nombre" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="correo">Correo electrónico:</label>
                                            <input type="email" class="form-control" id="correo" name="correo" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="contrasena">Contraseña:</label>
                                            <input type="password" class="form-control" id="contrasena" name="contrasena" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="rol">Rol:</label>
                                            <select class="form-control" id="rol" name="rol" required>
                                                <option value="" disabled selected>Seleccionar Rol</option>
                                                <option value="Admin">Admin</option>
                                                <option value="Usuario">Usuario</option>
                                            </select>
                                        </div>

                                        <button type="submit" class="btn btn-primary btn-block">Registrar</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Bootstrap JS -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
                    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
                    </body>
                    </html>
