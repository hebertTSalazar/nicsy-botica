<%-- 
    Document   : panelCajero
    Created on : 29 oct 2025, 22:38:33
    Author     : frank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="pe.nicsy.botica.model.Usuario"%>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    // Seguridad: solo CAJERO o ADMIN
    if (usuario == null || 
        (!"CAJERO".equalsIgnoreCase(usuario.getRol()) && !"ADMIN".equalsIgnoreCase(usuario.getRol()))) {

        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        return;
    }
%>

<!-- ====== INCLUDE LAYOUT UNIFICADO ====== -->
<%@include file="adminLayout.jspf" %>

<!-- ============================================================
     TÍTULO PRINCIPAL DEL PANEL CAJERO
     ============================================================ -->
<h3 class="fw-bold text-danger mb-2">
    <i class="bi bi-cash-coin"></i> Panel del Cajero
</h3>

<p class="welcome mb-4">
    Bienvenido, <strong><%= usuario.getNombreUsuario() %></strong>.  
    Desde este módulo puedes registrar ventas, consultar stock y revisar tus operaciones.
</p>



<!-- ============================================================
     TARJETAS DE ACCIÓN PARA EL CAJERO
     ============================================================ -->
<div class="row g-4 mb-4">

    <!-- Registrar Venta -->
    <div class="col-md-4">
        <a href="<%=request.getContextPath()%>/catalogo" class="text-decoration-none">
            <div class="card p-4 text-center shadow-sm">
                <i class="bi bi-cart-plus fs-1"></i>
                <h5 class="fw-bold mt-3 text-danger">Registrar Venta</h5>
                <p class="text-muted small">Buscar productos, agregar al carrito y generar boleta.</p>
            </div>
        </a>
    </div>

    <!-- Consultar Stock -->
    <div class="col-md-4">
        <a href="<%=request.getContextPath()%>/AdminProductoServlet?accion=listar" class="text-decoration-none">
            <div class="card p-4 text-center shadow-sm">
                <i class="bi bi-box2-heart fs-1"></i>
                <h5 class="fw-bold mt-3 text-danger">Consultar Stock</h5>
                <p class="text-muted small">Ver inventario actualizado y lotes.</p>
            </div>
        </a>
    </div>

    <!-- Historial de Ventas -->
    <div class="col-md-4">
        <a href="#" class="text-decoration-none">
            <div class="card p-4 text-center shadow-sm">
                <i class="bi bi-clock-history fs-1"></i>
                <h5 class="fw-bold mt-3 text-danger">Historial de Ventas</h5>
                <p class="text-muted small">Revisa tus ventas realizadas.</p>
            </div>
        </a>
    </div>

</div>



<!-- ============================================================
     NOTA IMPORTANTE
     ============================================================ -->
<div class="alert alert-primary d-flex align-items-center shadow-sm" role="alert">
    <i class="bi bi-info-circle-fill me-2 fs-5"></i>
    Este módulo está diseñado para la gestión diaria de ventas y atención al cliente.
</div>


<!-- ====== INCLUDE FIN LAYOUT ====== -->
<%@include file="adminLayoutEnd.jspf" %>
