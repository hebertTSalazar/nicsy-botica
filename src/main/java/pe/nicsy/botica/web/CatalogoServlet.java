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
import java.util.List;
import pe.nicsy.botica.model.Producto;
import pe.nicsy.botica.service.ProductoService;
import pe.nicsy.botica.service.impl.ProductoServiceImpl;

/**
 *
 * @author frank
 */
@WebServlet("/catalogo")
public class CatalogoServlet extends HttpServlet {

    private final ProductoService productoService = new ProductoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            String q = req.getParameter("q");
            String categoria = req.getParameter("categoria");

            List<Producto> productos;

            // Si no hay filtro ni categoría, listar todos
            if ((q == null || q.trim().isEmpty()) && (categoria == null || categoria.trim().isEmpty())) {
                productos = productoService.listarProductos();
            } else {
                productos = productoService.obtenerProductos(q, categoria);
            }

            req.setAttribute("productos", productos);
            req.setAttribute("q", q);
            req.setAttribute("categoriaSeleccionada", categoria);

            // === Leer mensaje del carrito (si viene de un "agregar") ===
            HttpSession session = req.getSession(false);
            if (session != null) {
                String msgCarrito = (String) session.getAttribute("msgCarrito");
                if (msgCarrito != null) {
                    req.setAttribute("msgCarrito", msgCarrito);
                    session.removeAttribute("msgCarrito");
                }
            }

            req.getRequestDispatcher("views/catalogo.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "No fue posible cargar el catálogo: " + e.getMessage());
        }
    }
}
