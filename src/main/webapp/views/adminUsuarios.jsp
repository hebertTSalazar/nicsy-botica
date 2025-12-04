<%-- 
    Document   : adminUsuarios
    Created on : 25 nov 2025, 1:12:00
    Author     : frank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="pe.nicsy.botica.model.Usuario"%>

<%
    List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuarios");
    String msg = (String) request.getAttribute("msg");
%>

<!-- ====== INCLUDE: LAYOUT ADMIN (SIDEBAR + CONTENIDO) ====== -->
<%@include file="adminLayout.jspf" %>


<!-- ============================================================
     TÍTULO Y CABECERA
     ============================================================ -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-danger">
        <i class="bi bi-people-fill"></i> Gestión de Usuarios
    </h3>

    <button class="btn btn-danger fw-semibold" data-bs-toggle="modal" data-bs-target="#modalNuevoUsuario">
        <i class="bi bi-person-plus-fill"></i> Nuevo usuario
    </button>
</div>


<!-- ============================================================
     MENSAJE DE OPERACIÓN (INSERTAR / EDITAR / ELIMINAR)
     ============================================================ -->
<%
    if (msg != null) {
        String tipo = "alert-success";

        if (msg.contains("eliminado")) tipo = "alert-danger";
        if (msg.contains("actualizado")) tipo = "alert-primary";
%>

<div class="alert <%= tipo %> alert-dismissible fade show shadow-sm text-center fw-semibold">
    <%= msg %>
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>

<% } %>


<!-- ============================================================
     TABLA DE USUARIOS
     ============================================================ -->
