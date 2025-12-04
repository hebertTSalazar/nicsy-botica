<%-- 
    Document   : adminLotes
    Created on : 31 oct 2025, 12:31:41
    Author     : frank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="pe.nicsy.botica.model.Lote"%>
<%@page import="pe.nicsy.botica.model.Producto"%>

<%
    Producto producto = (Producto) request.getAttribute("producto");
    List<Lote> lotes = (List<Lote>) request.getAttribute("lotes");
%>

<!-- ====== INCLUDE: LAYOUT ADMIN (SIDEBAR + CONTENIDO) ====== -->
<%@include file="adminLayout.jspf" %>


<!-- ============================================================
     TÍTULO Y DESCRIPCIÓN
     ============================================================ -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold text-danger">
            <i class="bi bi-layers"></i> Gestión de Lotes
        </h3>
        <p class="text-muted mb-0">Administra los lotes de cada producto y controla su fecha de vencimiento.</p>
    </div>

    <!-- Botón de nuevo lote -->
    <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#modalLote">
        <i class="bi bi-plus-lg"></i> Nuevo Lote
    </button>
</div>


<!-- ============================================================
     INFORMACIÓN PRINCIPAL DEL PRODUCTO
     ============================================================ -->
<% if (producto != null) { %>
<div class="card shadow-sm mb-4">
    <div class="card-body">
        <h5 class="fw-bold text-danger mb-3">Información del Producto</h5>

        <div class="row">
            <div class="col-md-4">
                <p><strong>Producto:</strong> <%= producto.getNombre() %></p>
            </div>
            <div class="col-md-4">
                <p><strong>Categoría:</strong> <%= producto.getCategoria() %></p>
            </div>
            <div class="col-md-4">
                <p><strong>Stock total:</strong> <%= producto.getStock() %></p>
            </div>
        </div>
    </div>
</div>
<% } %>


<!-- ============================================================
     TABLA DE LOTES
     ============================================================ -->

<div class="card shadow-sm mb-5">
    <div class="card-body">
        <h5 class="fw-bold text-danger mb-3">Lista de Lotes</h5>

        <div class="table-responsive">
            <table class="table table-hover align-middle text-center">
                <thead style="background:#ffd7d7;">
                    <tr>
                        <th>ID Lote</th>
                        <th>Fecha de Vencimiento</th>
                        <th>Cantidad</th>
                    </tr>
                </thead>

                <tbody>
                    <%
                        if (lotes != null && !lotes.isEmpty()) {
                            for (Lote l : lotes) {
                    %>
                    <tr>
                        <td><%= l.getIdLote() %></td>
                        <td><%= l.getFechaVencimiento() %></td>
                        <td><%= l.getCantidad() %></td>
                    </tr>

                    <%      }
                        } else {
                    %>
                    <tr>
                        <td colspan="3" class="text-muted py-3">
                            No hay lotes registrados para este producto.
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>


<!-- ============================================================
     MODAL: AGREGAR NUEVO LOTE
     ============================================================ -->
<div class="modal fade" id="modalLote" tabindex="-1" aria-labelledby="modalLoteLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form method="post" action="<%=request.getContextPath()%>/AdminProductoServlet" class="modal-content">

            <input type="hidden" name="accion" value="insertarLote">
            <input type="hidden" name="id_producto" value="<%= (producto != null) ? producto.getIdProducto() : "" %>">

            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title"><i class="bi bi-plus-circle"></i> Agregar Nuevo Lote</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

                <div class="mb-3">
                    <label class="form-label">Fecha de vencimiento</label>
                    <input type="date" class="form-control" name="fecha" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Cantidad</label>
                    <input type="number" class="form-control" name="cantidad" min="1" required>
                </div>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-danger">Guardar Lote</button>
            </div>

        </form>
    </div>
</div>


<!-- ====== INCLUDE: FIN DEL LAYOUT ====== -->
<%@include file="adminLayoutEnd.jspf" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
