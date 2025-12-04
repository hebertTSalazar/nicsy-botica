/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import pe.nicsy.botica.model.ItemCarrito;
import pe.nicsy.botica.model.VentaResultado;
import pe.nicsy.botica.service.VentaService;
import pe.nicsy.botica.service.impl.VentaServiceImpl;

/**
 *
 * @author frank
 */
@WebServlet("/FinalizarCompraServlet")
public class FinalizarCompraServlet extends HttpServlet {

    private final VentaService ventaService = new VentaServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/CarritoServlet");
            return;
        }

        @SuppressWarnings("unchecked")
        List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");

        if (carrito == null || carrito.isEmpty()) {
            session.setAttribute("msgCarritoError",
                    "Tu carrito está vacío. Agrega productos antes de finalizar la compra.");
            resp.sendRedirect(req.getContextPath() + "/CarritoServlet");
            return;
        }

        // 1) Datos del formulario
        String nombreCompleto = req.getParameter("nombreCompleto");
        String dni = req.getParameter("dni");
        String email = req.getParameter("email");
        String telefono = req.getParameter("telefono");
        String metodoEntrega = req.getParameter("metodoEntrega"); // "tienda" o "delivery"
        String direccion = req.getParameter("direccion");
        String referencia = req.getParameter("referencia");

        // Validación mínima
        if (nombreCompleto == null || nombreCompleto.trim().isEmpty()
                || dni == null || dni.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || telefono == null || telefono.trim().isEmpty()) {

            session.setAttribute("msgCarritoError",
                    "Por favor completa todos los campos obligatorios: nombre, DNI, correo y teléfono.");
            resp.sendRedirect(req.getContextPath() + "/CarritoServlet");
            return;
        }

        // Si elige delivery, dirección obligatoria
        if ("delivery".equalsIgnoreCase(metodoEntrega)) {
            if (direccion == null || direccion.trim().isEmpty()) {
                session.setAttribute("msgCarritoError",
                        "Para delivery debes indicar la dirección de entrega.");
                resp.sendRedirect(req.getContextPath() + "/CarritoServlet");
                return;
            }
        } else {
            metodoEntrega = "tienda";
            if (direccion == null) direccion = "";
            if (referencia == null) referencia = "";
        }

        // 2) Calcular subtotal, envío y total
        BigDecimal subtotal = BigDecimal.ZERO;
        for (ItemCarrito item : carrito) {
            subtotal = subtotal.add(item.getSubtotal());
        }

        BigDecimal envio = BigDecimal.ZERO;
        if ("delivery".equalsIgnoreCase(metodoEntrega)) {
            // Regla: subtotal >= 30 => envío 0, si no => 5
            if (subtotal.compareTo(new BigDecimal("30.00")) < 0) {
                envio = new BigDecimal("5.00");
            } else {
                envio = BigDecimal.ZERO;
            }
        }

        BigDecimal total = subtotal.add(envio);

        try {
            // 3) Registrar venta completa en BD
            VentaResultado resultado = ventaService.registrarVentaDesdeCarrito(
                    nombreCompleto.trim(),
                    dni.trim(),
                    email.trim(),
                    telefono.trim(),
                    metodoEntrega.toLowerCase(),
                    direccion.trim(),
                    referencia.trim(),
                    carrito,
                    subtotal,
                    envio,
                    total
            );

            // 4) Limpiar carrito y mostrar comprobante
            session.removeAttribute("carrito");
            session.setAttribute("msgCarritoOK", "Compra registrada correctamente.");

            req.setAttribute("ventaResultado", resultado);
            req.setAttribute("nombreCliente", nombreCompleto);
            req.setAttribute("metodoEntrega", metodoEntrega.toLowerCase());

            req.getRequestDispatcher("views/resultadoCompra.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgCarritoError",
                    "Ocurrió un error al registrar la compra: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/CarritoServlet");
        }
    }
}