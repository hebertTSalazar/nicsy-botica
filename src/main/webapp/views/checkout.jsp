<%-- 
    Document   : checkout
    Created on : 27 nov 2025, 2:23:05
    Author     : frank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.math.BigDecimal"%>

<%
    BigDecimal subtotal = (BigDecimal) request.getAttribute("subtotal");
    BigDecimal envio = (BigDecimal) request.getAttribute("envio");
    BigDecimal total = (BigDecimal) request.getAttribute("total");

    if (subtotal == null) subtotal = BigDecimal.ZERO;
    if (envio == null) envio = BigDecimal.ZERO;
    if (total == null) total = subtotal.add(envio);

    String errorCheckout = (String) request.getAttribute("errorCheckout");
    String metodoEntregaSeleccionado = (String) request.getAttribute("metodoEntregaSeleccionado");
    if (metodoEntregaSeleccionado == null) {
        metodoEntregaSeleccionado = "tienda"; // por defecto
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Finalizar compra | Botica Nicsy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body class="bg-light">

<%@include file="header.jsp" %>

<main class="container my-4">

    
    <div class="row mb-4">
        <div class="col">
            <div class="d-flex justify-content-center align-items-center gap-3 flex-wrap">
                <span class="badge bg-secondary">1. Carrito</span>
                <i class="bi bi-arrow-right"></i>
                <span class="badge bg-danger">2. Datos y pago</span>
                <i class="bi bi-arrow-right"></i>
                <span class="badge bg-secondary">3. Confirmación</span>
            </div>
        </div>
    </div>

    <div class="row g-4">

        
        <div class="col-lg-7">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-danger text-white">
                    <h5 class="mb-0">
                        <i class="bi bi-person-badge"></i> Datos del cliente
                    </h5>
                </div>
                <div class="card-body">

                    <% if (errorCheckout != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <%= errorCheckout %>
                    </div>
                    <% } %>

                    <form action="<%=request.getContextPath()%>/CheckoutServlet"
                          method="post"
                          id="formCheckout">
                        <input type="hidden" name="accion" value="confirmar">

                        <div class="mb-3">
                            <label class="form-label">Nombre completo</label>
                            <input type="text" name="nombreCompleto" class="form-control"
                                   value="<%= request.getParameter("nombreCompleto") != null ? request.getParameter("nombreCompleto") : "" %>"
                                   required>
                        </div>

                        <div class="row g-3">
                            <div class="col-md-4">
                                <label class="form-label">DNI</label>
                                <input type="text" name="dni" class="form-control"
                                       value="<%= request.getParameter("dni") != null ? request.getParameter("dni") : "" %>"
                                       required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Teléfono</label>
                                <input type="text" name="telefono" class="form-control"
                                       value="<%= request.getParameter("telefono") != null ? request.getParameter("telefono") : "" %>">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Email</label>
                                <input type="email" name="email" class="form-control"
                                       value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>"
                                       required>
                            </div>
                        </div>

                        <hr class="my-4">

                       
                        <h6 class="mb-3"><i class="bi bi-truck"></i> Método de entrega</h6>
                        <div class="mb-3">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="metodoEntrega"
                                       id="radioTienda" value="tienda"
                                       <%= "tienda".equalsIgnoreCase(metodoEntregaSeleccionado) ? "checked" : "" %>>
                                <label class="form-check-label" for="radioTienda">
                                    Recojo en tienda (sin costo de envío)
                                </label>
                            </div>

                            <div class="form-check mt-2">
                                <input class="form-check-input" type="radio" name="metodoEntrega"
                                       id="radioDelivery" value="delivery"
                                       <%= "delivery".equalsIgnoreCase(metodoEntregaSeleccionado) ? "checked" : "" %>>
                                <label class="form-check-label" for="radioDelivery">
                                    Delivery a domicilio
                                    <br>
                                    <small class="text-muted">
                                        * Si tu compra es mayor o igual a S/ 30, el delivery es <strong>GRATIS</strong>.
                                        De lo contrario, el costo es <strong>S/ 5.00</strong>.
                                    </small>
                                </label>
                            </div>
                        </div>

                        <!-- Datos de delivery (solo si se elige delivery) -->
                        <div id="bloque-delivery"
                             class="<%= "delivery".equalsIgnoreCase(metodoEntregaSeleccionado) ? "" : "d-none" %> mt-3">
                            <div class="mb-3">
                                <label class="form-label">Dirección de entrega</label>
                                <input type="text" name="direccion" class="form-control"
                                       value="<%= request.getParameter("direccion") != null ? request.getParameter("direccion") : "" %>">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Referencia del lugar</label>
                                <textarea name="referencia" class="form-control" rows="2"><%= request.getParameter("referencia") != null ? request.getParameter("referencia") : "" %></textarea>
                            </div>
                        </div>

                        <hr class="my-4">

                        
                        <h6 class="mb-3"><i class="bi bi-qr-code"></i> Pago con Yape / Plin</h6>
                        

                        <div class="d-grid">
                            
                            <button type="button"
                                    class="btn btn-danger btn-lg"
                                    id="btnMostrarQr">
                                <i class="bi bi-credit-card"></i> Finalizar compra
                            </button>
                        </div>
                    </form>

                </div>
            </div>
        </div>

        <!-- Columna derecha: resumen -->
        <div class="col-lg-5">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white">
                    <h5 class="mb-0 text-danger">
                        <i class="bi bi-receipt"></i> Resumen de compra
                    </h5>
                </div>
                <div class="card-body">

                    <div class="d-flex justify-content-between mb-2">
                        <span>Subtotal productos:</span>
                        <strong>S/ <span id="spanSubtotal"><%= subtotal %></span></strong>
                    </div>

                    <div class="d-flex justify-content-between mb-2">
                        <span>Envío:</span>
                        <strong>S/ <span id="spanEnvio"><%= envio %></span></strong>
                    </div>

                    <hr>

                    <div class="d-flex justify-content-between mb-3">
                        <span class="fw-bold">Total a pagar:</span>
                        <span class="fw-bold text-danger">
                            S/ <span id="spanTotal"><%= total %></span>
                        </span>
                    </div>

                    

                </div>
            </div>
        </div>
    </div>
</main>

<%@include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


<div class="modal fade" id="modalPago" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius:1rem; border:2px solid #b30000; background-color:#fffaf5;">
            <div class="modal-header bg-danger text-white" style="border-top-left-radius:1rem;border-top-right-radius:1rem;">
                <h5 class="modal-title">
                    <i class="bi bi-qr-code"></i> Pago con Yape
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>

            <div class="modal-body text-center">
                <p class="fw-bold mb-1 text-danger" style="font-size:1.4rem;">
                    S/ <span id="montoModal"><%= total %></span>
                </p>
                <p class="text-muted" style="margin-top:-6px;">Monto a pagar</p>

                <!-- QR REAL DEL DUEÑO (carpeta img) -->
                <img src="<%=request.getContextPath()%>/img/yapeqr.jpg"
                     alt="QR de pago Botica Nicsy"
                     style="max-width:250px; background-color:#ffffff;"
                     class="img-fluid border rounded mb-3">

                <div class="text-start small">
                    <p class="mb-1 fw-bold text-danger">Instrucciones:</p>
                    <ol class="mb-0 ps-3">
                        <li>Abre tu Yape o Plin.</li>
                        <li>Escanea el código QR de <strong>Botica Nicsy</strong>.</li>
                        <li>Verifica el monto y confirma el pago.</li>
                        <li>Presiona <strong>"He pagado"</strong> para registrar la compra.</li>
                    </ol>
                </div>
            </div>

            <div class="modal-footer" style="border-top:1px solid #f3d5cf;">
                <!-- Este botón ENVÍA el formulario original -->
                <button type="submit"
                        class="btn btn-danger w-100"
                        form="formCheckout">
                    <i class="bi bi-check-circle"></i> HE PAGADO
                </button>
            </div>

        </div>
    </div>
</div>

<script>
    // Mostrar/ocultar bloque de delivery y recalcular totales visualmente
    document.addEventListener('DOMContentLoaded', () => {
        const radioTienda = document.getElementById('radioTienda');
        const radioDelivery = document.getElementById('radioDelivery');
        const bloqueDelivery = document.getElementById('bloque-delivery');

        const spanEnvio = document.getElementById('spanEnvio');
        const spanTotal = document.getElementById('spanTotal');
        const spanSubtotal = document.getElementById('spanSubtotal');

        const subtotalNumber = parseFloat(spanSubtotal.textContent.replace(',', '.')) || 0;

        function actualizarEnvioYTotal() {
            let envio = 0;

            if (radioDelivery.checked) {
                if (subtotalNumber >= 30) {
                    envio = 0;
                } else {
                    envio = 5;
                }
                bloqueDelivery.classList.remove('d-none');
            } else {
                envio = 0;
                bloqueDelivery.classList.add('d-none');
            }

            spanEnvio.textContent = envio.toFixed(2);
            const totalCalc = subtotalNumber + envio;
            spanTotal.textContent = totalCalc.toFixed(2);
            document.getElementById('montoModal').textContent = totalCalc.toFixed(2);
        }

        radioTienda.addEventListener('change', actualizarEnvioYTotal);
        radioDelivery.addEventListener('change', actualizarEnvioYTotal);
        actualizarEnvioYTotal();

        // Botón que abre el modal con el QR
        const btnMostrarQr = document.getElementById('btnMostrarQr');
        const modalPago = new bootstrap.Modal(document.getElementById('modalPago'));

        btnMostrarQr.addEventListener('click', () => {
            actualizarEnvioYTotal();
            modalPago.show();
        });
    });
</script>

</body>
</html>
