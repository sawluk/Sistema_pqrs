<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Inicio de Sesi�n</title>
        <!-- Bootstrap CSS -->
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <style>
            /* Definir la variable $primary */
            :root {
                --primary: #FFA500;
            }

            body {
                position: relative;
                font-family: "Open Sans", sans-serif;
                height: 100vh;
                margin: 0; /* Elimina el margen predeterminado del cuerpo */
                background: url("https://www.xtrafondos.com/wallpapers/montanas-en-bosque-minimalista-flat-3306.jpg") no-repeat center center fixed;
                background-size: cover;
            }

            body::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(255, 165, 0, 0.5); /* Naranja con opacidad del 50% */
            }




            @keyframes spinner {
                0% {
                    transform: rotateZ(0deg);
                }

                100% {
                    transform: rotateZ(359deg);
                }
            }

            * {
                box-sizing: border-box;
            }

            .wrapper {
                display: flex;
                align-items: center;
                flex-direction: column;
                justify-content: center;
                width: 100%;
                min-height: 100%;
                padding: 20px;
                /* Utilizar la variable --primary */
                background: rgba(darken(var(--primary), 40%), 0.85);
            }

            .login {
                border-radius: 2px 2px 5px 5px;
                padding: 10px 20px 20px 20px;
                width: 90%;
                max-width: 320px;
                background: #ffffff;
                position: relative;
                padding-bottom: 80px;
                box-shadow: 0px 1px 5px rgba(0, 0, 0, 0.3);
            }

            .login.loading button {
                max-height: 100%;
                padding-top: 50px;
            }

            .login.ok button {
                background-color: #8bc34a;
            }

            .login.ok button .spinner {
                border-radius: 0;
                border-top-color: transparent;
                border-right-color: transparent;
                height: 20px;
                animation: none;
                transform: rotateZ(-45deg);
            }

            .login input {
                display: block;
                padding: 15px 10px;
                margin-bottom: 10px;
                width: 100%;
                border: 1px solid #ddd;
                transition: border-width 0.2s ease;
                border-radius: 2px;
                color: #ccc;
            }

            .login input+i.fa {
                color: #fff;
                font-size: 1em;
                position: absolute;
                margin-top: -47px;
                opacity: 0;
                left: 0;
                transition: all 0.1s ease-in;
            }

            .login input:focus+i.fa {
                opacity: 1;
                left: 30px;
                transition: all 0.25s ease-out;
            }

            .login input:focus {
                outline: none;
                color: #444;
                border-color: var(--primary); /* Utilizar la variable --primary */
                border-left-width: 35px;
            }

            .login a {
                font-size: 0.8em;
                color: var(--primary); /* Utilizar la variable --primary */
                text-decoration: none;
            }

            .login .title {
                color: #444;
                font-size: 1.2em;
                font-weight: bold;
                margin: 10px 0 30px 0;
                border-bottom: 1px solid #eee;
                padding-bottom: 20px;
            }

            .login button {
                width: 100%;
                height: 100%;
                padding: 10px 10px;
                background: var(--primary); /* Utilizar la variable --primary */
                color: #fff;
                display: block;
                border: none;
                margin-top: 20px;
                position: absolute;
                left: 0;
                bottom: 0;
                max-height: 60px;
                border: 0px solid rgba(0, 0, 0, 0.1);
                border-radius: 0 0 2px 2px;
                transform: rotateZ(0deg);
                transition: all 0.1s ease-out;
                border-bottom-width: 7px;
            }

            .login .spinner {
                display: block;
                width: 40px;
                height: 40px;
                position: absolute;
                border: 4px solid #ffffff;
                border-top-color: rgba(255, 255, 255, 0.3);
                border-radius: 100%;
                left: 50%;
                top: 0;
                opacity: 0;
                margin-left: -20px;
                margin-top: -20px;
                animation: spinner 0.6s infinite linear;
                transition: top 0.3s 0.3s ease, opacity 0.3s 0.3s ease, border-radius 0.3s ease;
                box-shadow: 0px 1px 0px rgba(0, 0, 0, 0.2);
            }

            .wrapper:not(.loading) .login button:hover {
                box-shadow: 0px 1px 3px var(--primary); /* Utilizar la variable --primary */
            }

            .wrapper:not(.loading) .login button:focus {
                border-bottom-width: 4px;
            }

            footer {
                display: block;
                padding-top: 50px;
                text-align: center;
                color: #ddd;
                font-weight: normal;
                text-shadow: 0px -1px 0px rgba(0, 0, 0, 0.2);
                font-size: 0.8em;
            }

            footer a,
            footer a:link {
                color: #fff;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <main>
            <div class="wrapper">
                <form class="login" action="SvLogin" method="POST">
                    <h2 class="title">Login para atencion</h2>
                    <div class="form-group">
                        <div data-mdb-input-init class="form-outline">
                            <label for="username">C�dula:</label>
                            <input type="text" class="form-control" id="username" name="cedula" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password">Contrase�a:</label>
                        <input type="password" class="form-control" id="password" name="contrasenia" required>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Iniciar Sesi�n</button>
                    <div>
                        <p class="text-center"> <a href="#registroModal" data-toggle="modal">�A�n no tienes cuenta? Cr�ala!!!</a></p>
                    </div>
                </form>
            </div>
        </main>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

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
                                <label for="cedula">C�dula:</label>
                                <input type="text" class="form-control" id="cedula" name="cedula" required>
                            </div>
                            <div class="form-group">
                                <label for="nombre">Nombre de usuario:</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" required>
                            </div>
                            <div class="form-group">
                                <label for="correo">Correo electr�nico:</label>
                                <input type="email" class="form-control" id="correo" name="correo" required>
                            </div>
                            <div class="form-group">
                                <label for="contrasena">Contrase�a:</label>
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
