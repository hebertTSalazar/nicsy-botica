<%-- 
    Document   : contacto
    Created on : 2 dic 2025, 21:43:39
    Author     : frank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Contáctanos | Botica Nicsy</title>

    <!-- Bootstrap + Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">

    <style>
        .contact-card {
            border: 2px solid #f28b82;      /* rojo suave */
            background-color: #fff8e1;      /* crema */
            border-radius: 18px;
        }
        .contact-title {
            font-weight: 700;
            letter-spacing: 1px;
        }
        .btn-contact {
            background-color: #b00020;
            border-color: #b00020;
            color: #ffffff;
            border-radius: 999px;
            font-weight: 600;
            letter-spacing: .5px;
            padding: 0.65rem 1.8rem;
            box-shadow: 0 6px 12px rgba(0,0,0,.18);
            transition: all .18s ease-in-out;
        }
        .btn-contact:hover {
            background-color: #7f0016;
            border-color: #7f0016;
            color: #ffffff;
            transform: translateY(-1px);
            box-shadow: 0 10px 20px rgba(0,0,0,.22);
        }
        .btn-contact:active {
            transform: translateY(0);
            box-shadow: 0 4px 8px rgba(0,0,0,.18);
        }
    </style>
</head>
<body class="bg-light">

<%@include file="header.jsp" %>

