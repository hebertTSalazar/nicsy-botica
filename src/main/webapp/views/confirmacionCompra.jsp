<%-- 
    Document   : confirmacionCompra
    Created on : 27 nov 2025, 2:23:55
    Author     : frank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.math.BigDecimal"%>

<%
    String nombreCompleto = (String) request.getAttribute("nombreCompleto");
    String codigoComprobante = (String) request.getAttribute("codigoComprobante");
    String metodoEntrega = (String) request.getAttribute("metodoEntrega");
    String direccion = (String) request.getAttribute("direccion");
    String referencia = (String) request.getAttribute("referencia");

    BigDecimal subtotal = (BigDecimal) request.getAttribute("subtotal");
    BigDecimal envio = (BigDecimal) request.getAttribute("envio");
    BigDecimal total = (BigDecimal) request.getAttribute("total");

    if (subtotal == null) subtotal = BigDecimal.ZERO;
    if (envio == null) envio = BigDecimal.ZERO;
    if (total == null) total = subtotal.add(envio);
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Compra realizada | Botica Nicsy</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    </head>
    <body class="bg-light">

        <%@include file="header.jsp" %>

        <main class="container my-5">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card shadow-sm border-0">
                        <div class="card-body text-center p-5">
                            <i class="bi bi-check-circle-fill"
                               style="font-size:3rem; color:#28a745;"></i>
                            <h3 class="mt-3 fw-bold">¡Tu pago ha sido realizado con éxito!</h3>
                            <p class="text-muted mt-2">
                                Gracias, <strong><%= nombreCompleto != null ? nombreCompleto : "cliente"%></strong>.
                                Hemos registrado tu compra correctamente.
                            </p>

                            <div class="mt-4 text-start">
                                <h5 class="fw-bold text-danger">Detalles de la compra</h5>
                                <ul class="list-group text-start mt-2">
                                    <li class="list-group-item d-flex justify-content-between">
                                        <span>Código de comprobante:</span>
                                        <strong><%= codigoComprobante %></strong>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between">
                                        <span>Subtotal productos:</span>
                                        <span>S/ <%= subtotal %></span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between">
                                        <span>Costo de envío:</span>
                                        <span>S/ <%= envio %></span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between">
                                        <span>Total pagado:</span>
                                        <span class="fw-bold text-danger">S/ <%= total %></span>
                                    </li>
                                    <li class="list-group-item">
                                        <span>Método de entrega: </span>
                                        <strong>
                                            <%= "delivery".equalsIgnoreCase(metodoEntrega) ?
                                                "Delivery a domicilio" : "Recojo en tienda" %>
                                        </strong><br>
                                        <% if ("delivery".equalsIgnoreCase(metodoEntrega)) { %>
                                        <small class="text-muted">
                                            Dirección: <%= direccion %><br>
                                            Referencia: <%= referencia %>
                                        </small>
                                        <% } %>
                                    </li>
                                </ul>
                            </div>

                            <div class="mt-4 d-flex justify-content-center gap-3 flex-wrap">
                                <!-- Aquí más adelante conectaremos a un Servlet que genere el PDF -->
                                <a href="#" class="btn btn-outline-danger">
                                    <i class="bi bi-file-earmark-arrow-down"></i> Descargar comprobante (próximo paso)
                                </a>

                                <a href="<%=request.getContextPath()%>/catalogo" class="btn btn-danger">
                                    <i class="bi bi-bag"></i> Volver al catálogo
                                </a>
                            </div>

                            <p class="text-muted small mt-4 mb-0">
                                * En la siguiente iteración conectaremos este comprobante con la base de datos
                                y la generación de PDF para tu informe.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <%@include file="footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

