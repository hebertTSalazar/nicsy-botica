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
import java.util.ArrayList;
import java.util.List;
import pe.nicsy.botica.model.ItemCarrito;
import pe.nicsy.botica.model.Producto;
import pe.nicsy.botica.service.ProductoServiceAdmin;
import pe.nicsy.botica.service.impl.ProductoServiceAdminImpl;

/**
 *
 * @author frank
 */
@WebServlet("/CarritoServlet")
public class CarritoServlet extends HttpServlet {

    private final ProductoServiceAdmin productoAdminService = new ProductoServiceAdminImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(true);

        List<ItemCarrito> carrito = obtenerCarrito(session);

        BigDecimal total = BigDecimal.ZERO;
        for (ItemCarrito item : carrito) {
            total = total.add(item.getSubtotal());
        }

        // Recalcular contador del carrito
        actualizarContadorCarrito(session, carrito);

        req.setAttribute("carrito", carrito);
        req.setAttribute("total", total);

        String msgOK = (String) session.getAttribute("msgCarritoOK");
        String msgError = (String) session.getAttribute("msgCarritoError");

        if (msgOK != null) {
            req.setAttribute("msgCarritoOK", msgOK);
            session.removeAttribute("msgCarritoOK");
        }
        if (msgError != null) {
            req.setAttribute("msgCarritoError", msgError);
            session.removeAttribute("msgCarritoError");
        }

