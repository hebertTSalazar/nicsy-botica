<%-- 
    Document   : carrito
    Created on : 26 nov 2025, 23:29:08
    Author     : frank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="pe.nicsy.botica.model.ItemCarrito"%>

<%
    List<ItemCarrito> carrito = (List<ItemCarrito>) request.getAttribute("carrito");
    BigDecimal total = (BigDecimal) request.getAttribute("total");
    if (total == null) {
        total = BigDecimal.ZERO;
    }

    String msgOK = (String) request.getAttribute("msgCarritoOK");
    String msgError = (String) request.getAttribute("msgCarritoError");

    String msgOKSesion = (String) session.getAttribute("msgCarritoExito");
    String msgErrorSesion = (String) session.getAttribute("msgCarritoError");

    if (msgOK == null && msgOKSesion != null) {
        msgOK = msgOKSesion;
    }
    if (msgError == null && msgErrorSesion != null) {
        msgError = msgErrorSesion;
    }

    session.removeAttribute("msgCarritoExito");
    session.removeAttribute("msgCarritoError");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Carrito de Compras | Botica Nicsy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body class="bg-light">

<%@include file="header.jsp" %>

<main class="container my-4">
    <% if (msgOK != null) { %>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <%= msgOK %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } if (msgError != null) { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <%= msgError %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <div class="row g-4">

        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-danger text-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">
                        <i class="bi bi-cart-fill"></i> Carrito de compras
                    </h5>
                    <small class="text-white-50">
                        Revisa tus productos antes de finalizar la compra
                    </small>
                </div>
                <div class="card-body">

                    <%
                        if (carrito != null && !carrito.isEmpty()) {
                    %>

                    <div class="table-responsive">
                        <table class="table align-middle">
                            <thead class="table-light">
                            <tr>
                                <th>Producto</th>
                                <th class="text-center">Precio</th>
                                <th class="text-center">Cantidad</th>
                                <th class="text-end">Subtotal</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                for (ItemCarrito item : carrito) {
                            %>
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <img src="<%=request.getContextPath()%>/<%= item.getImagenUrl()%>"
                                             alt="Producto"
                                             class="rounded me-3"
                                             style="width:60px; height:60px; object-fit:cover;">
                                        <div>
                                            <strong><%= item.getNombre()%></strong><br>
                                            
                                        </div>
                                    </div>
                                </td>

                                <td class="text-center">
                                    S/ <%= item.getPrecioUnitario()%>
                                </td>

                                <td class="text-center" style="max-width:120px;">
                                    <form action="<%=request.getContextPath()%>/CarritoServlet" method="post" class="d-inline-flex">
                                        <input type="hidden" name="accion" value="actualizar">
                                        <input type="hidden" name="idProducto" value="<%= item.getIdProducto()%>">
                                        <input type="number"
                                               name="cantidad"
                                               value="<%= item.getCantidad()%>"
                                               min="1"
                                               class="form-control form-control-sm text-center">
                                        <button type="submit" class="btn btn-sm btn-outline-secondary ms-2">
                                            <i class="bi bi-arrow-clockwise"></i>
                                        </button>
                                    </form>
                                </td>

                                <td class="text-end">
                                    <strong>S/ <%= item.getSubtotal()%></strong>
                                </td>

                                <td class="text-end">
                                    <form action="<%=request.getContextPath()%>/CarritoServlet" method="post" class="d-inline">
                                        <input type="hidden" name="accion" value="eliminar">
                                        <input type="hidden" name="idProducto" value="<%= item.getIdProducto()%>">
                                        <button type="submit" class="btn btn-sm btn-outline-danger"
                                                onclick="return confirm('¿Quitar este producto del carrito?');">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                            </tbody>
                        </table>
                    </div>

                    <%
                        } else {
                    %>
                    <div class="text-center py-4">
                        <i class="bi bi-cart-x" style="font-size: 3rem; color:#b30000;"></i>
                        <h5 class="mt-3">Tu carrito está vacío</h5>
                        <p class="text-muted">Explora nuestro catálogo y agrega productos a tu compra.</p>
                        <a href="<%=request.getContextPath()%>/catalogo" class="btn btn-danger">
                            <i class="bi bi-bag"></i> Ver catálogo
                        </a>
                    </div>
                    <%
                        }
                    %>

                </div>

                <% if (carrito != null && !carrito.isEmpty()) { %>
                <div class="card-footer bg-light d-flex justify-content-between align-items-center">
                    <div>
                        <a href="<%=request.getContextPath()%>/catalogo"
                           class="btn btn-outline-secondary btn-sm me-2">
                            <i class="bi bi-bag"></i> Ver catálogo
                        </a>

                        <form action="<%=request.getContextPath()%>/CarritoServlet" method="post" class="d-inline">
                            <input type="hidden" name="accion" value="vaciar">
                            <button type="submit" class="btn btn-outline-danger btn-sm"
                                    onclick="return confirm('¿Vaciar todo el carrito?');">
                                <i class="bi bi-trash3"></i> Vaciar carrito
                            </button>
                        </form>
                    </div>
                </div>
                <% } %>
            </div>
        </div>

        <!-- Columna derecha: resumen -->
        <div class="col-lg-4">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white">
                    <h5 class="mb-0 text-danger">
                        <i class="bi bi-receipt"></i> Resumen de compra
                    </h5>
                </div>
                <div class="card-body">

                    <div class="d-flex justify-content-between mb-2">
                        <span>Subtotal:</span>
                        <strong>S/ <%= total %></strong>
                    </div>

                    <div class="d-flex justify-content-between mb-2">
                        <span>Envío:</span>
                       
                    </div>

                    <hr>

                    <div class="d-flex justify-content-between mb-3">
                        <span class="fw-bold">Total :</span>
                        <span class="fw-bold text-danger">S/ <%= total %></span>
                    </div>

                    <%
                        if (carrito != null && !carrito.isEmpty()) {
                    %>
                    <form action="<%=request.getContextPath()%>/CheckoutServlet" method="get">
                        <button type="submit" class="btn btn-danger w-100">
                            <i class="bi bi-credit-card"></i> Finalizar compra
                        </button>
                    </form>
                    <%
                        } else {
                    %>
                    <p class="text-muted">Agrega productos al carrito para continuar.</p>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>

    </div>
</main>

<%@include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
