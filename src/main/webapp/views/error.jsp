<%-- 
    Document   : error
    Created on : 31 oct 2025, 16:25:38
    Author     : frank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Error | Botica Nicsy</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet">
    </head>
    <body class="bg-light d-flex justify-content-center align-items-center vh-100">
        <div class="card shadow-lg border-danger" style="max-width: 600px;">
            <div class="card-header bg-danger text-white text-center fw-bold">
                ⚠️ Error en el sistema
            </div>
            <div class="card-body text-center">
                <h5 class="text-danger mb-3">Ha ocurrido un problema al procesar la solicitud</h5>
                <p class="text-muted">
                    <strong>Detalle técnico:</strong><br>
                    <%= request.getAttribute("error") != null ? request.getAttribute("error") : "Error desconocido"%>
                </p>
                <a href="<%=request.getContextPath()%>/AdminProductoServlet?accion=listar" class="btn btn-danger mt-3">
                    Volver al panel de productos
                </a>
            </div>
        </div>
    </body>
</html>
