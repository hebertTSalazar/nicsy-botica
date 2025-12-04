<%-- 
    Document   : validarOtp
    Created on : 24 nov 2025, 19:12:57
    Author     : frank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="pe.nicsy.botica.model.Usuario"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Verificación en dos pasos | Botica Nicsy</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Iconos -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

        <!-- Tu CSS -->
        <link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet">
    </head>
    <body class="body-login">

        <%
            Usuario uTemp = null;
            String correoDestino = "";

            if (session != null && session.getAttribute("usuarioTemporal") != null) {
                uTemp = (Usuario) session.getAttribute("usuarioTemporal");
                if (uTemp.getCorreo() != null) {
                    correoDestino = uTemp.getCorreo();
                }
            }

            String error = (String) request.getAttribute("error");
            String mensaje = (String) request.getAttribute("mensaje");
        %>

        <div class="container d-flex justify-content-center align-items-center vh-100">
            <div class="row login-container shadow-lg rounded-4 overflow-hidden" style="max-width: 480px; width: 100%;">

                <div class="col-12 bg-white d-flex flex-column justify-content-center p-4">
                    <h3 class="login-title text-center mb-3">Verificación en dos pasos</h3>

                    <p class="text-muted text-center mb-3">
                        Hemos enviado un código de verificación a tu correo
                        <br>
                        <strong><%= correoDestino.isEmpty() ? "registrado" : correoDestino %></strong>.
                        <br>
                        Ingrésalo a continuación para acceder al panel.
                    </p>

                    <% if (error != null) { %>
                        <div class="alert alert-danger py-2" role="alert">
                            <%= error %>
                        </div>
                    <% } %>

                    <% if (mensaje != null) { %>
                        <div class="alert alert-success py-2" role="alert">
                            <%= mensaje %>
                        </div>
                    <% } %>

                    <form action="<%=request.getContextPath()%>/ValidarOtpServlet" method="post">
                        <div class="mb-3">
                            <label for="otp" class="form-label">Código de verificación (OTP)</label>
                            <input type="text"
                                   class="form-control text-center"
                                   id="otp"
                                   name="otp"
                                   maxlength="6"
                                   required
                                   placeholder="Ejemplo: 123456">
                        </div>

                        <button type="submit" class="btn btn-login w-100">
                            Verificar código
                        </button>
                    </form>

                    <div class="text-center mt-3">
                        <a href="<%=request.getContextPath()%>/LoginServlet?logout=true"
                           class="text-danger text-decoration-none">
                            <i class="bi bi-arrow-left-circle"></i> Volver al login
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

