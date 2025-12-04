/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.nicsy.botica.service;

import java.math.BigDecimal;
import java.util.List;
import pe.nicsy.botica.model.ItemCarrito;
import pe.nicsy.botica.model.VentaResultado;

/**
 *
 * @author frank
 */
public interface VentaService {
   
    VentaResultado registrarVentaDesdeCarrito(
            String nombreCompleto,
            String dni,
            String email,
            String telefono,
            String metodoEntrega,  // "tienda" o "delivery"
            String direccion,
            String referencia,
            List<ItemCarrito> carrito,
            BigDecimal subtotal,
            BigDecimal envio,
            BigDecimal total
    ) throws Exception;
}
