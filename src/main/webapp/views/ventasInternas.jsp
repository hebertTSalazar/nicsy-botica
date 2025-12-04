<%-- 
    Document   : ventasInternas
    Created on : 3 dic 2025, 21:28:39
    Author     : frank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="pe.nicsy.botica.model.Producto"%>
<%@page import="pe.nicsy.botica.model.Usuario"%>

<%
    // Seguridad: solo ADMIN o CAJERO pueden vender
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null ||
       (!"Administrador".equalsIgnoreCase(usuario.getRol()) &&
        !"Cajero".equalsIgnoreCase(usuario.getRol()))) {

        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        return;
    }

    List<Producto> productos = (List<Producto>) request.getAttribute("productos");
%>

<!-- ====== INICIO LAYOUT PANEL INTERNO ====== -->
<%@include file="adminLayout.jspf" %>

<h3 class="fw-bold text-danger mb-4">
    <i class="bi bi-cart-check"></i> Registrar Venta Interna
</h3>

<p class="welcome mb-3">
    Desde aquí puedes buscar productos, agregarlos al carrito y generar una boleta.
</p>


<!-- ============================================================
     BUSCADOR DE PRODUCTOS
     ============================================================ -->
<div class="card shadow-sm p-3 mb-4">
    <form class="row g-3" method="get" action="VentasInternasServlet">
        <div class="col-md-10">
            <input type="text" name="q" class="form-control"
                   placeholder="Buscar producto por nombre o categoría...">
        </div>
        <div class="col-md-2 d-grid">
            <button class="btn btn-danger">
                <i class="bi bi-search"></i> Buscar
            </button>
        </div>
    </form>
</div>


<!-- ============================================================
     TABLA DE PRODUCTOS (STOCK REAL / LOTE)
     ============================================================ -->
<div class="card shadow-sm mb-4">
    <div class="card-body">

        <h5 class="fw-bold text-danger mb-3">Productos disponibles</h5>

        <div class="table-responsive">
            <table class="table table-hover align-middle text-center">
                <thead style="background:#ffd7d7;">
                    <tr>
                        <th>Imagen</th>
                        <th>Producto</th>
                        <th>Categoría</th>
                        <th>Precio</th>
                        <th>Stock</th>
                        <th>Agregar</th>
                    </tr>
                </thead>

                <tbody>
                    <%
                        if (productos != null && !productos.isEmpty()) {
                            for (Producto p : productos) {
                    %>
                    <tr>
                        <td>
                            <img src="<%=request.getContextPath()%>/<%=p.getImagenUrl()%>"
                                 width="60" height="60" class="rounded shadow-sm">
                        </td>

                        <td><strong><%= p.getNombre() %></strong></td>
                        <td><%= p.getCategoria() %></td>
                        <td>S/ <%= p.getPrecio() %></td>
                        <td class="<%= (p.getStock() <= 10 ? "text-danger fw-bold" : "") %>">
                            <%= p.getStock() %>
                        </td>

                        <td>
                            <button class="btn btn-sm btn-outline-danger btn-add"
                                data-id="<%= p.getIdProducto() %>"
                                data-nombre="<%= p.getNombre() %>"
                                data-precio="<%= p.getPrecio() %>"
                                data-stock="<%= p.getStock() %>"
                                data-bs-toggle="modal"
                                data-bs-target="#modalAgregar">
                                <i class="bi bi-plus-lg"></i>
                            </button>
                        </td>
                    </tr>
                    <% } } else { %>
                    <tr>
                        <td colspan="6" class="text-muted py-3">
                            No se encontraron productos.
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

    </div>
</div>


<!-- ============================================================
     MODAL: AGREGAR PRODUCTO AL CARRITO INTERNO
     ============================================================ -->
<div class="modal fade" id="modalAgregar" tabindex="-1">
    <div class="modal-dialog">
        <form method="post" action="CarritoInternoServlet" class="modal-content">

            <input type="hidden" name="accion" value="agregar">
            <input type="hidden" id="idProducto" name="idProducto">

            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title">Agregar a la venta</h5>
                <button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <p><strong>Producto:</strong> <span id="nombreProducto"></span></p>
                <p><strong>Stock disponible:</strong> <span id="stockProducto"></span></p>

                <label>Cantidad</label>
                <input type="number" min="1" id="cantidad" name="cantidad"
                       class="form-control" required>
            </div>

            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button class="btn btn-danger" type="submit">Agregar</button>
            </div>

        </form>
    </div>
</div>


<!-- ============================================================
     BOTÓN IR AL CARRITO / GENERAR VENTA
     ============================================================ -->
<div class="text-end mb-5">
    <a href="CarritoInternoServlet?accion=ver" class="btn btn-danger btn-lg">
        <i class="bi bi-receipt"></i> Ir al carrito de venta
    </a>
</div>


<!-- ====== FIN LAYOUT ====== -->
<%@include file="adminLayoutEnd.jspf" %>


<!-- ============================================================
     SCRIPT: ENVIAR DATOS AL MODAL
     ============================================================ -->
<script>
document.querySelectorAll('.btn-add').forEach(btn => {
    btn.addEventListener('click', () => {
        document.getElementById("idProducto").value = btn.dataset.id;
        document.getElementById("nombreProducto").innerText = btn.dataset.nombre;
        document.getElementById("stockProducto").innerText = btn.dataset.stock;
        document.getElementById("cantidad").value = 1;
        document.getElementById("cantidad").max = btn.dataset.stock;
    });
});
</script>
