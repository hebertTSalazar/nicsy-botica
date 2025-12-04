<%-- 
    Document   : resultadoCompra
    Created on : 28 nov 2025, 18:26:43
    Author     : frank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="pe.nicsy.botica.model.VentaResultado"%>

<%
    VentaResultado vr = (VentaResultado) request.getAttribute("ventaResultado");
    String nombreCliente = (String) request.getAttribute("nombreCliente");
    String metodoEntrega = (String) request.getAttribute("metodoEntrega");

    if (vr == null) {
        vr = new VentaResultado(0, "N/A", BigDecimal.ZERO, BigDecimal.ZERO, BigDecimal.ZERO);
    }
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
                <div class="col-md-8 col-lg-6">
                    <div class="card shadow-sm border-0">
                        <div class="card-body text-center p-4">
                            <i class="bi bi-check-circle-fill text-success" style="font-size:3rem;"></i>
                            <h3 class="mt-3">¡Tu pago ha sido realizado con éxito!</h3>

                            <p class="text-muted mt-2">
                                Gracias <strong><%= nombreCliente != null ? nombreCliente : "" %></strong> 
                                por confiar en <strong>Botica Nicsy</strong>.
                            </p>

                            <div class="mt-3 text-start">
                                <h6 class="fw-bold">Detalle de la operación</h6>
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item d-flex justify-content-between">
                                        <span>N° de comprobante:</span>
                                        <strong><%= vr.getNumeroComprobante() %></strong>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between">
                                        <span>Subtotal:</span>
                                        <span>S/ <%= vr.getSubtotal() %></span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between">
                                        <span>Envío:</span>
                                        <span>S/ <%= vr.getEnvio() %></span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between">
                                        <span>Total pagado:</span>
                                        <span class="fw-bold text-danger">S/ <%= vr.getTotal() %></span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between">
                                        <span>Método de entrega:</span>
                                        <span class="text-capitalize">
                                            <%= metodoEntrega != null ? metodoEntrega : "" %>
                                        </span>
                                    </li>
                                </ul>
                            </div>

                            <div class="mt-4">
                                <!-- Botón REAL que llama al servlet PDF -->
                                <a href="<%=request.getContextPath()%>/ComprobantePdfServlet"
                                   class="btn btn-outline-primary w-100 mb-2">
                                    <i class="bi bi-file-earmark-arrow-down"></i>
                                    Descargar comprobante (PDF)
                                </a>

                                <a href="<%=request.getContextPath()%>/catalogo"
                                   class="btn btn-danger w-100 mt-1">
                                    <i class="bi bi-bag"></i> Seguir comprando
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <%@include file="footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
