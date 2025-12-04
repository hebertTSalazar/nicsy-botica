/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.service.impl;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import pe.nicsy.botica.config.DBPool;
import pe.nicsy.botica.model.ItemCarrito;
import pe.nicsy.botica.model.VentaResultado;
import pe.nicsy.botica.service.VentaService;

/**
 *
 * @author frank
 */
public class VentaServiceImpl implements VentaService {

    @Override
    public VentaResultado registrarVentaDesdeCarrito(
            String nombreCompleto,
            String dni,
            String email,
            String telefono,
            String metodoEntrega,   // "tienda" o "delivery" desde el formulario
            String direccion,
            String referencia,
            List<ItemCarrito> carrito,
            BigDecimal subtotal,
            BigDecimal envio,
            BigDecimal total) throws Exception {

        if (carrito == null || carrito.isEmpty()) {
            throw new IllegalArgumentException("El carrito está vacío, no se puede registrar la venta.");
        }

        VentaResultado resultado = new VentaResultado();

        try (Connection con = DBPool.getConnection()) {
            con.setAutoCommit(false);

            try {
                // =======================================================
                // 1) Registrar / obtener CLIENTE (SP RegistrarCliente)
                // =======================================================
                int idCliente;
                String sqlCliente = "{ CALL RegistrarCliente(?, ?, ?, ?, ?) }";
                try (CallableStatement csCli = con.prepareCall(sqlCliente)) {
                    csCli.setString(1, nombreCompleto);
                    csCli.setString(2, dni);
                    csCli.setString(3, email);
                    csCli.setString(4, telefono);
                    csCli.registerOutParameter(5, java.sql.Types.INTEGER);

                    csCli.executeUpdate();
                    idCliente = csCli.getInt(5);
                }

                if (idCliente <= 0) {
                    throw new IllegalStateException("No se pudo obtener el id_cliente.");
                }

                // =======================================================
                // 2) Crear CABECERA de PEDIDO (SP InsertarPedidoCabecera)
                //    Devuelve id_pedido en un SELECT
                // =======================================================
                int idPedido = 0;
                String sqlPedCab = "{ CALL InsertarPedidoCabecera(?) }";
                try (CallableStatement csPed = con.prepareCall(sqlPedCab)) {
                    csPed.setInt(1, idCliente);

                    boolean hasResult = csPed.execute();
                    if (hasResult) {
                        try (ResultSet rs = csPed.getResultSet()) {
                            if (rs.next()) {
                                // la consulta del SP: SELECT LAST_INSERT_ID() AS id_pedido;
                                idPedido = rs.getInt("id_pedido");
                            }
                        }
                    }
                }

                if (idPedido <= 0) {
                    throw new IllegalStateException("No se pudo crear el pedido.");
                }

                // =======================================================
                // 3) Insertar DETALLE del pedido (SP InsertarPedidoDetalle)
                //    Por cada item del carrito
                // =======================================================
                for (ItemCarrito item : carrito) {
                    String sqlPedDet = "{ CALL InsertarPedidoDetalle(?, ?, ?, ?) }";
                    try (CallableStatement csDet = con.prepareCall(sqlPedDet)) {
                        csDet.setInt(1, idPedido);
                        csDet.setInt(2, item.getIdProducto());
                        csDet.setInt(3, item.getCantidad());
                        csDet.setBigDecimal(4, item.getPrecioUnitario());
                        // El SP hace: agrega subtotal y acumula total del pedido
                        csDet.execute();
                        // El SELECT v_sub AS subtotal_linea lo podemos ignorar
                    }
                }

                // =======================================================
                // 4) Actualizar método de entrega + envío en PEDIDOS
                //    Tabla pedidos:
                //      metodo_entrega ENUM('Delivery','Recojo')
                //      costo_delivery DECIMAL
                //      direccion_entrega, referencia_entrega
                //      total (sum(lineas) + costo_delivery)
                // =======================================================
                String metodoBD = "Recojo"; // por defecto
                if (metodoEntrega != null &&
                        metodoEntrega.equalsIgnoreCase("delivery")) {
                    metodoBD = "Delivery";
                }

                BigDecimal costoDelivery = (envio != null) ? envio : BigDecimal.ZERO;

                String sqlUpdPedido =
                        "UPDATE pedidos " +
                        "   SET metodo_entrega   = ?, " +
                        "       costo_delivery   = ?, " +
                        "       direccion_entrega = ?, " +
                        "       referencia_entrega = ?, " +
                        "       total = total + ? " +   // sumamos el envío al total ya calculado por los detalles
                        " WHERE id_pedido = ?";

                try (PreparedStatement ps = con.prepareStatement(sqlUpdPedido)) {
                    ps.setString(1, metodoBD);
                    ps.setBigDecimal(2, costoDelivery);
                    ps.setString(3, direccion);
                    ps.setString(4, referencia);
                    ps.setBigDecimal(5, costoDelivery);
                    ps.setInt(6, idPedido);
                    ps.executeUpdate();
                }

                // =======================================================
                // 5) Crear VENTA desde el pedido (SP CrearVentaDesdePedido)
                //    - descuenta stock
                //    - llena detalleventa
                //    - registra movimientosstock
                //    - marca pedido como Confirmado
                //
                //    Firma:
                //    CrearVentaDesdePedido(IN p_id_pedido INT,
                //                          IN p_id_usuario INT,
                //                          IN p_tipo VARCHAR(20))
                //    SELECT v_id_venta AS id_venta, v_total AS total;
                // =======================================================

                // Por ahora usamos el usuario 3 (Administrador General) como vendedor web.
                // Más adelante puedes cambiarlo para tomar el id_usuario de la sesión.
                int idUsuarioVendedor = 3;
                String tipoVenta = "Online";

                int idVenta = 0;
                BigDecimal totalBD = BigDecimal.ZERO;

                String sqlCrearVenta = "{ CALL CrearVentaDesdePedido(?, ?, ?) }";
                try (CallableStatement csVenta = con.prepareCall(sqlCrearVenta)) {
                    csVenta.setInt(1, idPedido);
                    csVenta.setInt(2, idUsuarioVendedor);
                    csVenta.setString(3, tipoVenta);

                    boolean hasResult = csVenta.execute();
                    if (hasResult) {
                        try (ResultSet rs = csVenta.getResultSet()) {
                            if (rs.next()) {
                                idVenta = rs.getInt("id_venta");
                                totalBD = rs.getBigDecimal("total");
                            }
                        }
                    }
                }

                if (idVenta <= 0) {
                    throw new IllegalStateException("No se pudo crear la venta desde el pedido.");
                }

                // =======================================================
                // 6) Registrar PAGO de la venta (SP RegistrarPagoVenta)
                //    Firma:
                //       RegistrarPagoVenta(IN p_id_venta INT,
                //                          IN p_metodo   VARCHAR(20))
                // =======================================================
                String sqlPago = "{ CALL RegistrarPagoVenta(?, ?) }";
                try (CallableStatement csPago = con.prepareCall(sqlPago)) {
                    csPago.setInt(1, idVenta);
                    csPago.setString(2, "Yape/Plin");  // medio de pago del flujo online
                    csPago.execute();
                    // El SP devuelve id_pago y total, pero no es necesario usarlo aquí.
                }

                // =======================================================
                // 7) Generar BOLETA (SP GenerarBoletaVenta)
                //    Devuelve:
                //       id_boleta, numero_incremental
                // =======================================================
                String numeroComprobante = null;
                String sqlBoleta = "{ CALL GenerarBoletaVenta(?) }";
                try (CallableStatement csBol = con.prepareCall(sqlBoleta)) {
                    csBol.setInt(1, idVenta);

                    boolean hasResult = csBol.execute();
                    if (hasResult) {
                        try (ResultSet rs = csBol.getResultSet()) {
                            if (rs.next()) {
                                int numeroIncremental = rs.getInt("numero_incremental");
                                numeroComprobante = "BOL-" + numeroIncremental;
                            }
                        }
                    }
                }

                if (numeroComprobante == null) {
                    // Fallback: al menos devolvemos algo
                    numeroComprobante = "BOL-" + idVenta;
                }

                // =======================================================
                // Commit y llenar objeto de resultado
                // =======================================================
                con.commit();

                resultado.setIdVenta(idVenta);
                resultado.setNumeroComprobante(numeroComprobante);
                resultado.setSubtotal(subtotal);
                resultado.setEnvio(envio);
                // Aquí podría usarse totalBD (lo que realmente quedó en la BD)
                // pero como tu flujo ya calculó "total" (subtotal + envío),
                // lo devolvemos para mostrarlo tal como lo vio el cliente.
                resultado.setTotal(total);

                return resultado;

            } catch (Exception ex) {
                con.rollback();
                throw ex;
            } finally {
                con.setAutoCommit(true);
            }
        }
    }
}