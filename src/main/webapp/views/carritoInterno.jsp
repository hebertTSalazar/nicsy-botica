<%-- 
    Document   : carritoInterno
    Created on : 3 dic 2025, 22:19:48
    Author     : frank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="pe.nicsy.botica.model.ItemCarritoInterno"%>

<%
    List<ItemCarritoInterno> carrito = (List<ItemCarritoInterno>) session.getAttribute("carritoInterno");
    double total = 0;

    if (carrito != null) {
        for (ItemCarritoInterno item : carrito) {
            total += item.getSubtotal();
        }
    }
%>

<!-- ====== LAYOUT UNIFICADO ====== -->
<%@include file="adminLayout.jspf" %>

<h3 class="fw-bold text-danger mb-4">
    <i class="bi bi-cart-check"></i> Carrito de Venta Interna
</h3>

<div class="card shadow-sm mb-4">
    <div class="card-body">

        <%
            if (carrito == null || carrito.isEmpty()) {
        %>
        <p class="text-center text-muted">El carrito está vacío.</p>

        <div class="text-center mt-3">
            <a href="VentasInternasServlet" class="btn btn-danger">
                <i class="bi bi-arrow-left"></i> Volver a productos
            </a>
        </div>

        <% } else { %>

        <div class="table-responsive">
            <table class="table table-hover align-middle text-center">
                <thead style="background:#ffd7d7;">
                    <tr>
                        <th>Producto</th>
                        <th>Precio</th>
                        <th>Cantidad</th>
                        <th>Subtotal</th>
                        <th>Quitar</th>
                    </tr>
                </thead>

                <tbody>
                    <% for (ItemCarritoInterno item : carrito) { %>
                    <tr>
                        <td><strong><%= item.getNombre() %></strong></td>
                        <td>S/ <%= item.getPrecio() %></td>

                        <td>
                            <form action="CarritoInternoServlet" method="post" class="d-flex">
                                <input type="hidden" name="accion" value="actualizar">
                                <input type="hidden" name="id" value="<%= item.getIdProducto() %>">
                                <input type="number" name="cantidad"
                                       min="1"
                                       max="<%= item.getStock() %>"
                                       value="<%= item.getCantidad() %>"
                                       class="form-control me-2" style="width:90px;">
                                <button class="btn btn-outline-primary btn-sm">✔</button>
                            </form>
                        </td>

                        <td>S/ <%= item.getSubtotal() %></td>

                        <td>
                            <a href="CarritoInternoServlet?accion=eliminar&id=<%= item.getIdProducto() %>"
                               class="btn btn-sm btn-outline-danger">
                                <i class="bi bi-trash"></i>
                            </a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>

                <tfoot>
                    <tr>
                        <th colspan="3" class="text-end">TOTAL:</th>
                        <th>S/ <%= total %></th>
                        <th></th>
                    </tr>
                </tfoot>

            </table>
        </div>

        <div class="d-flex justify-content-between mt-4">

            <a href="VentasInternasServlet" class="btn btn-outline-danger">
                <i class="bi bi-arrow-left"></i> Seguir comprando
            </a>

            <a href="RegistrarVentaInternaServlet" class="btn btn-danger btn-lg">
                <i class="bi bi-receipt"></i> Procesar venta
            </a>

        </div>

        <% } %>

    </div>
</div>

<!-- ====== FIN LAYOUT ====== -->
<%@include file="adminLayoutEnd.jspf" %>
