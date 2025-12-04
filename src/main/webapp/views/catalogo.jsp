<%-- 
    Document   : catalogo
    Created on : 7 oct 2025, 0:30:20
    Author     : frank
--%>


<%@page import="java.util.List"%>
<%@page import="pe.nicsy.botica.model.Producto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Catálogo de Productos - Botica Nicsy</title>
        <link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body>
        
        <jsp:include page="header.jsp"/>

        <div class="content-wrapper">
            <main class="container my-4 flex-grow-1">
                <h3 class="mb-3 text-center fw-bold">Catálogo de Productos</h3>

                <!-- MENSAJE DE PRODUCTO AGREGADO AL CARRITO -->
                <% if (request.getAttribute("msgCarrito") != null) { %>
                    <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
                        <%= request.getAttribute("msgCarrito") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>

                <!-- Filtros de búsqueda -->
                <form class="row mb-4 align-items-center" method="get" action="<%=request.getContextPath()%>/catalogo">
                    <div class="col-md-6 mb-2">
                        <input type="text" class="form-control" name="q"
                               placeholder="Buscar producto..."
                               value="<%= request.getAttribute("q") != null ? request.getAttribute("q") : ""%>">
                    </div>

                    <div class="col-md-4 mb-2">
                        <select name="categoria" class="form-select">
                            <option value="">Todas las categorías</option>
                            <option value="Nutrición" <%= "Nutrición".equals(request.getAttribute("categoriaSeleccionada")) ? "selected" : ""%>>Nutrición</option>
                            <option value="Cuidado personal" <%= "Cuidado personal".equals(request.getAttribute("categoriaSeleccionada")) ? "selected" : ""%>>Cuidado personal</option>
                            <option value="Salud" <%= "Salud".equals(request.getAttribute("categoriaSeleccionada")) ? "selected" : ""%>>Salud</option>
                        </select>
                    </div>

                    <div class="col-md-2 mb-2">
                        <button type="submit" class="btn btn-agregar w-100">Buscar</button>
                    </div>
                </form>

                <!-- Grid de productos -->
                <div class="row" id="grid">
                    <%
                        List<Producto> productos = (List<Producto>) request.getAttribute("productos");
                        if (productos != null && !productos.isEmpty()) {
                            for (Producto p : productos) {
                    %>
                    <div class="col-sm-6 col-md-4 col-lg-3 mb-4">
                        <div class="card text-center h-100 shadow-sm fade-in">
                            <img src="<%=request.getContextPath() + "/" + p.getImagenUrl()%>"
                                 class="card-img-top"
                                 alt="<%=p.getNombre()%>">
                            <div class="card-body d-flex flex-column justify-content-between">
                                <div>
                                    <h6 class="card-title fw-bold"><%=p.getNombre()%></h6>
                                    <p class="text-muted mb-1">S/ <%=p.getPrecio()%></p>
                                    <p class="small text-secondary"><%=p.getCategoria()%></p>
                                </div>

                                <!-- FORMULARIO: Agregar al carrito -->
                                <form action="<%=request.getContextPath()%>/CarritoServlet" method="post">
                                    <input type="hidden" name="accion" value="agregar">
                                    <input type="hidden" name="idProducto" value="<%=p.getIdProducto()%>">

                                    <!-- Versión simple: siempre 1 unidad -->
                                    <button type="submit" class="btn btn-agregar btn-sm w-100 mt-2">
                                        <i class="bi bi-cart-plus"></i> Agregar al carrito
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <% } } else { %>
                    <div class="col-12 text-center">
                        <p class="text-muted">No hay productos disponibles en este momento.</p>
                    </div>
                    <% } %>
                </div>
            </main>
        </div>

        <jsp:include page="footer.jsp"/>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="<%=request.getContextPath()%>/js/catalogo.js"></script>
    </body>
</html>
