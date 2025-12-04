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

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

    private final VentaService ventaService = new VentaServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
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
                    "Tu carrito está vacío. Agrega productos antes de continuar.");
            resp.sendRedirect(req.getContextPath() + "/CarritoServlet");
            return;
        }

        BigDecimal subtotal = calcularSubtotal(carrito);
        BigDecimal envio = BigDecimal.ZERO; // por defecto
        BigDecimal total = subtotal.add(envio);

        req.setAttribute("subtotal", subtotal);
        req.setAttribute("envio", envio);
        req.setAttribute("total", total);

        // Paso 2: mostrar formulario + QR (en modal) en checkout.jsp
        req.getRequestDispatcher("views/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String accion = req.getParameter("accion");
        if (accion == null) {
            accion = "confirmar";
        }

        if ("confirmar".equals(accion)) {
            procesarConfirmacion(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/CarritoServlet");
        }
    }

    private void procesarConfirmacion(HttpServletRequest req, HttpServletResponse resp)
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
                    "Tu carrito está vacío. Agrega productos antes de continuar.");
            resp.sendRedirect(req.getContextPath() + "/CarritoServlet");
            return;
        }

        // ===== Datos del formulario =====
        String nombreCompleto = req.getParameter("nombreCompleto");
        String dni = req.getParameter("dni");
        String email = req.getParameter("email");
        String telefono = req.getParameter("telefono");
        String metodoEntrega = req.getParameter("metodoEntrega"); // "tienda" o "delivery"
        String direccion = req.getParameter("direccion");
        String referencia = req.getParameter("referencia");

        // ===== Validaciones simples =====
        if (nombreCompleto == null || nombreCompleto.trim().isEmpty()
                || dni == null || dni.trim().isEmpty()
                || email == null || email.trim().isEmpty()) {

            req.setAttribute("errorCheckout",
                    "Por favor complete como mínimo Nombre completo, DNI y Email.");
            recargarCheckoutConTotales(req, resp, carrito, metodoEntrega);
            return;
        }

        if ("delivery".equalsIgnoreCase(metodoEntrega)) {
            if (direccion == null || direccion.trim().isEmpty()
                    || referencia == null || referencia.trim().isEmpty()) {

                req.setAttribute("errorCheckout",
                        "Para delivery debe indicar Dirección de entrega y Referencia.");
                recargarCheckoutConTotales(req, resp, carrito, metodoEntrega);
                return;
            }
        }

        // ===== Cálculo de totales =====
        BigDecimal subtotal = calcularSubtotal(carrito);
        BigDecimal envio = calcularEnvio(subtotal, metodoEntrega);
        BigDecimal total = subtotal.add(envio);

        try {
            // ===== Registrar venta completa en BD =====
            VentaResultado venta = ventaService.registrarVentaDesdeCarrito(
                    nombreCompleto,
                    dni,
                    email,
                    telefono,
                    metodoEntrega,
                    direccion,
                    referencia,
                    carrito,
                    subtotal,
                    envio,
                    total
            );

            // ----- GUARDAR DATOS EN SESIÓN PARA EL PDF -----
            session.setAttribute("ultimaVentaResultado", venta);
            session.setAttribute("ultimaVentaCliente", nombreCompleto);
            session.setAttribute("ultimaVentaMetodoEntrega", metodoEntrega);
            session.setAttribute("ultimaVentaItems", carrito);

            // Limpiar carrito y contador (no borra la lista ya guardada en ultimaVentaItems)
            session.removeAttribute("carrito");
            session.setAttribute("carritoCantidad", 0);

            // Mensaje para el carrito si regresara luego
            session.setAttribute("msgCarritoExito", "Compra registrada correctamente.");

            // Pasamos datos a la página de resultado
            req.setAttribute("ventaResultado", venta);
            req.setAttribute("nombreCliente", nombreCompleto);
            req.setAttribute("metodoEntrega", metodoEntrega);

            req.getRequestDispatcher("views/resultadoCompra.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorCheckout",
                    "Ocurrió un error al registrar la venta: " + e.getMessage());
            recargarCheckoutConTotales(req, resp, carrito, metodoEntrega);
        }
    }

    private void recargarCheckoutConTotales(HttpServletRequest req, HttpServletResponse resp,
                                            List<ItemCarrito> carrito, String metodoEntrega)
            throws ServletException, IOException {

        BigDecimal subtotal = calcularSubtotal(carrito);
        BigDecimal envio = calcularEnvio(subtotal, metodoEntrega);
        BigDecimal total = subtotal.add(envio);

        req.setAttribute("subtotal", subtotal);
        req.setAttribute("envio", envio);
        req.setAttribute("total", total);
        req.setAttribute("metodoEntregaSeleccionado", metodoEntrega);

        req.getRequestDispatcher("views/checkout.jsp").forward(req, resp);
    }

    private BigDecimal calcularSubtotal(List<ItemCarrito> carrito) {
        BigDecimal subtotal = BigDecimal.ZERO;
        if (carrito != null) {
            for (ItemCarrito it : carrito) {
                subtotal = subtotal.add(it.getSubtotal());
            }
        }
        return subtotal;
    }

    /**
     * Regla:
     *  - si método = "delivery" y subtotal < 30 → envío = 5.00
     *  - si subtotal >= 30 → envío = 0
     *  - si método = "tienda" → envío = 0
     */
    private BigDecimal calcularEnvio(BigDecimal subtotal, String metodoEntrega) {
        if (metodoEntrega == null) {
            return BigDecimal.ZERO;
        }

        if ("delivery".equalsIgnoreCase(metodoEntrega)) {
            if (subtotal.compareTo(new BigDecimal("30.00")) >= 0) {
                return BigDecimal.ZERO;
            } else {
                return new BigDecimal("5.00");
            }
        }
        return BigDecimal.ZERO;
    }
}