        req.getRequestDispatcher("views/carrito.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String accion = req.getParameter("accion");
        if (accion == null) {
            accion = "ver";
        }

        HttpSession session = req.getSession(true);
        List<ItemCarrito> carrito = obtenerCarrito(session);

        try {
            switch (accion) {
                case "agregar":
                    agregarProducto(req, session, carrito, resp);
                    return;
                case "actualizar":
                    actualizarCantidad(req, session, carrito, resp);
                    return;
                case "eliminar":
                    eliminarProducto(req, session, carrito, resp);
                    return;
                case "vaciar":
                    vaciarCarrito(session, resp, req);
                    return;
                default:
                    resp.sendRedirect(req.getContextPath() + "/CarritoServlet");
                    return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgCarritoError", "Error al procesar el carrito: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/CarritoServlet");
        }
    }

    // ===================== MÉTODOS PRIVADOS ======================

    @SuppressWarnings("unchecked")
    private List<ItemCarrito> obtenerCarrito(HttpSession session) {
        List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
        if (carrito == null) {
            carrito = new ArrayList<>();
            session.setAttribute("carrito", carrito);
        }
        return carrito;
    }

    private void actualizarContadorCarrito(HttpSession session, List<ItemCarrito> carrito) {
        int totalUnidades = 0;
        if (carrito != null) {
            for (ItemCarrito it : carrito) {
                totalUnidades += it.getCantidad();
            }
        }
        session.setAttribute("carritoCantidad", totalUnidades);
    }

    private void agregarProducto(HttpServletRequest req, HttpSession session,
                                 List<ItemCarrito> carrito, HttpServletResponse resp) throws Exception {

        int idProducto = Integer.parseInt(req.getParameter("idProducto"));
        int cantidadSolicitada = 1;

        String cantParam = req.getParameter("cantidad");
        if (cantParam != null && !cantParam.trim().isEmpty()) {
            try {
                cantidadSolicitada = Integer.parseInt(cantParam);
                if (cantidadSolicitada <= 0) {
                    cantidadSolicitada = 1;
                }
            } catch (NumberFormatException e) {
                cantidadSolicitada = 1;
            }
        }

        Producto p = productoAdminService.buscarPorId(idProducto);
        if (p == null) {
            session.setAttribute("msgCarritoError", "El producto seleccionado no existe.");
            resp.sendRedirect(req.getContextPath() + "/catalogo");
            return;
        }

        int stockDisponible = p.getStock();

        ItemCarrito existente = null;
        for (ItemCarrito it : carrito) {
            if (it.getIdProducto() == idProducto) {
                existente = it;
                break;
            }
        }

        int cantidadActualEnCarrito = (existente != null) ? existente.getCantidad() : 0;
        int cantidadFinal = cantidadActualEnCarrito + cantidadSolicitada;

        if (cantidadFinal > stockDisponible) {
            session.setAttribute(
                "msgCarritoError",
                "Stock insuficiente para \"" + p.getNombre()
                + "\". Solo hay " + stockDisponible + " unidades disponibles."
            );
            resp.sendRedirect(req.getContextPath() + "/catalogo");
            return;
        }

        if (existente == null) {
            ItemCarrito nuevo = new ItemCarrito();
            nuevo.setIdProducto(p.getIdProducto());
            nuevo.setNombre(p.getNombre());
            nuevo.setPrecioUnitario(p.getPrecio());
            nuevo.setCantidad(cantidadSolicitada);
            nuevo.setImagenUrl(p.getImagenUrl());
            carrito.add(nuevo);
        } else {
            existente.setCantidad(cantidadFinal);
        }

        actualizarContadorCarrito(session, carrito);

        session.setAttribute("msgCarritoOK", "Producto agregado correctamente al carrito.");
        resp.sendRedirect(req.getContextPath() + "/catalogo");
    }

    private void actualizarCantidad(HttpServletRequest req, HttpSession session,
                                    List<ItemCarrito> carrito, HttpServletResponse resp) throws Exception {

        int idProducto = Integer.parseInt(req.getParameter("idProducto"));
        int nuevaCantidad;

        try {
            nuevaCantidad = Integer.parseInt(req.getParameter("cantidad"));
        } catch (NumberFormatException e) {
            session.setAttribute("msgCarritoError", "Cantidad inválida.");
            resp.sendRedirect(req.getContextPath() + "/CarritoServlet");
            return;
        }

        if (nuevaCantidad <= 0) {
            carrito.removeIf(it -> it.getIdProducto() == idProducto);
            actualizarContadorCarrito(session, carrito);
            session.setAttribute("msgCarritoOK", "Producto eliminado del carrito.");
            resp.sendRedirect(req.getContextPath() + "/CarritoServlet");
            return;
        }

        Producto p = productoAdminService.buscarPorId(idProducto);
        if (p == null) {
            session.setAttribute("msgCarritoError", "El producto ya no existe en el sistema.");
            resp.sendRedirect(req.getContextPath() + "/CarritoServlet");
            return;
        }

        int stockDisponible = p.getStock();
        if (nuevaCantidad > stockDisponible) {
            session.setAttribute(
                "msgCarritoError",
                "No puedes seleccionar " + nuevaCantidad + " unidades de \"" + p.getNombre()
                + "\". Stock disponible: " + stockDisponible + "."
            );
            resp.sendRedirect(req.getContextPath() + "/CarritoServlet");
            return;
        }

        for (ItemCarrito it : carrito) {
            if (it.getIdProducto() == idProducto) {
                it.setCantidad(nuevaCantidad);
                break;
            }
        }

        actualizarContadorCarrito(session, carrito);

        session.setAttribute("msgCarritoOK", "Cantidad actualizada correctamente.");
        resp.sendRedirect(req.getContextPath() + "/CarritoServlet");
    }

    private void eliminarProducto(HttpServletRequest req, HttpSession session,
                                  List<ItemCarrito> carrito, HttpServletResponse resp) throws IOException {

        int idProducto = Integer.parseInt(req.getParameter("idProducto"));
        carrito.removeIf(it -> it.getIdProducto() == idProducto);

        actualizarContadorCarrito(session, carrito);

        session.setAttribute("msgCarritoOK", "Producto eliminado del carrito.");
        resp.sendRedirect(req.getContextPath() + "/CarritoServlet");
    }

    private void vaciarCarrito(HttpSession session, HttpServletResponse resp, HttpServletRequest req) throws IOException {
        session.removeAttribute("carrito");
        session.setAttribute("carritoCantidad", 0);

        session.setAttribute("msgCarritoOK", "Carrito vaciado correctamente.");
        resp.sendRedirect(req.getContextPath() + "/CarritoServlet");
    }
}