<main class="container my-4">

    <div class="text-center mb-4">
        <h2 class="contact-title">Contáctanos</h2>
        <p class="text-muted">
            Estamos aquí para ayudarte. Escríbenos para consultas farmacéuticas,
            dudas sobre productos o cualquier mensaje que tengas para Botica Nicsy.
        </p>
    </div>

    <!-- Mensajes de feedback -->
    <%
        String okContacto = (String) request.getAttribute("okContacto");
        String errorContacto = (String) request.getAttribute("errorContacto");
        if (okContacto != null) {
    %>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <%= okContacto %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } else if (errorContacto != null) { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <%= errorContacto %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <div class="row g-4">

        <!-- Columna izquierda: formulario -->
        <div class="col-lg-6">
            <div class="card contact-card shadow-sm h-100">
                <div class="card-body">
                    <div class="d-flex align-items-center mb-3">
                        <i class="bi bi-chat-dots-fill text-danger me-2" style="font-size:1.6rem;"></i>
                        <h5 class="mb-0">Envíanos un mensaje</h5>
                    </div>

                    <form action="<%=request.getContextPath()%>/contacto" method="post">

                        <!-- Nombres y apellidos: solo letras -->
                        <div class="mb-3">
                            <label class="form-label">Nombres y apellidos*</label>
                            <input type="text"
                                   name="nombre"
                                   class="form-control"
                                   placeholder="Ingrese nombre y apellidos"
                                   value="<%= request.getAttribute("nombre") != null ? request.getAttribute("nombre") : "" %>"
                                   pattern="[A-Za-zÁÉÍÓÚÜÑáéíóúüñ ]{3,60}"
                                   title="Solo letras y espacios, mínimo 3 caracteres."
                                   required>
                        </div>

                        <div class="row g-3">
                            <!-- DNI: 8 dígitos numéricos -->
                            <div class="col-md-6">
                                <label class="form-label">DNI*</label>
                                <input type="text"
                                       name="dni"
                                       class="form-control"
                                       placeholder="Ingrese DNI"
                                       maxlength="8"
                                       pattern="[0-9]{8}"
                                       title="El DNI debe tener exactamente 8 dígitos numéricos."
                                       value="<%= request.getAttribute("dni") != null ? request.getAttribute("dni") : "" %>"
                                       required>
                            </div>

                            <!-- Teléfono (opcional, pero numérico si lo pone) -->
                            <div class="col-md-6">
                                <label class="form-label">Teléfono</label>
                                <input type="text"
                                       name="telefono"
                                       class="form-control"
                                       placeholder="+51 9xx xxx xxx"
                                       value="<%= request.getAttribute("telefono") != null ? request.getAttribute("telefono") : "" %>"
                                       pattern="[0-9 +]{0,15}"
                                       title="Solo números, espacios y el signo +.">
                            </div>
                        </div>

                        <div class="row g-3 mt-1">
                            <div class="col-12">
                                <label class="form-label">E-mail*</label>
                                <input type="email"
                                       name="email"
                                       class="form-control"
                                       placeholder="Ingrese su correo"
                                       value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                                       required>
                            </div>
                        </div>

                        <!-- Asunto obligatorio -->
                        <div class="mb-3 mt-3">
                            <label class="form-label">Asunto*</label>
                            <input type="text"
                                   name="asunto"
                                   class="form-control"
                                   placeholder="Consulta sobre medicamento, pedido, etc."
                                   value="<%= request.getAttribute("asunto") != null ? request.getAttribute("asunto") : "" %>"
                                   minlength="3"
                                   maxlength="150"
                                   required>
                        </div>

                        <!-- Mensaje obligatorio -->
                        <div class="mb-3">
                            <label class="form-label">Mensaje*</label>
                            <textarea name="mensaje"
                                      class="form-control"
                                      rows="5"
                                      placeholder="Escribe tu consulta o pregunta aquí..."
                                      minlength="5"
                                      required><%= request.getAttribute("mensaje") != null ? request.getAttribute("mensaje") : "" %></textarea>
                        </div>

                        <div class="d-flex justify-content-center mt-3">
                            <button type="submit"
                                    class="btn btn-contact d-inline-flex align-items-center justify-content-center gap-2">
                                <i class="bi bi-send-fill"></i>
                                <span>Enviar mensaje</span>
                            </button>
                        </div>
                    </form>

                </div>
            </div>
        </div>

        <!-- Columna derecha: mapa y ubicación -->
        <div class="col-lg-6">
            <div class="card contact-card shadow-sm h-100">
                <div class="card-body d-flex flex-column">
                    <div class="d-flex align-items-center mb-3">
                        <i class="bi bi-geo-alt-fill text-danger me-2" style="font-size:1.6rem;"></i>
                        <h5 class="mb-0">Nuestra ubicación</h5>
                    </div>

                    <div class="mb-3" style="height:300px;">
                        <iframe
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3921.991836931473!2d-79.443!3d-6.849!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2sBotica%20Nicsy!5e0!3m2!1ses-419!2spe!4v1700000000000"
                            width="100%" height="100%" style="border:0;" allowfullscreen=""
                            loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                    </div>

                    <div class="mt-auto">
                        <h6 class="fw-bold mb-1">Botica Nicsy</h6>
                        <p class="mb-1">
                            Av. 09 de Octubre Mz 8 Lt. 01 – CAYALTÍ
                        </p>
                        <p class="mb-3">
                            <i class="bi bi-telephone-fill text-danger"></i>
                            &nbsp;968320516 / 938948479
                        </p>

                        <a href="https://maps.app.goo.gl/pDFHd2JpKgaGHsbv5"
                           target="_blank"
                           class="btn btn-contact w-100 d-inline-flex align-items-center justify-content-center gap-2">
                            <i class="bi bi-car-front-fill"></i>
                            <span>Cómo llegar</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>

    </div>

</main>

<%@include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Validación extra en el lado del cliente (limpia mientras escribe)
    document.addEventListener('DOMContentLoaded', () => {
        const inputNombre = document.querySelector('input[name="nombre"]');
        const inputDni    = document.querySelector('input[name="dni"]');

        if (inputNombre) {
            inputNombre.addEventListener('input', () => {
                // Solo letras y espacios
                inputNombre.value = inputNombre.value.replace(/[^A-Za-zÁÉÍÓÚÜÑáéíóúüñ\s]/g, '');
            });
        }

        if (inputDni) {
            inputDni.addEventListener('input', () => {
                // Solo dígitos, máximo 8
                inputDni.value = inputDni.value.replace(/\D/g, '').slice(0, 8);
            });
        }
    });
</script>

</body>
</html>
