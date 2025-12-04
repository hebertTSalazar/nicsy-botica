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
import java.util.List;
import pe.nicsy.botica.model.Producto;
import pe.nicsy.botica.service.ProductoServiceAdmin;
import pe.nicsy.botica.service.impl.ProductoServiceAdminImpl;

/**
 *
 * @author frank
 */
@WebServlet("/VentasInternasServlet")
public class VentasInternasServlet extends HttpServlet {

    private ProductoServiceAdmin productoService = new ProductoServiceAdminImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            String q = req.getParameter("q");
            List<Producto> productos;

            if (q == null || q.trim().isEmpty()) {
                productos = productoService.listar(null, null);
            } else {
                productos = productoService.listar(q, null);
            }

            req.setAttribute("productos", productos);

        } catch (Exception e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher("views/ventasInternas.jsp").forward(req, resp);
    }
}