<div class="card shadow-sm mb-5">
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-hover align-middle text-center">
                <thead style="background:#ffd7d7;">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Rol</th>
                        <th>Estado</th>
                        <th>Correo</th>
                        <th>Teléfono</th>
                        <th>DNI</th>
                        <th>Edad</th>
                        <th>Acciones</th>
                    </tr>
                </thead>

                <tbody>
                    <%
                        if (usuarios != null && !usuarios.isEmpty()) {
                            for (Usuario u : usuarios) {
                    %>
                    <tr>
                        <td><%= u.getIdUsuario() %></td>
                        <td><%= u.getNombre() %></td>
                        <td><%= u.getRol() %></td>
                        <td><%= u.getEstado() %></td>
                        <td><%= u.getCorreo() %></td>
                        <td><%= u.getTelefono() %></td>
                        <td><%= u.getDni() %></td>
                        <td><%= u.getEdad() %></td>

                        <td>
                            <button type="button"
                                    class="btn btn-sm btn-outline-primary btn-editar-usuario"
                                    data-id="<%= u.getIdUsuario() %>"
                                    data-nombre="<%= u.getNombre() %>"
                                    data-rol="<%= u.getRol() %>"
                                    data-estado="<%= u.getEstado() %>"
                                    data-correo="<%= u.getCorreo() %>"
                                    data-telefono="<%= u.getTelefono() %>"
                                    data-dni="<%= u.getDni() %>"
                                    data-edad="<%= u.getEdad() %>"
                                    data-bs-toggle="modal"
                                    data-bs-target="#modalEditarUsuario">
                                <i class="bi bi-pencil"></i>
                            </button>

                            <a href="<%=request.getContextPath()%>/AdminUsuarioServlet?accion=eliminar&id=<%= u.getIdUsuario() %>"
                               class="btn btn-sm btn-outline-danger"
                               onclick="return confirm('¿Seguro que desea eliminar este usuario?');">
                                <i class="bi bi-trash"></i>
                            </a>
                        </td>
                    </tr>

                    <%
                            }
                        } else {
                    %>

                    <tr>
                        <td colspan="9" class="text-muted py-3">No hay usuarios registrados.</td>
                    </tr>

                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>



<!-- ============================================================
     MODAL: NUEVO USUARIO
     ============================================================ -->
<div class="modal fade" id="modalNuevoUsuario" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">

            <form action="<%=request.getContextPath()%>/AdminUsuarioServlet" method="post">
                <input type="hidden" name="accion" value="insertar">

                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">
                        <i class="bi bi-person-plus-fill"></i> Registrar nuevo usuario
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">

                    <div class="row g-3">

                        <div class="col-md-6">
                            <label class="form-label">Nombre completo</label>
                            <input type="text" name="nombre" class="form-control" required>
                        </div>

                        <div class="col-md-3">
                            <label class="form-label">Rol</label>
                            <select name="rol" class="form-select" required>
                                <option>Administrador</option>
                                <option>Cajero</option>
                                <option>Cliente</option>
                            </select>
                        </div>

                        <div class="col-md-3">
                            <label class="form-label">Estado</label>
                            <select name="estado" class="form-select" required>
                                <option>Verificado</option>
                                <option>Pendiente</option>
                                <option>Bloqueado</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Correo</label>
                            <input type="email" name="correo" class="form-control" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Teléfono</label>
                            <input type="text" name="telefono" class="form-control">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">DNI</label>
                            <input type="text" name="dni" class="form-control">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Edad</label>
                            <input type="number" name="edad" class="form-control" min="0">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Contraseña</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Confirmar contraseña</label>
                            <input type="password" name="password2" class="form-control" required>
                        </div>

                    </div>

                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-danger">Registrar usuario</button>
                </div>

            </form>

        </div>
    </div>
</div>



<!-- ============================================================
     MODAL: EDITAR USUARIO
     ============================================================ -->
<div class="modal fade" id="modalEditarUsuario" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">

            <form action="<%=request.getContextPath()%>/AdminUsuarioServlet" method="post">
                <input type="hidden" name="accion" value="actualizar">
                <input type="hidden" id="edit-id" name="id">

                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">
                        <i class="bi bi-pencil-square"></i> Editar usuario
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <div class="row g-3">

                        <div class="col-md-6">
                            <label class="form-label">Nombre</label>
                            <input type="text" id="edit-nombre" name="nombre" class="form-control" required>
                        </div>

                        <div class="col-md-3">
                            <label class="form-label">Rol</label>
                            <select id="edit-rol" name="rol" class="form-select">
                                <option>Administrador</option>
                                <option>Cajero</option>
                                <option>Cliente</option>
                            </select>
                        </div>

                        <div class="col-md-3">
                            <label class="form-label">Estado</label>
                            <select id="edit-estado" name="estado" class="form-select">
                                <option>Verificado</option>
                                <option>Pendiente</option>
                                <option>Bloqueado</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Correo</label>
                            <input type="email" id="edit-correo" name="correo" class="form-control" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Teléfono</label>
                            <input type="text" id="edit-telefono" name="telefono" class="form-control">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">DNI</label>
                            <input type="text" id="edit-dni" name="dni" class="form-control">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Edad</label>
                            <input type="number" id="edit-edad" name="edad" class="form-control" min="0">
                        </div>

                        <small class="text-muted mt-2">
                            * La contraseña no se modifica desde este formulario por seguridad.
                        </small>

                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-danger">Guardar cambios</button>
                </div>

            </form>

        </div>
    </div>
</div>



<!-- ====== INCLUDE: FIN DEL LAYOUT ====== -->
<%@include file="adminLayoutEnd.jspf" %>


<!-- ============================================================
     SCRIPT: LLENAR MODAL EDITAR USUARIO
     ============================================================ -->
<script>
document.querySelectorAll('.btn-editar-usuario').forEach(btn => {
    btn.addEventListener('click', () => {
        document.getElementById('edit-id').value = btn.dataset.id;
        document.getElementById('edit-nombre').value = btn.dataset.nombre;
        document.getElementById('edit-rol').value = btn.dataset.rol;
        document.getElementById('edit-estado').value = btn.dataset.estado;
        document.getElementById('edit-correo').value = btn.dataset.correo;
        document.getElementById('edit-telefono').value = btn.dataset.telefono;
        document.getElementById('edit-dni').value = btn.dataset.dni;
        document.getElementById('edit-edad').value = btn.dataset.edad;
    });
});
</script>
