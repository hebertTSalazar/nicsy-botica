<%-- 
    Document   : adminProductos
    Created on : 31 oct 2025, 13:03:11
    Author     : frank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="pe.nicsy.botica.model.Producto"%>
<%@page import="pe.nicsy.botica.model.LotePorVencer"%>

<%
    List<Producto> productos = (List<Producto>) request.getAttribute("productos");
    List<LotePorVencer> alertas = (List<LotePorVencer>) request.getAttribute("alertas");
    String msg = (String) request.getAttribute("msg");
%>

<!-- ====== INCLUDE: SIDEBAR + LAYOUT BASE ====== -->
<%@include file="adminLayout.jspf" %>

<!-- ===============================================
     CONTENIDO PRINCIPAL — GESTIÓN DE PRODUCTOS
     =============================================== -->

<div class="d-flex flex-wrap justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold text-danger">Gestión de Productos</h3>
        <p class="text-muted mb-0">Administra productos, controla stock y fechas de vencimiento (FEFO).</p>
    </div>

    <div>
        <a href="<%=request.getContextPath()%>/AdminUsuarioServlet?accion=listar"
           class="btn btn-outline-danger">
            <i class="bi bi-people-fill"></i> Gestionar usuarios
        </a>
    </div>
</div>


<!-- ====== ALERTA DE OPERACIÓN (AGREGAR / EDITAR / ELIMINAR) ====== -->
<%
    if (msg != null) {
        String tipo = "alert-success";

        if (msg.contains("actualizado")) tipo = "alert-primary";
        if (msg.contains("eliminado")) tipo = "alert-danger";
%>

<div class="alert <%= tipo %> alert-dismissible fade show shadow-sm fw-semibold text-center">
    <%= msg %>
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>

<% } %>


<!-- ===============================================
     FILTROS DE BÚSQUEDA
     =============================================== -->

<div class="card shadow-sm mb-3 p-3">
    <form class="row g-3" method="get" action="AdminProductoServlet">
        <input type="hidden" name="accion" value="listar">

        <div class="col-md-6">
            <input type="text" class="form-control" name="q"
                   placeholder="Buscar producto...">
        </div>

        <div class="col-md-3">
            <select name="categoria" class="form-select">
                <option value="">Todas las categorías</option>
                <option value="Salud">Salud</option>
                <option value="Nutrición">Nutrición</option>
                <option value="Cuidado personal">Cuidado personal</option>
            </select>
        </div>

        <div class="col-md-3 d-grid">
            <button type="submit" class="btn btn-danger">
                <i class="bi bi-search"></i> Buscar
            </button>
        </div>
    </form>
</div>


<!-- ===============================================
     BOTÓN NUEVO PRODUCTO (FULL WIDTH)
     =============================================== -->

<button class="btn btn-danger w-100 mb-3 py-2 fw-semibold"
        data-bs-toggle="modal" data-bs-target="#modalAgregar">
    + Nuevo Producto
</button>


<!-- ===============================================
     TABLA DE PRODUCTOS
     =============================================== -->

<div class="card shadow-sm mb-5">
    <div class="table-responsive">
        <table class="table table-hover align-middle text-center">
            <thead style="background:#ffd7d7;">
                <tr>
                    <th>Producto</th>
                    <th>Categoría</th>
                    <th>Precio</th>
                    <th>Stock</th>
                    <th>Imagen</th>
                    <th>Acciones</th>
                </tr>
            </thead>

            <tbody>
                <%
                    if (productos != null && !productos.isEmpty()) {
                        for (Producto p : productos) {
                %>
                <tr>
                    <td><%= p.getNombre() %></td>
                    <td><%= p.getCategoria() %></td>
                    <td>S/ <%= p.getPrecio() %></td>

                    <td class="<%= p.getStock() <= 10 ? "text-danger fw-bold" : "" %>">
                        <%= p.getStock() %>
                    </td>

                    <td>
                        <% if (p.getImagenUrl() != null && !p.getImagenUrl().isEmpty()) { %>
                        <img src="<%= p.getImagenUrl() %>" width="55" height="55" class="rounded">
                        <% } else { %>
                        <span class="text-muted">Sin imagen</span>
                        <% } %>
                    </td>

                    <td>
                        <a href="<%=request.getContextPath()%>/AdminProductoServlet?accion=lotes&id=<%= p.getIdProducto() %>"
                           class="btn btn-sm btn-outline-secondary">
                            <i class="bi bi-eye"></i>
                        </a>

                        <button type="button"
                                class="btn btn-sm btn-outline-primary btn-editar"
                                data-id="<%= p.getIdProducto()%>"
                                data-nombre="<%= p.getNombre()%>"
                                data-categoria="<%= p.getCategoria()%>"
                                data-precio="<%= p.getPrecio()%>"
                                data-stock="<%= p.getStock()%>"
                                data-descripcion="<%= p.getDescripcion()%>"
                                data-imagen="<%= p.getImagenUrl()%>"
                                data-bs-toggle="modal"
                                data-bs-target="#modalEditar">
                            <i class="bi bi-pencil"></i>
                        </button>

                        <form method="post" action="AdminProductoServlet" class="d-inline">
                            <input type="hidden" name="accion" value="eliminar">
                            <input type="hidden" name="id" value="<%= p.getIdProducto() %>">
                            <button type="submit"
                                    class="btn btn-sm btn-outline-danger"
                                    onclick="return confirm('¿Seguro que desea eliminar este producto?');">
                                <i class="bi bi-trash"></i>
                            </button>
                        </form>
                    </td>
                </tr>

                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="6" class="text-muted py-3">
                        No hay productos registrados.
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>



<!-- ===============================================
     SECCIÓN: LOTES PRÓXIMOS A VENCER
     =============================================== -->

<h5 class="fw-bold text-danger mb-3">
    <i class="bi bi-hourglass-split"></i> Lotes próximos a vencer
</h5>

<div class="card shadow-sm mb-5">
    <div class="table-responsive">
        <table class="table table-bordered text-center align-middle">
            <thead style="background: #fff3cd;">
                <tr>
                    <th>Producto</th>
                    <th>Fecha de vencimiento</th>
                    <th>Cantidad</th>
                </tr>
            </thead>

            <tbody>
                <%
                    if (alertas != null && !alertas.isEmpty()) {
                        for (LotePorVencer l : alertas) {
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


<!-- ===============================================
     MODALES (AGREGAR Y EDITAR)
     =============================================== -->

<%@include file="modalesProductos.jspf" %>


<!-- ====== INCLUDE: FIN DEL LAYOUT ====== -->
<%@include file="adminLayoutEnd.jspf" %>


<!-- ===============================================
     SCRIPT: CARGA DE DATOS AL MODAL EDITAR
     =============================================== -->

<script>
document.querySelectorAll('.btn-editar').forEach(btn => {
    btn.addEventListener('click', () => {
        document.getElementById('edit-id').value = btn.dataset.id;
        document.getElementById('edit-nombre').value = btn.dataset.nombre;
        document.getElementById('edit-categoria').value = btn.dataset.categoria;
        document.getElementById('edit-precio').value = btn.dataset.precio;
        document.getElementById('edit-stock').value = btn.dataset.stock;
        document.getElementById('edit-descripcion').value = btn.dataset.descripcion || "";
        document.getElementById('edit-imagenUrl').value = btn.dataset.imagen || "";
    });
});
</script>
