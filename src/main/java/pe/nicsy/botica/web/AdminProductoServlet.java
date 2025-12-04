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
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import pe.nicsy.botica.model.Lote;
import pe.nicsy.botica.model.LotePorVencer;
import pe.nicsy.botica.model.Producto;
import pe.nicsy.botica.service.ProductoServiceAdmin;
import pe.nicsy.botica.service.impl.ProductoServiceAdminImpl;

/**
 *
 * @author frank
 */
@WebServlet("/AdminProductoServlet")
public class AdminProductoServlet extends HttpServlet {

    private final ProductoServiceAdmin service = new ProductoServiceAdminImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        try {
            if (accion == null || accion.equals("listar")) {
                listarProductos(request, response);

            } else if ("lotes".equals(accion)) {
                listarLotes(request, response);

            } else if ("alertas".equals(accion) || "porVencer".equals(accion)) {
                mostrarAlertas(request, response);

            } else if ("eliminar".equals(accion)) {
                eliminarProducto(request, response);

            } else {
                listarProductos(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Para que acepte tildes y caracteres especiales
        request.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("accion");

        if (accion == null) {
            response.sendRedirect("AdminProductoServlet?accion=listar");
            return;
        }

        try {
            switch (accion) {
                case "insertar":
                    insertarProducto(request, response);
                    break;
                case "actualizar":
                    actualizarProducto(request, response);
                    break;
                case "eliminar":
                    eliminarProducto(request, response);
                    break;
                case "insertarLote":
                    insertarLote(request, response);
                    break;
                default:
                    response.sendRedirect("AdminProductoServlet?accion=listar");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    // ==========================================================
    // === MÉTODOS GET
    // ==========================================================
    private void listarProductos(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String filtro = request.getParameter("q");
        String categoria = request.getParameter("categoria");

        // Obtener lista de productos
        List<Producto> productos = service.listar(filtro, categoria);
        request.setAttribute("productos", productos);

        // Bloque que muestra el mensaje visual del CRUD (insertar / actualizar / eliminar)
        String msg = (String) request.getSession().getAttribute("msg");
        if (msg != null) {
            request.setAttribute("msg", msg);
            request.getSession().removeAttribute("msg");
        }

        // Forward al JSP (mantener siempre al final)
        request.getRequestDispatcher("views/adminProductos.jsp").forward(request, response);
    }

    private void listarLotes(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int idProducto = Integer.parseInt(request.getParameter("id"));
        List<Lote> lotes = service.listarLotesPorProducto(idProducto);
        Producto producto = service.buscarPorId(idProducto);

        request.setAttribute("lotes", lotes);
        request.setAttribute("producto", producto);
        request.getRequestDispatcher("views/adminLotes.jsp").forward(request, response);
    }

    private void mostrarAlertas(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<LotePorVencer> lotesVencer = service.listarLotesPorVencer();
        List<Producto> stockBajo = service.listarStockBajo();

        request.setAttribute("lotesVencer", lotesVencer);
        request.setAttribute("stockBajo", stockBajo);
        request.getRequestDispatcher("views/adminAlertas.jsp").forward(request, response);
    }

    // ==========================================================
    // === MÉTODOS POST
    // ==========================================================
    private void insertarProducto(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        Producto p = new Producto();
        p.setNombre(request.getParameter("nombre"));
        p.setCategoria(request.getParameter("categoria"));
        p.setPrecio(new BigDecimal(request.getParameter("precio")));
        p.setDescripcion(request.getParameter("descripcion"));
        p.setStock(Integer.parseInt(request.getParameter("stock")));

        String imagen = request.getParameter("imagenUrl");
        if (imagen == null || imagen.isEmpty()) {
            imagen = "img/default.png";
        } else if (!imagen.startsWith("img/")) {
            imagen = "img/" + imagen;
        }
        p.setImagenUrl(imagen);

        service.registrar(p);

        // Mensaje de éxito
        request.getSession().setAttribute("msg", "✅ Producto agregado correctamente.");
        response.sendRedirect("AdminProductoServlet?accion=listar");
    }

    private void actualizarProducto(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int id = Integer.parseInt(request.getParameter("id"));
        Producto actual = service.buscarPorId(id);

        if (actual == null) {
            throw new Exception("No se encontró el producto a actualizar.");
        }

        // === Obtener nuevos valores del formulario ===
        String nuevoNombre = request.getParameter("nombre");
        String nuevaCategoria = request.getParameter("categoria");
        String nuevaDescripcion = request.getParameter("descripcion");
        String nuevaImagen = request.getParameter("imagenUrl");
        String precioStr = request.getParameter("precio");
        String stockStr = request.getParameter("stock");

        // === Aplicar solo los cambios proporcionados ===
        if (nuevoNombre != null && !nuevoNombre.trim().isEmpty()) {
            actual.setNombre(nuevoNombre.trim());
        }

        if (nuevaCategoria != null && !nuevaCategoria.trim().isEmpty()) {
            actual.setCategoria(nuevaCategoria.trim());
        }

        if (nuevaDescripcion != null && !nuevaDescripcion.trim().isEmpty()) {
            actual.setDescripcion(nuevaDescripcion.trim());
        }

        // === Imagen: mantener la actual si no se ingresa una nueva ruta ===
        if (nuevaImagen != null && !nuevaImagen.trim().isEmpty()) {
            if (!nuevaImagen.startsWith("img/")) {
                nuevaImagen = "img/" + nuevaImagen;
            }
            actual.setImagenUrl(nuevaImagen);
        }

        // === Precio y stock ===
        if (precioStr != null && !precioStr.trim().isEmpty()) {
            try {
                actual.setPrecio(new BigDecimal(precioStr));
            } catch (NumberFormatException e) {
                throw new Exception("El formato del precio no es válido.");
            }
        }

        if (stockStr != null && !stockStr.trim().isEmpty()) {
            try {
                actual.setStock(Integer.parseInt(stockStr));
            } catch (NumberFormatException e) {
                throw new Exception("El formato del stock no es válido.");
            }
        }

        // === Guardar cambios ===
        service.actualizar(actual);
        request.getSession().setAttribute("msg", "✏️ Producto actualizado correctamente.");
        response.sendRedirect("AdminProductoServlet?accion=listar");
    }

    private void eliminarProducto(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        service.eliminar(id);

        request.getSession().setAttribute("msg", "🗑️ Producto eliminado correctamente.");
        response.sendRedirect("AdminProductoServlet?accion=listar");
    }

    private void insertarLote(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int idProducto = Integer.parseInt(request.getParameter("id_producto"));
        String fecha = request.getParameter("fecha");
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));
        service.insertarLote(idProducto, fecha, cantidad);

        response.sendRedirect("AdminProductoServlet?accion=lotes&id=" + idProducto);
    }
}
