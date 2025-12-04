<%-- 
    Document   : panelAdmin
    Created on : 29 oct 2025, 22:38:01
    Author     : frank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="pe.nicsy.botica.model.Producto"%>
<%@page import="pe.nicsy.botica.model.LotePorVencer"%>

<%
    List<Producto> productos = (List<Producto>) request.getAttribute("productos");
    List<LotePorVencer> alertas = (List<LotePorVencer>) request.getAttribute("alertas");
%>

<!-- ====== INCLUDE LAYOUT (SIDEBAR + INICIO CONTENIDO) ====== -->
<%@include file="adminLayout.jspf" %>

<!-- ============================================================
     TÍTULO PRINCIPAL DEL DASHBOARD
     ============================================================ -->
<h3 class="fw-bold text-danger mb-4">
    <i class="bi bi-speedometer2"></i> Panel del Administrador
</h3>

<p class="welcome mb-4">
    Bienvenido al <strong>Sistema de Gestión Interna de Botica Nicsy</strong>.  
    Aquí puedes administrar productos, lotes, usuarios, alertas, ventas y más.
</p>


<!-- ============================================================
     TARJETAS DE ACCESO RÁPIDO
     ============================================================ -->
<div class="row g-4 mb-5">

    <!-- Productos -->
    <div class="col-md-4">
        <a href="<%=request.getContextPath()%>/AdminProductoServlet?accion=listar" class="text-decoration-none">
            <div class="card p-4 text-center shadow-sm">
                <i class="bi bi-box-seam fs-1"></i>
                <h5 class="fw-bold mt-3 text-danger">Productos</h5>
                <p class="text-muted small">
                    Gestiona los productos, precios, categorías e inventario.
                </p>
            </div>
        </a>
    </div>

    <!-- Lotes -->
    <div class="col-md-4">
        <a href="<%=request.getContextPath()%>/AdminProductoServlet?accion=lotes&id=1" class="text-decoration-none">
            <div class="card p-4 text-center shadow-sm">
                <i class="bi bi-layers fs-1"></i>
                <h5 class="fw-bold mt-3 text-danger">Lotes</h5>
                <p class="text-muted small">
                    Control de lotes, ingresos y fechas de vencimiento (FEFO).
                </p>
            </div>
        </a>
    </div>

    <!-- Usuarios -->
    <div class="col-md-4">
        <a href="<%=request.getContextPath()%>/AdminUsuarioServlet?accion=listar" class="text-decoration-none">
            <div class="card p-4 text-center shadow-sm">
                <i class="bi bi-people-fill fs-1"></i>
                <h5 class="fw-bold mt-3 text-danger">Usuarios</h5>
                <p class="text-muted small">
                    Administra cajeros, administradores y clientes del sistema.
                </p>
            </div>
        </a>
    </div>

</div>



<!-- ============================================================
     SECCIÓN DE ALERTAS DEL SISTEMA
     ============================================================ -->
<h5 class="fw-bold text-danger mb-3">
    <i class="bi bi-bell"></i> Alertas importantes del sistema
</h5>

<div class="row g-4">

    <!-- Stock bajo -->
    <div class="col-md-6">
        <div class="card border-danger shadow-sm">
            <div class="card-body">
                <h6 class="fw-bold mb-3 text-danger">
                    <i class="bi bi-arrow-down-circle"></i> Productos con stock bajo
                </h6>

                <div style="max-height: 220px; overflow-y: auto;">
                    <ul class="list-group">

                        <%
                            if (productos != null && !productos.isEmpty()) {
                                boolean hayStockBajo = false;
                                for (Producto p : productos) {
                                    if (p.getStock() <= 10) {
                                        hayStockBajo = true;
                        %>

                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <span><strong><%= p.getNombre() %></strong></span>
                            <span class="badge bg-danger">Stock: <%= p.getStock() %></span>
                        </li>

                        <% 
                                    }
                                }
                                if (!hayStockBajo) { 
                        %>

                        <li class="list-group-item text-muted text-center">
                            No hay productos con stock bajo.
                        </li>

                        <%   }
                           } else { %>
                        <li class="list-group-item text-muted text-center">
                            No hay productos registrados.
                        </li>
                        <% } %>

                    </ul>
                </div>

            </div>
        </div>
    </div>


    <!-- Lotes por vencer -->
    <div class="col-md-6">
        <div class="card border-danger shadow-sm">
            <div class="card-body">
                <h6 class="fw-bold mb-3 text-danger">
                    <i class="bi bi-hourglass-split"></i> Lotes próximos a vencer
                </h6>

                <div style="max-height: 220px; overflow-y: auto;">
                    <ul class="list-group">

                        <%
                            if (alertas != null && !alertas.isEmpty()) {
                                for (LotePorVencer l : alertas) {
                        %>

                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <span><strong><%= l.getNombreProducto() %></strong></span>
                            <span class="badge bg-warning text-dark">
                                Vence: <%= l.getFechaVencimiento() %>
                            </span>
                        </li>

                        <%  }
                           } else { %>

                        <li class="list-group-item text-muted text-center">
                            No hay lotes próximos a vencer.
                        </li>

                        <% } %>

                    </ul>
                </div>

            </div>
        </div>
    </div>

</div>


<!-- ====== FIN DEL LAYOUT ADMIN ====== -->
<%@include file="adminLayoutEnd.jspf" %>
