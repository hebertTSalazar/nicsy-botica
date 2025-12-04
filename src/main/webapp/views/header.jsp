<%-- 
    Document   : header
    Created on : 25 oct 2025, 12:25:19
    Author     : frank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="pe.nicsy.botica.model.ItemCarrito"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Botica Nicsy</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css?v=2">
    </head>

    <body>

        <%

            String nombreUsuario = null;
            if (session != null && session.getAttribute("nombreUsuario") != null) {
                nombreUsuario = (String) session.getAttribute("nombreUsuario");
            }

            int totalItemsCarrito = 0;
            if (session != null) {
                List<ItemCarrito> carritoHeader = (List<ItemCarrito>) session.getAttribute("carrito");
                if (carritoHeader != null) {
                    for (ItemCarrito it : carritoHeader) {
                        totalItemsCarrito += it.getCantidad();
                    }
                }
            }
        %>

        <nav class="navbar navbar-expand-lg navbar-dark" style="background-color:#b30000;">
            <div class="container-fluid">
                <a class="navbar-brand fw-bold text-white" href="<%=request.getContextPath()%>/views/index.jsp">
                    BOTICA NICSY
                </a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                    <ul class="navbar-nav">

                        <!-- Enlaces públicos (no requieren login) -->
                        <li class="nav-item">
                            <a class="nav-link text-white" href="<%=request.getContextPath()%>/views/index.jsp">Inicio</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="<%=request.getContextPath()%>/catalogo">Catálogo</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%=request.getContextPath()%>/contacto">Contacto</a>
                        </li>

                        <% if (nombreUsuario != null) {%>
                        <!-- Usuario logueado: mostrar saludo y opción de cerrar sesión -->
                        <li class="nav-item">
                            <span class="nav-link text-white">
                                Bienvenido, <strong><%= nombreUsuario%></strong>
                            </span>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white"
                               href="<%=request.getContextPath()%>/LoginServlet?logout=true">
                                Cerrar sesión
                            </a>
                        </li>
                        <% } else {%>
                        <!-- Nadie logueado: mostrar botón Login -->
                        <li class="nav-item">
                            <a class="nav-link text-white"
                               href="<%=request.getContextPath()%>/views/login.jsp">
                                <i class="bi bi-person-circle"></i> Login
                            </a>
                        </li>
                        <% }%>

                        <!-- Carrito siempre visible con badge de cantidad -->
                        <li class="nav-item">
                            <a class="nav-link fw-bold text-white position-relative" 
                               href="<%=request.getContextPath()%>/CarritoServlet">
                                <i class="bi bi-cart-fill"></i> Carrito
                                <% if (totalItemsCarrito > 0) {%>
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-warning text-dark">
                                    <%= totalItemsCarrito%>
                                </span>
                                <% }%>
                            </a>
                        </li>

                    </ul>
                </div>
            </div>
        </nav>
