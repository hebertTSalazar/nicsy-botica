/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.web;

import pe.nicsy.botica.model.ItemCarritoInterno;
import pe.nicsy.botica.model.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import pe.nicsy.botica.service.ProductoServiceAdmin;
import pe.nicsy.botica.service.impl.ProductoServiceAdminImpl;

/**
 *
 * @author frank
 */
@WebServlet("/CarritoInternoServlet")
public class CarritoInternoServlet extends HttpServlet {

    private final ProductoServiceAdmin productoService = new ProductoServiceAdminImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String accion = req.getParameter("accion");
        HttpSession session = req.getSession();

        List<ItemCarritoInterno> carrito =
                (List<ItemCarritoInterno>) session.getAttribute("carritoInterno");

        if (carrito == null) {
            carrito = new ArrayList<>();
            session.setAttribute("carritoInterno", carrito);
        }

        if (accion == null) accion = "ver";

        switch (accion) {

            case "ver":
                req.getRequestDispatcher("views/carritoInterno.jsp").forward(req, resp);
                break;

            case "eliminar":
                int idEliminar = Integer.parseInt(req.getParameter("id"));
                carrito.removeIf(item -> item.getIdProducto() == idEliminar);
                session.setAttribute("carritoInterno", carrito);
                resp.sendRedirect("CarritoInternoServlet?accion=ver");
                break;

            case "limpiar":
                carrito.clear();
                session.setAttribute("carritoInterno", carrito);
                resp.sendRedirect("CarritoInternoServlet?accion=ver");
                break;

            default:
                resp.sendRedirect("VentasInternasServlet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String accion = req.getParameter("accion");
        HttpSession session = req.getSession();

        List<ItemCarritoInterno> carrito =
                (List<ItemCarritoInterno>) session.getAttribute("carritoInterno");

        if (carrito == null) {
            carrito = new ArrayList<>();
            session.setAttribute("carritoInterno", carrito);
        }

        switch (accion) {

            case "agregar":

                int idProd = Integer.parseInt(req.getParameter("idProducto"));
                int cantidad = Integer.parseInt(req.getParameter("cantidad"));

                try {
                    Producto prod = productoService.buscarPorId(idProd);

                    if (prod == null) {
                        resp.sendRedirect("VentasInternasServlet");
                        return;
                    }

                    double precio = prod.getPrecio().doubleValue();
                    int stock = prod.getStock();

                    boolean existe = false;

                    for (ItemCarritoInterno item : carrito) {
                        if (item.getIdProducto() == idProd) {

                            int nuevaCantidad = item.getCantidad() + cantidad;

                            if (nuevaCantidad <= stock) {
                                item.setCantidad(nuevaCantidad);
                            }

                            existe = true;
                            break;
                        }
                    }

                    if (!existe) {
                        carrito.add(new ItemCarritoInterno(
                                prod.getIdProducto(),
                                prod.getNombre(),
                                precio,
                                cantidad,
                                stock
                        ));
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }

                session.setAttribute("carritoInterno", carrito);
                resp.sendRedirect("CarritoInternoServlet?accion=ver");
                break;


            case "actualizar":
                int idUpdate = Integer.parseInt(req.getParameter("id"));
                int nuevaCantidad = Integer.parseInt(req.getParameter("cantidad"));

                for (ItemCarritoInterno it : carrito) {
                    if (it.getIdProducto() == idUpdate) {
                        if (nuevaCantidad <= it.getStock()) {
                            it.setCantidad(nuevaCantidad);
                        }
                    }
                }

                session.setAttribute("carritoInterno", carrito);
                resp.sendRedirect("CarritoInternoServlet?accion=ver");
                break;
        }
    }
}