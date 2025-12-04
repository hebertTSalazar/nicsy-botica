<%-- 
    Document   : login
    Created on : 29 oct 2025, 22:26:12
    Author     : frank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Iniciar Sesión | Botica Nicsy</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Iconos Bootstrap -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

        <!-- Tu estilo personalizado -->
        <link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet">
    </head>
    <body class="body-login">

        <div class="container d-flex justify-content-center align-items-center vh-100">
            <div class="row login-container shadow-lg rounded-4 overflow-hidden">

                <!-- COLUMNA IMAGEN -->
                <div class="col-md-6 p-0 d-none d-md-block">
                    <img src="<%=request.getContextPath()%>/img/login.jpg" alt="Botica Nicsy" class="img-login">
                </div>

                <!-- COLUMNA FORMULARIO -->
                <div class="col-md-6 bg-white d-flex flex-column justify-content-center p-4">
                    <h3 class="login-title text-center mb-3">BOTICA NICSY</h3>
                    <p class="text-muted text-center mb-4">Inicia sesión para continuar</p>

                    <!-- 🔐 Autocompletado desactivado en el formulario -->
                    <form action="<%=request.getContextPath()%>/LoginServlet"
                          method="post"
                          autocomplete="off">

                        <div class="mb-3">
                            <label for="usuario" class="form-label">Correo o usuario</label>
                            <input type="text"
                                   class="form-control"
                                   id="usuario"
                                   name="usuario"
                                   required
                                   placeholder="Ingresa tu correo o usuario"
                                   autocomplete="off"
                                   autocapitalize="off"
                                   spellcheck="false">
                        </div>

                        <div class="mb-3">
                            <label for="clave" class="form-label">Contraseña</label>
                            <input type="password"
                                   class="form-control"
                                   id="clave"
                                   name="clave"
                                   required
                                   placeholder="Ingresa tu contraseña"
                                   autocomplete="new-password">
                        </div>

                        <button type="submit" class="btn btn-login w-100">Ingresar</button>

                        <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger alerta mt-3" role="alert">
                            <%= request.getAttribute("error") %>
                        </div>
                        <% } %>

                        <% if (request.getAttribute("mensaje") != null) { %>
                        <div class="alert alert-success alerta mt-3" role="alert">
                            <%= request.getAttribute("mensaje") %>
                        </div>
                        <% } %>
                    </form>

                    <div class="footer-login text-center mt-3">
                        <p>¿Eres cliente? 
                            <a href="<%=request.getContextPath()%>/views/registroCliente.jsp" 
                               class="text-danger text-decoration-none">Regístrate aquí</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <div class="mt-3 text-center">
            <a href="<%=request.getContextPath()%>/views/index.jsp" class="btn btn-outline-danger btn-volver">
                <i class="bi bi-house-door-fill"></i> Volver al inicio
            </a>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
