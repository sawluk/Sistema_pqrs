<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de Sesión</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        /* Estilos personalizados */

        /* Estilos para el contenedor principal */
        body {
            background-color: darkblue;
        }
        .center-text {
    text-align: center;
    font-family: monospace;
    font-size: 30px; /* Tamaño de fuente */
    color: #007bff; /* Color de texto */
    margin-bottom: 20px; /* Margen inferior */
         }

        .container {
            margin-top: 50px;
        }

        /* Estilos para la tarjeta */
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        /* Estilos para el título */
        .card-title {
            font-size: 24px;
            font-weight: bold;
            color:  #fff;
        }

        /* Estilos para los botones */
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }

        /* Estilos para los campos de entrada */
        .form-control {
            border-radius: 5px;
            border-color: #ced4da;
        }
    </style>
</head>
<body>
    <main>
    <div>
    <h2 class="center-text">Mi empresa</h2>
    </div>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <!-- Formulario de Inicio de Sesión -->
                <div class="card bg-dark text-white" style="border-radius: 1rem;">
                <div class="card-body px-4 py-5 px-md-5">
                    <h1 class="card-title text-center">Inicio de Sesión</h1>
                        <form action="SvLogin" method="POST">
                            <div class="form-group">
                                <div data-mdb-input-init class="form-outline">
                                <label for="username">Cédula:</label>
                                <input type="text" class="form-control" id="username" name="cedula" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Contraseña:</label>
                                <input type="password" class="form-control" id="password" name="contrasenia" required>
                            </div>
                            <button type="submit" class="btn btn-primary btn-block">Iniciar Sesión</button>
                        </form>
                    </div>
                    <div class="card-body">
                        <p class="text-center">¿Aún no tienes cuenta? Créala!!!</p>
                        <!-- Botón para abrir la ventana modal -->
                        <button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-target="#registroModal">Crear cuenta</button> 
                    </div>
                </div>
            </div>
        </div>
    </div>
        </div>
        </main>

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
                        <button type="submit" class="btn btn-primary btn-block">Crear cuenta</button>
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
