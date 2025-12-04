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
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Types;
import java.util.List;
import pe.nicsy.botica.config.DBPool;
import pe.nicsy.botica.model.ItemCarritoInterno;
import pe.nicsy.botica.model.Usuario;

/**
 *
 * @author frank
 */
@WebServlet("/RegistrarVentaInternaServlet")
public class RegistrarVentaInternaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        // 1. Validar seguridad
        Usuario user = (Usuario) session.getAttribute("usuario");
        if (user == null || 
            !(user.getRol().equalsIgnoreCase("Administrador") ||
              user.getRol().equalsIgnoreCase("Cajero"))) {

            resp.sendRedirect("views/login.jsp");
            return;
        }

        // 2. Obtener carrito
        List<ItemCarritoInterno> carrito =
                (List<ItemCarritoInterno>) session.getAttribute("carritoInterno");

        if (carrito == null || carrito.isEmpty()) {
            resp.sendRedirect("CarritoInternoServlet?accion=ver");
            return;
        }

        double total = carrito.stream()
                .mapToDouble(ItemCarritoInterno::getSubtotal)
                .sum();

        int idVentaGenerada = 0;

        try (Connection con = DBPool.getConnection()) {

            // ================================================
            // 3. PRIMER SP: RegistrarVentaInterna (cabecera)
            // ================================================
            CallableStatement csVenta = con.prepareCall("{ CALL RegistrarVentaInterna(?, ?, ?) }");
            csVenta.setInt(1, user.getIdUsuario());
            csVenta.setBigDecimal(2, new BigDecimal(total));
            csVenta.registerOutParameter(3, Types.INTEGER);  // id venta
            csVenta.execute();

            idVentaGenerada = csVenta.getInt(3);

            if (idVentaGenerada <= 0) {
                throw new Exception("No se generó la venta interna.");
            }


            // ================================================
            // 4. SEGUNDO SP: RegistrarDetalleVentaInterna
            // ================================================
            CallableStatement csDet = con.prepareCall(
                    "{ CALL RegistrarDetalleVentaInterna(?, ?, ?, ?) }"
            );

            for (ItemCarritoInterno item : carrito) {

                csDet.setInt(1, idVentaGenerada);
                csDet.setInt(2, item.getIdProducto());
                csDet.setInt(3, item.getCantidad());
                csDet.setBigDecimal(4, new BigDecimal(item.getPrecio()));
                csDet.execute();
            }


            // ================================================
            // 5. Registrar Pago (Presencial)
            // ================================================
            CallableStatement csPago = con.prepareCall(
                    "{ CALL RegistrarPagoVenta(?, ?) }"
            );

            csPago.setInt(1, idVentaGenerada);
            csPago.setString(2, "Efectivo"); // Podrás cambiar luego a Tarjeta/Yape

            csPago.execute();


            // ================================================
            // 6. Generar boleta (incremental)
            // ================================================
            CallableStatement csBol = con.prepareCall(
                    "{ CALL GenerarBoletaVenta(?) }"
            );

            csBol.setInt(1, idVentaGenerada);
            csBol.execute();


            // ================================================
            // 7. Limpiar carrito
            // ================================================
            carrito.clear();
            session.setAttribute("carritoInterno", carrito);


            // ================================================
            // 8. Ir a mensaje de éxito
            // ================================================
            resp.sendRedirect("views/ventaExito.jsp?idVenta=" + idVentaGenerada);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgError", e.getMessage());
            resp.sendRedirect("CarritoInternoServlet?accion=ver");
        }
    }

}