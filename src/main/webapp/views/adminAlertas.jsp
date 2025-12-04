<%-- 
    Document   : adminAlertas
    Created on : 31 oct 2025, 12:37:46
    Author     : frank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="pe.nicsy.botica.model.Producto"%>
<%@page import="pe.nicsy.botica.model.LotePorVencer"%>

<%
    List<Producto> stockBajo = (List<Producto>) request.getAttribute("stockBajo");
    List<LotePorVencer> lotesVencer = (List<LotePorVencer>) request.getAttribute("lotesVencer");
%>

<!-- ====== INCLUDE: LAYOUT ADMIN (SIDEBAR + CONTENIDO) ====== -->
<%@include file="adminLayout.jspf" %>


<!-- ============================================================
     TITULO Y DESCRIPCIÓN
     ============================================================ -->
<div class="mb-4">
    <h3 class="fw-bold text-danger">
        <i class="bi bi-bell-fill"></i> Alertas del Sistema
    </h3>
    <p class="text-muted">
        Monitorea productos con stock bajo y lotes próximos a vencer.
    </p>
</div>


<!-- ============================================================
     SECCIÓN 1: PRODUCTOS CON STOCK BAJO
     ============================================================ -->

<div class="card shadow-sm mb-5">
    <div class="card-header bg-danger text-white d-flex align-items-center">
        <i class="bi bi-arrow-down-circle-fill me-2"></i>
        <h5 class="mb-0 fw-bold">Productos con stock bajo</h5>
    </div>

    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-hover align-middle text-center">
                <thead style="background:#ffd7d7;">
                    <tr>
                        <th>Producto</th>
                        <th>Categoría</th>
                        <th>Precio (S/)</th>
                        <th>Stock</th>
                    </tr>
                </thead>

                <tbody>
                    <%
                        if (stockBajo != null && !stockBajo.isEmpty()) {
                            for (Producto p : stockBajo) {
                    %>
                    <tr>
                        <td><%= p.getNombre() %></td>
                        <td><%= p.getCategoria() %></td>
                        <td>S/ <%= p.getPrecio() %></td>
                        <td class="text-danger fw-bold"><%= p.getStock() %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="4" class="text-muted py-3">
                            No hay productos con stock bajo.
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>



<!-- ============================================================
     SECCIÓN 2: LOTES PRÓXIMOS A VENCER
     ============================================================ -->

<div class="card shadow-sm mb-5">
    <div class="card-header bg-warning text-dark d-flex align-items-center">
        <i class="bi bi-hourglass-split me-2"></i>
        <h5 class="mb-0 fw-bold">Lotes próximos a vencer</h5>
    </div>

    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-hover align-middle text-center">
                <thead style="background:#fff3cd;">
                    <tr>
                        <th>Producto</th>
                        <th>Fecha de vencimiento</th>
                        <th>Cantidad</th>
                    </tr>
                </thead>

                <tbody>
                    <%
                        if (lotesVencer != null && !lotesVencer.isEmpty()) {
                            for (LotePorVencer l : lotesVencer) {
                    %>
                    <tr>
                        <td><%= l.getNombreProducto() %></td>
                        <td><%= l.getFechaVencimiento() %></td>
                        <td><%= l.getCantidad() %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="3" class="text-muted py-3">
                            No hay lotes próximos a vencer.
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>


<!-- ====== INCLUDE: FIN DEL LAYOUT ====== -->
<%@include file="adminLayoutEnd.jspf" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
