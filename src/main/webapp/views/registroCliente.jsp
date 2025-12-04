<%-- 
    Document   : registroCliente
    Created on : 24 nov 2025, 22:53:04
    Author     : frank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Registro de Cliente | Botica Nicsy</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet">
    </head>
    <body class="body-login">

        <div class="container py-4">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-10">
                    <div class="row shadow-lg rounded-4 overflow-hidden bg-white">

                        <!-- IMAGEN (arriba en móvil, a la izquierda en desktop) -->
                        <div class="col-12 col-md-5 p-0 d-flex align-items-stretch">
                            <img src="<%=request.getContextPath()%>/img/login.jpg"
                                 alt="Cliente Botica Nicsy"
                                 class="img-fluid w-100"
                                 style="object-fit: cover;">
                        </div>

                        <!-- FORMULARIO -->
                        <div class="col-12 col-md-7 p-4">
                            <h4 class="text-center fw-bold text-danger mb-2">
                                <i class="bi bi-person-plus-fill"></i> Registro de Cliente
                            </h4>
                            <p class="text-muted text-center mb-3">
                                Crea tu cuenta para realizar compras en Botica Nicsy.
                            </p>

                            <%
                                String error = (String) request.getAttribute("error");
                                if (error != null) {
                            %>
                            <div class="alert alert-danger py-2"><%= error %></div>
                            <% } %>

                            <form action="<%=request.getContextPath()%>/RegistrarClienteServlet"
                                  method="post"
                                  class="needs-validation"
                                  novalidate
                                  autocomplete="off">

                                <!-- FILA 1: Nombre - DNI -->
                                <div class="row">
                                    <div class="col-md-7 mb-2">
                                        <label class="form-label">Nombre completo</label>
                                        <input type="text" name="nombre" class="form-control"
                                               required minlength="3" autocomplete="off">
                                        <div class="invalid-feedback">
                                            Ingrese su nombre completo (mínimo 3 caracteres).
                                        </div>
                                    </div>
                                    <div class="col-md-5 mb-2">
                                        <label class="form-label">DNI</label>
                                        <input type="text" name="dni" class="form-control"
                                               required pattern="[0-9]{8}" maxlength="8" autocomplete="off">
                                        <div class="invalid-feedback">
                                            El DNI debe tener 8 dígitos numéricos.
                                        </div>
                                    </div>
                                </div>

                                <!-- FILA 2: Teléfono - Edad -->
                                <div class="row">
                                    <div class="col-md-6 mb-2">
                                        <label class="form-label">Teléfono</label>
                                        <input type="text" name="telefono" class="form-control"
                                               required pattern="[0-9]{9,15}" autocomplete="off">
                                        <div class="invalid-feedback">
                                            Ingrese un teléfono válido (solo números, mínimo 9 dígitos).
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-2">
                                        <label class="form-label">Edad</label>
                                        <input type="number" name="edad" class="form-control"
                                               required min="18" max="100" autocomplete="off">
                                        <div class="invalid-feedback">
                                            La edad debe ser mayor o igual a 18 años.
                                        </div>
                                    </div>
                                </div>

                                <!-- FILA 3: Correo - Dirección -->
                                <div class="row">
                                    <div class="col-md-6 mb-2">
                                        <label class="form-label">Correo electrónico</label>
                                        <input type="email" name="correo" class="form-control"
                                               required autocomplete="off">
                                        <div class="invalid-feedback">
                                            Ingrese un correo electrónico válido.
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-2">
                                        <label class="form-label">Dirección</label>
                                        <input type="text" name="direccion" class="form-control"
                                               autocomplete="off">
                                        <div class="invalid-feedback">
                                            Ingrese una dirección válida.
                                        </div>
                                    </div>
                                </div>

                                <!-- FILA 4: Contraseña - Repetir -->
                                <div class="row">
                                    <div class="col-md-6 mb-2">
                                        <label class="form-label">Contraseña</label>
                                        <input type="password" name="password" id="pass1"
                                               class="form-control" required minlength="6"
                                               autocomplete="new-password">
                                        <div class="invalid-feedback">
                                            La contraseña debe tener al menos 6 caracteres.
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Repetir contraseña</label>
                                        <input type="password" name="password2" id="pass2"
                                               class="form-control" required minlength="6"
                                               autocomplete="new-password">
                                        <div class="invalid-feedback" id="msgPass2">
                                            Repita la misma contraseña.
                                        </div>
                                    </div>
                                </div>

                                <button type="submit" class="btn btn-danger w-100 mb-2">
                                    <i class="bi bi-check-circle-fill"></i> Registrarme
                                </button>

                                <div class="text-center">
                                    <a href="<%=request.getContextPath()%>/views/login.jsp"
                                       class="text-danger text-decoration-none">
                                        <i class="bi bi-box-arrow-in-right"></i> ¿Ya tienes cuenta? Inicia sesión
                                    </a>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Validación Bootstrap + contraseñas iguales -->
        <script>
            (() => {
                'use strict';
                const forms = document.querySelectorAll('.needs-validation');

                Array.from(forms).forEach(form => {
                    form.addEventListener('submit', event => {
                        const pass1 = document.getElementById('pass1');
                        const pass2 = document.getElementById('pass2');
                        const msgPass2 = document.getElementById('msgPass2');

                        if (pass1.value !== pass2.value) {
                            event.preventDefault();
                            event.stopPropagation();
                            pass2.setCustomValidity("Las contraseñas no coinciden");
                            msgPass2.textContent = "Las contraseñas no coinciden.";
                        } else {
                            pass2.setCustomValidity("");
                        }

                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }

                        form.classList.add('was-validated');
                    }, false);
                });
            })();
        </script>
    </body>
</html>
